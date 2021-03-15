
Describe "Get-Watchlist" {
    It "Gets Watchlist(s) from Carbon Black EDR" {

        $Watchlists = Get-Watchlist

        $Watchlists | Should -Not -BeNullOrEmpty
        $Watchlists.Count | Should -BeGreaterThan 2

        foreach ($Watchlist in $Watchlists) {
            $Watchlist.id | Should -BeGreaterThan 0
            $Watchlist.date_added | Should -Not -BeNullOrEmpty
            ($Watchlist | Get-Member description) | Should -BeTrue
            $Watchlist.index_type | Should -Not -BeNullOrEmpty
            ($Watchlist | Get-Member search_query) | Should -BeTrue
            $Watchlist.name | Should -Not -BeNullOrEmpty

            # Verify presense of actions
            ($Watchlist | Get-Member action) | Should -BeTrue
            ($Watchlist.action.Contains("syslog")) | Should -BeTrue
        }

        # Test "NoActions" switch
        $Watchlists = Get-Watchlist -NoActions

        $Watchlists | Should -Not -BeNullOrEmpty
        $Watchlists.Count | Should -BeGreaterThan 2

        foreach ($Watchlist in $Watchlists) {
            $Watchlist.id | Should -BeGreaterThan 0
            $Watchlist.date_added | Should -Not -BeNullOrEmpty
            ($Watchlist | Get-Member description) | Should -BeTrue
            $Watchlist.index_type | Should -Not -BeNullOrEmpty
            ($Watchlist | Get-Member search_query) | Should -BeTrue
            $Watchlist.name | Should -Not -BeNullOrEmpty

            # Verify absense of actions
            ($Watchlist | Get-Member action) | Should -BeFalse
        }
    }
}
