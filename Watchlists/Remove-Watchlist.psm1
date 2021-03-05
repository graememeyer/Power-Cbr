# Remove-Watchlist.psm1
Function Remove-Watchlist {
    [alias("Delete-Watchlist")]
    param(
        [Parameter(mandatory=$True)] [int]$Id,
        [Parameter(mandatory=$False)] [string]$Instance
    )
    $UriPath = "/api/v1/watchlist"
    $Method = "DELETE"

    # Single alert query
    if ($Id) {
        $UriPath = $UriPath + "/$Id"
    }

    if ($Instance) {
        Invoke-CbrApi -Uri $UriPath -Method $Method -Instance $Instance
    }
    else {
        Invoke-CbrApi -UriPath $UriPath -Method $Method
    }
}