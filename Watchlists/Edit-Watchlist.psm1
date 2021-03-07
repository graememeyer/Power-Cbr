# Edit-Watchlist.psm1
Function Edit-Watchlist {
    [alias("Set-Watchlist")]
    [alias("Update-Watchlist")]
    param(
        [Parameter(mandatory=$True, ValueFromPipelineByPropertyName=$True)] [int]$Id,
        [Parameter(mandatory=$False)] [string]$Instance,
        [Parameter(mandatory=$False)] [string]$Name,
        [Parameter(mandatory=$False)] [string]$Description,
        [Parameter(mandatory=$False)] [string]$Search_Query,
        [Parameter(mandatory=$False)] [bool]$Enabled
    )
    process {
        $UriPath = "/api/v1/watchlist/$Id"
        $Method = "PUT"

        if ($Search_query) {
            # Format and url-encode the search query
            $Search_query = $Search_query | ConvertTo-EncodedSearchQuery
        }
        else { # The search_query field is required to update/edit the watchlist
            try { # If it's blank or non-existant, the query will be blanked on the server too.
                $CurrentWatchlist = Get-Watchlist -Id $Id
                $Search_query = $CurrentWatchlist.search_query
            }
            catch {
                Write-Error "Something went wrong retreiving the details of the existing watchlist."
                Write-Error "Exiting."
                exit
            }
        }

        $Body = @{}
        if ($Name)          {$Body.name = $Name}
        if ($Description)   {$Body.description = $Description}
        if ($Search_query)  {$Body.search_query = $Search_query}
        if ($Enabled)       {$Body.enabled = $Enabled}


        if ($Instance) {
            Invoke-CbrApi -Uri $UriPath -Method $Method -Body $Body -Instance $Instance
        }
        else {
            Invoke-CbrApi -UriPath $UriPath -Method $Method -Body $Body
        }
    }
}