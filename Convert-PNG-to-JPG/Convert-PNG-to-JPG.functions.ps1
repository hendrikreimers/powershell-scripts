#
# Show-FormDialog
#
# Shows a simple dialog for converting settings
#
function Show-FormDialog {
	Param (
		[Parameter(Mandatory=$false)] [AllowEmptyString()] [int]$defaultRatio = 100,
		[Parameter(Mandatory=$false)] [AllowEmptyString()] [int]$defaultQuality = 85,
		[Parameter(Mandatory=$false)] [AllowEmptyString()] [bool]$defaultDeleteOrig = $false,
		[Parameter(Mandatory=$false)] [AllowEmptyString()] [bool]$defaultInsteadJpg = $false,
		[Parameter(Mandatory=$false)] [AllowEmptyString()] [int]$selectSteps = 5
	)
	
	Add-Type -Assembly 'System.Windows.Forms'

	$form = New-Object Windows.Forms.Form
	$form.Text = 'Network Drive Credentials'
	$form.Size = New-Object System.Drawing.Size(285,225)
	$form.StartPosition = 'CenterScreen'
	$form.MaximizeBox = $false
	$form.MinimizeBox = $false
	$form.FormBorderStyle = 'FixedDialog'

	$label = New-Object System.Windows.Forms.Label
	$label.Location = New-Object System.Drawing.Point(5,5)
	$label.Size = New-Object System.Drawing.Size(260,20)
	$label.Text = 'Resize Ratio:'
	$form.Controls.Add($label)

	$ratioSelect = New-Object Windows.Forms.ComboBox 
	$ratioSelect.Items.AddRange((100..10).Where({$_ % $selectSteps -eq 0}))
	$ratioSelect.Top  = 25
	$ratioSelect.Left = 5
	$ratioSelect.selectedIndex = ((100 / $selectSteps) - ((100 / $selectSteps) / 100 * $defaultRatio))
	$ratioSelect.DropDownStyle = [System.Windows.Forms.ComboBoxStyle]::DropDownList;
	$ratioSelect.Size = New-Object System.Drawing.Size(260,20)
	$form.Controls.Add($ratioSelect)

	$label = New-Object System.Windows.Forms.Label
	$label.Location = New-Object System.Drawing.Point(5,50)
	$label.Size = New-Object System.Drawing.Size(260,20)
	$label.Text = 'Quality:'
	$form.Controls.Add($label)

	$qualitySelect = New-Object Windows.Forms.ComboBox 
	$qualitySelect.Items.AddRange((100..10).Where({$_ % $selectSteps -eq 0}))
	$qualitySelect.Top  = 70
	$qualitySelect.Left = 5
	$qualitySelect.selectedIndex = ((100 / $selectSteps) - ((100 / $selectSteps) / 100 * $defaultQuality))
	$qualitySelect.DropDownStyle = [System.Windows.Forms.ComboBoxStyle]::DropDownList;
	$qualitySelect.Size = New-Object System.Drawing.Size(260,20)
	$form.Controls.Add($qualitySelect)
	
	$deleteOrigCheckbox = New-Object Windows.Forms.Checkbox 
	$deleteOrigCheckbox.Text = 'Delete original PNG/JPG files?'
	$deleteOrigCheckbox.Top  = 100
	$deleteOrigCheckbox.Left = 5
	$deleteOrigCheckbox.Size = New-Object System.Drawing.Size(260,20)
	$deleteOrigCheckbox.Checked = $defaultDeleteOrig
	$form.Controls.Add($deleteOrigCheckbox)
	
	$insteadJpgCheckbox = New-Object Windows.Forms.Checkbox 
	$insteadJpgCheckbox.Text = 'Do it with JPGs as instead?'
	$insteadJpgCheckbox.Top  = 130
	$insteadJpgCheckbox.Left = 5
	$insteadJpgCheckbox.Size = New-Object System.Drawing.Size(260,20)
	$insteadJpgCheckbox.Checked = $defaultInsteadJpg
	$form.Controls.Add($insteadJpgCheckbox)

	$okButton = New-Object System.Windows.Forms.Button
	$okButton.Location = New-Object System.Drawing.Point(5,155)
	$okButton.Size = New-Object System.Drawing.Size(75,25)
	$okButton.Text = 'OK'
	$okButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
	$form.AcceptButton = $okButton
	$form.Controls.Add($okButton)

	$cancelButton = New-Object System.Windows.Forms.Button
	$cancelButton.Location = New-Object System.Drawing.Point(90,155)
	$cancelButton.Size = New-Object System.Drawing.Size(75,25)
	$cancelButton.Text = 'Cancel'
	$cancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
	$form.CancelButton = $cancelButton
	$form.Controls.Add($cancelButton)

	# Activate form window
	$form.Add_Shown({
		$form.Activate()
	})

	$dialogResult = $form.ShowDialog()
	
	if ( $dialogResult -eq [System.Windows.Forms.DialogResult]::OK ) {
		$result = Set-DialogResultObject $($ratioSelect.SelectedItem) $($qualitySelect.SelectedItem) $($deleteOrigCheckbox.Checked) $($insteadJpgCheckbox.Checked)
	} else {
		$result = $false
	}
		
	return $result
}

#
# Builds a simple object including dialog resulting data
#
# Usage:
# 	$cred = Set-DialogResultObject "username" "password"
#
function Set-DialogResultObject {
	Param (
		[Parameter(Mandatory=$true, Position=0)] [AllowEmptyString()] [int]$ratio,
		[Parameter(Mandatory=$true, Position=1)] [AllowEmptyString()] [int]$quality,
		[Parameter(Mandatory=$true, Position=2)] [AllowEmptyString()] [bool]$deleteOrig,
		[Parameter(Mandatory=$true, Position=3)] [AllowEmptyString()] [bool]$insteadJpg
	)
	
	$result = "" | Select-Object -Property ratio,quality,deleteOrig,insteadJpg
	$result.ratio      = $ratio
	$result.quality    = $quality
	$result.deleteOrig = $deleteOrig
	$result.insteadJpg = $insteadJpg
	
	return $result
}

