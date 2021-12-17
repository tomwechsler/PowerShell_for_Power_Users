Clear-Host

"Dies ist ein Textbeispiel."

Get-ChildItem -Path "C:\Temp"

"Ihr Benutzerverzeichnis ist $HOME."

'Ihr Benutzerverzeichnis ist $HOME. '

"Das ist ein kurzer Text."

'Das ist ein kurzer Text.'

"Das ist ein 'kurzer' Text."

'Das ist ein "kurzer" Text.'

#"Das ist ein "kurzer" Text."

#'Das ist ein 'kurzer' Text.'

#"Das ist ein "kurzer Text."

"Betriebssystem: $env:OS"

'Betriebssystem: $env:OS'

"$env:OS = $env:OS"

'$env:OS = $env:OS'

'$env:OS = ' + "$env:OS"

"Heute: " + (Get-Date)

#The PowerShell converts the second value based on the first value
5 * "38"

#So also in this case. We get five times 38
"38" * 5

#Here the conversion does not work anymore!
5 * "38m"

"17 mal 69 ergibt $(17*69)."

'17 mal 69 ergibt $(17*69).'

"Zeitzone: $(Get-TimeZone)."

'Zeitzone: $(Get-TimeZone).'

#Backtick
Get-Process `
-Name "pswh" `
-FileVersionInfo

#Some " examples
Read-Host -Prompt "Bitte geben Sie Ihr Alter ein"

Write-Host "Sie geben an, $(Read-Host -Prompt "Bitte geben Sie Ihr Alter ein") Jahre alt zu sein."

$alter = Read-Host -Prompt "Bitte geben Sie Ihr Alter ein"

$alter

Read-Host -Prompt "Neues Kennwort" -AsSecureString

$pass = Read-Host -Prompt "Neues Kennwort" -AsSecureString
