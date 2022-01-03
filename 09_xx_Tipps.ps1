Start-Transcript

Get-Process

Get-Service

Stop-Transcript

#Splatting
Copy-Item -Path "test.txt" -Destination "test2.txt" -WhatIf

$HashArguments = @{
    Path = "test.txt"
    Destination = "test2.txt"
    WhatIf = $true
  }

Copy-Item @HashArguments

#Override splatted parameters with explicitly defined parameters
$commonParams = @{
    ResourceGroupName = "myResourceGroup"
    Location = "East US"
    VirtualNetworkName = "myVnet"
    SubnetName = "mySubnet"
    SecurityGroupName = "myNetworkSecurityGroup"
    PublicIpAddressName = "myPublicIpAddress"
}

$allVms = @('myVM1','myVM2','myVM3')

foreach ($vm in $allVms)
{
    if ($vm -eq 'myVM2')
    {
        New-AzVm @commonParams -Name $vm -Location "West US"
    }
    else
    {
        New-AzVm @commonParams -Name $vm
    }
}