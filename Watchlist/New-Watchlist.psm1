# New-Watchlist.psm1
Function New-Watchlist {
    param(
            [Parameter(mandatory=$False)]
            [string]
        $Instance,

            [Parameter(mandatory=$False, ValueFromPipelineByPropertyName=$true)]
            [string]
        $Name,

            [Parameter(mandatory=$False, ValueFromPipelineByPropertyName=$true)]
            [string]
        $Description,

            [Parameter(mandatory=$False, ValueFromPipelineByPropertyName=$true)]
            [string]
        $Search_query
    )
    process {
        $UriPath = "/api/v1/watchlist"
        $Method = "POST"

        $Search_query = $Search_query | ConvertTo-EncodedSearchQuery

        $Body = @{}
        $Body.name = $Name
        $Body.search_query = $Search_query
        $Body.description = $Description
        $Body.index_type = "events"

        if ($Instance) {
            Invoke-Api -Uri $UriPath -Method $Method -Body $Body -Instance $Instance
        }
        else {
            Invoke-Api -UriPath $UriPath -Method $Method -Body $Body
        }
    }
}