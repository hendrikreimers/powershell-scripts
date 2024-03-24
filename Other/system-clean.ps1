# Don't forget to set your sagerun by calling: cleanmgr /sageset:1
# ...then choose your options (maybe all), and then /sagerun:1 will do it
$CleanMgrArgs = "/sagerun:1"
Start-Process -FilePath "cleanmgr.exe" -ArgumentList $CleanMgrArgs -Wait
