$Instances = Get-EC2Instance -Region eu-west-1 -Filter @( @{name='tag:Name'; values="${env}*"}) | ForEach-Object { 
    $Name = $_.Instances.Tag | Where-Object {$_.Key -eq "Name"} | select -ExpandProperty Value
    Write-Host $_.Instances.instanceid $_.Instances.privateipaddress $Name
    }
