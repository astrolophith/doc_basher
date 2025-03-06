#!/bin/bash

# Input YAML file
yaml_file="topics.yaml"

# Output README file
readme_file="index.md"

# Base URL for GitHub pages
base_url="https://github.com/astrolophith/bash_aidocs/blob/main"

# Function to generate the README index
generate_readme_index() {
  echo "# Bash Documentation Index" > "$readme_file"
  echo -e "\nThis is an auto-generated index of all documentation files.\n" >> "$readme_file"
  
  while IFS= read -r line; do
    if [[ "$line" =~ ^[A-Za-z].*:$ ]]; then
      # Extract the topic
      topic=$(echo "$line" | sed 's/://')
      echo "## $topic" >> "$readme_file"
    elif [[ "$line" =~ ^\ \ -\ .*: ]]; then
      # Extract the subtopic
      subtopic=$(echo "$line" | sed 's/^  - //; s/:.*//')
      filename="${topic}_${subtopic}.md"
      filename=$(echo "$filename" | tr ' ' '_' | tr -cd '[:alnum:]._-')
      echo "- [$subtopic]($base_url/$filename)" >> "$readme_file"
    fi
  done < "$yaml_file"
}

# Generate the README index
generate_readme_index
echo "Generated: $readme_file"