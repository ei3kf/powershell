    Do{
        $S = 60;
        Write-Host "$(Get-Date -uformat "%Y-%m-%d-%H%M%S") : Waiting on ${Count} EBS volumes to be attached. Current disk count is $((Get-Disk).Count).";
        Write-Host "$(Get-Date -uformat "%Y-%m-%d-%H%M%S") : Current disks.";
        Get-Disk | Sort-Object | ForEach-Object { 
            Write-Host $(Get-Date -uformat "%Y-%m-%d-%H%M%S") : $_.Number $_.SerialNumber $_.HealthStatus $_.OperationalStatus;
            }
        Write-Host "$(Get-Date -uformat "%Y-%m-%d-%H%M%S") : Sleeping for $S seconds.";
        Start-Sleep $S;
        } Until ((Get-Disk).Count -eq $Count)
