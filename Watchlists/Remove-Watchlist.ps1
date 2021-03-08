# Remove-Watchlist.psm1
Function Remove-Watchlist {
    [alias("Delete-Watchlist")]
    param(
        [Parameter(mandatory=$True, ValueFromPipelineByPropertyName=$True)] [int]$Id,
        [Parameter(mandatory=$False)] [string]$Instance
    )
    process {
        $UriPath = "/api/v1/watchlist"
        $Method = "DELETE"

        # Single alert query
        if ($Id) {
            $UriPath = $UriPath + "/$Id"
        }

        if ($Instance) {
            Invoke-Api -Uri $UriPath -Method $Method -Instance $Instance
        }
        else {
            Invoke-Api -UriPath $UriPath -Method $Method
        }
    }
}