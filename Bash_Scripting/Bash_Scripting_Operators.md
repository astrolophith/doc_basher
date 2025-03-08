# Bash Scripting: Operators

## Details
Operator Precedence

Bash conditional operator precedence dictates the order in which operators are evaluated in compound conditional expressions. Here's a concise overview:

**Highest Precedence:**

1.  **Grouping:**
    * Parentheses `( )` or curly braces `{ }` are used to explicitly group expressions, overriding default precedence.

2.  **Unary Operators:**
    * Unary operators like `!` (logical NOT) have high precedence.

3.  **Arithmetic Operators:**
    * Arithmetic operators (e.g., `-eq`, `-ne`, `-lt`, `-gt`, `-le`, `-ge`) are evaluated next.

4.  **String Comparison Operators:**
    * String comparison operators (e.g., `=`, `==`, `!=`, `<`, `>`) are evaluated after arithmetic operators.

5.  **File Test Operators:**
    * File test operators (e.g., `-f`, `-d`, `-r`, `-w`, `-x`) are also evaluated at this level.

6.  **Logical AND:**
    * `&&` (logical AND) is evaluated before `||`.

7.  **Logical OR:**
    * `||` (logical OR) has the lowest precedence.

**Key Points:**

* Use parentheses or curly braces to explicitly control the order of evaluation when you have complex conditional expressions.
* `&&` is evaluated before `||`.
* `!` has a very high precedence.
* In the context of the `[[ ]]` test, operators like `&&` and `||` behave more predictably than in the older `[ ]` test.
* The order of operations is very important when using short circuit evaluation.- Operator Precedence