# Search-Process.psm1
Function Search-Process {
    [Alias("Search-Processes")]
    [Alias("Find-Process")]
    [Alias("Find-Processes")]
    param(
        [Parameter(mandatory=$False)] [string]$Instance,
        [Parameter(mandatory=$False)] [string]$Query,

        [Alias("Count","Row")]
        [Parameter(mandatory=$False)] [int]$Rows = 10,

        [Parameter(mandatory=$False)] [int]$Start=0,

        [Parameter(mandatory=$False)] [string]$Sort = "last_update desc",


        [Parameter(mandatory=$False,ParameterSetName="FacetSearch")] [bool]$Facet = $False,

        [ValidateSet("process_md5","hostname","group","path_full","parent_name","process_name","host_type","hour_of_day","day_of_week","start","username_full")]
        [Parameter(mandatory=$False, ParameterSetName="FacetSearch")] [string[]]$FacetField,

        [Parameter(mandatory=$False)] [bool]$ComprehensiveSearch,

        [Alias("FuzzyFacets","FacetFuzzy", "FuzzyFaceting")]
        [Parameter(mandatory=$False)] [bool]$FuzzyFacet,

        [Alias("GroupBy", "GroupField")]
        [Parameter(mandatory=$False)] [string]$Group,

        [Alias("Results")]
        [switch]$ResultsOnly
    )
    $UriPath = "/api/v1/process"
    $Method = "GET"

    $UriQuery = "?cb.urlver=1"

    $UriQuery += "&"

    $Parameters = @{}

    if ($Query) {$Parameters['q'] = [uri]::EscapeDataString($Query)}
    if ($Rows) {$Parameters['rows'] = $Rows}
    if ($Start) {$Parameters['start'] = $Start}
    if ($Sort) {$Parameters['sort'] = [uri]::EscapeDataString($Sort)}
    if ($Facet) {$Parameters['facet'] = $Facet}
    if ($FacetField) {$Parameters['facet.field'] = $FacetField}
    if ($ComprehensiveSearch) {$Parameters['cb.comprehensive_search'] = $ComprehensiveSearch}
    if ($FuzzyFacet) {$Parameters['cb.facet.fuzzy'] = $FuzzyFacet}
    if ($group) {$Parameters['cb.group'] = $group}

    $Parameters = ($Parameters.GetEnumerator() | ForEach-Object { "$($_.Key)=$($_.Value)" }) -join '&'

    $UriQuery += $Parameters
    $UriPath += $UriQuery

    if ($Instance) {
        $Response = Invoke-Api -Uri $UriPath -Method $Method -Instance $Instance
    }
    else {
        $Response = Invoke-Api -UriPath $UriPath -Method $Method
    }

    if ($ResultsOnly -and $Response.Results) {
        $Response.Results
    }
    else {
        $Response
    }
}
