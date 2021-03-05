# ConvertFrom-EncodedSearchQuery.psm1
Function ConvertFrom-EncodedSearchQuery {
    [alias("Decode-SearchQuery")]
    [CmdletBinding()]
    param(
        [Alias("Search","Query","Search_Query")]
        [Parameter(mandatory=$False, ValueFromPipeline)] [string]$SearchQuery
    )

    $SearchQuery = [uri]::UnEscapeDataString($SearchQuery)

    if ($SearchQuery -match "^q=(?<query>.*)$") {
        $SearchQuery = $Matches.query
    }

    return $SearchQuery
}