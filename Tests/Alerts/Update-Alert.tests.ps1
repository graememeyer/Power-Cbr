ForEach ($Module in (Get-ChildItem -Path .\*.psm1 -Recurse)) {Import-Module $Module.FullName -Force}

Describe "Update-Alert" {
    It "Updates an alert from Carbon Black EDR" {
        
        # First get the alerts
        $Alerts = Get-Alerts

        # If non-zero
        $Alerts.Results | Should -Not -BeNullOrEmpty  
        $Alerts.Results.Count | Should -BeGreaterThan 0 

        # Edit alert
        $Alert = $Alerts.Results[0]
        if($Alert.status -eq "Unresolved") {
            $Response = Update-Alert -Id $Alert.unique_id -Status "In Progress"
        }
        else {
            $Response = Update-Alert -Id $Alert.unique_id -Status "Unresolved"
        }

        $Response.result | Should -Be "Success"

        # Check that the edit was successfull
        # $EditedAlert = Get-Alert -Id $Alert.unique_id
        # $EditedAlert.status = Get-Alert -Id $Alert.unique_id
        # $Alerts.Results | Should -Not -BeNullOrEmpty    
    }
}
