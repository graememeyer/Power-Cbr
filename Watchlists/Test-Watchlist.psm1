# Test-Watchlist.psm1
Function Test-Watchlist {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$True, ValueFromPipeline=$True)]
        $SuspectWatchlist
    )
    process {
        $ValidWatchlist = $True

        # Object Type
        try {
            if ($SuspectWatchlist -isnot [PSCustomObject]) {
                $ValidWatchlist = $False
                Write-Error "Not a valid object."
                return $ValidWatchlist
            }
        }
        catch {
            $ValidWatchlist = $False
            return $ValidWatchlist
        }

        # Watchlist properties
        try {
            $RequiredWatchlistProperties = (
                "id",
                "date_added",
                "name",
                "description",
                "index_type",
                "search_query",
                "readonly",
                "enabled"
            )

            foreach ($Property in $RequiredWatchlistProperties)
            {
                If (-not ($SuspectWatchlist | Get-Member $Property))
                {
                    $ValidWatchlist = $False
                    Write-Error "Not a valid Watchlist."
                    Write-Error "Failed property check for presence of property: $($Property)."
                    return $ValidWatchlist
                }
            }
        }
        catch {
            $ValidWatchlist = $False
            return $ValidWatchlist
        }

        Write-Verbose "You passed Watchlist $($SuspectWatchlist.name) into the pipeline!"
        Write-Verbose "===== Watchlist Details ====="
        Write-Verbose $SuspectWatchlist
        
        return $ValidWatchlist
    }

}