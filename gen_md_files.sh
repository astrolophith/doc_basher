#!/bin/bash

yaml_file="topics.yaml"

# Check if the YAML file exists and is readable
if [[ ! -f "$yaml_file" ]]; then
  echo "Error: YAML file '$yaml_file' not found."
  exit 1
fi

if [[ ! -r "$yaml_file" ]]; then
  echo "Error: YAML file '$yaml_file' not readable."
  exit 1
fi

# Extract the first topic
first_topic=$(sed -n '/^[A-Za-z].*:/{s/:.*//; p; q;}' "$yaml_file" | tr ' ' '_')

if [[ -z "$first_topic" ]]; then
  echo "Error: No topics found in '$yaml_file'."
  exit 1
fi

topics_dir="$first_topic"
[[ -d "$topics_dir" ]] || mkdir -p "$topics_dir"

generate_md_filename() {
  local topic="$1"
  local subtopic="$2"
  dirty_filename="${topic}_${subtopic}.md"
  filename=$(echo "$dirty_filename" | tr ' ' '_' | tr -cd '[:alnum:]._-')
  echo "$filename"
}

generate_md_file() {
  local filepath="$1"
  local topic="$2"
  local subtopic="$3"
  local content="$4"

  echo "# $topic: $subtopic" > "$filepath"
  echo -e "\n## Details" >> "$filepath"
  echo "$content" >> "$filepath" #removed the sed formatting.
  echo "Generated: $filepath"
}

current_topic="" #track current topic.
while IFS= read -r line; do
    if [[ "$line" =~ ^[A-Za-z].*:$ ]]; then
        current_topic=$(echo "$line" | sed 's/://')
    elif [[ "$line" =~ ^\ \ -\ .*: ]]; then
        if [[ -z "$current_topic" ]]; then
            echo "Error: Subtopic found before any Topic. Skipping line: $line"
            continue;
        fi
        subtopic=$(echo "$line" | sed 's/^  - //; s/:.*//')
        content=$(echo "$line" | sed 's/^.*: //')
        filename=$(generate_md_filename "$current_topic" "$subtopic")
        filepath="${topics_dir}/${filename}"
        if [[ ! -f "$filepath" ]]; then
            touch "$filepath"
            generate_md_file "$filepath" "$current_topic" "$subtopic" "$content"
        fi
    fi
done < "$yaml_file"