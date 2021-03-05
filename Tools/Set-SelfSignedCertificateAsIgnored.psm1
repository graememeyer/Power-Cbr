# Set-SelfSignedCertificateAsIgnored.psm1
function Set-SelfSignedCertificateAsIgnored {
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

        public static bool ReturnFalse(object sender,
        X509Certificate certificate,
        X509Chain chain,
        SslPolicyErrors sslPolicyErrors) { return false; }

        public static RemoteCertificateValidationCallback GetDelegateFalse() {
            return new RemoteCertificateValidationCallback(Dummy.ReturnFalse);
        }

    }
"@
    }

    [System.Net.ServicePointManager]::ServerCertificateValidationCallback = [dummy]::GetDelegate()
}