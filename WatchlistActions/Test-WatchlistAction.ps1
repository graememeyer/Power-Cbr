# Test-WatchlistAction.psm1
Function Test-WatchlistAction {
    [Alias("Test-WatchlistActions")]
    [CmdletBinding()]
    [OutputType([bool])]
    Param(
        [Parameter(Mandatory=$True, ValueFromPipeline=$True)]
        $SuspectWatchlistActions
    )
    process {
        $ValidWatchlistActions = $True

        # Object Type
        try {
            if ($SuspectWatchlistActions -isnot [PSCustomObject]) {
                $ValidWatchlistActions = $False
                Write-Error "Not a valid object."
                return $ValidWatchlistActions
            }
        }
        catch {
            $ValidWatchlistActions = $False
            return $ValidWatchlistActions
        }

        # WatchlistActions properties
        try {
            $RequiredWatchlistActionsProperties = (
                "action_type",
                "enabled"
            )

            foreach ($Property in $RequiredWatchlistActionsProperties)
            {
                If (-not ($SuspectWatchlistActions | Get-Member $Property))
                {
                    $ValidWatchlistActions = $False
                    Write-Error "Not a valid WatchlistActions."
                    Write-Error "Failed property check for presence of property: $($Property)."
                    return $ValidWatchlistActions
                }
            }
        }
        catch {
            $ValidWatchlistActions = $False
            return $ValidWatchlistActions
        }

        return $ValidWatchlistActions
    }
}