### RUN AS ADMIN IN A POWERSHELL

#
## INSTALLATION AND REPAIR LIST
#
$registryList = @(
	### Right-Click Folder context menu
	[pscustomobject]@{
		Path="HKEY_CLASSES_ROOT\Directory\shell\PowershellConsoleHere"
		Key="MUIVerb"
		RegType="REG_SZ"
		Value="Powershell"
	},
	[pscustomobject]@{
		Path="HKEY_CLASSES_ROOT\Directory\shell\PowershellConsoleHere"
		Key="Icon"
		RegType="REG_SZ"
		Value="powershell.exe"
	},
	[pscustomobject]@{
		Path="HKEY_CLASSES_ROOT\Directory\shell\PowershellConsoleHere"
		Key="ExtendedSubCommandsKey"
		RegType="REG_SZ"
		Value="Directory\ContextMenus\MenuPowerShell"
	},
	
	

	### Right-Click Background (like Desktop) context menu
	[pscustomobject]@{
		Path="HKEY_CLASSES_ROOT\Directory\Background\shell\PowershellConsoleHere"
		Key="MUIVerb"
		RegType="REG_SZ"
		Value="Powershell"
	},
	[pscustomobject]@{
		Path="HKEY_CLASSES_ROOT\Directory\Background\shell\PowershellConsoleHere"
		Key="Icon"
		RegType="REG_SZ"
		Value="powershell.exe"
	},
	[pscustomobject]@{
		Path="HKEY_CLASSES_ROOT\Directory\Background\shell\PowershellConsoleHere"
		Key="ExtendedSubCommandsKey"
		RegType="REG_SZ"
		Value="Directory\Background\ContextMenus\MenuPowerShell"
	},
	
	
	
	### Add 7Zip to Context Menu
	[pscustomobject]@{
		Path="HKEY_CLASSES_ROOT\Directory\ContextMenus\MenuPowerShell\shell\7zall"
		Key="MUIVerb"
		RegType="REG_SZ"
		Value="Compress all"
	},
	[pscustomobject]@{
		Path="HKEY_CLASSES_ROOT\Directory\ContextMenus\MenuPowerShell\shell\7zall"
		Key="Icon"
		RegType="REG_SZ"
		Value="C:\Program Files\7-Zip\7zG.exe"
	},
	[pscustomobject]@{
		Path="HKEY_CLASSES_ROOT\Directory\ContextMenus\MenuPowerShell\shell\7zall\command"
		RegType="(Default)"
		Value="powershell.exe -File C:\\Users\\YOUR_USERNAME\\PowerShellScripts\\7Zip-Compress-All.ps1 targetParent \`"%V\`""
	}
	
	### Add 7Zip to Context Menu
	[pscustomobject]@{
		Path="HKEY_CLASSES_ROOT\Directory\Background\ContextMenus\MenuPowerShell\shell\7zall"
		Key="MUIVerb"
		RegType="REG_SZ"
		Value="Compress all"
	},
	[pscustomobject]@{
		Path="HKEY_CLASSES_ROOT\Directory\Background\ContextMenus\MenuPowerShell\shell\7zall"
		Key="Icon"
		RegType="REG_SZ"
		Value="C:\Program Files\7-Zip\7zG.exe"
	},
	[pscustomobject]@{
		Path="HKEY_CLASSES_ROOT\Directory\Background\ContextMenus\MenuPowerShell\shell\7zall\command"
		RegType="(Default)"
		Value="powershell.exe -File C:\\Users\\YOUR_USERNAME\\PowerShellScripts\\7Zip-Compress-All.ps1 targetSame \`"%V\`""
	}
)

# ----------------------------------------

# Registry Testing Function
function Test-RegistryEntryExists($regEntryObj) {
	$key = Get-Item -LiteralPath registry::$($regEntryObj.Path) -ErrorAction SilentlyContinue
	$key -and $null -ne $key.GetValue($regEntryObj.Key, $null)
}

# Shows a Dialog
function Show-AnswerDialog($question) {
	$wshell = New-Object -ComObject Wscript.Shell
	if ( $wshell.Popup($question, 0, "Alert", 64+4) -eq 6 ) { $true } else { $false }
}

# ----------------------------------------

# GENERAL TEST ITERATION
$allExists = $true
foreach ( $regEntry in $registryList ) {
	$entryExists = Test-RegistryEntryExists($regEntry)
	if ( !$entryExists ) {
		$allExists = $false
	}
}

# ----------------------------------------

# INSTALL REPAIR DIALOG
if ( $allExists -eq $false ) {
	$answer = Show-AnswerDialog("Looks damaged or not installed. Repair/Install it?")
	
	if ( $answer -eq $true ) {
		foreach ( $regEntry in $registryList ) {
			$entryExists = Test-RegistryEntryExists($regEntry)
			
			if ( !$entryExists ) {
				if ( $regEntry.RegType -eq "(Default)" ) {
					reg add "$($regEntry.Path)" /f /ve /d $regEntry.Value
				} else {
					reg add "$($regEntry.Path)" /v $regEntry.Key /t $regEntry.RegType /d $regEntry.Value /f
				}
			}
		}
	}
}

# UNINSTALL DIALOG
if ( $allExists -eq $true ) {
	$answer = Show-AnswerDialog("Uninstall it?")
	
	if ( $answer -eq $true ) {
		foreach ( $regEntry in $registryList ) {
			$entryExists = Test-Path -path registry::$($regEntry.Path)
			
			if ( $entryExists -eq $true ) {
				Write-Output "REMOVING ENTRY: $($regEntry.Path)"
				reg delete "$($regEntry.Path)" /f
			}
		}
	}
}

# ----------------------------------------
pause