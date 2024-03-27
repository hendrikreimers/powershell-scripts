# Force to run as an administrator
if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
{
    Start-Process powershell.exe -ArgumentList ('-NoProfile -ExecutionPolicy Bypass -File "{0}" -am_admin' -f $MyInvocation.MyCommand.Path) -Verb RunAs
    exit
}

# Delete temporary files and directories
$paths = @(
    'C:\Windows\System32\config\systemprofile\AppData\Local\tw*.tmp',
    "$env:USERPROFILE\AppData\Local\Temp\*",
    'C:\Windows\Temp\*',
    'C:\Windows\SoftwareDistribution\Download\*',
    'C:\Windows\SoftwareDistribution\SLS\*',
    "$env:USERPROFILE\AppData\Roaming\Nextcloud\*.msi",
    "$env:USERPROFILE\AppData\Roaming\Nextcloud\*cfg_bak*",
    "$env:USERPROFILE\AppData\Roaming\Nextcloud\logs\*.log*"
)

foreach ($path in $paths) {
    Write-Host "Processing $path"
    Get-ChildItem -Path $path -Recurse -Directory -ErrorAction SilentlyContinue | ForEach-Object {
        Write-Host "Removing directory: $($_.FullName)"
        Remove-Item $_.FullName -Recurse -Force -ErrorAction SilentlyContinue
    }
    Get-ChildItem -Path $path -File -ErrorAction SilentlyContinue | ForEach-Object {
        Write-Host "Deleting file: $($_.FullName)"
        Remove-Item $_.FullName -Force -ErrorAction SilentlyContinue
    }
}

# Force deleting of recent lists, like jump list etc.
$recentPaths = @(
    "$env:APPDATA\Microsoft\Windows\Recent\AutomaticDestinations",
    "$env:APPDATA\Microsoft\Windows\Recent\CustomDestinations",
    "$env:APPDATA\Microsoft\Windows\Recent"
)

foreach ($recentPath in $recentPaths) {
    Write-Host "Cleaning up $recentPath"
    Get-ChildItem -Path $recentPath -File -ErrorAction SilentlyContinue | ForEach-Object {
        Write-Host "Deleting recent file: $($_.FullName)"
        Remove-Item $_.FullName -Force -ErrorAction SilentlyContinue
    }
}

# System Cleaner
Write-Host "Running System Cleaner"
& "$env:USERPROFILE\PowerShellScripts\system-clean.ps1"

# Clear Clipboard
Write-Host "Clearing Clipboard"
& "$env:USERPROFILE\PowerShellScripts\ClearClipboard.ps1"

# Delete Recent Files in Word and Excel
Write-Host "Clearing Recent Documents in Word and Excel"
& "$env:USERPROFILE\PowerShellScripts\ClearRecentDocuments.ps1"

# Clean up developer caches
& "$env:USERPROFILE\PowerShellScripts\dev-clean.ps1"
