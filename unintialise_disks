    (Get-Volume).DriveLetter | Sort-Object | ForEach-Object {
        If ( $_ -ne "C" ){
            Write-Host "$(Get-Date -uformat "%Y-%m-%d-%H%M%S") : Un-initializing $_.";
            Remove-Partition -DriveLetter $_ -Confirm:0 -Verbose;
        }
    }
