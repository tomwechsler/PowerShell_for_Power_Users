Clear-Host

###########
#Providers allow access to data and namespaces (information stores) within PowerShell. 
#Each provider is responsible for a specific information store. Drives are provided by the 
#providers in PowerShell. If a provider has been added or removed, the associated drives are also added or removed.
###########

#Get installed providers
Get-PSProvider

#Providers (indirectly) are added or removed by adding or removing modules

#Available drives
Get-PSDrive

#With Get-ChildItem you can equally list the files in a file system directory, items in the Windows registry or in other data stores of a provider
Get-ChildItem

#Provider and drives
Get-PSDrive -PSProvider FileSystem
Get-PSDrive -PSProvider Alias, Variable

#Set the location
Set-Location Alias:
Set-Location -Path C:
(Get-PSDrive -Name C).CurrentLocation

Get-Location
Set-Location HKLM:
Set-Location -Path .\Software\Microsoft\
Set-Location C:

Get-Location -PSDrive HKLM
Get-Location -PSDrive C

#Let's build a stack
Set-Location $HOME
Push-Location
Set-Location $PSHOME
Push-Location
Set-Location $env:windir\system32\
Push-Location
Set-Location HKLM:
Push-Location
Pop-Location
Pop-Location
Pop-Location
Pop-Location

#Multiple comma-separated paths are converted to absolute paths by the Resolve-Path cmdlet and output
Resolve-Path -Path ~,/,..

Resolve-Path -Path $PSHOME\[d-h]*.dll

#In addition, the Test-Path cmdlet is useful for determining whether a file type or directory exists, or whether a path is syntactically correct.
Test-Path -Path C:\Temp
Test-Path -Path $PSHOME -PathType Container
Test-Path -Path $PSHOME -PathType Leaf #Is it a file

#With this line you test whether there are elements in the specified directory that are newer than the specified date.
Test-Path -Path $HOME -NewerThan "05.12.2018"

#Something more variable, we check if something was added in the last 14 days
Test-Path -Path $HOME -NewerThan (Get-Date).AddDays(-14)

#This command tests if there are other file types than modern Word files *.docx with the extension in your Windows document directory
Test-Path -Path $HOME\Documents -Exclude *.docx -PathType Leaf

#####
#Install and remove drives
#####

#The E drive of the Filesystem provider is created. Root directory is the specified network share
New-PSDrive -Name "E" -PSProvider "FileSystem" -Root "\\SERVER\TOOLS"

#The Team: drive is created in the file system and points to a local directory
New-PSDrive "Team" "FileSystem" "C:\Gemeinsame Daten\"

#When creating the A7: drive, the provider alias is used
New-PSDrive -Name A7 -PSProvider Alias -Root Alias:\

#Note: All new PowerShell drives created in the examples are no longer available in the next session (-Persist for permanent)

#Removes the Drive Team
Remove-PSDrive -Name Team

#List's the "Registry" Providers and removes the drives HKCU: and HKLM:
Get-PSDrive -PSProvider Registry | Remove-PSDrive

#####
#Cmdlets for handling providers and drives
#####

#It lists all files from the PowerShell installation directory starting with c, d, e or w
Get-ChildItem $PSHOME\[c-ew]*.*

#Lists the content
Get-ChildItem -Path "C:\Program Files\Microsoft Office\Office16"

#The cmdlet checks the specified path to the pwsh.exe file in the PowerShell installation directory on Windows
Split-Path -Path $PSHOME\pwsh.exe
#The Result will be C:\Program Files\PowerShell\7

#Displays the contents of the file
Get-Content -Path .\process.txt

#The first 10 lines
Get-Content .\process.txt -TotalCount 10

#The last 10 lines
Get-Content .\process.txt -Tail 10

#This function outputs the 6 line in the file
(Get-Content .\process.txt)[5]

#The text is added to the file
Set-Content -Path .\notiz.txt -Value "Das ist ein neuer Text"

#The result before the pipeline is written to the file
Get-ChildItem -Path $HOME | Set-Content -Path .\listing.txt

#The command writes the text to the end of the file
Add-Content -Path .\einkauf.txt -Value "Milch: 2 Liter"

#The content of the file wednesday.txt is appended to the file week.txt
Add-Content -Path .\week.txt -Value (Get-Content .\wednesday.txt)

#The command deletes the contents of all .log files in the current directory. 
#The files remain empty with a file size of 0 bytes in the file system
Clear-Content -Path .\*.log

#In the first step all running processes are collected and written to a text file. 
#After that, the file is write-protected. Finally the content of the file is deleted 
#because the parameter -Force can override a write protection.
Get-Process | Out-File .\process.txt
Set-ItemProperty -Path .\process.txt -Name IsReadOnly -Value $True
Get-ItemProperty .\process.txt
Clear-Content -Path .\process.txt -Force

#####
#The Item-Cmdlets
#####

