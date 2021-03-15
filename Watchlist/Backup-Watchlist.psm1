# Backup-Watchlist.psm1
Function Backup-Watchlist {
    [alias("Backup-Watchlists")]
    [alias("Export-Watchlist")]
    [alias("Export-Watchlists")]
    param(
            [Parameter(mandatory=$False)]
            [string]
        $Instance,

            [Parameter(mandatory=$False, Position=0)]
            [ValidateScript({
                if(($_ | Test-Path) ){
                    Write-Warning "Output file $_ already exists and will be overwritten."
                }
                if($_ | Test-Path -PathType Container){
                    throw "The Path argument must be a file. Folder paths are not allowed."
                }
                return $true
            })]
            [System.IO.FileInfo]
        $OutputPath,

            [Parameter(mandatory=$False)]
            [switch]
        $NoActions
    )
    if ($NoActions) {
        $Watchlists = Get-Watchlist -Instance $Instance -NoActions
    }
    else {
        $Watchlists = Get-Watchlist -Instance $Instance
    }

    if (-not $OutputPath) {
        if (-not $Instance) {
            try {
                $Instance = Get-CurrentInstance
            }
            catch {
                throw $_
            }
        }
        $OutputPath = ".\$Instance-watchlist-backup.txt"
    }

    $Watchlists | Export-Clixml $OutputPath
}