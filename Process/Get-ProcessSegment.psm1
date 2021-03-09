# Get-ProcessSegment.psm1
Function Get-ProcessSegment {
    [Alias("Get-ProcessSegments")]
    [Alias("Get-ProcessSegmentDetails")]
    param(
        [Parameter(mandatory=$False)] [string]$Instance,
            [Alias("Id", "Process_Id")]
            [Parameter(mandatory=$true, ParameterSetName="Separate", ValueFromPipeline)]
            [ValidateScript({$_ -Match "\w+-\w+-\w+-\w+-\w+"})]
        [string]$ProcessId,

        [switch]$SegmentsOnly
    )
    process {
        $UriPath = "/api/v1/process/$ProcessId/segment"
        $Method = "GET"

        if ($Instance) {
            $Response = Invoke-Api -Uri $UriPath -Method $Method -Instance $Instance
        }
        else {
            $Response = Invoke-Api -UriPath $UriPath -Method $Method
        }

        if ($SegmentsOnly -and $Response.Process.Segments) {
            $Response.Process.Segments
        }
        else {
            $Response
        }
    }
}
