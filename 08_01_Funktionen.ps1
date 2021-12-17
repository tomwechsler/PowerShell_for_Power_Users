Clear-Host

########
#A function is a list of PowerShell statements that has a name that you give it. To execute a function enter this name
########

#A simple function has the following basic structure:

function functionname
{
    Instruction
}

#The keyword function introduces the definition of a function

#In this example, a greeting formula that is output to the console was used as 
#the statement block of a new function named according to the usual naming conventions.
function Get-AD_Greeting
{
Write-Host "Schöne Grüsse aus der Schweiz!"
}

Get-AD_Greeting

#We retrieve information about the PowerShell core process via a function, and only properties in an easily readable form
function Get-AD_PwshInfo
{
Get-Process -Name pwsh | Select-Object -Property Name, Id,
Product, ProductVersion, Path, StartTime
}

Get-AD_PwshInfo

#Instead of the pipeline used above, we can also formulate more clearly
$pwsh = Get-Process -Name pwsh
Select-Object -InputObject $pwsh -Property Name, Id, Product, ProductVersion, Path, StartTime

#Leap year?
function Get-AD_LeapYear
{
[int]$jahr = Read-Host "Jahr (vierstellig)"
if ([datetime]::IsLeapYear($jahr))
{
Write-Host "$jahr ist ein Schaltjahr."
}
else
{
Write-Host "$jahr ist KEIN Schaltjahr."
}
}

Get-AD_LeapYear


#To get an overview of the available functions, we use the following:
Get-ChildItem -Path Function:

#All functions of available but currently not loaded modules
Get-Command -CommandType Function

#Function with named parameter
function Get-AD_ProcessInfo
{
param ($Process)
Get-Process -Name $Process | Select-Object -Property Name, Id, Product, ProductVersion, Path, StartTime
}

#The parameter must be specified when the function is called
Get-AD_ProcessInfo -Process winlogon

#The function is written in alternative notation and with fewer line breaks to save space
function Get-AD_LeapYear ([int]$jahr)
{
if ([datetime]::IsLeapYear($jahr))
{ Write-Host "$jahr ist ein Schaltjahr." }
else
{ Write-Host "$jahr ist KEIN Schaltjahr." }
}

Get-AD_LeapYear -jahr 1975


#Provide parameters with default values
function Get-AD_LeapYear ([int]$jahr = (Get-Date).Year)
{
if ([datetime]::IsLeapYear($jahr))
{ Write-Host "$jahr ist ein Schaltjahr." }
else
{ Write-Host "$jahr ist KEIN Schaltjahr." }
}

Get-AD_LeapYear

#Insert switch parameters
function Test-AD_Switch
{
param ([switch] $schalter)
if ($schalter)
{ Write-Host "EIN" }
else
{ Write-Host "AUS" }
}

#We get Ein
Test-AD_Switch -schalter

#We get AUS
Test-AD_Switch

#Use simple position parameters
function Get-AD_PosParam
{
$n = 1
foreach ($arg in $args)
{
Write-Host "Eingegebener Parameter $n = $arg"
$n++
}
}

#This function outputs the parameters passed with the function call numbered and 
#line by line via a foreach loop.
Get-AD_PosParam 1 2 4 "acht" 16