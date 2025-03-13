#!/bin/bash

yaml_file="topics.yaml"
index_file="index.md"
base_url="https://github.com/astrolophith/doc_basher/blob/main" #Can be command line argument.

# Check if YAML file exists and is readable
if [[ ! -f "$yaml_file" ]]; then
    echo "Error: YAML file '$yaml_file' not found."
    exit 1
fi

if [[ ! -r "$yaml_file" ]]; then
    echo "Error: YAML file '$yaml_file' not readable."
    exit 1
fi

# Function to generate filename
generate_md_filename() {
    local topic="$1"
    local subtopic="$2"
    local dirty_filename="${topic}_${subtopic}.md"
    echo "$(echo "$dirty_filename" | tr ' ' '_' | tr -cd '[:alnum:]._-')"
}

# Find the topics directory
topics_dir=$(find . -maxdepth 1 -type d -exec sh -c 'ls "{}"/*.md > /dev/null 2>&1' \; -print -quit)

if [[ -z "$topics_dir" ]]; then
    echo "Error: Could not find topics directory."
    exit 1
fi

index_path="${topics_dir}/${index_file}"

# Generate README index
echo "# Bash Documentation Index" > "$index_path"
echo -e "\nThis is an auto-generated index of all documentation files.\n" >> "$index_path"

current_topic=""

while IFS= read -r line; do
    if [[ "$line" =~ ^[A-Za-z].*:$ ]]; then
        current_topic=$(echo "$line" | sed 's/://')
        echo "## $current_topic" >> "$index_path"
    elif [[ "$line" =~ ^\ \ -\ .*: ]]; then
        if [[ -z "$current_topic" ]]; then
            echo "Error: Subtopic found before any Topic. Skipping line: $line"
            continue;
        fi
        subtopic=$(echo "$line" | sed 's/^  - //; s/:.*//')
        filename=$(generate_md_filename "$current_topic" "$subtopic")
        echo "- [$subtopic]($base_url/$topics_dir/$filename)" >> "$index_path"
    fi
done < "$yaml_file"

echo "Generated: $index_path"