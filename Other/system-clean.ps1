$CleanMgrArgs = "/sagerun:65535"
Start-Process -FilePath "cleanmgr.exe" -ArgumentList $CleanMgrArgs -Wait
