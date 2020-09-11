# Invokes Carbon Black EDR's API with the submitted parameters
Function Invoke-CbrApi {
    [CmdletBinding()]
    [OutputType([psobject])]
    param(
        [Parameter(Mandatory = $true)]
        [string]
        $Uri,

        [Parameter(Mandatory = $true)]
        [string]
        $Method,

        [string]
        $Body
    )
    begin {
        # If no API creds, prompt user
        try {
            $Message = "Please insert the URI, including port number of your Carbon Black instance " +
            "in the User name box (e.g. my.hostname:9000), and your API key in the Password box."

            $Cbr = Get-StoredCredential -Name "Cbr" -Message $Message

            $CbrUri = ($Cbr.GetNetworkCredential().UserName).ToLower()
            if(-not ($CbrUri.StartsWith("http://") -or $CbrUri.StartsWith("https://")))
            {
                $CbrUri = "http://" + $CbrUri 
            }
            $Token = $Cbr.GetNetworkCredential().Password
        }
        catch {
            Write-Error "Something went wrong with obtaining credentials. " + 
            "Possibly the CredentialManager module isn't installed."
        }
    }
    process {
        # Do some stuff
        # Define request parameters
        $Param = @{
            Uri = $CbrUri + $Uri # Adds the path element to the base fqdn
            Method = $Method
            Headers = @{
                "X-Auth-Token" = "$Token"
            }
        }
        if($Method -and $Method -ne "GET"){$Param.ContentType = 'application/json'}
        if($Body){$Param.Body = $Body}
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