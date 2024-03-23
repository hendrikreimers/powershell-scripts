# Accepts an argument and use it's default value if not set
Param(
    [string]$configFile = "$($PSScriptRoot)\$([System.IO.Path]::GetFileNameWithoutExtension($MyInvocation.MyCommand.Name)).ini"
)

# Get-IniContent
#
# Reads a simple ini file as array (Src: https://techgenix.com/reading-an-ini-file-into-powershell/)
# 
function Get-IniContent($filePath) {
    $ini = @{}
    switch -regex -file $FilePath
    {
        "^\[(.+)\]" # Section
        {
            $section = $matches[1].Trim()
            $ini[$section] = @{}
            $CommentCount = 0
        }
        #"^(;.*)$" # Comment
        #{
        #    $value = $matches[1]
        #    $CommentCount = $CommentCount + 1
        #    $name = "Comment" + $CommentCount
        #    $ini[$section][$name.Trim()] = $value.Trim()
        #}
        #"(.+?)\s*=(.*)" # Key
		"^([^;\\n][a-zA-Z]+)([ ]{0,}=[ ]{0,})([^;]*)(;?.*)$" # Key (ignoring comments)
        {
            $name,$x,$value = $matches[1..3]
            $ini[$section][$name.Trim()] = $value.Trim('"'," ")
        }
    }
    return $ini
}

#
# DoExitWithMessage
#
# Shows a message and waits before ending the script
#
# Usage:
# 	DoExitWithMessage -Message "Host not available" -Timeout 5
# 	DoExitWithMessage "Host not available" 5
# 	DoExitWithMessage -Message "Host not available"
# 	DoExitWithMessage "Host not available"
#
function DoExitWithMessage {
	Param (
		[Parameter(Mandatory=$true)] [string]$Message,
		[Parameter(Mandatory=$false)] [int]$Timeout = 3
	)
	
	Write-Output ""
	Write-Output ">>> $($Message)..."
	Write-Output ""
	Write-Output "Script exiting in $($Timeout) seconds..."
	Start-Sleep -Seconds $Timeout
	Exit
}

#
# Check-AlreadyRunning
#
# Checks if the script is already running and 
# forces to only run one instance by exiting with a message
#
function Check-AlreadyRunning {
	$scriptName = $(GCI $MyInvocation.PSCommandPath | Select -Expand Name)
	
	# You may want to replace FullPathName
	# 	$MyInvocation.MyCommand.Path 
	# 
	# with Scriptname
	# 	$MyInvocation.MyCommand.Name 
	# 
	$otherScriptInstances=get-wmiobject win32_process | where{$_.processname -eq 'powershell.exe' -and $_.ProcessId -ne $pid -and $_.commandline -match $scriptName}
	
	if ($otherScriptInstances -ne $null) {
		DoExitWithMessage -Message "Script already running. Exiting"
	}
}

# Allow only one instance
Check-AlreadyRunning

# Load INI Configuration
$AppProps = Get-IniContent($configFile)
$rcArgs   = "/MIR /R:0 /W:0 /NFL /NDL /NS /NC /NP /NJH /NJS"

# GetEnumerator() is important to keep access to the values by accessing it via:
# $groupItem.key or $groupItem.value (example: $groupItem.value.source )
foreach ( $groupItem in $AppProps.GetEnumerator() ) {
	if ( $groupItem.key.ToUpper() -ne "_SETTINGS_" ) {
		# Produce some output
		Write-Output "==============================================================================="
		Write-Output ""
		Write-Output ">>> $($groupItem.key): "
		Write-Output ""
		
		if ( (Test-Path -path "$($groupItem.value.source)") -And (Test-Path -path "$($groupItem.value.target)") ) {
			Write-Output "----> From '$($groupItem.value.source)' to '$($groupItem.value.target)'..."
			
			# Generate the robocopy arguments
			$pArgs = "`"$($groupItem.value.source)`" `"$($groupItem.value.target)`" $($rcArgs)"
			
			# Add exclude path option for robocopy if set
			if ( -not ([string]::IsNullOrEmpty($groupItem.value.exclude)) ) {
				Write-Output "--> EXCLUDING: $($groupItem.value.exclude)"
				$pArgs = $pArgs + " /XD `"$($groupItem.value.exclude)`""
			}
			
			# Run the process (robocopy)
			#Start-Process -FilePath "robocopy" -ArgumentList "$($pArgs)" -PassThru -Wait -NoNewWindow 
			$Process = Start-Process -FilePath "robocopy" -ArgumentList "$($pArgs)" -PassThru -NoNewWindow
			$Process.PriorityClass = [System.Diagnostics.ProcessPriorityClass]::$($AppProps._SETTINGS_.processPriority)
			Wait-Process -Id $Process.id -ErrorAction SilentlyContinue
		} else {
			Write-Output "Source/Target Path not available for `"$($groupItem.key)`""
		}
	}
}

# Just for debug purpose to check if everything runs without errors by the user
#Write-Output ""
#pause