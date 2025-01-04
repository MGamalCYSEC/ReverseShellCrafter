Let's break down the command `useradd -m -s /bin/bash dork && echo 'dork:123' | sudo chpasswd && sudo usermod -aG sudo dork` into its components and explain each step in detail.

### Step-by-Step Explanation:

1. **Creating the user `dork` with a home directory and a specific shell:**
   ```bash
   useradd -m -s /bin/bash dork
   ```
   - **`useradd`**: Command to create a new user.
   - **`-m`**: Creates the user's home directory if it does not exist.
   - **`-s /bin/bash`**: Sets the user's login shell to `/bin/bash`.
   - **`dork`**: The username of the new user.

   This command creates a new user `dork`, ensures they have a home directory (e.g., `/home/dork`), and sets their default shell to `/bin/bash`.

2. **Setting the password for the user `dork`:**
   ```bash
   echo 'dork:123' | sudo chpasswd
   ```
   - **`echo 'dork:123'`**: Echoes the string `dork:123`, where `dork` is the username and `123` is the password.
   - **`|`**: Pipe operator that passes the output of the preceding command (`echo 'dork:123'`) as input to the following command (`sudo chpasswd`).
   - **`sudo chpasswd`**: Runs the `chpasswd` command with superuser privileges (using `sudo`). `chpasswd` reads a username and password pair from its input and updates the password.

   This command sets the password for the user `dork` to `123`.

3. **Adding the user `dork` to the `sudo` group:**
   ```bash
   sudo usermod -aG sudo dork
   ```
   - **`sudo`**: Executes the command with superuser privileges.
   - **`usermod`**: Command to modify a user account.
   - **`-aG sudo`**: Adds the user to the specified group. `-a` appends the user to the group, and `-G sudo` specifies the `sudo` group.
   - **`dork`**: The username of the user to be modified.

   This command adds the user `dork` to the `sudo` group, granting them sudo privileges.
### Create root password from passwd file:
 "hack" a password by editing the `/etc/passwd` file directly, here's the method in a quick, concise manner:
1. **Generate a Password Hash**:
   Use `openssl` to generate a hash for your chosen password:
   ```bash
   openssl passwd -1
   ```
   Enter the password you want, and you’ll get a hash like:
   ```
   $1$HyqKu9OH$9ASGGUDT0ohZUOqs1KA5E0
   ```
2. **Edit the `/etc/passwd` File**:
   Open `/etc/passwd`:
   ```bash
   sudo nano /etc/passwd
   ```
   Find the line for the `root` user:
   ```
   root:x:0:0:root:/root:/bin/bash
   ```
   Replace the `x` with the hash:
   ```
   root:$1$randomsalt$YzDdVkjyhfuiOP5k/35zY/:0:0:root:/root:/bin/bash
   ```
3. **Save and Exit**:
   Save the file and exit. Now, the `root` password is set to the password you hashed.
