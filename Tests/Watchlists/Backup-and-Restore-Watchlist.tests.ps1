
Describe "Backup-Watchlist" {
    It "Tests backing up and restoring watchlists." {

        # Create a random string
        $RandomString = [System.IO.Path]::GetRandomFileName().Substring(0,8)

        # Create a new watchlist on dev1 with $RandomString
        $NewWatchlistResponse = New-Watchlist -Name "$RandomString" `
                    -Description "Testing the ability to create a new watchlist via the api." `
                    -Search_query "process_name:calc.exe" `
                    -Instance dev1
        $NewWatchlistResponse.id | Should -BeGreaterThan 0
        $NewWatchlist = Get-Watchlist -Id $NewWatchlistResponse.id -Instance dev1
        $NewWatchlist | Test-Watchlist | Should -BeTrue

        # Backup the watchlists from dev1
        $BackupPath = ".\dev1-backup-watchlists.txt"
        Backup-Watchlists $BackupPath -Instance dev1

        Test-Path $BackupPath | Should -BeTrue

        $Content = Import-Clixml $BackupPath
        $Content -is [System.Array] | Should -BeTrue
        foreach ($C in $Content) {
            $C | Test-Watchlist | Should -BeTrue
        }


        # "Restore" the watchlists from dev1 to dev2
        Restore-Watchlist $BackupPath -Instance dev2

        # Verify that dev2 now contains a watchlist with the $RandomString name
        $Watchlists = Get-Watchlist -Instance dev2
        $Watchlists.Name -Contains $RandomString | Should -BeTrue
    }
}
