# Get-Watchlists.psm1
Function Get-Watchlist {
    [alias("Get-Watchlists")]
    param(
        [Parameter(mandatory=$False, ValueFromPipelineByPropertyName=$True)] [int]$Id,
        [Parameter(mandatory=$False)] [string]$Instance
    )
    process {
        $UriPath = "/api/v1/watchlist"
        $Method = "GET"

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
}