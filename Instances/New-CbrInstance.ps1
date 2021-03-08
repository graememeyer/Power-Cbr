<#
.SYNOPSIS
    .
.DESCRIPTION
    .
.PARAMETER Name
    The path to the .
.PARAMETER Uri
    Specifies a path to one or more locations. Unlike Path, the value of
    LiteralPath is used exactly as it is typed. No characters are interpreted
    as wildcards. If the path includes escape characters, enclose it in single
    quotation marks. Single quotation marks tell Windows PowerShell not to
    interpret any characters as escape sequences.
#>

# New-InstanceConfig.psm1
Function New-Instance {
    param(
            [Parameter(Mandatory=$true,
                HelpMessage="A name to refer to this unique instance of carbon black - e.g. 'dev'")]
            [ValidatePattern("^[\w\s.-]+$")]
        [string]$Name,

            [Parameter(Mandatory=$true,
            HelpMessage="URI must match format fqdn:port. e.g. google.com:443")]
                [Alias("FQDN")]
                [ValidatePattern("^(http(s?)://)?[\w\.-]+:\d+$")]
        [string]$Uri,

            [Parameter(Mandatory=$false)]
        [bool]$IgnoreSelfSignedCertificates,

            [Parameter(Mandatory=$false)]
        [PSCredential]$Credential
    )
    begin {
        # Create $Config for the application configuration
        if (-not($Config)) {
            [System.Collections.Hashtable] $global:Config = @{}
        }

        # Create $Config for the application configuration
        if (-not($Config.Instances)) {
            [System.Collections.Hashtable] $Config.Instances = @{}
        }
    }
    process {

        if($Uri -NotMatch "^http(s)?://") {
            $Uri = "https://" + $Uri
        }

        if(-not $IgnoreSelfSignedCertificates) {
            $Valid = $false
            while (-not $Valid) {
                $Choice = Read-Host -Prompt "Ignore self-signed / invalid certificates? [Y/N]"

                if ($Choice -match "y" -or $Choice -match "yes") {
                    $IgnoreSelfSignedCertificates = $true
                    $Valid = $True
                }
                elseif ($Choice -match "n" -or $Choice -match "no") {
                    $IgnoreSelfSignedCertificates = $false
                    $Valid = $True
                }
            }
        }

        $InstanceConfig = @{}
        $InstanceConfig.name = $Name
        $InstanceConfig.uri = $Uri
        $InstanceConfig.ignore_selfsigned_certificate = $IgnoreSelfSignedCertificates

        if ($Credential) {
            $InstanceConfig.Credential = Get-Credential -Credential $Credential
        }
        else {
            $InstanceConfig.Credential = Get-Credential -UserName $Name `
                                                        -Message "Input the API token for this instance of Carbon Black:"
        }

        $Config.Instances[$InstanceConfig.Name] = $InstanceConfig
        $Config.CurrentInstance = $InstanceConfig.Name

        Return [pscustomobject]$InstanceConfig
    }
}