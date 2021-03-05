# Invokes Carbon Black EDR's API with the submitted parameters
Function Invoke-CbrApi {
    [CmdletBinding()]
    [OutputType([psobject])]
    param(
        [Parameter(Mandatory = $true)]
        [string]
        $UriPath,

        [Parameter(Mandatory = $true)]
        [string]
        $Method,

        [Parameter(Mandatory = $false)]
        [hashtable]
        $Body,

        [Parameter(Mandatory = $false)]
        [string]
        $Instance
    )
    begin {
        if ($Instance) { # Use specified instance
            $CbrInstance = Get-CbrInstance -Instance $Instance
        } else { # else create a new instance
            $CbrInstance = Get-CbrInstance
        }

        if ($CbrInstance.ignore_selfsigned_certificate) {
            if ($CbrInstance.ignore_selfsigned_certificate -eq $true) {
                Set-SelfSignedCertificateAsIgnored
            }
        }
    }
    process {
        # Do some stuff
        # Define request parameters
        $Param = @{
            Uri = $CbrInstance.uri + $UriPath # Adds the path element to the base fqdn
            Method = $Method
            Headers = @{
                "X-Auth-Token" = "$($CbrInstance.Credential.GetNetworkCredential().Password)"
            }
        }
        if($Method -and $Method -ne "GET"){$Param.ContentType = 'application/json'}
        if($Body){$Param.Body = $Body | ConvertTo-Json -depth 100 -Compress}
        # Make request
        $Request = try {
            Invoke-RestMethod @Param
        }
        # Capture error
        catch {
            if ($_.ErrorDetails) {
                $_.ErrorDetails # | ConvertFrom-Json
            }
            else {
                $_.Exception
            }
        }
    }
    end {
        # Output debug as Json
        if ($PSBoundParameters.Debug -eq $true) {
            if ($Request.results) {
                [PSCustomObject] @{
                    headers = $Request.Headers
                    content = $Request.Content | ConvertFrom-Json
                } | ConvertTo-Json -Depth 32
            }
            else {
                $Request | ConvertTo-Json -Depth 32
            }
        }
        # Output successful request object
        elseif ($Request.results) {
            $Request # | ConvertFrom-Json
        }
        # Catch-all output
        else {
            $Request
        }
    }
}