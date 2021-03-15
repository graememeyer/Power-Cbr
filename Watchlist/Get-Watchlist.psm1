# Get-Watchlists.psm1
Function Get-Watchlist {
    [alias("Get-Watchlists")]
    param(
            [Parameter(mandatory=$False, ValueFromPipelineByPropertyName=$True)]
            [int]
        $Id,
            [Parameter(mandatory=$False)]
            [string]
        $Instance,

            [switch]
            [Alias("NoWatchlistActions")]
        $NoActions
    )
    process {
        $UriPath = "/api/v1/watchlist"
        $Method = "GET"

        # Single alert query
        if ($Id) {
            $UriPath = $UriPath + "/$Id"
        }

        $Watchlists = Invoke-Api -Uri $UriPath -Method $Method -Instance $Instance

        foreach ($Watchlist in $Watchlists) {
            if (-not $NoActions) {
                $WatchlistActions = [ordered]@{}
                $WatchlistActionResponse = Get-WatchlistAction -Id $Watchlist.Id -Instance $Instance
                foreach ($item in $WatchlistActionResponse) {
                    $WatchlistActions.($item.action_type) = $item.enabled
                }
                $Watchlist | Add-Member -Name 'action' -Value $WatchlistActions -MemberType NoteProperty
            }
        }
        return $Watchlists
    }
}