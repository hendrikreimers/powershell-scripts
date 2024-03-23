# Accepts an argument and use it's default value if not set
Param(
    [string]$configFile = "$($PSScriptRoot)\$([System.IO.Path]::GetFileNameWithoutExtension($MyInvocation.MyCommand.Name)).ini"
)

# Include Functions from external script file
. "$PSScriptRoot\$([System.IO.Path]::GetFileNameWithoutExtension($MyInvocation.MyCommand.Name)).functions.ps1"

# Force only one instance of this script
Check-AlreadyRunning

# Hide the command line prompt
SetConsole-Visibility -hide

# Loads the INI Configuration
$AppConfig = Get-IniContent($configFile)

# Test connection first
if ( (Test-Host $($AppConfig._DEFAULTS_.address)) -eq $false ) {
	SetConsole-Visibility -show
	DoExitWithMessage -Message "Host not available" -Timeout 5
}

# Shows the password dialog if not all default values set
# If all is set, it uses the default values from the INI File
$cred = Set-CredentialObject "$($AppConfig._DEFAULTS_.username)" "$($AppConfig._DEFAULTS_.password)"
if ( ($cred.user -eq "") -or ($cred.pass -eq "") ) {
	$cred = Show-PasswordDialog -defaultUsername $cred.user -defaultPassword $cred.pass
}

# Check if everything is right and go the way up...
if ( ($cred -ne $false) -and ($cred.user -ne "") -and ($cred.pass -ne "") ) {
	SetConsole-Visibility -show
	
	# GetEnumerator() is important to keep access to the values by accessing it via:
	# $groupItem.key or $groupItem.value (example: $groupItem.value.source )
	foreach ( $groupItem in $AppConfig.GetEnumerator() ) {
		if ( $groupItem.key -ne "_DEFAULTS_" ) {
			$localPath  = "$($groupItem.value.driveLetter):".ToUpper()
			$remotePath = "\\$($AppConfig._DEFAULTS_.address)\$($groupItem.value.shareName)"
			
			$mapStatus  = $(Get-SmbMapping -LocalPath $localPath -RemotePath $remotePath -ErrorAction SilentlyContinue).Status
			
			# Map if not already mapped
			if ( $mapStatus -ne "OK" ) {
				Write-Output "----------------------------------------------------------------------"
				Write-Output ">>> Connecting `"$($remotePath)`" to `"$($localPath)`" ..."
				Write-Output ""
			
				net use "$($groupItem.value.driveLetter):" /delete /Y
				net use "$($localPath)" "$($remotePath)" "$($cred.pass)" /USER:"$($cred.user)" /PERSISTENT:NO
			}
		}
	}
} else {
	SetConsole-Visibility -show
	DoExitWithMessage "Cancelled"
}