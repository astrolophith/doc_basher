# doc_basher
Generate Documentation Topics and Index with Bash

My example documentations is AI generated. 

## Instructions
- Create a list of topics in topics.yaml
- Generate topics MD files using gen_md_files.sh
- Generate Index links with gen_index.sh

## [Example Topics Index](https://github.com/astrolophith/doc_basher/blob/main/Bash_Scripting/index.md)

---

### **How It Works**
1. **`generate_md.sh`**:
   - Reads the `topics.yaml` file.
   - Generates Markdown files for each subtopic.
   - Does not modify the `README.md` file.

2. **`generate_index.sh`**:
   - Reads the same `topics.yaml` file.
   - Generates a `index.md` file with an index of links to the Markdown files.
   - Links are formatted as `[Subtopic](URL)`.

---

### **Steps to Run the Scripts**
1. Save `generate_md.sh` and `generate_index.sh` to your project directory.
2. Make both scripts executable:
   ```bash
   chmod +x generate_md.sh
   chmod +x generate_index.sh
   ```
3. Run `generate_md.sh` first to create the Markdown files:
   ```bash
   ./generate_md.sh
   ```
4. Run `generate_index.sh` to create the `index.md` index:
   ```bash
   ./generate_index.sh
   ```

---
