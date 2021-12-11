Clear-Host

#All the services
Get-Service | More

#More infos
Get-Service | Get-Member

#Use the new infos
Get-Service | Select-Object Name,DependentServices,Status

#List the stopped services
Get-Service | Where-Object Status -eq "Stopped" | More