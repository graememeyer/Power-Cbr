ForEach ($Module in (Get-ChildItem -Path .\*.psm1 -Recurse)) {Import-Module $Module.FullName -Force}

Describe "Get-Alerts" {
    It "Gets alert(s) from Carbon Black EDR" {
        
        $Alerts = Get-Alerts

        $Alerts.Results | Should -Not -BeNullOrEmpty    
    }

    It "Tests multiple queries in sequence" {
        
        $Alerts = Get-Alerts

        $Alerts.Results | Should -Not -BeNullOrEmpty    

        $Alerts = Get-Alerts

        $Alerts.Results | Should -Not -BeNullOrEmpty 
    }

}
