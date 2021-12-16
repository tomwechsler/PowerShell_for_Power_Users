Clear-Host

#Cmdlets
Get-Command -CommandType Cmdlet

#Functions
Get-Command -CommandType Function

#Aliases
Get-Command -CommandType Alias

#Empty aliases point to commands that haven't been loaded
#into the current PowerShell session

#Can you find a command that works with aliases?
#you could try broadly
Get-Command *alias*

#Or be a bit more narrower
Get-Command -Noun *alias*

#Try it
Get-Alias #these are all the active aliases in this PowerShell session

Get-Alias cls

#try it
ps

Get-Process

ps win*

#Here's something fun
#You'll find this in the list as well
gcm gcm

gcm -Noun Computer

#Do not?
gps | ? ws -gt 25MB | sort ws -d | select -p Name,WS -f 5

#That's ok
Get-Process | Where-Object {$_.WorkingSet64 -GT 25MB} | Sort-Object -Property WorkingSet64 -Descending | Select-Object -Property Name, WorkingSet64 -First 5

#Export
Export-Alias -Path .\alias-liste.csv

#Import
Import-Alias -Path .\alias-liste.csv -Force

#You can create your own aliases, but you should not use them. 
#They are available only on your computer. Also, do not use aliases in scripts and certainly not custom aliases.
