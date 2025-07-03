# SourceScraper

**SourceScraper** is a simple Bash script to download JavaScript files listed in a text file (`js.txt`). It downloads each file into a `data/` folder next to your `js.txt`.

---

## 🛠️ Features

- Reads URLs from a file and downloads them
- Skips blank lines or comments (`#`)
- Prevents duplicate downloads
- Shows a download progress bar
- Logs success/failure for each URL

---

## 📦 Requirements

- Unix-like OS (Linux, macOS)
- `bash` shell
- `curl` installed

---

## 🚀 Usage

```bash
./sourcescraper.sh path/to/js.txt
