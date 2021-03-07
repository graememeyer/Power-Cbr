foreach ($Module in (Get-ChildItem .\*.psm1 -Recurse | Select-Object -ExpandProperty FullName)) {Import-Module $Module -Force}

Describe "Get-Alerts" {
    It "Gets alert(s) from Carbon Black EDR" {
        
        $Alerts = Get-Alerts

        ($Alerts | Get-Member results) | Should -BeTrue
        ($Alerts | Get-Member facets) | Should -BeTrue
        ($Alerts | Get-Member elapsed) | Should -BeTrue
        ($Alerts | Get-Member start) | Should -BeTrue
    }

    It "Tests multiple queries in sequence" {
        
        $Alerts = Get-Alerts

        ($Alerts | Get-Member results) | Should -BeTrue
        ($Alerts | Get-Member facets) | Should -BeTrue
        ($Alerts | Get-Member elapsed) | Should -BeTrue
        ($Alerts | Get-Member start) | Should -BeTrue  

        $Alerts = Get-Alerts

        ($Alerts | Get-Member results) | Should -BeTrue
        ($Alerts | Get-Member facets) | Should -BeTrue
        ($Alerts | Get-Member elapsed) | Should -BeTrue
        ($Alerts | Get-Member start) | Should -BeTrue
    }

}
