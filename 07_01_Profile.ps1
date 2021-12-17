Clear-Host

#####
#PowerShell is sympathetic, it forgets a lot. If we don't want PowerShell to forget, we can work with profile scripts.
#####

#The profile paths under Windows
$PROFILE.AllUsersAllHosts
$PROFILE.AllUsersCurrentHost
$PROFILE.CurrentUserAllHosts
$PROFILE.CurrentUserCurrentHost
$PROFILE

#Does a profile file already exist?
Test-Path -Path $PROFILE

#Creating a profile file
New-Item -Path $PROFILE -ItemType File

#Open with notpad
notepad $PROFILE

#A few example settings...
$Tag = (Get-Date).DayOfYear
$Jahr = (Get-Date).Year
Write-Host "Hallo, $env:USERNAME!" -ForegroundColor White -BackgroundColor Blue
Write-Host "Heute ist der $Tag. Tag des Jahres $Jahr."
#...and many more definitions

#Press Windows + R (start without a profile)
pwsh -NoProfile

#There are more parameters for the PowerShell startup
Get-Help about_pwsh

#Execution guidelines for script files

#Check the ExecutionPolicy
Get-ExecutionPolicy -List

Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned

Set-ExecutionPolicy RemoteSigned

Set-ExecutionPolicy -Scope CurrentUser RemoteSigned

Set-ExecutionPolicy -Scope LocalMachine Restricted

#Change colors and prompt permanently. 
Get-PSReadLineOption

Get-PSReadLineOption | Get-Member -Name *color

Set-PSReadLineOption -Colors @{"Number" = "DarkYellow"; "Parameter" = "Cyan"}

Set-PSReadLineOption -Colors @{"Variable" = "#FFA500"}

Set-PSReadLineOption -Colors @{
"Number" = "DarkYellow"; 
"Parameter" = "Cyan"; 
"Variable" = "#FFA500"
}

#multiline without separator
Set-PSReadLineOption -Colors @{
"Number" = "DarkYellow"
"Parameter" = "Cyan"
"Variable" = "#FFA500"
}

#Colors for the error messages
$Host.PrivateData.ErrorForegroundColor = "DarkRed"
$Host.PrivateData.ErrorBackgroundColor = "Yellow"

Get-Error

#Customize prompt in the console with a function
function prompt {"PS [$(hostname)> "}
function prompt {"PS [$env:COMPUTERNAME]> "}
function prompt {"$(Get-Date)> "}

#Only the current time in the prompt, the rest in the title line from the ISE
function prompt {"PS $(Get-Date -Format HH:mm)> "; $Host.UI.RawUI.WindowTitle = "$(Get-Location) +++ Benutzer: $env:USERNAME"}

#A complete profile script...
$Tag = (Get-Date).DayOfYear
$Jahr = (Get-Date).Year
Write-Host "Hallo, $env:USERNAME!" -ForegroundColor White -BackgroundColor Blue
Write-Host "Heute ist der $Tag. Tag des Jahres $Jahr."

Set-PSReadLineOption -Colors @{
"Number" = "DarkYellow"
"Parameter" = "Cyan"
"Variable" = "#FFA500"
}
$Host.PrivateData.ErrorForegroundColor = "DarkBlue"
$Host.PrivateData.ErrorBackgroundColor = "DarkYellow"
#...and many more definitions