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
	
	
	
	### Sub-context menu for Excel-TO-PDF
	
	# Folders (Right-Click on it)
	[pscustomobject]@{
		Path="HKEY_CLASSES_ROOT\Directory\ContextMenus\MenuPowerShell\shell\ExcelToPdf"
		Key="MUIVerb"
		RegType="REG_SZ"
		Value="Convert .xls(x) to PDF"
	},
	[pscustomobject]@{
		Path="HKEY_CLASSES_ROOT\Directory\ContextMenus\MenuPowerShell\shell\ExcelToPdf"
		Key="Icon"
		RegType="REG_SZ"
		Value="C:\Program Files (x86)\Adobe\Acrobat Reader DC\Reader\AcroRd32.exe,1"
	},
	[pscustomobject]@{
		Path="HKEY_CLASSES_ROOT\Directory\ContextMenus\MenuPowerShell\shell\ExcelToPdf\command"
		RegType="(Default)"
		Value="powershell.exe -File C:\\Users\\hendrik\\PowerShellScripts\\ExcelToPdf.ps1 \`"%V\`""
	},
	
	# Folders (Background)
	[pscustomobject]@{
		Path="HKEY_CLASSES_ROOT\Directory\Background\ContextMenus\MenuPowerShell\shell\ExcelToPdf"
		Key="MUIVerb"
		RegType="REG_SZ"
		Value="Convert .xls(x) to PDF"
	},
	[pscustomobject]@{
		Path="HKEY_CLASSES_ROOT\Directory\Background\ContextMenus\MenuPowerShell\shell\ExcelToPdf"
		Key="Icon"
		RegType="REG_SZ"
		Value="C:\Program Files (x86)\Adobe\Acrobat Reader DC\Reader\AcroRd32.exe,1"
	},
	[pscustomobject]@{
		Path="HKEY_CLASSES_ROOT\Directory\Background\ContextMenus\MenuPowerShell\shell\ExcelToPdf\command"
		RegType="(Default)"
		Value="powershell.exe -File C:\\Users\\hendrik\\PowerShellScripts\\ExcelToPdf.ps1 \`"%V\`""
	},
	
	# xlsx - Menu
	[pscustomobject]@{
		Path="HKEY_CLASSES_ROOT\SystemFileAssociations\.xlsx\shell\MenuPowerShell"
		Key="MUIVerb"
		RegType="REG_SZ"
		Value="Powershell"
	},
	[pscustomobject]@{
		Path="HKEY_CLASSES_ROOT\SystemFileAssociations\.xlsx\shell\MenuPowerShell"
		Key="Icon"
		RegType="REG_SZ"
		Value="powershell.exe"
	},
	[pscustomobject]@{
		Path="HKEY_CLASSES_ROOT\SystemFileAssociations\.xlsx\shell\MenuPowerShell"
		Key="ExtendedSubCommandsKey"
		RegType="REG_SZ"
		Value="SystemFileAssociations\.xlsx\shell\MenuPowerShell"
	},
	
	# .xlsx - Sub-menu entry
	[pscustomobject]@{
		Path="HKEY_CLASSES_ROOT\SystemFileAssociations\.xlsx\shell\MenuPowerShell\shell\ExcelToPdf"
		Key="MUIVerb"
		RegType="REG_SZ"
		Value="Convert to PDF"
	},
	[pscustomobject]@{
		Path="HKEY_CLASSES_ROOT\SystemFileAssociations\.xlsx\shell\MenuPowerShell\shell\ExcelToPdf"
		Key="Icon"
		RegType="REG_SZ"
		Value="C:\Program Files (x86)\Adobe\Acrobat Reader DC\Reader\AcroRd32.exe,1"
	},
	[pscustomobject]@{
		Path="HKEY_CLASSES_ROOT\SystemFileAssociations\.xlsx\shell\MenuPowerShell\shell\ExcelToPdf\command"
		Value="powershell.exe -File C:\\Users\\hendrik\\PowerShellScripts\\ExcelToPdf.ps1 \`"%L\`""
		RegType="(Default)" # Changes the "reg add" arguments to "/f /ve /d [VALUE]" instead of "/v [KEY] /t [REG_TYPE] /d [VALUE]"
	},
	
	# .xls - Menu
	[pscustomobject]@{
		Path="HKEY_CLASSES_ROOT\SystemFileAssociations\.xls\shell\MenuPowerShell"
		Key="MUIVerb"
		RegType="REG_SZ"
		Value="Powershell"
	},
	[pscustomobject]@{
		Path="HKEY_CLASSES_ROOT\SystemFileAssociations\.xls\shell\MenuPowerShell"
		Key="Icon"
		RegType="REG_SZ"
		Value="powershell.exe"
	},
	[pscustomobject]@{
		Path="HKEY_CLASSES_ROOT\SystemFileAssociations\.xls\shell\MenuPowerShell"
		Key="ExtendedSubCommandsKey"
		RegType="REG_SZ"
		Value="SystemFileAssociations\.xls\shell\MenuPowerShell"
	},
	
	# .xls - Sub-menu entry
	[pscustomobject]@{
		Path="HKEY_CLASSES_ROOT\SystemFileAssociations\.xls\shell\MenuPowerShell\shell\ExcelToPdf"
		Key="MUIVerb"
		RegType="REG_SZ"
		Value="Convert to PDF"
	},
	[pscustomobject]@{
		Path="HKEY_CLASSES_ROOT\SystemFileAssociations\.xls\shell\MenuPowerShell\shell\ExcelToPdf"
		Key="Icon"
		RegType="REG_SZ"
		Value="C:\Program Files (x86)\Adobe\Acrobat Reader DC\Reader\AcroRd32.exe,1"
	},
	[pscustomobject]@{
		Path="HKEY_CLASSES_ROOT\SystemFileAssociations\.xls\shell\MenuPowerShell\shell\ExcelToPdf\command"
		Value="powershell.exe -File C:\\Users\\hendrik\\PowerShellScripts\\ExcelToPdf.ps1 \`"%L\`""
		RegType="(Default)" # Changes the "reg add" arguments to "/f /ve /d [VALUE]" instead of "/v [KEY] /t [REG_TYPE] /d [VALUE]"
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
