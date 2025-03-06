# Bash Scripting: Readibility

## Details
- Line continuation
- Grouping
- Case statements
- Funciotns

You can improve the readability of long conditional statements in Bash using several techniques, including line continuation with `\` and other methods that avoid line breaks.

**1. Line Continuation with `\`:**

* You can use the backslash `\` character to break long lines into multiple lines.
* This is the most common and straightforward way to improve readability.
* **Important:** There should be no characters (including spaces) after the `\` on the line.
    ```bash
    if [[ "$var1" -gt 10 && \
          "$var2" == "some_string" && \
          -f "$file_path" && \
          "$var3" -le 100 ]]; then
      # Code here
    fi
    ```

**2. Grouping with Parentheses:**

* You can use parentheses `( )` to group parts of your conditional expression.
* This can make the logic clearer and allow you to break lines more naturally.
    ```bash
    if [[ ( "$var1" -gt 10 && "$var2" == "some_string" ) || \
          ( -f "$file_path" && "$var3" -le 100 ) ]]; then
      # Code here
    fi
    ```

**3. Using `case` Statements (for Multiple Comparisons):**

* If you're dealing with multiple comparisons of a single variable, a `case` statement can be more readable than a long `if` statement.
    ```bash
    case "$var" in
      "value1" | "value2")
        # Code here
        ;;
      "value3")
        # Code here
        ;;
      *)
        # Default code
        ;;
    esac
    ```

**4. Using Functions to Break Down Logic:**

* For very complex conditional logic, consider breaking it down into smaller functions.
* This improves readability and makes your code more modular.
    ```bash
    check_condition1() {
      [[ "$var1" -gt 10 && "$var2" == "some_string" ]]
    }

    check_condition2() {
      [[ -f "$file_path" && "$var3" -le 100 ]]
    }

    if check_condition1 || check_condition2; then
      # Code here
    fi
    ```

**5. Avoiding Line Breaks (Less Recommended):**

* While you *can* write long conditional statements on a single line, it's generally not recommended.
* It makes your code harder to read and maintain.
* However, if you must, ensure it is still logically grouped with parenthesis.
    ```bash
    if [[ ("$var1" -gt 10 && "$var2" == "some_string") || (-f "$file_path" && "$var3" -le 100) ]]; then #code here; fi
    ```
* This is not recommended, but is technically possible.

**Best Practices:**

* **Consistency:** Choose a style and stick with it throughout your script.
* **Indentation:** Use consistent indentation to highlight the structure of your conditional statements.
* **Comments:** Add comments to explain complex logic.
* **Meaningful Variable Names:** Use descriptive variable names to make your code more self-explanatory.
* **Short-Circuiting Awareness:** Understand how `&&` and `||` short-circuit evaluation. This is relevant to the order of your conditions.
