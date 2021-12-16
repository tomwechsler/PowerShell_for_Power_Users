Clear-Host

#Is only a simulation
Start-Service -Name Fax -WhatIf

#Here the execution must be confirmed
Start-Service -Name Fax -Confirm

#-Confirm is ignored
Start-Service -Name Fax -WhatIf -Confirm

#Also here
Start-Service -Name Fax -Confirm -WhatIf
