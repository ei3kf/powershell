$Volumes = (Get-EC2InstanceAttribute -Region $Region -InstanceId $InstanceId -Attribute blockDeviceMapping ).BlockDeviceMappings | Where-Object { $_.DeviceName -ne '/dev/sda1' }
$Details = @{};
$Volumes | ForEach-Object {
    [string]$Device =  $_.DeviceName
    [string]$VolId = $_.Ebs.VolumeId.Replace("vol-","vol")
    If ( $Device -eq "xvdf" ) { $O = "Data,E"}
    If ( $Device -eq "xvdg" ) { $O = "Logs,L"}
    If ( $Device -eq "xvdh" ) { $O = "Backup,V"}
    If ( $Device -eq "xvdi" ) { $O = "TempDB,T"}
    $Details[$VolId] =  "$Device,$O"
    } 
}

$Details.keys | Sort-Object | ForEach-Object {
    Write-Host "$(Get-Date -uformat "%Y-%m-%d-%H%M%S") : Working on disk with serial number "$_ "with details : " $Details[$_];
    If ( (Get-Disk -SerialNumber $_ -ErrorAction SilentlyContinue) ) {
        $N = (Get-Disk -SerialNumber $_).Number;
        $DEVICE, $LABEL, $DRIVELETTER = $Details["$_"].split(",")
        Write-Host "$(Get-Date -uformat "%Y-%m-%d-%H%M%S") : Clearing Disk $_.";
        Clear-Disk -Verbose -Number $N -RemoveData -Confirm:0 -ErrorAction SilentlyContinue;
        Start-Sleep 30;
        Write-Host "$(Get-Date -uformat "%Y-%m-%d-%H%M%S") : Initialising Disk $_. as ${DRIVELETTER}";
        Get-Disk | Where-Object Number -eq $N | `
        Initialize-Disk -PartitionStyle GPT -PassThru -ErrorAction SilentlyContinue | `
        New-Partition -UseMaximumSize -DriveLetter $DRIVELETTER | `
        Format-Volume -FileSystem NTFS -AllocationUnitSize $BlockSize -NewFileSystemLabel $LABEL -Confirm:0;
        Start-Sleep 30;
        }
    }
