# Get-ProcessEventDetails.psm1
Function Get-ProcessEventDetails {
    [Alias("Get-ProcessDetail")]
    [Alias("Get-ProcessDetails")]
    [Alias("Get-Process")]
    param(
        [Parameter(mandatory=$False)] [string]$Instance,

            [Alias("Id", "Process_Id")]
            [Parameter(mandatory=$true, ParameterSetName="Separate")]
            [ValidateScript({$_ -Match "\w+-\w+-\w+-\w+-\w+"})]
        [string]$ProcessId,

        [Alias("Segment_Id")]
        [Parameter(mandatory=$true, ParameterSetName="Separate")]
    [int64]$SegmentId,

        [Alias("Unique_Id")]
        [Parameter(mandatory=$true, ParameterSetName="Unified" ,ValueFromPipeline)]
        [ValidateScript({$_ -Match "\w+-\w+-\w+-\w+-\w+-\w+"})]
    [string]$UniqueId,

    [int64]$EventStart,

    [int64]$EventCount,

    [Alias("ProcessOnly")]
    [switch]$DetailsOnly

    )
    process {

        if ($UniqueId -and $UniqueId -Match "(?<ProcessId>\w+-\w+-\w+-\w+-\w+)-(?<SegmentId>\w+)") {
            try {
                $ProcessId = $Matches.ProcessId
                $SegmentId = [int64] ("0x" + $Matches.SegmentId)
            }
            catch {
                throw "Submitted UniqueID $UniqueId did not parse correctly. Details $_"
            }
        }

        $UriPath = "/api/v4/process/$ProcessId/$SegmentId/event"
        $Method = "GET"

        if ($Instance) {
            $Response = Invoke-Api -Uri $UriPath -Method $Method -Instance $Instance
        }
        else {
            $Response = Invoke-Api -UriPath $UriPath -Method $Method
        }

        if ($DetailsOnly -and $Response.Process) {
            $Response.Process
        }
        else {
            $Response
        }
    }
}
