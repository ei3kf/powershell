    $Details = @{
    "0005" = "xvdf,Data,E"
    "0006" = "xvdg,Logs,L"
    "0007" = "xvdh,Backup,V"
    "0008" = "xvdi,TempDB,T"
    }

    $Details.keys | Sort-Object | ForEach-Object {
        If ( (Get-Disk -SerialNumber $_ -ErrorAction SilentlyContinue) ) {
            $N = (Get-Disk -SerialNumber $_).Number;
            $DEVICE, $LABEL, $DRIVELETTER = $Details["$_"].split(",")
            Write-Host "$(Get-Date -uformat "%Y-%m-%d-%H%M%S") : Intializing Disk $_.";
            Clear-Disk -Number $N -RemoveData -Confirm:0 -ErrorAction SilentlyContinue;
            Get-Disk | Where-Object Number -eq $N | `
            Initialize-Disk -PartitionStyle GPT -PassThru | `
            New-Partition -UseMaximumSize -DriveLetter $DRIVELETTER | `
            Format-Volume -FileSystem NTFS -AllocationUnitSize 65536 -NewFileSystemLabel $LABEL -Confirm:0;
        }
    }
