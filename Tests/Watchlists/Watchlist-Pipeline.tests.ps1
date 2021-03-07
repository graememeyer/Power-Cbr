foreach ($Module in (Get-ChildItem .\*.psm1 -Recurse | Select-Object -ExpandProperty FullName)) {Import-Module $Module -Force}

Describe "Watchlist-Pipeline" {
    It "Tests removing/deleting watchlists in Carbon Black EDR" {

        # Create 5 watchlists
        $WatchlistArray = @()
        [string[]]$RandomStringArray = @()
        for ($i=0; $i -lt 5; $i++) {
            # Create a random string
            $RandomString = [System.IO.Path]::GetRandomFileName().Substring(0,8)
            $RandomStringArray += $RandomString

            # Create a new watchlist
            $NewWatchlistResponse = New-Watchlist -Name "API-TEST-WL-$($RandomString)" `
                    -Description "Testing the ability to create a new watchlist via the api." `
                    -Search_query "process_name:calc.exe" `

            $NewWatchlistResponse.id | Should -BeGreaterThan 0

            $NewWatchlist = Get-Watchlist -Id $NewWatchlistResponse.id
            $NewWatchlist | Test-Watchlist | Should -BeTrue

            $WatchlistArray += $NewWatchlist
        }

        # Verify the random string in the name
        $referenzRegex = [string]::Join('|', $RandomStringArray)
        foreach ($Watchlist in $WatchlistArray) {
            $Watchlist.Name | Should -Match $referenzRegex
        }


        # Edit all 5 watchlists using the pipeline
        [string[]]$RandomEditStringArray = @()
        foreach ($Watchlist in $WatchlistArray) {
            # Create a random string
            $RandomEditString = [System.IO.Path]::GetRandomFileName().Substring(0,8)
            $RandomEditStringArray += $RandomEditString
            $WatchlistEditResponse = $Watchlist | Edit-Watchlist -Description ($Watchlist.description + " [EDITED] $RandomEditString")
            $WatchlistEditResponse.result | Should -Be "Success"
        }

        # Verify the watchlist description was edited to include the random string
        $EditedWatchlistReferenzRegex = [string]::Join('|', $RandomEditStringArray)
        foreach ($Watchlist in $WatchlistArray) {
            $EditedWatchlist = $Watchlist | Get-Watchlist
            $EditedWatchlist | Test-Watchlist | Should -BeTrue
            $EditedWatchlist.description | Should -Match $EditedWatchlistReferenzRegex
        }

<#
        # Get the existing action states
        $WatchlistActions = Get-WatchlistActions -Id $EditedWatchlist.id
        $WatchlistActions | Test-WatchlistActions | Should -BeTrue

        # Flip a couple of the action states
        $WatchlistActionsResponse = Set-WatchlistActionState -Id $EditedWatchlist.id -Action syslog -Enabled
        $WatchlistActionsResponse.result | Should -Be "Success"

        # Confirm the action states flipped
        $UpdatedWatchlistActions = Get-WatchlistActions -Id $EditedWatchlist.id
        $UpdatedWatchlistActions | Test-WatchlistActions | Should -BeTrue

        # Flip them back
        $FlippedWatchlistActionsResponse = Set-WatchlistActionState -Id $EditedWatchlist.id -Action syslog -Disabled
        $FlippedWatchlistActionsResponse.result | Should -Be "Success"

        # Confirm the action states flipped
        $FlippedWatchlistActions = Get-WatchlistActions -Id $EditedWatchlist.id
        $FlippedWatchlistActions | Test-WatchlistActions | Should -BeTrue


        # Delete the new watchlist
        $RemoveWatchlistResponse = Remove-Watchlist $EditedWatchlist.id
        $RemoveWatchlistResponse.result | Should -Be "Success"

        # Confirm it's been deleted
        $GotRemovedWatchlist = Get-Watchlist $EditedWatchlist.id
        $GotRemovedWatchlist.Message | Should -Match "404" #>
    }
}
