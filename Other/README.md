# PowerShell Helper Scripts

This project is a collection of small PowerShell scripts designed to perform various utility functions for Windows users. Each script addresses a specific task, providing a quick and automated way to manage certain system functions.

## Scripts Overview

1. `ClearClipboard.ps1`: Clears the text content from the Windows clipboard.
2. `ClearRecentDocuments.ps1`: Clears the list of recent documents in Microsoft Word and Excel.
3. `system-clean.ps1`: Runs the built-in Windows Disk Cleanup tool in automated mode.
4. `local-temp-del.ps1`: Deletes temporary files and directories and clears recent file history.

## Requirements

- Windows operating system with PowerShell.
- For `ClearRecentDocuments.ps1`, Microsoft Office (Word, Excel) must be installed.
- Administrative rights may be required depending on the script's function and user permissions.

## Usage

Each script can be run independently based on the task you wish to perform:

### Clear Clipboard

    .\ClearClipboard.ps1

This script checks if the clipboard contains text and clears it if so.

### Clear Recent Documents

    .\ClearRecentDocuments.ps1

This script clears the list of recent documents from Microsoft Word and Excel. Extend the $apps array to include other Office applications if needed.

### System Clean

    .\system-clean.ps1

This script initiates the Windows Disk Cleanup tool in automated mode, using the setup preferences. Before running this script for the first time, remember to configure your cleanup options. Execute `cleanmgr /sageset:1` in a PowerShell window with administrative rights. This command opens the Disk Cleanup settings where you can select the types of files you want to delete (you may choose all available options for a comprehensive cleanup). Once configured, the script uses these settings to clean your system with the command `cleanmgr /sagerun:1`. Ensure this setup step has been completed to utilize the script effectively.

### Local Temporary Files Deletion

    .\local-temp-del.ps1

This script removes temporary files from various system directories and clears the recent file history. It also calls the previously mentioned scripts for system cleaning, clipboard clearing, and recent document clearance to ensure comprehensive cleanup.

## Safety and Security

Please ensure that you understand the actions performed by each script before execution. While these scripts are generally safe, unintended effects can occur, especially when modifying system settings or cleaning up files.

## Customization

You can customize the scripts to add more applications or alter the existing functionalities to better suit your needs. Ensure you have a basic understanding of PowerShell scripting before making changes.

## Contributing

If you have any improvements or additional utility scripts that you believe would fit well in this collection, feel free to fork the project and submit a pull request.