<# https://developer.carbonblack.com/reference/enterprise-response/6.3/rest-api/#alerts
Alerts
Search Alerts
/api/v2/alert

Supports: GET, POST

Parameters

q: REQUIRED Query string. Accepts the same data as the alert search box on the Triage Alerts page. See the Query overview for the query syntax.
rows: OPTIONAL Return this many rows, 10 by default.
start: OPTIONAL Start at this row, 0 by default.
sort: OPTIONAL Sort rows by this field and order. last_update desc by default.
facets: OPTIONAL Return facet results. ‘false’ by default, set to ‘true’ for facets.

#> ## THIS SEEMS TO BE _WRONG_ "last_update" is _NOT_ a valid sort field!

# Get-Alert.psm1
Function Get-Alert {
    [alias("Get-Alerts")]
    param(
        [Parameter(mandatory=$False)] [string]$Instance,

        #[Parameter(mandatory=$False)] [guid]$Id,
        [Parameter(mandatory=$False)] [string]$Query,

        [Alias("Count","Row")]
        [Parameter(mandatory=$False)] [int]$Rows = 100,

        [Parameter(mandatory=$False)] [int]$Start,

        [Parameter(mandatory=$False)] [string]$Sort = "created_time asc", # Split into field + order at some point

        [Alias("Facet")]
        [Parameter(mandatory=$False)] [bool]$Facets = $False,

        [ValidateSet("In Progress","Resolved","Unresolved","False Positive","all")]
        [Parameter(mandatory=$False)] [string[]]$Status = @("Unresolved","In Progress"),

        [switch]$ResultsOnly
    )
    $UriPath = "/api/v2/alert"
    $Method = "GET"

    # Single alert query
    # if ($Id)
    # {
    #     $UriPath = $UriPath + "?cb.fq.unique_id=$Id"
    # }

    # Build the URI query string
    # For some reason, this API wants query strings instead of body parameters...

    $UriQuery = "?cb.urlver=1" # Doesn't seem to be required, but ¯\_(ツ)_/¯

    if ($Status -like "all") {
        $Status = @("In Progress","Resolved","Unresolved","False Positive")
    }
    else {
        foreach ($S in $Status) {
            $UriQuery += "&cb.fq.status="
            $UriQuery += ([uri]::EscapeDataString($S))
        }
    }

    $UriQuery += "&"

    $Parameters = @{}

    if ($Query) {$Parameters['q'] = [uri]::EscapeDataString($Query)}
    if ($Rows) {$Parameters['rows'] = $Rows}
    if ($Start) {$Parameters['start'] = $Start}
    if ($Sort) {$Parameters['sort'] = [uri]::EscapeDataString($Sort)}
    if ($Facets) {$Parameters['facets'] = $Facets}

    $Parameters = ($Parameters.GetEnumerator() | ForEach-Object { "$($_.Key)=$($_.Value)" }) -join '&'

    # $UriPath += "?
    # $UriQuery = "cb.urlver=1&cb.fq.status=Unresolved&sort=alert_severity%20desc&rows=1&facet=false"
    $UriQuery += $Parameters
    $UriPath += $UriQuery

    if ($Instance) {
        $Response = Invoke-Api -Uri $UriPath -Method $Method -Instance $Instance
    }
    else {
        $Response = Invoke-Api -UriPath $UriPath -Method $Method
    }

    if ($ResultsOnly -and $Response.results) {
        $Response.results
    }
    else {
        $Response
    }
}
