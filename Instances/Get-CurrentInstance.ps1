# Get-CurrentInstance.psm1
Function Get-CurrentInstance {
    process {
        if (-not $Config.CurrentInstance) {
            throw "No current instance is set."
        }
        else {
            $Config.CurrentInstance
        }
    }
}