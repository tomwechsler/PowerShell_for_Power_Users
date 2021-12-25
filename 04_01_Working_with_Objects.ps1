Clear-Host

#PowerShell is object-oriented. When you type a command, 
#PowerShell creates an object as a result.

#The current date (It is a complete object)
Get-Date | Get-Member

#The object created with the help of Get-Date has among 
#others the properties DayOfYear and DayOfWeek.
(Get-Date).DayOfYear

(Get-Date -Date "05.10.1826").DayOfWeek

#The calc app
calc.exe

#We can use not only properties but also methods, for example:
(Get-Process -Name "*calc*").kill()

#As we already know we can use Get-Member to locate the properties and methods
Get-Process

Get-Process | Get-Member

#Work with the properties
Get-Process -Name "pwsh"

Get-Process -Name "pwsh" | Select-Object -Property "*"

(Get-Process -Name "pwsh").StartTime