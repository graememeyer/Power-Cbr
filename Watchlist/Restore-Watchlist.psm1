# Restore-Watchlist.psm1
Function Restore-Watchlist {
    [alias("Restore-Watchlists")]
    param(
            [Parameter(mandatory=$False)]
            [string]
        $Instance,

            [Parameter(mandatory=$False, Position=0)]
            [ValidateScript({
                if(-not ($_ | Test-Path) ){
                    throw "Input file $_ doesn't appear to exist."
                }
                if($_ | Test-Path -PathType Container){
                    throw "The Path argument must be a file. Folder paths are not allowed."
                }
                return $true
            })]
            [System.IO.FileInfo]
        $InputPath,

            [Parameter(mandatory=$False)]
            [alias("DefaultActions")]
            [switch]
        $NoActions
    )

    # Test backup file
    try {
        $Watchlists = Import-Clixml -Path $InputPath -ErrorAction Stop
        foreach ($Watchlist in $Watchlists) {
            if (-Not ($Watchlist | Test-Watchlist)) {
                throw "Invalid watchlists imported from $InputPath. $_"
                exit
            }
        }
    }
    catch {
        throw $_
        exit
    }

    # Remove all watchlists
    $CurrentWatchlists = Get-Watchlist -Instance $Instance

    foreach ($Watchlist in $CurrentWatchlists) {
        Write-Verbose "Removing existing watchlist $($Watchlist.id), `"$($Watchlist.name)`""
        $Result = $Watchlist | Remove-Watchlist -Instance $Instance
        Write-Verbose $Result
    }

    # Upload from backup file
    foreach ($Watchlist in $Watchlists) {
        Write-Verbose "Restoring watchlist $($Watchlist.id), `"$($Watchlist.name)`""
        $Watchlist | New-Watchlist -Instance $Instance

        if ($Watchlist.action) {

        }
    }
}