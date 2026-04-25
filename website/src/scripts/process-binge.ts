import type { Dirent } from "fs"
import { fileURLToPath } from "url"
import path from "path"
import { gunzip } from "zlib"
import { promisify } from "util"
import { readdir, readFile, writeFile } from "fs/promises"

import pLimit from "p-limit"
import * as yaml from 'js-yaml'

import { createHash } from "crypto"

import ffmpeg from "fluent-ffmpeg"
import ffmpegPath from "ffmpeg-static"

ffmpeg.setFfmpegPath(ffmpegPath!)

import sharp from "sharp"
import { MinPriorityQueue } from '@datastructures-js/priority-queue'

const shortHash = (buf: Buffer, length = 12) =>
  createHash("sha256").update(buf).digest("hex").slice(0, length)

const gunzipAsync = promisify(gunzip)

class ProcessBinge {

  bingeInfoMap = new Map<string, SeryModel>()
  discoverFolder = ''
  topThumbnails = new MinPriorityQueue<[string, number]>({
    compare: (a, b) => a[1] - b[1],
  })


  async processFiles() {
    const tsFile = fileURLToPath(import.meta.url)
    this.discoverFolder = path.resolve(path.dirname(tsFile), '../../public/discover')
    const files = await readdir(this.discoverFolder, { recursive: true, withFileTypes: true })
    const bingeFiles = files.filter((f) => f.name.endsWith('.binge'))
    const limit = pLimit(8)
    const processes = bingeFiles.map(f => limit(() => this.process(f)))
    await Promise.all(processes)
  }

  async process(file: Dirent) {
    console.log(`processing ${file.name}`)
    const filePath = path.resolve(file.parentPath, file.name)
    const zipBuffer = await readFile(filePath)
    const zipHash = shortHash(zipBuffer)
    const fileBuffer = await gunzipAsync(zipBuffer)
    const fileContent = fileBuffer.toString('utf-8')
    const model = JSON.parse(fileContent) as BingeModel
    const relativePath = filePath.slice(this.discoverFolder.length + 1)
    const videoModel = model.videos[0]
    const series: SeryModel = {
      title: model.title,
      description: model.description,
      dataPath: relativePath,
      dataHash: zipHash,
      coverId: videoModel.video.id,
      coverUrl: videoModel.thumbnails.highUrl,
      iconUrl: model.channels[videoModel.video.channelId]!.thumbnails.mediumUrl,
      totalVideos: model.videos.length,
    }
    this.bingeInfoMap.set(relativePath, series)

    for (const video of model.videos) {
      const viewCount = video.statistics.viewCount
      if (typeof viewCount === 'number') {
        this.topThumbnails.push([video.thumbnails.highUrl, viewCount])
        if (this.topThumbnails.size() > 100) {
          this.topThumbnails.dequeue()
        }
      }
    }
  }

  async merge() {
    const filePath = path.resolve(this.discoverFolder, 'discover.yml')
    const fileContent = await readFile(filePath, 'utf-8')
    const discover = yaml.load(fileContent) as Discover

    discover.models = Object.fromEntries(this.bingeInfoMap)

    discover.collections.forEach((f) => {
      f.series.map((s) => {
        const bingeFile = `${s}.binge`
        if (!this.bingeInfoMap.has(bingeFile)) {
          throw Error(`binge defined in discover.yml missing/duplicate: ${s}`)
        } else {
          this.bingeInfoMap.get(bingeFile)!
          this.bingeInfoMap.delete(s)
        }
      })
    })

    console.log(`writing discover.json file`)
    const jsonFilePath = path.resolve(this.discoverFolder, 'discover.json')
    await writeFile(jsonFilePath, JSON.stringify(discover, null, 2))
  }

  async downloadThumbnails(): Promise<Buffer[]> {
    const thumbImages: Buffer[] = []
    const limit = pLimit(8)
    const processes = this.topThumbnails.toArray().map(f => limit(async () => {
      const data = await this.downloadThumbnail(f[0])
      if (data != null) {
        thumbImages.push(data)
      }
    }))
    await Promise.all(processes)
    console.log(`thumbImages: ${thumbImages.length}`)

    if (thumbImages.length === 0) {
      throw Error('No thumbnails downloaded, skipping poster creation.')
    }

    return thumbImages
  }

