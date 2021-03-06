# Set-WatchlistAction.psm1
Function Set-WatchlistAction {
    [alias("Set-WatchlistActionStatus")]
    [alias("Set-WatchlistActionState")]
    [alias("Set-WatchlistActionType")]
    param(
        [Parameter(mandatory=$true, ValueFromPipelineByPropertyName=$True)] [int]$Id,
        [Parameter(mandatory=$False)] [string]$Instance,

        [ValidateSet("syslog","email","alert")]
        [Parameter(mandatory=$True)] [string]$Action,

        [ValidateSet("enabled","disabled")]
        [Parameter(mandatory=$True, ParameterSetName="state")] [string]$State,

        [Parameter(mandatory=$True, ParameterSetName="switchEnabled")] [switch]$Enabled,

        [Parameter(mandatory=$True, ParameterSetName="switchDisabled")] [switch]$Disabled

    )
    process {
        $UriPath = "/api/v1/watchlist/$Id/action_type/$Action"
        $Method = "PUT"

        $Body = @{}
        # $Body.enabled = $Enabled
        if ($Enabled -or $State -eq "enabled") {
            $Body.enabled = $true
        }
        elseif ($Disabled -or $State -eq "disabled") {
            $Body.enabled = $false
        }
        else {
            Write-Error "Somehow no state submission was detected. Disabling the action by default."
            $Body.enabled = $false
        }

        if ($Instance) {
            Invoke-Api -Uri $UriPath -Method $Method -Body $Body -Instance $Instance
        }
        else {
            Invoke-Api -UriPath $UriPath -Method $Method -Body $Body
        }
    }
}