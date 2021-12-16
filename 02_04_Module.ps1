#Get installed modules and available modules
Get-Module -ListAvailable

#Get all exported files
Get-Module -ListAvailable -All

#Get properties of a module
Get-Module | Get-Member -MemberType Property | Format-Table Name

#Let's use it
Get-Module -Name Microsoft.PowerShell.Management | Select-Object AccessMode,Author,ClrVersion

#Get all installed modules
Get-InstalledModule

#Find a module by name
Find-Module -Name PowerShellGet

#Find modules with similar names
Find-Module -Name PowerShell*

#Find a module by minimum version:
Find-Module -Name PowerShellGet -MinimumVersion 2.2.5

#Find a module in a specific repository:
Find-Module -Name PowerShellGet -Repository PSGallery

#Find a module by name
Find-Module -Name NewRandomPassword

#Install the module
Install-Module -Name NewRandomPassword

#Is it available
Get-Module -ListAvailable -Name NewRandomPassword

#Just an example
Get-Help New-RandomPassword

#Get a password
New-RandomPassword -MinimumLength 8 -MaximumLength 16 -FirstCharacter "8" -Count 10
