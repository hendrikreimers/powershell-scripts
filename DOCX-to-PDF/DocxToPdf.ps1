Param(
    [Parameter(Mandatory=$True)]
    [string]$PathArg
)

$Types = "*.docx","*.doc"

if ( (Get-Item $PathArg) -is [System.IO.DirectoryInfo] ) {
	$FilePath = "$($PathArg)\*"
} else {
	$FilePath = "$PathArg"
}

$Files = Get-ChildItem -path "$FilePath" -include $Types -File

$Word = New-Object -ComObject Word.Application
 
$pause = $false
Foreach ($File in $Files) {
	Write-Output "Converting $($File) ..."
    # open a Word document, filename from the directory
    $Doc = $Word.Documents.Open($File.FullName)
	
    # Swap out DOCX with PDF in the Filename
    #$Name=($Doc.FullName).Replace("docx","pdf")
    $Name=($Doc.FullName).substring(0,($Doc.FullName).lastindexOf("."))
	
	# Check if target file already exists and rename it eventually
	if ( Test-Path "$($Name).pdf" -PathType Leaf ) {
		$newName = "$($Name)_BAK_$(get-date -Format 'yyyy-MM-dd_HH-mm-ss-tt').pdf"
		
		Rename-Item -Path "$($Name).pdf" -NewName $newName
		Write-Output ">>> Renamed existing file to `"$newName`" <<<"
		$pause = $true
	}
 
    # Save this File as a PDF ([ref] 17) in Word 2010/2013
    $Doc.SaveAs([ref] $Name, [ref] 17)
    $Doc.Close()
}

if ( $pause -eq $true ) {
	pause
}