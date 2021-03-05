# Set-CurrentInstance.psm1
Function Set-CurrentInstance {
    [CmdletBinding()]
    param(
        [Alias("InstanceName","Name")]
        [Parameter(mandatory=$true, ValueFromPipeline)] [string]$Instance
    )
    begin {
        if (-not($Config)) {
            [System.Collections.Hashtable] $Global:Config = @{}
        }
        if (-not($Config.Instances)) {
            [System.Collections.Hashtable] $Global:Config.Instances = @{}
        }
    }
    process {
        $Config.CurrentInstance = $Instance
    }
}
