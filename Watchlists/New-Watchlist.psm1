# Get-Watchlists.psm1
Function New-Watchlist {
    param(
        [Parameter(mandatory=$true)] [string]$Instance,
        [Parameter(mandatory=$False)] [string]$Name,
        [Parameter(mandatory=$False)] [string]$Description,
        [Parameter(mandatory=$False)] [string]$Search_query
    )
    $UriPath = "/api/v1/watchlist"
    $Method = "POST"

    $Search_query = $Search_query | Encode-SearchQuery

    $Body = @{}
    $Body.name = $Name
    $Body.search_query = $Search_query
    $Body.description = $Description
    $Body.index_type = "events"
    
    Invoke-CbrApi -Uri $UriPath -Method $Method -Body $Body -Instance $Instance
}