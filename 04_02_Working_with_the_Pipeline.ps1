Clear-Host

#The functionality of the pipeline is nothing else than processing single steps, 
#which are connected with the | (pipe). Let's divide this into 3 steps:
#1. collect data
#2. process data
#3. process result

#Step 1 (These are some examples of cmdlets how you can collect data)
Get-ChildItem
Get-Command
Get-Date
Get-Process

#The list with the Get cmdlets
Get-Command -Verb "Get"

#Step 2 (We are looking for the Object cmdlets)
Get-Command -Name *object*

#Let's look at some examples with the different "Object" cmdlets. Starts with ForEach-Object
2, 4, 6 | ForEach-Object -Process {Write-Host "Eingabe: $_ GB. Wert in MB: " ($_ * 1024)}

Get-Process | ForEach-Object Stop-Process -WhatIf

#Using this example, a list of the locations of the modules available in PowerShell is displayed. 
#In addition, a short text is displayed before and after processing the loop
Get-Module -ListAvailable | ForEach-Object -Begin {Write-Host "Starts the output:"} -Process {$_.Path} -End {"Task finished."}

####
#The Group-Object cmdlet groups results by a specified criterion or by multiple criteria in order of opinion
####

#-NoElement outputs the result without listing the individual elements
Get-ChildItem -Path $PSHOME | Group-Object -Property Extension -NoElement

#with positionparameter
Get-Process | Group-Object -Property Product

#Without
Get-Process | Group-Object Product

#Since there are almost 100 different verbs, a subsequent grouping by verb makes no sense.
Get-Verb | Group-Object Verb

#Now the result shows the membership of the verbs to their groups
Get-Verb | Group-Object Group

#Running or not
Get-Service | Group-Object {$_.Status -eq "Running"}

#All processes grouped by initial letter
Get-Process | Group-Object {$_.Name.Substring(0,1).ToUpper()}

####
#Measure-Object calculates the numerical properties of objects as well as characters, words and lines in texts.
####

#The values that query file sizes are specified in bytes
Get-ChildItem -Path $PSHOME | Measure-Object -Property Length -Minimum -Maximum -Average

#It displays how many lines, words and characters the file contains
Get-Content -Path .\common.txt | Measure-Object -Line -Word -Character

#The -AllStats parameter causes all statistics for numeric values to be output
2, 4, 6.3, 8, 10 | Measure-Object -AllStats

#A small error, because toast is not a numeric value
"Toast", "4", "6.3", "8", "7" | Measure-Object -AllStats

#Without -AllStats
"Toast", "4", "6.3", "8", "7" | Measure-Object -AllStats

#It searches for all commands whose verb consists of the string Get.
Get-Command -Verb Get | Measure-Object

#Each result is passed to the Measure-Object cmdlet, which counts the respective object 
#only if the PSISContainer property has the value True. 
#This is the case if it is a container, i.e. a directory.
Get-ChildItem -Path $PSHOME -Recurse | Measure-Object -Property PSIsContainer

####
#The Select-Object cmdlet selects specified properties of an object or group of objects. 
###

#We just want to see the interesting Properties
Get-Process | Select-Object -Property ProcessName, ID

#We want to see all the known properties
Get-Process -Name "pwsh" | Select-Object -Property *

#Not quite as detailed
Get-Process -Name "pwsh"

#We want to see only 10 elements
Get-ChildItem -Path $PSHOME | Select-Object -First 10

#The unique values alpha and beta are displayed in the order of occurrence
"alpha", "beta", "beta", "alpha" | Select-Object -Unique

####
#The Sort-Object cmdlet sorts objects by values of their properties. By default, data is sorted in ascending order, descending with -Descending.
####

#Descending by file size
Get-ChildItem | Sort-Object -Property Length -Descending

#Sorted and listed by power*
Get-ChildItem -Path $PSHOME\power* | Sort-Object -Property Length

#All processes starting with s* are sorted
Get-Process -ProcessName s* | Sort-Object -Property ProcessName, ID

#All processes sorted by the property StartTime and the last 5 started processes should be displayed
Get-Process | Sort-Object -Property StartTime | Select-Object -Last 5

#Some Errors (with Windows PowerShell not in Core)
#The trigger (in Windows PowerShell) is the Sort-Object cmdlet.

####
#Tee-Object saves the command output to a file and sends it to the next cmdlet through the pipeline at the same time
####

#Uptime in two different files (same content) without output
Get-Uptime | Tee-Object -FilePath .\gesamt.txt -Append | Out-File .\momentan.txt

#All processes in one file and with an output
Get-Process | Tee-Object -FilePath .\process.txt

#The date is displayed and created as a variable
Get-Date | Tee-Object -Variable JETZT

#Lets check
$JETZT

####
#The Where-Object cmdlet can filter results by matching the items passed through the pipeline with a condition
####

Get-Process -Name "pwsh"

Get-Process | Where-Object {$_.ProcessName -EQ "pwsh"}