#The Get-Item cmdlet gets an item from the specified location. However, the contents of the item are not listed without the wildcard *.
Get-Item -Path .

#-Path is a position parameter
Get-Item *

#Is there a write protection?
(Get-Item .\process.txt).IsReadOnly

#We can also query the Windows Registry
Get-Item HKCU:\Software\Microsoft\Windows\CurrentVersion\Run

#The alias cc is defined as a shortcut command for clear-host. The previous definition is overwritten. 
#If there was no alias with this name before, it will be created without feedback.
Set-Item -Path Alias:cc -Value "Clear-Host"

#The value of the environment variable USRENAME is set to the value Nikolaus
Set-Item -Path Env:USERNAME -Value "Nikolaus"

#All 3 equal and create a file
New-Item -Path . -Name "test.txt" -ItemType "file"
New-Item -Path .\test.txt -ItemType "file"
New-Item .\test.txt

#Text is added here
New-Item -Path . -Name "test01.txt" -ItemType "file" -Value "Erster Eintrag..."

#Two lines create a folder (do not forget -ItemType with the Value Directory)
New-Item -Path $HOME\Documents -Name "Urlaub 2019" -ItemType Directory
New-Item -Path "HOME\Documents\Urlaub 2019" -ItemType Directory

#Creating an empty new key in the registry
New-Item -Path HKCU:\Software\Microsoft\ -Name TEST

#Note: If there is already a file with the same name at the specified location, 
#it will be overwritten without asking. -Recurse copies all files and subdirectories, 
#if the target directories do not yet exist, they are created automatically.
Copy-Item -Path ".\Konzert.docx" -Destination "C:\Konzertauftritt"
Copy-Item -Path ".\Konzert.docx" -Destination "C:\Konzertauftritt\Vortrag-AD.docx"
Copy-Item "C:\Daten" -Destination "D:\Backup\Daten" -Recurse

#The alias clear is copied and is available in the future also under the name cc
Copy-Item Alias:\clear Alias:\cc

#Copies all .txt files into the specified directory
Get-ChildItem -Path $PSHOME\*.txt -Recurse | Copy-Item -Destination C:\PSCore-Doku

#Rename a file
Rename-Item -Path .\Vorlage.xlsx -NewName Job-03.xlsx
Rename-Item -Path .\Vorlage.xlsx -NewName E:\Job-03.xlsx

#Rename a alias
Rename-Item -Path Alias:\clear -NewName cc

#The file is moved
Move-Item -Path .\Daten.xlsx -Destination c:\Neu\Daten.xlsx

#The file is renamed (is the same location)
Move-Item -Path .\Daten.xlsx -Destination .\AD01.xlsx

#Moves the directory
Move-Item -Path C:\Daten -Destination D:\Backup

#Moves all files with the extension .log to the destination directory
Move-Item C:\Daten\*.log D:\Backup

#Moves the registry keys and values (inside \Software\FirmaX) to the destination directory. 
Move-Item -Path HKLM:\Software\FirmaX\* -Destination HKLM:\Software\KonzernY

#The element is deleted
Remove-Item .\alte-socken.txt

#Delete all elements that start with the string alt and exclude files with the extension .xlsx
Remove-Item * -Include alt* -Exclude *.xlsx

#Delete (whether hidden or write-protected)
Remove-Item -Path .\geheim.xml -Force

#The specified registry key will be deleted, including the substructure without prompting
Remove-Item -Path HKLM:\Software\WegDamit -Recurse

#The value of the variable $temp is deleted, i.e. set to $null
Clear-Item Variable:\temp

#Deletes the content of the specified key
Clear-Item -Path HKLM:\Software\WegDamit

#Starts the editor associated with the file type
Invoke-Item -Path .\notiz.txt

######
#The ItemProperty-Cmdlets
######

#Brief information in table format
Get-ItemProperty C:\Windows\

#All available properties are displayed
Get-ItemProperty C:\Windows\ | Select-Object -Property *

#Show all registry entries in the specified registry key
Get-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion

#The file is marked as read-only
Set-ItemProperty -Path .\process.txt -Name IsReadOnly -Value $false

Get-ItemProperty -Path .\process.txt

#The value for the property of the last changes is moved back 14 days
Set-ItemProperty -Path .\process.txt -Name LastWriteTime -Value ((Get-Date).AddDays(-14))

#Create registry entries and values
Set-Location HKLM:\SOFTWARE\
New-Item -Name ZumTesten
Set-Location -Path .\ZumTesten
New-ItemProperty -Path . -Name Firma -Value Meine
New-ItemProperty -Path . -Name Kollegen -Value 1255

#Open the registry editor to check
#Now you can also work with Rename, Move, Clear and Remove again, as already learned

#One last example
Remove-ItemProperty -Path HKLM:\SOFTWARE\ZumTesten -Name Kollegen