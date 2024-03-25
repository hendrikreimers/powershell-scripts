Param(
    [Parameter(Mandatory=$True)]
    [string]$PathArg
)

$Types = "*.xlsx", "*.xls"

if ( (Get-Item $PathArg) -is [System.IO.DirectoryInfo] ) {
    $FilePath = "$($PathArg)\*"
} else {
    $FilePath = "$PathArg"
}

$Files = Get-ChildItem -path "$FilePath" -include $Types -File

$Excel = New-Object -ComObject Excel.Application

$pause = $false
Foreach ($File in $Files) {
    Write-Output "Converting $($File) ..."
    # open an Excel workbook, filename from the directory
    $Workbook = $Excel.Workbooks.Open($File.FullName)
    
    # Swap out XLSX with PDF in the Filename
    $Name = $Workbook.FullName.substring(0,$Workbook.FullName.lastindexOf("."))
    
    # Check if target file already exists and rename it eventually
    if ( Test-Path "$($Name).pdf" -PathType Leaf ) {
        $newName = "$($Name)_BAK_$(get-date -Format 'yyyy-MM-dd_HH-mm-ss-tt').pdf"
        
        Rename-Item -Path "$($Name).pdf" -NewName $newName
        Write-Output ">>> Renamed existing file to `"$newName`" <<<"
        $pause = $true
    }
 
    # Save this File as a PDF
    $Workbook.ExportAsFixedFormat(0, $Name)
    $Workbook.Close($false)
}

$Excel.Quit()
[System.Runtime.InteropServices.Marshal]::ReleaseComObject($Excel) | Out-Null
Remove-Variable Excel

if ( $pause -eq $true ) {
    pause
}
