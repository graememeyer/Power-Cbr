# ConvertFrom-EncodedSearchQuery.psm1
Function ConvertFrom-EncodedSearchQuery {
    [alias("Decode-SearchQuery")]
    [CmdletBinding()]
    param(
        [Alias("Search","Query","Search_Query")]
        [Parameter(mandatory=$True, ValueFromPipeline=$True)] [string]$SearchQuery
    )
    process {
        $SearchQuery = [uri]::UnEscapeDataString($SearchQuery)

        # Remove a leading "q=" from the search query
        if ($SearchQuery -match "^q=(?<query>.*)$") {
            $SearchQuery = $Matches.query
        }

        return $SearchQuery
    }
}