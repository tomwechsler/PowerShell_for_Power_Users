Clear-Host

#Verbs
Get-Verb
Get-Command -Verb Get
Get-Command -verb Stop

#Nouns
Get-Command -Noun time*
Get-Command -Noun *time*
Get-Command -Noun *process*

#Combine
Get-Command -Noun *share* -Verb Re*

Get-Command –Verb Get –Noun *print*

#Notice all the different types of commands
Get-Command *service*

#I'll refine the command
Get-Command *service