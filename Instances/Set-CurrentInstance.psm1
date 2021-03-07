# Set-CurrentInstance.psm1
Function Set-CurrentInstance {
    [CmdletBinding()]
    param(
        [Alias("InstanceName","Name")]
        [Parameter(mandatory=$true, ValueFromPipeline)] [string]$Instance
    )
    begin {
        if (-not($Config)) {
            [System.Collections.Hashtable] $global:Config = @{}
        }
        if (-not($Config.Instances)) {
            [System.Collections.Hashtable] $global:Config.Instances = @{}
        }
    }
    process {
        $Config.CurrentInstance = $Instance
    }
}
