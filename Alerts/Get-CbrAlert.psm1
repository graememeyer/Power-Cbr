# Get-CbrAlert.psm1
Function Get-CbrAlert {
    param(
        [Parameter(mandatory=$False)] [guid]$Id,
        [Parameter(mandatory=$False)] [int]$Query,
        [Parameter(mandatory=$False)] [string]$Count,
        [Parameter(mandatory=$False)] [string]$Start,
        [Parameter(mandatory=$False)] [string]$Sort,
        [Parameter(mandatory=$False)] [string]$Facets
    )
    $Uri = "/api/v2/alert"
    $Method = "GET"

    # Single alert query
    if ($Id)
    {
        $Uri = $Uri + "?cb.fq.unique_id=$Id"
    }

    Invoke-CbrApi -Uri $Uri -Method $Method
}