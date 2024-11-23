The folder contains reverse shell scripts for PHP, ASP, and ASPX, which establish a reverse connection using `nc.exe` (Netcat) to a designated `local IP` and `port`, executing `cmd.exe` from the current directory. 

Ensure that you replace `<LOCAL-IP>` and `<PORT>` with the IP address and port number of your listener.

It is crucial that `nc.exe` is uploaded to the target machine in the same directory prior to execution for proper functionality.

- [PHP](https://github.com/MGamalCYSEC/ReverseShellCrafter/blob/main/Server-Side%20Reverse%20shell/ReverseShell%20Using%20NetCat/nc-reverse.php)
- [asp](https://github.com/MGamalCYSEC/ReverseShellCrafter/blob/main/Server-Side%20Reverse%20shell/ReverseShell%20Using%20NetCat/nc-reverse.asp)
- [aspx](https://github.com/MGamalCYSEC/ReverseShellCrafter/blob/main/Server-Side%20Reverse%20shell/ReverseShell%20Using%20NetCat/nc-reverse.aspx)
