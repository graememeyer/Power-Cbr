
Describe "Get-Alert" {
    It "Gets alert(s) from Carbon Black EDR" {

        $Alerts = Get-Alert

        ($Alerts | Get-Member results) | Should -BeTrue
        ($Alerts | Get-Member facets) | Should -BeTrue
        ($Alerts | Get-Member elapsed) | Should -BeTrue
        ($Alerts | Get-Member start) | Should -BeTrue
    }

    It "Tests multiple queries in sequence" {

        $Alerts = Get-Alert

        ($Alerts | Get-Member results) | Should -BeTrue
        ($Alerts | Get-Member facets) | Should -BeTrue
        ($Alerts | Get-Member elapsed) | Should -BeTrue
        ($Alerts | Get-Member start) | Should -BeTrue

        $Alerts = Get-Alert

        ($Alerts | Get-Member results) | Should -BeTrue
        ($Alerts | Get-Member facets) | Should -BeTrue
        ($Alerts | Get-Member elapsed) | Should -BeTrue
        ($Alerts | Get-Member start) | Should -BeTrue
    }

}
