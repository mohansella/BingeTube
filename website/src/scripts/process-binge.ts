import { fileURLToPath } from "url"
import path from "path"
import { readdir } from "fs/promises"
import type { Dirent } from "fs"

class ProcessBinge {
  public static async main() {
    const tsFile = fileURLToPath(import.meta.url)
    const publicFolder = path.resolve(path.dirname(tsFile), '../../public')
    const files = await readdir(publicFolder, { recursive: true, withFileTypes: true });
    files.map(ProcessBinge.process)
  }

  public static process(file: Dirent) {
    if(!file.name.endsWith('.binge')) {
      return;
    }
    console.log(`processing ${file.name}`);
  }
}

const isMain = process.argv[1] === fileURLToPath(import.meta.url)

if (isMain) {
  ProcessBinge.main()
}
