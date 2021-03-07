# ConvertTo-EncodedSearchQuery.psm1
Function ConvertTo-EncodedSearchQuery {
    [alias("Encode-SearchQuery")]
    [CmdletBinding()]
    param(
        [Alias("Search","Query","Search_Query")]
        [Parameter(mandatory=$True, ValueFromPipeline=$True)] [string]$SearchQuery
    )
    process {
        if ($SearchQuery -notmatch "^q=") {
            $SearchQuery = "q=" + $SearchQuery
        }
    
        # $SearchQuery = [uri]::EscapeDataString($SearchQuery)
    
        return $SearchQuery
    }
}