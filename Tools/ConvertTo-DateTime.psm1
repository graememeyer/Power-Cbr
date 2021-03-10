# ConvertTo-DateTime.psm1
Function ConvertTo-DateTime {
    [alias("Get-DateTime")]
    [CmdletBinding()]
    param(
        [Parameter(mandatory=$True, ValueFromPipeline=$True)] [string]$DateTime
    )
    process {
        try {
            [datetime]$DateTime = $DateTime
        }
        catch {
            throw $_
        }

        return $DateTime
    }
}