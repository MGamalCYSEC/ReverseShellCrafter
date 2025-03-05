
---

# ReverseShellCrafter 
*A collection of reverse shell scripts for ethical hacking and penetration testing.*

---

## 🚀 **About**  
ReverseShellForge is a repository containing reverse shell payloads written in various programming languages and technologies. These scripts are designed to help penetration testers, ethical hackers, and security researchers during red team assessments or Capture The Flag (CTF) challenges.

### **Key Features**  
- Reverse shells in multiple languages (e.g., Bash, Python, PHP, ASP, ASPX, Perl, Ruby, and more).  
- Easy-to-use templates for command execution and payload customization.  
- Scripts for both Windows and Linux environments.  
- Ready for testing and educational purposes.  

---

## 📂 **Contents**  
Server-Side Reverse shell

- [Testing Server-Side](https://github.com/MGamalCYSEC/ReverseShellCrafter/blob/main/Server-Side%20Reverse%20shell/Testing%20Server-Side.md) 
- [Server Side Reverse Shell](https://github.com/MGamalCYSEC/ReverseShellCrafter/tree/main/Server-Side%20Reverse%20shell)
  - [URL Command Execution](https://github.com/MGamalCYSEC/ReverseShellCrafter/tree/main/Server-Side%20Reverse%20shell/URL-Command-Execution) (PHP - asp - aspx)
  - [Reverse Shell Using NetCat](https://github.com/MGamalCYSEC/ReverseShellCrafter/tree/main/Server-Side%20Reverse%20shell/ReverseShell%20Using%20NetCat) (PHP - asp - aspx)

---

## 🛠 **Setup and Usage**  

### **Step 1**: Start a Listener  
Start a Netcat listener on your local machine to catch the reverse shell connection. Replace `<PORT>` with the desired port number:  
```bash
rlwrap nc -nlvp <PORT>
```

### **Step 2**: Customize the Script  
Edit the script to replace `<LOCAL-IP>` with your IP address and `<PORT>` with the port used in the listener.

### **Step 3**: Upload and Execute  
1. Upload the script to the target machine or web server.  
2. Execute the script using the appropriate method (e.g., accessing it via a browser for web shells, running it directly on the target machine, etc.).  

### **Example**  
For a PHP reverse shell:  
1. Upload `reverse.php` to the server.  
2. Visit `http://<target>/reverse.php` in your browser.  
3. Receive the shell on your Netcat listener.

---

## ⚠️ **Disclaimer**  
This repository is intended **only for legal and ethical use**. Unauthorized use of these tools on systems without explicit permission is illegal and punishable under law. Always ensure you have appropriate authorization before conducting any tests.

---

## 🌐 **Connect**  
Feel free to reach out for suggestions or discussions:  
[LinkedIn](https://www.linkedin.com/in/mgamal202/)
---

This README provides a professional and comprehensive overview of your repository, making it easy for users to understand and use your scripts effectively!
