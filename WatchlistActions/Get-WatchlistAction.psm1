# Get-WatchlistAction.psm1
Function Get-WatchlistAction {
    [alias("Get-WatchlistActions")]
    [alias("Get-WatchlistActionStatus")]
    [alias("Get-WatchlistActionState")]
    [alias("Get-WatchlistActionType")]
    [CmdletBinding(DefaultParameterSetName = 'All')]
    param(
        [Parameter(mandatory=$true)] [int]$Id,
        [Parameter(mandatory=$False)] [string]$Instance,
        
        [ValidateSet("syslog","email","alert","all")]
        [Parameter(mandatory=$false, ParameterSetName="Action")] [string]$Action,
        
        [Parameter(mandatory=$false, ParameterSetName="All")] [switch]$All
        
    )
    if ($PSBoundParameters.ContainsKey('Action') -and $Action -ne "all") {
        $UriPath = "/api/v1/watchlist/$Id/action_type/$Action"
    }
    elseif ($All -or $Action -eq "all") {
        $UriPath = "/api/v1/watchlist/$Id/action_type"
    }
    else {
        $UriPath = "/api/v1/watchlist/$Id/action_type"
    }

    $Method = "GET"


    if ($Instance) {
        Invoke-CbrApi -Uri $UriPath -Method $Method -Instance $Instance
    }
    else {
        Invoke-CbrApi -UriPath $UriPath -Method $Method
    }
}