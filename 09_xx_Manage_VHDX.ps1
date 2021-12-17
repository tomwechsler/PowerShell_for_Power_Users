Clear-Host

$VHDs = Get-VM | Select-Object VMID | Get-VHD

($VHDs).count

#If you now want to know whether VMs are still located in the default directory (i.e. on the system drive in the profile of the user Public) contrary to the best practices for Hyper-V
$VHDs | Where-Object Path -like "C:\Users\Public\*" | Select-Object Path

#If you want to get an overview of all directories containing virtual drives, this call will help:
($VHDs | Select-Object Path).path -replace "[^\\]*\.a?vhdx?","" | Sort-Object -Uniq

#Calculate space consumption of VHDs
$VHDs | ForEach-Object {$FS += $_.FileSize}; $FS/1GB

#Sort VHDs by size
$VHDs | Sort-Object -Descending -Property FileSize | Select-Object Path, @{Name="GByte";Expression={$_.FileSize/1GB}}

#Distinguish VHD from VHDX
$VHDs | Where-Object VHDFormat -eq "VHD"

$VHDs | Where-Object VHDFormat -eq "VHDX"

#Dynamic, fixed or differential VHD?
$VHDs | Where-Object VhdType -EQ "Dynamic"| Select-Object Path
$VHDs | Where-Object VhdType -EQ "Differencing"| Select-Object Path
$VHDs | Where-Object VhdType -EQ "Fixed"| Select-Object Path

#Analyze fragmentation
$VHDs | Select-Object Path, FragmentationPercentage | Out-GridView

#This example creates a dynamic virtual hard disk in VHDX format that is 10 GB in size
New-VHD -Path C:\Base.vhdx -SizeBytes 10GB

#This example creates a VHDX-format differencing virtual hard disk with a parent path of c:\Base.vhdx.
New-VHD -ParentPath C:\Base.vhdx -Path C:\Diff.vhdx -Differencing

#This example creates a 1 TB VHD-format fixed virtual hard disk at the specified path
New-VHD -Path C:\fixed.vhd -Fixed -SourceDisk 2 -SizeBytes 1TB

#This example creates a new 1 TB VHDX-format dynamic virtual hard disk at the specified path with a block size of 128 MB and a logical sector size of 4 KB
New-VHD -Path c:\LargeSectorBlockSize.vhdx -BlockSizeBytes 128MB -LogicalSectorSize 4KB -SizeBytes 1TB

#This example creates a new 127GB VHD and then mounts, initializes, and formats it so the drive is ready to use.
$vhdpath = "C:\VHDs\Test.vhdx"
$vhdsize = 127GB
New-VHD -Path $vhdpath -Dynamic -SizeBytes $vhdsize | 
Mount-VHD -Passthru |
    Initialize-Disk -Passthru |
        New-Partition -AssignDriveLetter -UseMaximumSize |
            Format-Volume -FileSystem NTFS -Confirm:$false -Force
