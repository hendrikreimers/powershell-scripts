# Include Functions from external script file
. "$PSScriptRoot\$([System.IO.Path]::GetFileNameWithoutExtension($MyInvocation.MyCommand.Name)).functions.ps1"

SetConsole-Visibility -hide

$sourceDir          = $(Get-Item "$($args[0])").FullName
$conversionSettings = Show-FormDialog

SetConsole-Visibility -show

if ( $conversionSettings -eq $false ) {
	Exit
}

# Call the conversion
Convert-Image -SourcePath $sourceDir -Settings $conversionSettings