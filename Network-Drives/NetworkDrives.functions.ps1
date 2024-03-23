
#
# Show-PasswordDialog
#
# Shows a simple dialog for credentials (user/pass)
#
function Show-PasswordDialog {
	Param (
		[Parameter(Mandatory=$false)] [AllowEmptyString()] [string]$defaultUsername = '',
		[Parameter(Mandatory=$false)] [AllowEmptyString()] [string]$defaultPassword = ''
	)
	
	Add-Type -Assembly 'System.Windows.Forms'

	$form = New-Object Windows.Forms.Form
	$form.Text = 'Network Drive Credentials'
	$form.Size = New-Object System.Drawing.Size(285,165)
	$form.StartPosition = 'CenterScreen'
	$form.MaximizeBox = $false
	$form.MinimizeBox = $false
	$form.FormBorderStyle = 'FixedDialog'

	$label = New-Object System.Windows.Forms.Label
	$label.Location = New-Object System.Drawing.Point(5,5)
	$label.Size = New-Object System.Drawing.Size(260,20)
	$label.Text = 'Username:'
	$form.Controls.Add($label)

	$usernameBox = New-Object Windows.Forms.TextBox
	$usernameBox.Text = $defaultUsername
	$usernameBox.Top  = 25
	$usernameBox.Left = 5
	$usernameBox.Size = New-Object System.Drawing.Size(260,20)
	$form.Controls.Add($usernameBox)

	$label = New-Object System.Windows.Forms.Label
	$label.Location = New-Object System.Drawing.Point(5,50)
	$label.Size = New-Object System.Drawing.Size(260,20)
	$label.Text = 'Password:'
	$form.Controls.Add($label)

	$passwordBox = New-Object Windows.Forms.MaskedTextBox
	$passwordBox.PasswordChar = '*'
	$passwordBox.Text = $defaultPassword
	$passwordBox.Top  = 70
	$passwordBox.Left = 5
	$passwordBox.Size = New-Object System.Drawing.Size(260,20)
	$form.Controls.Add($passwordBox)

	$okButton = New-Object System.Windows.Forms.Button
	$okButton.Location = New-Object System.Drawing.Point(5,95)
	$okButton.Size = New-Object System.Drawing.Size(75,25)
	$okButton.Text = 'OK'
	$okButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
	$form.AcceptButton = $okButton
	$form.Controls.Add($okButton)

	$cancelButton = New-Object System.Windows.Forms.Button
	$cancelButton.Location = New-Object System.Drawing.Point(90,95)
	$cancelButton.Size = New-Object System.Drawing.Size(75,25)
	$cancelButton.Text = 'Cancel'
	$cancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
	$form.CancelButton = $cancelButton
	$form.Controls.Add($cancelButton)

	# Activate form window and set focus to field
	$form.Add_Shown({
		$form.Activate()
		
		if ( $defaultUsername -eq "" ) {
			$usernameBox.focus() # Alternate: if ( $usernameBox.CanFocus ) { $usernameBox.focus() } else { $usernameBox.select() }
		} elseif ( $defaultPassword -eq "" ) {
			$passwordBox.focus()
		} else {
			$okButton.focus()
		}
	})

	$dialogResult = $form.ShowDialog()
	
	if ( $dialogResult -eq [System.Windows.Forms.DialogResult]::OK ) {
		$result = Set-CredentialObject "$($usernameBox.Text)" "$($passwordBox.Text)"
	} else {
		$result = $false
	}
		
	return $result
}

#
# Builds a simple object including username and password strings
#
# Usage:
# 	$cred = Set-CredentialObject "username" "password"
#
function Set-CredentialObject {
	Param (
		[Parameter(Mandatory=$true, Position=0)] [AllowEmptyString()] [string]$user,
		[Parameter(Mandatory=$true, Position=1)] [AllowEmptyString()] [string]$pass
	)
	
	$result = "" | Select-Object -Property user,pass
	$result.user = $user
	$result.pass = $pass
	
	return $result
}

#
# Get-IniContent
#
# Reads a simple ini file as array (Src: https://techgenix.com/reading-an-ini-file-into-powershell/)
# 
function Get-IniContent($filePath) {
    $ini = @{}
    switch -regex -file $FilePath
    {
        "^\[(.+)\]" # Section
        {
            $section = $matches[1].Trim()
            $ini[$section] = @{}
            $CommentCount = 0
        }
        #"^(;.*)$" # Comment
        #{
        #    $value = $matches[1]
        #    $CommentCount = $CommentCount + 1
        #    $name = "Comment" + $CommentCount
        #    $ini[$section][$name.Trim()] = $value.Trim()
        #}
        #"(.+?)\s*=(.*)" # Key
		"^([^;\\n][a-zA-Z]+)([ ]{0,}=[ ]{0,})([^;]*)(;?.*)$" # Key (ignoring comments)
        {
            $name,$x,$value = $matches[1..3]
            $ini[$section][$name.Trim()] = $value.Trim('"'," ")
        }
    }
    return $ini
}

#
# DoExitWithMessage
#
# Shows a message and waits before ending the script
#
# Usage:
# 	DoExitWithMessage -Message "Host not available" -Timeout 5
# 	DoExitWithMessage "Host not available" 5
# 	DoExitWithMessage -Message "Host not available"
# 	DoExitWithMessage "Host not available"
#
function DoExitWithMessage {
	Param (
		[Parameter(Mandatory=$true)] [string]$Message,
		[Parameter(Mandatory=$false)] [int]$Timeout = 3
	)
	
	Write-Output ""
	Write-Output ">>> $($Message)..."
	Write-Output ""
	Write-Output "Script exiting in $($Timeout) seconds..."
	Start-Sleep -Seconds $Timeout
	Exit
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
# Check-AlreadyRunning
#
# Checks if the script is already running and 
# forces to only run one instance by exiting with a message
#
function Check-AlreadyRunning {
	$scriptName = $(GCI $MyInvocation.PSCommandPath | Select -Expand Name)
	
	# You may want to replace FullPathName
	# 	$MyInvocation.MyCommand.Path 
	# 
	# with Scriptname
	# 	$MyInvocation.MyCommand.Name 
	# 
	$otherScriptInstances=get-wmiobject win32_process | where{$_.processname -eq 'powershell.exe' -and $_.ProcessId -ne $pid -and $_.commandline -match $scriptName}
	
	if ($otherScriptInstances -ne $null) {
		DoExitWithMessage -Message "Script already running. Exiting"
	}
}

#
# Test-Host
#
# Tests a host or IP address whether it is reachable
#
# Usage:
# 	Test-Host -addr YOUR_HOSTNAME
# 	Test-Host YOUR_HOSTNAME
# 	Test-Host -addr YOUR_IP_ADDRESS
# 	Test-Host YOUR_IP_ADDRESS
#
function Test-Host {
	Param (
		[Parameter(Mandatory=$true, Position=0)]
		[string]
		$addr
	)
	
	return (Test-Connection -ComputerName $addr -Quiet -Count 1)
}