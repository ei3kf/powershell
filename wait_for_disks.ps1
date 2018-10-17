    while ((Get-Disk).Count -lt ${Count}) {
        Write-Host "$(Get-Date -uformat "%Y-%m-%d-%H%M%S") : Waiting on ${Count} EBS volumes to be attached. Sleeping 60 seconds.";
        Start-Sleep 60;
        }
