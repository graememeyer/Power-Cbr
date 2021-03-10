
Describe "Multiple-Instances" {
    It "Tests querying multiple instances" {

        # Set first instance
        Set-CurrentInstance dev1

        $CurrentInstance = Get-CurrentInstance
        $CurrentInstance | Should -Be "dev1"

        # Get alerts

        $Alerts = Get-Alert -Status all

        ($Alerts | Get-Member results) | Should -BeTrue
        ($Alerts | Get-Member facets) | Should -BeTrue
        ($Alerts | Get-Member elapsed) | Should -BeTrue
        ($Alerts | Get-Member start) | Should -BeTrue



        # Set second instance
        Set-CurrentInstance dev2

        $CurrentInstance = Get-CurrentInstance
        $CurrentInstance | Should -Be "dev2"

        # Get alerts
        $Alerts = Get-Alert -Status all

        ($Alerts | Get-Member results) | Should -BeTrue
        ($Alerts | Get-Member facets) | Should -BeTrue
        ($Alerts | Get-Member elapsed) | Should -BeTrue
        ($Alerts | Get-Member start) | Should -BeTrue



        # Set back to first instance
        Set-CurrentInstance dev1

        $CurrentInstance = Get-CurrentInstance
        $CurrentInstance | Should -Be "dev1"

        # Get watchlists
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


        # Get watchlists from the second instance with the -instance parameter
        $Watchlists = Get-Watchlists -Instance dev2

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
