# Power-Cbr
A PowerShell module library for interating with Carbon Black EDR (né Carbon Black Response).

Only CB EDR versions >=6.3 are supported / expected to work.

# Installation
Power-Cbr can be installed directly from the PowerShell Gallery:

```PowerShell
Install-Module -Name "Power-Cbr"
```

# Features
This library currently supports the Alert, Watchlist, Process and Watchlist Action APIs listed in Carbon Black's [official documentation](https://developer.carbonblack.com/reference/enterprise-response/6.3/rest-api/).

/api/v1/process/
* Search
* Get (Process Summary)
* Get (Process Segment Details)
* Get (Process)

/api/v2/process/
* Get (Process Summary (No Siblings))

/api/v4/process/
* Get (Process Event Details)

/api/v2/alert
* Search
* Update\

/api/v1/watchlist
* New (create)
* Get (read)
* Update
* Remove (delete)
* Get watchlist actions / action_types
* Set / update watchlist actions / action_types

# Roadmap
Current version: 1.1.0

* Backup + restore watchlists
* In-line documentation/comment-based help
* Basic user-guide in the README
* Save credentials and instance info some-how. TBD
* Binary API
* Go-live API
* May have to move to a class / more object-oriented model if the supported APIs keep drifting with Server versions.
* PowerShell 7 support / testing


# Known Issues
None, other than the not-yet-built content.

# Usage

## Alerts
* Get-Alert
* Update-Alert

## Instance
* Get-CbrInstance
* Get-CurrentInstance
* New-CbrInstance
* Set-CurrentInstance

## Processes
* Get-ProcessEventDetail
* Get-ProcessPreview
* Get-ProcessSegment
* Get-ProcessSummary
* Search-Process

## Watchlist Actions
* Get-WatchlistAction
* Set-WatchlistAction
* Test-WatchlistAction

## Watchlists
* Edit-Watchlist
* Get-Watchlist
* New-Watchlist
* Remove-Watchlist
* Test-Watchlist