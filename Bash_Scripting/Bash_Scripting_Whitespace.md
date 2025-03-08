# Bash Scripting: Whitespace

## Details
Whitespace and Line breaks

Using whitespace and line breaks for Bash script readability and maintainability. Here's an overview of best practices:

**1. General Whitespace (Spaces and Tabs):**

* **Spaces Around Operators:**
    * Always use spaces around operators like `=`, `==`, `!=`, `[ ]`, `[[ ]]`, `&&`, `||`, `-eq`, `-lt`, etc.
    * This makes your code much easier to read.
* **Indentation:**
    * Use consistent indentation (spaces or tabs, but be consistent) to highlight code blocks within `if` statements, `for` loops, `while` loops, and functions.
    * Consistent indentation is essential for understanding the script's structure.
* **Spaces in Command Arguments:**
    * Use spaces to separate command names from their arguments.
    * Example: `echo "Hello, world!"`
* **Tabs vs. Spaces:**
    * Choose either tabs or spaces for indentation and stick with it.
    * Spaces are generally preferred because they ensure consistent formatting across different editors and systems.
    * Configure your editor to use spaces instead of tabs.

**2. Line Breaks and Empty Lines:**

* **Empty Lines for Readability:**
    * Use empty lines to separate logical sections of your script.
    * This makes it easier to visually parse the code.
    * Use empty lines:
        * Between functions.
        * Between major code blocks.
        * Before and after `if`, `for`, `while`, and `case` statements.
* **Line Breaks in Long Lines:**
    * Break long lines into multiple lines using the backslash `\` character.
    * This is especially important for long conditional statements and command sequences.
* **Line Breaks in Functions:**
    * Place each command on a new line within functions.
    * This improves readability and makes it easier to debug.
    * Use empty lines to separate logical sections within functions.
* **Line Breaks in Conditional Statements:**
    * Place `then`, `else`, `elif`, and `fi` on separate lines.
    * Indent the code within `then`, `else`, and `elif` blocks.
* **Line Breaks in Loops:**
    * Place `do` and `done` on separate lines.
    * Indent the code within the loop.
* **Line Breaks in `case` Statements:**
    * Place each `case` pattern and its corresponding commands on separate lines.
    * Place `;;` on a separate line.

**3. Specific Examples:**

* **Functions:**

```bash
function my_function {

    local var1="value1"

    # Some logical section
    command1
    command2

    # Another logical section
    command3
    command4

}

function another_function {
    # ...
}
```

* **`if` Statements:**

```bash
if [[ "$var" -eq 1 ]]; then

    command1
    command2

elif [[ "$var" -eq 2 ]]; then

    command3

else

    command4

fi
```

* **Loops:**

```bash
for item in "$list"; do

    process_item "$item"

done

while [[ "$count" -lt 10 ]]; do

    increment_count

done
```

* **`case` Statements:**

```bash
case "$var" in
    "value1")
        command1
        command2
        ;;
    "value2")
        command3
        ;;
    *)
        command4
        ;;
esac
```

**Key Takeaways:**

* Consistent whitespace and line breaks are essential for readable Bash scripts.
* Use empty lines to separate logical sections of your code.
* Indent code blocks to highlight their structure.
* Choose either tabs or spaces for indentation and stick with it.
* Prioritize readability over brevity.
