# Bash Scripting: Sudo Privilege

## Details
Checking for sudo privilege

### It's important to differentiate between:

* **Checking if a user *can* use sudo:** This means they are in the sudoers file or a relevant group.
* **Checking if a user can use sudo *without a password*:** This means their sudo permissions are configured with the `NOPASSWD` option.

Here's a breakdown of how to approach this, and what to expect:

**1. Checking if a User Can Use Sudo (Potentially with Password):**

* The `sudo -l` command is useful for listing a user's sudo privileges. However, it's crucial to understand that:
    * If the user's sudo session has timed out, or if they haven't used sudo recently, `sudo -l` might prompt for a password.
    * Therefore, `sudo -l` by itself doesn't guarantee a password-less check.

**2. Checking if a User Can Use Sudo Without a Password:**

* The most reliable way to check for password-less sudo permissions is to use `sudo -n`. The `-n` option tells `sudo` to run in non-interactive mode.
    * If the user has `NOPASSWD` privileges for the command being tested, `sudo -n` will succeed.
    * If a password is required, `sudo -n` will fail and return a non-zero exit code.
* Here is an example of checking if a user can run the true command without a password.
    ```bash
    if sudo -n true 2>/dev/null; then
        echo "User can use sudo without a password."
    else
        echo "User requires a password for sudo."
    fi
    ```
    * `sudo -n true`: Attempts to run the `true` command with sudo in non-interactive mode.
    * `2>/dev/null`: Suppresses error messages.
    * The `if` statement checks the exit code of `sudo -n true`.

**Key Considerations:**

* **sudoers Configuration:** The `sudoers` file (`/etc/sudoers`) controls sudo permissions. The `NOPASSWD` option in this file is what allows password-less sudo.
* **sudo Timeout:** `sudo` caches authentication for a period of time. If the user hasn't used `sudo` recently, they will be prompted for a password, even if they have `NOPASSWD` privileges.
* **Security:** Be very cautious when granting `NOPASSWD` privileges. It can create significant security risks if not used carefully.

**In summary:**

* To check for password-less sudo, use `sudo -n`.
* Be aware of sudo timeout and the security implications of `NOPASSWD` privileges.
* The script will pause and request a password if the user does not have the NOPASSWD setting, and the sudo authentication has timed out.