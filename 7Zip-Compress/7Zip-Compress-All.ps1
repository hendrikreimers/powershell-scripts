<# 

	This script uses 7-Zip to compress multiple (sub)folders and saves them individually in separate zip files. 
	
#>

$sourceDir = Get-Item "$($args[1])"
$parentDir = Get-Item "$(Split-Path $sourceDir -Parent)"

$source = "$($sourceDir.FullName)\*"
$target = switch ( $args[0] ) {
	"targetParent" { "$($parentDir.FullName)\$($sourceDir.Name).7z" }
	"targetSame" { "$($sourceDir)\$($sourceDir.Name).7z" }
}

$cmdPath     = "C:\Program Files\7-Zip"
$cmdExe      = "7z.exe"
$cmdArgs     = "a -mx=9 -bb0 -mqs=on -m0=bcj2:d24 -m1=lzma:mt2:d=384M:lc8:pb2:lp0:fb273:mc999 -m2=delta:4 -m3=lzma:mt2:d24:lc0:pb2:lp2:fb273 -m4=lzma:mt2:d24:lc0:pb2:lp2:fb273 -m5=lzma2:mt2:d24:lc0:pb0:lp0:fb273 -mb00s0:1 -mb00s1:2 -mb00s2:4 -mb00s3:5 -mb02s0:3 -r"
$processCmd  = "`"$($cmdPath)\$($cmdExe)`""

$processArgs = "$($cmdArgs) `"$($target)`" `"$($source)`""

# Check if 7z-File already exists
if ( Test-Path "$($target)" -PathType Leaf ) {
	$newName = "$($sourceDir.Name)_BAK_$(get-date -Format 'yyyy-MM-dd_HH-mm-ss-tt').7z"
	
	Rename-Item -Path "$($target)" -NewName $newName
	Write-Output ">>> Renamed existing file to `"$newName`" <<<"
}

# Start the command and 
# set the process with alternate priority,
# beware that you dont use the "-Wait" argument in "Start-Process"
#
# Realtime
# High
# AboveNormal
# Normal
# BelowNormal
# Low
$process = Start-Process -FilePath "$($processCmd)" -ArgumentList "$($processArgs)" -PassThru -NoNewWindow
$process.PriorityClass = [System.Diagnostics.ProcessPriorityClass]::High
Wait-Process -Id $Process.id -ErrorAction SilentlyContinue
