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
            Invoke-Api -Uri $UriPath -Method $Method -Instance $Instance
        }
        else {
            Invoke-Api -UriPath $UriPath -Method $Method
        }
    }
}