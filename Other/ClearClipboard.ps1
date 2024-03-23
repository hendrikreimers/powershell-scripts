Add-Type -Assembly 'System.Windows.Forms'

if ([System.Windows.Forms.Clipboard]::ContainsText()) {
	Write-Output "Clearing Clipboard"
    [System.Windows.Forms.Clipboard]::Clear()
}
