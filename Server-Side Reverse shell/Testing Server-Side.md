### **1. PHP Info File**

```php
<?php
phpinfo();
?>
```

- **Access**: Upload the file and visit `http://<target>/info.php`.

---
### **2. ASP Info File**

```asp
<%
Response.Write("ASP is supported!<br>")
Response.Write("Server: " & Request.ServerVariables("SERVER_SOFTWARE") & "<br>")
Response.Write("Platform: " & Request.ServerVariables("OS") & "<br>")
%>
```

- **Access**: Upload the file and visit `http://<target>/info.asp`.

---

### **3. ASPX Info File**

```aspx
<%@ Page Language="C#" %>
<!DOCTYPE html>
<html>
<head>
    <title>ASPX Info</title>
</head>
<body>
    <h1>ASPX is supported!</h1>
    <p>Server: <% =Environment.MachineName %></p>
    <p>OS Version: <% =Environment.OSVersion %></p>
</body>
</html>
```

- **Access**: Upload the file and visit `http://<target>/info.aspx`.

---
### **Testing Steps**

1. Upload each file to the server.
2. Visit the URLs for each file:
    - PHP: `http://<target>/info.php`
    - ASP: `http://<target>/info.asp`
    - ASPX: `http://<target>/info.aspx`
3. Check the output:
    - If the file executes and displays results, the server supports the respective technology.
    - If it does not execute or returns an error, the technology is not supported or configured.

These files are lightweight and effective for quick server diagnostics.
