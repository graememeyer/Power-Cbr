# Establish Working Directory
try {
    $WorkingDirectory = Switch ($Host.name){
        'Visual Studio Code Host' { split-path $psEditor.GetEditorContext().CurrentFile.Path }
        'Windows PowerShell ISE Host' {  Split-Path -Path $psISE.CurrentFile.FullPath }
        'ConsoleHost' { $PSScriptRoot }
    }
} catch {
    Write-Error -ForegroundColor Red "Caught Exception: $($Error[0].Exception.Message)"
    exit 2
}

$Modules = Get-ChildItem -Path $WorkingDirectory\*.ps1 -Recurse | Where-Object {$_.FullName -notmatch ".tests.ps1$"}

foreach ($Module in $Modules) {
    try {
        if ($Module.FullName -NotMatch "debug") {
            . $Module.FullName
        }
    }
    catch {
        throw $_
    }
}