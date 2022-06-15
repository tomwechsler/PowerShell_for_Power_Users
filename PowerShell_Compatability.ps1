#Enable WinRM
Set-WSManQuickConfig -SkipNetworkProfileCheck

#PowerShell Core Compatibility with Windows PowerShell modules
Get-Module -ListAvailable -SkipEditionCheck

Get-EventLog  #Fails in PowerShell Core

Install-Module WindowsCompatibility -Scope CurrentUser

Import-WinModule Microsoft.PowerShell.Management

Get-EventLog -Newest 5 -LogName "security"

#Behind the scenes
$c = Get-Command Get-EventLog
$c
$c.definition
Get-PSSession #Note the WinCompat session to local machine