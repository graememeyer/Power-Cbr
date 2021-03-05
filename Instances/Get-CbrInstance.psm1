# Get-CbrInstanceConfig.psm1
Function Get-CbrInstance {
    [Alias("New-CbrInstanceConfig")]
    param(
            [Parameter(mandatory=$false,
                HelpMessage="A name to refer to this unique instance of carbon black - e.g. 'dev'")]
            [ValidatePattern("^[\w\s.-]+$")]
            [alias("InstanceName")]
        [string]$Instance
    )
    begin {
        if (-not($Config)) {
            [System.Collections.Hashtable] $Global:Config = @{}
        }
        if (-not($Config.Instances)) {
            [System.Collections.Hashtable] $Global:Config.Instances = @{}
        }
    }
    process {
        if ($Instance) { # Specific instance requested
            if ($Config.Instances.$Instance) { # Return it if it already exists
                $InstanceConfig = $Config.Instances.$Instance
                Set-CurrentInstance -Instance $InstanceConfig.Name
                return $InstanceConfig
            }
            else { # Create it if it doesn't
                $InstanceConfig = New-CbrInstance -Name $Instance
                Set-CurrentInstance -Instance $InstanceConfig.Name
                return $InstanceConfig
            }
        }
        elseif ($Config.CurrentInstance) { # Use "current"/"previous" instance
            $InstanceConfig = $Config.Instances.($Config.CurrentInstance)
            return $InstanceConfig
        }
<#         elseif ($Global:Config.Instances) { # If instances are configured but somehow no current instance is set
            $Valid = $false
            while (-not $Valid) {
                Write-Host "No current/previous instance is set, but $($Config.Instances.Count) configurations are loaded:"
                Write-Host $Config.Instances.GetEnumerator()

                $Choice = Read-Host -Prompt "Which one would you like to use? Enter 'new' to create a new instance and use that."
                if ($Config.Instances.Keys -contains $Choice) {
                    Write-Host "You have chosen: $Choice"
                    Set-CurrentInstance -Instance $Choice
                    $InstanceConfig = $Config.Instances.$Choice
                    return $InstanceConfig
                }
                elseif ($Choice -eq "new") {
                    $InstanceConfig = New-CbrInstance
                    Set-CurrentInstance -Instance $Instance
                    return $InstanceConfig
                }
            }
        } #>
        else { # Create a new one if none specified and none exist
            Write-Host "No instance was specified, and no instances were configured."
            Write-Host "You must configure a new instance. Please enter the details:"
            $InstanceConfig = New-CbrInstance
            Set-CurrentInstance -Instance $InstanceConfig.Name
            return $InstanceConfig
        }
        Write-Error "Get-CbrInstance: End of file - you shouldn't end up down here."
    }
}