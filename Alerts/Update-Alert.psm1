# Update-Alert.psm1
Function Update-Alert {
    [alias("Set-Alert")]
    param(
        [Alias("Id","AlertId","UniqueId")]
        [Parameter(mandatory=$true)] [guid]$Unique_Id,

        [Parameter(mandatory=$False)] [string]$Instance,

        [ValidateSet("In Progress","Resolved","Unresolved","False Positive","all")]
        [Alias("AlertStatus")]
        [Parameter(mandatory=$True)] [string]$Status = "Unresolved"

        # [Parameter(mandatory=$False)] [bool]$IsIgnored = $False # Not yet Supported
    )
    $UriPath = "/api/v1/alert/$Unique_Id"
    $Method = "POST"

    $Body = @{}
    $Body.status = $Status

    if ($Instance) {
        Invoke-CbrApi -Uri $UriPath -Method $Method -Body $Body -Instance $Instance
    }
    else {
        Invoke-CbrApi -UriPath $UriPath -Method $Method -Body $Body
    }
}
