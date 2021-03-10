
Describe "Get-Watchlist" {
    It "Gets Watchlist(s) from Carbon Black EDR" {

        $Watchlists = Get-Watchlists

        $Watchlists | Should -Not -BeNullOrEmpty
        $Watchlists.Count | Should -BeGreaterThan 2

        $Watchlist = $Watchlists[0]

        $Watchlist.id | Should -BeGreaterThan 0
        $Watchlist.date_added | Should -Not -BeNullOrEmpty
        ($Watchlist | Get-Member description) | Should -BeTrue
        $Watchlist.index_type | Should -Not -BeNullOrEmpty
        ($Watchlist | Get-Member search_query) | Should -BeTrue
        $Watchlist.name | Should -Not -BeNullOrEmpty
    }
}
