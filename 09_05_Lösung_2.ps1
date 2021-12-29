#Remote system port test
Test-NetConnection -ComputerName 192.168.1.60 -CommonTCPPort RDP

Test-NetConnection -ComputerName 192.168.1.60 -Port 3389

Test-NetConnection -ComputerName 8.8.8.8 -Port 53