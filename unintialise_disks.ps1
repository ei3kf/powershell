    ## Uninitialise disks except for C:\
    Get-Volume | Where-Object {$_.DriveLetter -ne "C"} | ForEach-Object{ 
        Write-Host "$(Get-Date -uformat "%Y-%m-%d-%H%M%S") : Un-initializing drive " $_.DriveLetter;
        try{
            Remove-Partition -DriveLetter $_.DriveLetter -Confirm:0 -Verbose; Start-Sleep 30;
            }
        catch{
            Write-Host "$(Get-Date -uformat "%Y-%m-%d-%H%M%S") : No partitions to remove";
            }
        }
