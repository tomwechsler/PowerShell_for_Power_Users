Clear-Host

#List the services with print in the name
Get-Service -Name print*

#No we exclude
Get-Service print* -Exclude PrintNotify

#Parameter is not equal to parameter
Get-Help -Name Get-Service -Parameter Name

Get-Help -Name Get-Service -Parameter Exclude

#Let's test
Get-Service print* -Exclude PrintNotify

#That works also
Get-Service -Exclude PrintNotify print*

#This not
Get-Service print* PrintNotify