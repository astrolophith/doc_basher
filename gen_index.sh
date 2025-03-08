#!/bin/bash

# Input YAML file
yaml_file="topics.yaml"

# Output README file
index_file="index.md"

# Base URL for GitHub pages
base_url="https://github.com/astrolophith/bash_aidocs/blob/main"

# Extract the first topic
first_topic=$(sed -n '/^[A-Za-z].*:/{s/:.*//; p; q;}' "$yaml_file" | tr ' ' '_')

if [[ -z "$first_topic" ]]; then
  echo "Error: No topics found in '$yaml_file'."
  exit 1
fi

# Topics directory
topics_dir="$first_topic"
index_path="${topics_dir}/${index_file}"

# Function to generate the README index
generate_readme_index() {
  echo "# Bash Documentation Index" > "$index_path"
  echo -e "\nThis is an auto-generated index of all documentation files.\n" >> "$index_path"
  
  while IFS= read -r line; do
    if [[ "$line" =~ ^[A-Za-z].*:$ ]]; then
      # Extract the topic
      topic=$(echo "$line" | sed 's/://')
      echo "## $topic" >> "$index_path"
    elif [[ "$line" =~ ^\ \ -\ .*: ]]; then
      # Extract the subtopic
      subtopic=$(echo "$line" | sed 's/^  - //; s/:.*//')
      dirty_filename="${topic}_${subtopic}.md"
      filename=$(echo "$dirty_filename" | tr ' ' '_' | tr -cd '[:alnum:]._-')
      echo "- [$subtopic]($base_url/$topics_dir/$filename)" >> "$index_path"
    fi
  done < "$yaml_file"
}

# Generate the README index
generate_readme_index
echo "Generated: $index_path"