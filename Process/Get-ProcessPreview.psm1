# Get-ProcessPreview.psm1
Function Get-ProcessPreview {
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

        [string]$Query
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

        if ($NoSiblings) {
            $ApiVersion = "v2"
        }
        else {
            $ApiVersion = "v1"
        }

        $UriPath = "/api/$ApiVersion/process/$ProcessId/$SegmentId/preview"
        $Method = "GET"

        if ($Instance) {
            Invoke-Api -Uri $UriPath -Method $Method -Instance $Instance
        }
        else {
            Invoke-Api -UriPath $UriPath -Method $Method
        }
    }
}
