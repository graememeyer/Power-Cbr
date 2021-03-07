# debug.ps1
Clear-Host

# Clean out the current config if it's already loaded
Remove-Variable -Name "Config" -ErrorAction SilentlyContinue

# Import modules
foreach ($Module in (Get-ChildItem .\*.psm1 -Recurse | Select-Object -ExpandProperty FullName)) {Import-Module $Module -Force}

# Load the dev configs for testing
if (-not $Config) {
    $User = "dev1" 
    $PWord = ConvertTo-SecureString -String "👀👀👀👀👀👀👀👀👀👀👀👀" -AsPlainText -Force
    $Credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $User, $PWord

    $CbrInstance = New-CbrInstance -Name dev1 -Uri "cb1.local:443" -IgnoreSelfSignedCertificates $True -Credential $Credential


    $User = "dev2"
    $PWord = ConvertTo-SecureString -String "👀👀👀👀👀👀👀👀👀👀👀👀" -AsPlainText -Force
    $Credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $User, $PWord

    $CbrInstance = New-CbrInstance -Name dev2 -Uri "cb2.local:443" -IgnoreSelfSignedCertificates $True -Credential $Credential
}

Invoke-Pester -Verbose -Script .\Tests\