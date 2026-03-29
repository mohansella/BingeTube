import type { Dirent } from "fs"
import { fileURLToPath } from "url"
import path from "path"
import { gunzip } from "zlib"
import { promisify } from "util"
import { readdir, readFile, writeFile } from "fs/promises"

import pLimit from "p-limit"
import * as yaml from 'js-yaml'

import { createHash } from "crypto";

const shortHash = (buf: Buffer, length = 12) =>
  createHash("sha256").update(buf).digest("hex").slice(0, length);

const gunzipAsync = promisify(gunzip)

class ProcessBinge {

  bingeInfoMap = new Map<String, SeriesInfo>();
  discoverFolder = ''

  async processFiles() {
    const tsFile = fileURLToPath(import.meta.url)
    this.discoverFolder = path.resolve(path.dirname(tsFile), '../../public/discover')
    const files = await readdir(this.discoverFolder, { recursive: true, withFileTypes: true });
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
    const series: SeriesInfo = {
      title: model.title,
      description: model.description,
      dataPath: relativePath,
      dataHash: zipHash,
      cover: model.videos[0].thumbnails
    }
    this.bingeInfoMap.set(relativePath, series)
  }

  async merge() {
    const filePath = path.resolve(this.discoverFolder, 'discover.yml')
    const fileContent = await readFile(filePath, 'utf-8')
    const discover = yaml.load(fileContent) as Discover
    discover.collections.forEach((f) => {
      f.series = (f.series as DiscoverSeries[]).map((s) => {
        if (!this.bingeInfoMap.has(s.data)) {
          throw Error(`binge defined in discover.yml missing: ${s.data}`)
        } else {
          return this.bingeInfoMap.get(s.data)!
        }
      })
    })
    console.log(`writing discover.json file`)
    const jsonFilePath = path.resolve(this.discoverFolder, 'discover.json')
    await writeFile(jsonFilePath, JSON.stringify(discover, null, 2))
  }

  static async main() {
    const processBinge = new ProcessBinge()
    console.time('BingeProcess')
    await processBinge.processFiles();
    console.timeEnd('BingeProcess')
    await processBinge.merge();
  }

}

interface Discover {
  collections: DiscoverCollection[]
}

interface DiscoverCollection {
  name: String
  series: DiscoverSeries[] | SeriesInfo[]
}

interface DiscoverSeries {
  data: String
}

interface SeriesInfo {
  title: String
  description: String
  dataPath: String
  dataHash: String
  cover: VideoThumbnail
}

interface BingeModel {
  title: String
  description: String
  videos: VideoModel[]
}

interface VideoModel {
  thumbnails: VideoThumbnail
}

interface VideoThumbnail {
  id: String
  defaultUrl: String
  mediumUrl: String
  highUrl: String
  standardUrl?: String
  maxresUrl?: String
}

const isMain = process.argv[1] === fileURLToPath(import.meta.url)

if (isMain) {
  ProcessBinge.main()
}
