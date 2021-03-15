# Module manifest for module 'Power-Cbr'
#
# Generated by: Graeme Meyer
#
# Generated on: 2021-03-07
#

@{

# Script module or binary module file associated with this manifest.
# RootModule = '.\Power-Cbr.psm1'

# Version number of this module.
ModuleVersion = '1.2.0'

# Supported PSEditions
# CompatiblePSEditions = @()

# ID used to uniquely identify this module
GUID = '007fe193-7ac7-4528-b6fa-01c85fadd1eb'

# Author of this module
Author = 'Graeme Meyer'

# Company or vendor of this module
# CompanyName = ''

# Copyright statement for this module
Copyright = '(c) 2021 Graeme Meyer. All rights reserved.'

# Description of the functionality provided by this module
Description = 'A PowerShell module library for interating with Carbon Black EDR (né Carbon Black Response).'

# Minimum version of the Windows PowerShell engine required by this module
PowerShellVersion = '5.1'

# Name of the Windows PowerShell host required by this module
# PowerShellHostName = ''

# Minimum version of the Windows PowerShell host required by this module
# PowerShellHostVersion = ''

# Minimum version of Microsoft .NET Framework required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
# DotNetFrameworkVersion = ''

# Minimum version of the common language runtime (CLR) required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
# CLRVersion = ''

# Processor architecture (None, X86, Amd64) required by this module
# ProcessorArchitecture = ''

# Modules that must be imported into the global environment prior to importing this module
# RequiredModules = @("")

# Assemblies that must be loaded prior to importing this module
# RequiredAssemblies = @()

# Script files (.ps1) that are run in the caller's environment prior to importing this module.
# ScriptsToProcess = @()

# Type files (.ps1xml) to be loaded when importing this module
# TypesToProcess = @()

# Format files (.ps1xml) to be loaded when importing this module
# FormatsToProcess = @()

# Modules to import as nested modules of the module specified in RootModule/ModuleToProcess
NestedModules = @(

    # Alerts
    '.\Alert\Get-Alert.psm1',
    '.\Alert\Update-Alert.psm1',

    # Instances
    '.\Instance\Get-CbrInstance.psm1',
    '.\Instance\Get-CurrentInstance.psm1',
    '.\Instance\New-CbrInstance.psm1',
    '.\Instance\Set-CurrentInstance.psm1',

    # Process
    '.\Process\Get-ProcessEventDetail.psm1',
    '.\Process\Get-ProcessPreview.psm1',
    '.\Process\Get-ProcessSegment.psm1',
    '.\Process\Get-ProcessSummary.psm1',
    '.\Process\Search-Process.psm1',

    # Tools
    '.\Tools\ConvertFrom-EncodedSearchQuery.psm1',
    '.\Tools\ConvertTo-DateTime.psm1'
    '.\Tools\ConvertTo-EncodedSearchQuery.psm1',
    '.\Tools\Invoke-Api.psm1',
    '.\Tools\Set-SelfSignedCertificateAsIgnored.psm1',

    # Watchlists
    '.\Watchlist\Backup-Watchlist.psm1',
    '.\Watchlist\Edit-Watchlist.psm1',
    '.\Watchlist\Get-Watchlist.psm1',
    '.\Watchlist\New-Watchlist.psm1',
    '.\Watchlist\Remove-Watchlist.psm1',
    '.\Watchlist\Restore-Watchlist.psm1',
    '.\Watchlist\Test-Watchlist.psm1',

    # Watchlist Actions
    '.\WatchlistActions\Get-WatchlistAction.psm1',
    '.\WatchlistActions\Set-WatchlistAction.psm1',
    '.\WatchlistActions\Test-WatchlistAction.psm1'
    )

# Functions to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no functions to export.
# FunctionsToExport = @()

# Cmdlets to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no cmdlets to export.
#CmdletsToExport = @('')

# Variables to export from this module
VariablesToExport = @('')

# Aliases to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no aliases to export.
#AliasesToExport = @('')

# DSC resources to export from this module
# DscResourcesToExport = @()

# List of all modules packaged with this module
# ModuleList = @()

# List of all files packaged with this module
# FileList = @()

# Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
PrivateData = @{

    PSData = @{

        # Tags applied to this module. These help with module discovery in online galleries.
        Tags = @("REST", "API", "EDR",
                "Carbon", "Black", "Response", "VMWare",
                "Power-Cbr", "CBR", "CB")

        # A URL to the license for this module.
        LicenseUri = 'https://github.com/graememeyer/Power-Cbr/LICENSE.md'

        # A URL to the main website for this project.
        ProjectUri = 'https://github.com/graememeyer/Power-Cbr'

        # A URL to an icon representing this module.
        # IconUri = ''

        # ReleaseNotes of this module
        ReleaseNotes = 'https://github.com/graememeyer/Power-Cbr/README.md'

    } # End of PSData hashtable

} # End of PrivateData hashtable

# HelpInfo URI of this module
HelpInfoURI = 'https://github.com/graememeyer/Power-Cbr/README.md'

# Default prefix for commands exported from this module. Override the default prefix using Import-Module -Prefix.
# DefaultCommandPrefix = ''

}