  async createPoster() {
    const thumbImages = await this.downloadThumbnails()
    const cells = 8
    const tileWidth = 480 + 40
    const tileHeight = 360 - 60
    const tileRadius = 24
    const xSpacing = 20
    const ySpacing = 20
    const posterWidth = cells * tileWidth + (cells - 1) * xSpacing
    const posterHeight = cells * tileHeight + (cells - 1) * ySpacing

    const maskSvg = `<svg width="${tileWidth}" height="${tileHeight}" viewBox="0 0 ${tileWidth} ${tileHeight}" xmlns="http://www.w3.org/2000/svg"><rect x="0" y="0" width="${tileWidth}" height="${tileHeight}" rx="${tileRadius}" ry="${tileRadius}" fill="white" /></svg>`
    const maskBuffer = Buffer.from(maskSvg)

    const shuffled = this.shuffle(thumbImages.slice())
    while (shuffled.length < cells * cells) {
      shuffled.push(...shuffled.slice(0, Math.min(shuffled.length, cells * cells - shuffled.length)))
    }

    const frames = shuffled.slice(0, cells * cells)

    const composite = await Promise.all(frames.map(async (image, index) => {
      const tile = await sharp(image)
        .resize(tileWidth, tileHeight, {
          fit: 'cover',
          position: 'centre',
        })
        .composite([{ input: maskBuffer, blend: 'dest-in' }])
        .png()
        .toBuffer()

      return {
        input: tile,
        left: (index % cells) * (tileWidth + xSpacing),
        top: Math.floor(index / cells) * (tileHeight + ySpacing),
      }
    }))

    const outputWidth = 2000 + 400
    const outputHeight = 1125 + 200
    const outputQuality = 85

    const posterBuffer = await sharp({
      create: {
        width: posterWidth,
        height: posterHeight,
        channels: 3,
        background: { r: 0, g: 0, b: 0 },
      },
    })
      .composite(composite)
      .png()
      .toBuffer()

    const outputBuffer = await sharp(posterBuffer)
      .resize(outputWidth, outputHeight, {
        fit: 'cover',
      })
      .jpeg({
        quality: outputQuality,
        mozjpeg: true,
      })
      .toBuffer()

    const posterPath = path.resolve(this.discoverFolder, 'poster-pre.jpg')
    await writeFile(posterPath, outputBuffer)
    console.log(`wrote poster: ${posterPath}`)
  }

  async transformPoster() {
    const inputPath = path.resolve(this.discoverFolder, 'poster-pre.jpg')
    const outputPath = path.resolve(this.discoverFolder, 'poster.jpg')
    return new Promise<void>((resolve, reject) => {
      ffmpeg(inputPath)
        .videoFilters([
          // slight rotate (Z axis)
          "rotate=0.25:fillcolor=black",

          // perspective transform (simulate rotateX + rotateY)
          "perspective=" +
          "x0=0:y0=0:" +
          "x1=W:y1=600:" +          // tilt top edge down
          "x2=0:y2=H:" +
          "x3=W:y3=H-100",           // tilt bottom edge slightly up

          "crop=2000:1125:150:0"
        ])
        .outputOptions([
          "-q:v 2" // high quality
        ])
        .save(outputPath)
        .on("end", () => {
          console.log("Poster transformed")
          resolve()
        })
        .on("error", reject)
    })
  }

  shuffle<T>(array: T[]) {
    for (let i = array.length - 1; i > 0; i--) {
      const j = Math.floor(Math.random() * (i + 1))
        ;[array[i], array[j]] = [array[j], array[i]]
    }
    return array
  }

  async downloadThumbnail(url: string): Promise<Buffer | null> {
    console.log(`downloading ${url}`)
    const response = await fetch(url)

    if (!response.ok) {
      console.error(`Failed to download: ${url} (${response.status})`)
      return null
    }

    const arrayBuffer = await response.arrayBuffer()
    return Buffer.from(arrayBuffer)
  }

  static async main() {
    const processBinge = new ProcessBinge()
    console.time('BingeProcess')
    await processBinge.processFiles()
    console.timeEnd('BingeProcess')
    await processBinge.merge()
    await processBinge.createPoster()
    await processBinge.transformPoster()
  }

}

interface Discover {
  collections: DiscoverCollection[]
  top_picks: string[]
  models: Record<string, SeryModel>
}

interface DiscoverCollection {
  name: string
  series: string[]
}

interface SeryModel {
  title: string
  description: string
  coverId: string
  coverUrl: string
  iconUrl: string
  totalVideos: Number
  dataPath: string
  dataHash: string
}

interface BingeModel {
  title: string
  description: string
  videos: VideoModel[]
  channels: Record<string, ChannelModel>
}

interface ChannelModel {
  thumbnails: { mediumUrl: string }
}

interface VideoModel {
  video: { id: string, channelId: string }
  thumbnails: { highUrl: string }
  statistics: { viewCount: any }
}

const isMain = process.argv[1] === fileURLToPath(import.meta.url)

if (isMain) {
  ProcessBinge.main()
}
