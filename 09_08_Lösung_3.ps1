#Free space in percent!

Get-Volume -DriveLetter C

$PartitionC = Get-Volume -DriveLetter C 

$Prozentsatz = ($PartitionC.SizeRemaining/$PartitionC.Size)*100 
if($Prozentsatz -lt 20) 
{ 
Write-Host -Es ist weniger als 20% Speicherplatz verfügbar.- 
Write-Host -Freier Speicherplatz nur noch $Prozentsatz%- 
} 
else 
{ 
Write-Host -Es ist mehr als 20% Speicherplatz verfügbar.- 
Write-Host -Freier Speicherplatz: $Prozentsatz%- 
}
