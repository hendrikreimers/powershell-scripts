$apps = @(
	"Word"
	"Excel"
)

foreach ( $appName in $apps.GetEnumerator() ) {
	Write-Output "Clearing Recent Files of `"$($appName)`" ..."
	$appObject = "$($appName).Application"
	
	$app = New-Object -ComObject $appObject
	
	$recentFiles = $app.RecentFiles
	$count = $recentFiles.Count
	
	for($i = $count; $i -gt 0; $i--){
		$recentFiles.Item($i).Delete()
	}
	
	$app.Quit()
}
