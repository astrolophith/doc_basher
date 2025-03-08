# Bash Scripting: Functions

## Details
Defining and calling functions, Passing arguments to functions, Return values

### Bash Function Syntax Rules and Best Practices

## Function Syntax

In Bash, functions are defined using the following syntax:

```bash
function_name () {
    # Function body
    commands
}
```

Alternatively, you can use the `function` keyword:

```bash
function function_name {
    # Function body
    commands
}
```

## Function Definition

The basic syntax for defining a Bash function is:

```bash
function function_name {
  # Function body
  command1
  command2
  ...
}

# Or, a shorter syntax (preferred):

function_name() {
  # Function body
  command1
  command2
  ...
}
```

* `function_name`: The name of your function. Choose descriptive names that reflect the function's purpose.
* `{ ... }`: The curly braces enclose the function's body, which contains the commands to be executed.

## Calling Functions

To execute a function, simply use its name:

```bash
function_name
```

## Function Arguments

Bash functions can accept arguments, which are accessed using positional parameters:

* `$1`: The first argument.
* `$2`: The second argument.
* `$3`, `$4`, ...: Subsequent arguments.
* `$#`: The number of arguments.
* `$@`: All arguments as separate words.
* `$*`: All arguments as a single string.

Example:

```bash
my_function() {
  echo "First argument: $1"
  echo "Second argument: $2"
  echo "Number of arguments: $#"
  echo "All arguments: $@"
}

my_function "hello" "world" "!"
```

Output:

```
First argument: hello
Second argument: world
Number of arguments: 3
All arguments: hello world !
```

## Return Values

Bash functions implicitly return the exit status of the last executed command. You can also explicitly return an integer value using the `return` keyword:

```bash
my_function() {
  if some_condition; then
    return 0 # Success
  else
    return 1 # Failure
  fi
}

my_function
if [[ $? -eq 0 ]]; then
  echo "Function succeeded."
else
  echo "Function failed."
fi
```

* `return 0`: Indicates success.
* `return 1` (or any non-zero value): Indicates failure.
* `$?`: Special variable containing the exit status of the last executed command.

**Important:** `return` can only return integer values between 0 and 255. If you need to return complex data, use output redirection or global variables (with caution).

## Best Practices

* **Descriptive Names:** Use meaningful names for your functions to improve readability.
* **Modular Code:** Break down complex scripts into smaller, reusable functions.
* **Argument Validation:** If your function expects specific arguments, validate them to prevent errors.
* **Local Variables:** Use `local` to declare variables within a function's scope. This prevents unintended side effects.
    ```bash
    my_function() {
      local my_variable="local value"
      echo "$my_variable"
    }
    ```
* **Error Handling:** Check the exit status of commands within your functions and handle errors gracefully.
* **Comments:** Add comments to explain the purpose and functionality of your functions.
* **Consistent Style:** Maintain a consistent coding style throughout your script.
* **Avoid Global Variables (When Possible):** overuse of global variables can make debugging difficult. Prefer returning values or passing information as arguments.
* **Use `set -u`:** Include `set -u` at the top of your script to treat unset variables as errors, helping catch potential bugs.
* **Use `set -e`:** Include `set -e` at the top of your script to exit immediately if a command fails, preventing unexpected behavior.
* **Use `set -o pipefail`:** Include `set -o pipefail` to make pipelines return a non-zero exit code if any command in the pipeline fails.

## Example with Arguments and Return Value

```bash
#!/bin/bash

# Function to add two numbers
add_numbers() {
  local num1="$1"
  local num2="$2"

  if [[ -z "$num1" || -z "$num2" ]]; then
    echo "Error: Missing arguments."
    return 1
  fi

  if [[ ! "$num1" =~ ^[0-9]+$ || ! "$num2" =~ ^[0-9]+$ ]]; then
    echo "Error: Arguments must be numbers."
    return 2
  fi

  local sum=$((num1 + num2))
  echo "$sum"
  return 0
}

# Main script
add_numbers 10 20
if [[ $? -eq 0 ]]; then
  echo "Sum: $?" # $? will be zero here, the echo in add_numbers printed the sum.
else
  echo "Addition failed."
fi

add_numbers "abc" 20
if [[ $? -eq 0 ]]; then
  echo "Sum: $?"
else
  echo "Addition failed."
fi
```


## Best Practices

### 1. **Use Descriptive Names**
   - Choose function names that clearly describe their purpose.
   - Use lowercase letters and separate words with underscores.

   ```bash
   calculate_sum() {
       # Function logic
   }
   ```

### 2. **Local Variables**
   - Use `local` to declare variables within functions to avoid polluting the global namespace.

   ```bash
   greet() {
       local name=$1
       echo "Hello, $name!"
   }
   ```

### 3. **Return Values**
   - Functions return the exit status of the last command executed.
   - Use `return` to explicitly return a status code (0 for success, non-zero for failure).

   ```bash
   is_even() {
       local num=$1
       if (( num % 2 == 0 )); then
           return 0
       else
           return 1
       fi
   }

   is_even 4
   echo $?  # Prints 0 (success)
   ```

### 4. **Pass Arguments**
   - Access arguments using `$1`, `$2`, etc.
   - Use `$@` to refer to all arguments.

   ```bash
   print_args() {
       echo "First argument: $1"
       echo "All arguments: $@"
   }

   print_args "arg1" "arg2" "arg3"
   ```

### 5. **Use Comments**
   - Add comments to explain the purpose and logic of the function.

   ```bash
   # Calculates the sum of two numbers
   sum() {
       local a=$1
       local b=$2
       echo $((a + b))
   }
   ```

### 6. **Avoid Global Side Effects**
   - Minimize the use of global variables to avoid unintended side effects.

   ```bash
   bad_example() {
       global_var="modified"  # Avoid this
   }

   good_example() {
       local local_var="safe"
   }
   ```

### 7. **Error Handling**
   - Use `set -e` to exit on error and `set -u` to treat unset variables as an error.
   - Check for errors within functions and handle them appropriately.

   ```bash
   safe_division() {
       local numerator=$1
       local denominator=$2

       if (( denominator == 0 )); then
           echo "Error: Division by zero"
           return 1
       fi

       echo $((numerator / denominator))
   }
   ```

### 8. **Keep Functions Small**
   - Write small, single-purpose functions for better readability and maintainability.

   ```bash
   # Good: Small, focused function
   capitalize() {
       local str=$1
       echo "${str^}"
   }
   ```

### 9. **Use `shift` for Argument Parsing**
   - Use `shift` to handle optional arguments or flags.

   ```bash
   process_args() {
       while [[ $# -gt 0 ]]; do
           case $1 in
               -f|--file)
                   file=$2
                   shift 2
                   ;;
               -v|--verbose)
                   verbose=1
                   shift
                   ;;
               *)
                   echo "Unknown option: $1"
                   return 1
                   ;;
           esac
       done
   }
   ```

### 10. **Test Functions**
   - Write test cases to ensure your functions work as expected.

   ```bash
   test_sum() {
       result=$(sum 2 3)
       if [[ $result -eq 5 ]]; then
           echo "Test passed"
       else
           echo "Test failed"
       fi
   }

   test_sum
   ```