Get-Process | Where ProcessName -EQ "pwsh"

Get-Service | Where-Object {$_.Status -EQ "Running"}

#More cumbersome than the original but syntactically correct and functional
Get-Service | Where Status -EQ "Running"

Get-ChildItem | Where-Object {$_.Length -GT 1MB}

Get-ChildItem | Where Length -GT 1MB

Get-ChildItem | Where-Object {$_.PSIsContainer}

#A little shorter
Get-ChildItem | Where PSIsContainer

#Step 3

####
#The export cmdlets presented now save data in a specific format to a file
####

#Export in xml format
Get-Credential | Export-CliXml -Path .\geheim.xml

#Not readable
Get-Content .\geheim.xml

#Username but not the password
Import-Clixml -Path .\geheim.xml

#Store in an variable
$UserInfo = Import-Clixml -Path .\geheim.xml

#Check
$UserInfo

#Export into a .csv file
Get-Process -Name "pwsh" | Select-Object -Property ProcessName, Id,CPU, WorkingSet | Export-Csv -Path .\prozess-pwsh.csv

#We retrieve information about the region
(Get-Culture).TextInfo | Export-Csv -Path .\culture.csv -UseCulture

#List the content
Get-Content -Path .\culture.csv

#This works but the data is really readable
Import-Csv -Path .\culture.csv

#This works better with a variable, because every value of the variable is retrievable
$cultur = Import-Csv -Path .\culture.csv -UseCulture

####
#The Convert-ToCmdlets group converts data to a specified format
####

Get-Date | ConvertTo-Csv

Get-Process -Name "pwsh" | ConvertTo-Html

#Data can also be processed without a pipeline, in this case data is passed directly via the respective cmdlet with the parameter -InputObject
ConvertTo-Html -InputObject (Get-TimeZone)

#To find out which cmdlet supports the -InputObject parameter, use the following cmdlet
Get-Command -ParameterName InputObject

#All the information is converted to an HTML file, with some additional text in the HTML file
Get-Process | Select-Object -Property Id, ProcessName, WS, CPU, StartTime | ConvertTo-Html -Title "Aktuelle Prozesse" -Body "<h1>Liste der Daten zu aktuell laufenden Prozessen</h1>" -PostContent "<p><i>Das war alles. Ich helfe gern wieder...</i></p>" | Out-File .\prozesse.html

#JSON File
Get-UICulture | ConvertTo-Json | Out-File .\culture.json

#We get only a short output showing the XML version and the output that the output document contains objects
#For further processing it is recommended to assign a variable or export to a file
Get-Process | ConvertTo-Xml

#The additional parameter -As Stream ensures that you can view the resulting flood of data on the screen in XML format
Get-Process | ConvertTo-Xml -As Stream

####
#Format cmdlets are primarily intended for customizing output directly on the screen
####

#The display information is not complete, with -Wrap the display is adjusted
Get-Service | Format-Table -Wrap

#Tabular output grouped by file attributes
Get-ChildItem -Path $HOME | Format-Table -GroupBy Mode

#It is seldom a good idea to force tabular output when Powershell automatically selects a list format
Get-PSReadLineOption | Format-Table

#With Format-List you get the complete output of Get-Date instead of the short output
Get-Date | Format-List

#Retrieve all properties, displayed in a list
Get-Process pwsh | Format-List -Property *

#A long list of available commands presented as a wide, three-column table
Get-Command | Format-Wide -Column 3

Get-Command | Format-Wide -GroupBy CommandType

####
#The out cmdlets are at the last position in the pipeline and complete the command line
####

#Is exactly the same as Get-Process
Get-Process | Out-Host

#-Paging at this point makes no sense
Get-Process | Out-Host -Paging | Select-Object -Property ProcessName, Id

#This is better
Get-Process | Select-Object -Property ProcessName, Id | Out-Host -Paging

#Ceates a text file
Get-History | Out-File -FilePath .\commandlist.txt

#-NoClobber parameter causes PowerShell to generate an error message and thus protects the original file from being replaced.
Get-ChildItem | Out-File -FilePath .\listing.txt -NoClobber

#From simple...
Get-ChildItem -Path $PSHOME -Recurse

Get-ChildItem -Path $PSHOME\m* -Recurse

Get-ChildItem -Path $PSHOME\m* -Recurse | Select-Object -Property Name,Length,Directory

Get-ChildItem -Path $PSHOME\m* -Recurse | Select-Object -Property Name,Length,Directory | Where-Object {$_.Length -GT 100kb}

Get-ChildItem -Path $PSHOME\m* -Recurse | Select-Object -Property Name,Length,Directory | Where-Object {$_.Length -GT 100kb} | 
Sort-Object -Property Length -Descending

Get-ChildItem -Path $PSHOME\m* -Recurse | Where-Object {$_.Length -GT 100kb} | Select-Object -Property Name,Length,Directory | 
Sort-Object -Property Length -Descending | Export-Csv -Path .\pshome.csv -Delimiter ";"
#...too complex
