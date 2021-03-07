# Get-Watchlists.psm1
Function New-Watchlist {
    param(
        [Parameter(mandatory=$False)] [string]$Instance,
        [Parameter(mandatory=$False)] [string]$Name,
        [Parameter(mandatory=$False)] [string]$Description,
        [Parameter(mandatory=$False)] [string]$Search_query
    )
    $UriPath = "/api/v1/watchlist"
    $Method = "POST"

    $Search_query = $Search_query | ConvertTo-EncodedSearchQuery

    $Body = @{}
    $Body.name = $Name
    $Body.search_query = $Search_query
    $Body.description = $Description
    $Body.index_type = "events"

    if ($Instance) {
        Invoke-CbrApi -Uri $UriPath -Method $Method -Body $Body -Instance $Instance
    }
    else {
        Invoke-CbrApi -UriPath $UriPath -Method $Method -Body $Body
    }
}