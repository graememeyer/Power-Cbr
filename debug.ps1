# debug.ps1
Clear-Host
#Import-Module .\Power-Cbr.psd1
Import-Module .\Tools\Invoke-CbrApi.psm1 -Force
foreach ($Module in (Get-ChildItem .\*.psm1 -Recurse | Select-Object -ExpandProperty FullName)) {Import-Module $Module -Force}

# Ignore the self-signed certificate.
if (-not("dummy" -as [type])) {
    add-type -TypeDefinition @"
using System;
using System.Net;
using System.Net.Security;
using System.Security.Cryptography.X509Certificates;

public static class Dummy {
    public static bool ReturnTrue(object sender,
        X509Certificate certificate,
        X509Chain chain,
        SslPolicyErrors sslPolicyErrors) { return true; }

    public static RemoteCertificateValidationCallback GetDelegate() {
        return new RemoteCertificateValidationCallback(Dummy.ReturnTrue);
    }
}
"@
}

[System.Net.ServicePointManager]::ServerCertificateValidationCallback = [dummy]::GetDelegate()

$Sensors = Invoke-CbrApi -Uri "/api/v1/sensor" -Method "GET" | Select-Object -First 100
""
"Retrieved $($Sensors.count) sensors."

$Alerts = Invoke-CbrApi -Uri "/api/v2/alert" -Method "GET" | Select-Object -First 100 | Select-Object -ExpandProperty "Results"
""
"Retrieved $($Alerts.count) alerts."
$Alerts

$Alert = Get-CbrAlert -Id
$Alert