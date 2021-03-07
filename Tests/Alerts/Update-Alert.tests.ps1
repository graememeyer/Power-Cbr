foreach ($Module in (Get-ChildItem .\*.psm1 -Recurse | Select-Object -ExpandProperty FullName)) {Import-Module $Module -Force}

Describe "Update-Alert" {
    It "Updates an alert from Carbon Black EDR" {

        # First get the alerts
        $Alerts = Get-Alert -Status all

        # If non-zero
        ($Alerts | Get-Member results) | Should -BeTrue
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
