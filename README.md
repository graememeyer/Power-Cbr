# Power-Cbr
A PowerShell module library for interating with Carbon Black EDR (né Carbon Black Response).

Only CB EDR versions >=6.3 are supported / expected to work.

# Features
This library currently supports the Alert, Watchlist and a subset of the Process APIs listed in Carbon Black's [official documentation](https://developer.carbonblack.com/reference/enterprise-response/6.3/rest-api/).

/api/v1/process/
* Search
* Get (Process Summary)
* Get (Process Segment Details)

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
Current version: 1.0

# Known Issues
None, other than the not-yet-built content.

# Usage
