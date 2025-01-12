# **Purpose**:
    Adds a user `hacker` with a password `password123`.
    Elevates the user to the Administrators group.

---

## ** Compile the Malicious DLL**

1. **Install the C++ Compiler**:
   - If you're on Linux, install the required package:
     ```bash
     sudo apt install g++-mingw-w64-x86-64
     ```

   - Ensure both the C and C++ components of MinGW are installed. You need the C++ compiler (`x86_64-w64-mingw32-g++`) for `.cpp` files.

2. **Use the  Compiler**:
   - For `.cpp` files, use `x86_64-w64-mingw32-g++` instead of `x86_64-w64-mingw32-gcc`:
     ```bash
     x86_64-w64-mingw32-g++ vv.cpp --shared -o addUser.dll
     ```
