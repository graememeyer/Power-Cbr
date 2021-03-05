ForEach ($Module in (Get-ChildItem -Path .\*.psm1 -Recurse)) {Import-Module $Module.FullName -Force}

Describe "Watchlists" {
    It "Creates a new watchlist in Carbon Black EDR" {
        
        # Create a random string
        $RandomString = [System.IO.Path]::GetRandomFileName().Substring(0,8)

        # Create a new watchlist
        $NewWatchlistResponse = New-Watchlist -Name "CTH-TEST-WL-GM-$($RandomString)" `
                    -Description "Testing the ability to create a new watchlist via the api." `
                    -Search_query "process_name:calc.exe" `
                    -Instance "dev"

        $NewWatchlistResponse.id | Should -BeGreaterThan 0

        $NewWatchlist = Get-Watchlist -Id $NewWatchlistResponse.id
        $NewWatchlist | Test-Watchlist | Should -BeTrue


        # Edit the watchlist
        $EditWatchlistResponse = Edit-Watchlist -Id $NewWatchlist.id `
                    -Description ($NewWatchlist.Description + " [EDITED] $RandomString")
        $EditWatchlistResponse.result | Should -Be "Success"

        # Confirm the watchlist was edited properly
        $EditedWatchlist = Get-Watchlist -Id $NewWatchlist.id
        $EditedWatchlist.description | Should -Match ([regex]::escape(" [EDITED] $RandomString"))
        $EditedWatchlist.description | Should -BeLike "*$RandomString*"


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
        $GotRemovedWatchlist.Message | Should -Match "404"
    }
}
