Function Invoke-DNSRecordAdd {
[cmdletbinding()]
Param(
    [Parameter(Mandatory=$true)]
    [ValidateNotNullOrEmpty()]
    [String]$ServerName,

    [Parameter(Mandatory=$true)]
    [ValidateNotNullOrEmpty()]
    [String]$IPAddress,

    [Parameter(Mandatory=$false)]
    [ValidateNotNullOrEmpty()]
    [String]$User = "",

    [Parameter(Mandatory=$false)]
    [ValidateNotNullOrEmpty()]
    [String]$Password = '',
    [Parameter(Mandatory=$false)]
    [ValidateNotNullOrEmpty()]
    [String]$DNSServer = "",

    [Parameter(Mandatory=$false)]
    [ValidateNotNullOrEmpty()]
    [String]$Zone =""
)

$PassPlain = ConvertTo-SecureString $Password -AsPlainText -Force;
$Cred = New-Object System.Management.Automation.PSCredential ($User, $PassPlain);

$commands = @"
    dnscmd.exe $DNSServer /RecordAdd $Zone $ServerName /createPTR A $IPAddress;   
    sleep 2
"@

Start-Process -FilePath Powershell -LoadUserProfile -Credential $Cred -ArgumentList '-Command', $commands;
     
}

Function Invoke-DNSRecordDelete {
[cmdletbinding()]
Param(
    [Parameter(Mandatory=$true)]
    [ValidateNotNullOrEmpty()]
    [String]$ServerName,

    [Parameter(Mandatory=$true)]
    [ValidateNotNullOrEmpty()]
    [String]$IPAddress,

    [Parameter(Mandatory=$false)]
    [ValidateNotNullOrEmpty()]
    [String]$User = "",

    [Parameter(Mandatory=$false)]
    [ValidateNotNullOrEmpty()]
    [String]$Password = '',

    [Parameter(Mandatory=$false)]
    [ValidateNotNullOrEmpty()]
    [String]$DNSServer = "",

    [Parameter(Mandatory=$false)]
    [ValidateNotNullOrEmpty()]
    [String]$Zone =""
)

$PassPlain = ConvertTo-SecureString $Password -AsPlainText -Force;
$Cred = New-Object System.Management.Automation.PSCredential ($User, $PassPlain);

$commands = @"
    dnscmd.exe $DNSServer /RecordDelete $Zone $ServerName A $IPAddress /f;
    sleep 2
"@

Start-Process -FilePath Powershell -LoadUserProfile -Credential $Cred -ArgumentList '-Command', $commands;
    
}

