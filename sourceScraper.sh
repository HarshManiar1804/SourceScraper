#!/bin/bash

# SourceScraper - A shell script to download JavaScript files from a list of URLs.

# Exit immediately on any error
set -e

# Check if the js.txt file argument is provided
if [ -z "$1" ]; then
    echo "Usage: $0 path/to/js.txt"
    exit 1
fi

js_list_file="$1"

# Check if the file exists
if [ ! -f "$js_list_file" ]; then
    echo "File not found: $js_list_file"
    exit 1
fi

# Get the directory path of the js.txt file
js_directory=$(dirname "$js_list_file")

# Create the data directory if it doesn't exist
data_dir="$js_directory/data"
mkdir -p "$data_dir"

# Log file
log_file="$data_dir/download.log"
echo "Download started at $(date)" > "$log_file"

# Read the js.txt file line by line
while IFS= read -r url || [ -n "$url" ]; do
    # Skip empty lines and comments
    [[ -z "$url" || "$url" =~ ^# ]] && continue

    file_name=$(basename "$url")
    output_path="$data_dir/$file_name"

    if [ -f "$output_path" ]; then
        echo "Skipping (already exists): $file_name"
        echo "SKIPPED $url" >> "$log_file"
        continue
    fi

    echo "Downloading: $file_name"
    if curl -# --fail --location "$url" -o "$output_path"; then
        echo "Downloaded: $file_name"
        echo "SUCCESS $url" >> "$log_file"
    else
        echo "Failed to download: $file_name"
        echo "FAILED $url" >> "$log_file"
    fi
done < "$js_list_file"

echo "Download complete. Logs saved to $log_file"
