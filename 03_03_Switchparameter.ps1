#A switch parameter is an on-off switch as the English term switch already suggests. 
#It is activated or switched on by the fact that it is used in the first place

Clear-Host

#Gets the items and child items 
Get-ChildItem

#Let's use the help
Get-Help Get-ChildItem

#Lets look closer
Get-Help Get-ChildItem -Parameter Recurse

#The contents of the current directory and all subdirectories are displayed
Get-ChildItem -Path C:\Temp -Recurse

#Equivalent is
Get-ChildItem -Path C:\Temp -Recurse:$true

#$false means as if -Recurse had not been used
Get-ChildItem -Path C:\Temp -Recurse:$false
