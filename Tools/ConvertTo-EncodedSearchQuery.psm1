# ConvertTo-EncodedSearchQuery.psm1
Function ConvertTo-EncodedSearchQuery {
    [alias("Encode-SearchQuery")]
    [CmdletBinding()]
    param(
        [Alias("Search","Query","Search_Query")]
        [Parameter(mandatory=$False, ValueFromPipeline)] [string]$SearchQuery
    )

    if ($SearchQuery -notmatch "^q=") {
        $SearchQuery = "q=" + $SearchQuery
    }

    $SearchQuery = $SearchQuery

    return $SearchQuery
}