#
# SetConsole-Visibility
#
# Show or hides the console
#
# Usage:
# 	Show-Console -hide
# 	Show-Console -show
#
function SetConsole-Visibility {
    Param (
		[Switch]$Show,
		[Switch]$Hide
	)
	
    if (-not ("Console.Window" -as [type])) {
        Add-Type -Name Window -Namespace Console -MemberDefinition '
			[DllImport("Kernel32.dll")]
			public static extern IntPtr GetConsoleWindow();

			[DllImport("user32.dll")]
			public static extern bool ShowWindow(IntPtr hWnd, Int32 nCmdShow);
        '
    }

    if ($Show) {
        $consolePtr = [Console.Window]::GetConsoleWindow()

        # Hide = 0,
        # ShowNormal = 1,
        # ShowMinimized = 2,
        # ShowMaximized = 3,
        # Maximize = 3,
        # ShowNormalNoActivate = 4,
        # Show = 5,
        # Minimize = 6,
        # ShowMinNoActivate = 7,
        # ShowNoActivate = 8,
        # Restore = 9,
        # ShowDefault = 10,
        # ForceMinimized = 11
		$showState = 1
		
        $null = [Console.Window]::ShowWindow($consolePtr, $showState)
    }

    if ($Hide) {
		#0 hide
		$showState = 0
		
        $consolePtr = [Console.Window]::GetConsoleWindow()
        $null = [Console.Window]::ShowWindow($consolePtr, $showState)
    }
}

#
# DeleteFile
#
# Deletes a file permantely or using recycle bin (Argument: -SafeDelete)
#
# Usage:
# 	DeleteFile -File "Path_to_file" -SafeDelete
#   DeleteFile -File "Path_to_file"
#
function DeleteFile {
	Param (
		[Parameter(Mandatory=$true)] [String]$File,
		[Switch]$SafeDelete
	)
	
	if ( $SafeDelete ) {
		Add-Type -AssemblyName Microsoft.VisualBasic
		[Microsoft.VisualBasic.FileIO.FileSystem]::DeleteFile($File, 'OnlyErrorDialogs', 'SendToRecycleBin')
	} else {
		Remove-Item $file
	}
}

#
# ConvertImage
#
# Converts a PNG or JPG to the given quality and resolution (scale)
#
# Usage:
#   Convert-Image -SourcePath $sourceDir -Settings $conversionSettings
#
function Convert-Image {
    Param (
        [Parameter(Mandatory=$true)] [String]$SourcePath,
        [Parameter(Mandatory=$true)] [Object]$Settings
    )
	
	Add-Type -AssemblyName system.drawing
	
	#Encoder parameter for image quality
	$imageEncoder = [System.Drawing.Imaging.Encoder]::Quality
	$imageEncoderParams = New-Object System.Drawing.Imaging.EncoderParameters(1)
	$imageEncoderParams.Param[0] = New-Object System.Drawing.Imaging.EncoderParameter($imageEncoder, $conversionSettings.quality)

	# get codec
	$imageCodecInfo = [System.Drawing.Imaging.ImageCodecInfo]::GetImageEncoders() | Where {$_.MimeType -eq 'image/jpeg'}

    # Determine the file filter based on the settings
	$fileFilter = "*.png"
    if ($Settings.insteadJpg) {
        $fileFilter = "*.jpg"
    }

	# Create new subfolder
	$newSubfolder = "Converted"
	$newFolderPath = Join-Path -Path $SourcePath -ChildPath $newSubfolder
    if (-not (Test-Path $newFolderPath)) {
        New-Item -ItemType Directory -Path $newFolderPath
    }

    Get-ChildItem $SourcePath -Filter $fileFilter -File | ForEach-Object {		
		$source  = $_.FullName
		$test    = [System.IO.Path]::GetDirectoryName($source)
		$base    = $_.BaseName + ".jpg"
		$basedir = Join-Path $test $base
		
		# Set target file path
		$targetFilePath = Join-Path $newFolderPath $base
		
		# Console output
		Write-Host "Konvertierung: $source -> $targetFilePath"
		
		# Load original image
		$image = [drawing.image]::FromFile($source)
		
		# Create a new image
		$newWidth  = [int] $([math]::Round( ($image.Width / 100) * $Settings.ratio ))
		$newHeight = [int] $([math]::Round( ($image.Height / 100) * $Settings.ratio ))		
		$newImage = [System.Drawing.Bitmap]::new($newWidth,$newHeight)

		# Add graphic based on the new image (makes on transparent PNGs the background white instead of black, and set the interpolation mode)
		$graphic = [System.Drawing.Graphics]::FromImage($newImage)
		$graphic.Clear([System.Drawing.Color]::White) # Set the color to white
		$graphic.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
		
		# Add the contents of $image
		$graphic.DrawImage($image, 0, 0, $newWidth, $newHeight)

		# Now save the $NewImage instead of $image
		$newImage.Save($targetFilePath, $imageCodecInfo, $imageEncoderParams)

		# Delete original PNG file
		if ( $Settings.deleteOrig -eq $true ) {
			$image.Dispose()
			DeleteFile -SafeDelete -File $source
		}
    }
	
	# Debug (wait for prompt to see errors)
	#Read-Host -Prompt "Drücken Sie Enter, um fortzufahren..."
}
