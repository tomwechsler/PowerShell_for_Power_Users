Clear-Host

#Help about Get-TimeZone
Get-Help -Name Get-TimeZone

#Online help about Get-TimeZone
Get-Help -Name Get-TimeZone -Online
	
#https://docs.microsoft.com/de-de/powershell/module/
#https://aka.ms/pscore6-docs

Update-Help * -Force

Update-Help -UICulture en-US -Force

Get-Command Get-Help -Syntax

Get-Help -Name Get-Process -Examples

Get-Help -Name Get-Process -Full

Get-Help Get-Help

#Help on conceptual topics of PowerShell are to be understood from detailed background texts
Get-Help -Name about_*

Get-Help -Name about_CommonParameters

#If the search term is found in several help files, the hits are listed
Get-Help "process"

#The question is in which help files the term Virtual Disk can be found. 
Get-Help "Virtual Disk"
