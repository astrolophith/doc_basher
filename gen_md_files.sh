#!/bin/bash

# Input YAML file
yaml_file="topics.yaml"

# Function to generate Markdown files
generate_md() {
  local topic="$1"
  local subtopic="$2"
  local content="$3"
  
  # Create a filename (replace spaces with underscores and remove special characters)
  filename="${topic}_${subtopic}.md"
  filename=$(echo "$filename" | tr ' ' '_' | tr -cd '[:alnum:]._-')

  # Write the content to the Markdown file
  [[ -f $filename ]] || {
    echo "# $topic: $subtopic" > "$filename"
    echo -e "\n## Details" >> "$filename"
    echo -e "$content" | sed 's/, /\n/g' | sed 's/^/- /' >> "$filename"
    echo "Generated: $filename"
  }

}

# Read the YAML file and process it
while IFS= read -r line; do
  if [[ "$line" =~ ^[A-Za-z].*:$ ]]; then
    # Extract the topic
    topic=$(echo "$line" | sed 's/://')
  elif [[ "$line" =~ ^\ \ -\ .*: ]]; then
    # Extract the subtopic and content
    subtopic=$(echo "$line" | sed 's/^  - //; s/:.*//')
    content=$(echo "$line" | sed 's/^.*: //')
    generate_md "$topic" "$subtopic" "$content"
  fi
done < "$yaml_file"