# Windows PowerShell Context Menu Extension

This project provides a PowerShell script to add custom context menu options for opening PowerShell windows directly from the right-click menu in Windows. It facilitates quick access to PowerShell from any folder or desktop background.

## Script Overview

The script modifies Windows Registry to add new context menu items:

- **Powershell Console Here**: Opens a PowerShell console in the current directory.
- **Elevated Console**: Opens an elevated (administrator) PowerShell console in the current directory.

These options are added for both folder right-clicks and right-clicks on the desktop background.

## Requirements

- Windows operating system with PowerShell installed.
- Administrative privileges are required to run the script as it modifies the Windows Registry.

## Setup and Usage

1. Open a PowerShell window as Administrator.
2. Navigate to the directory containing the script.
3. Execute the script:

   ```powershell
   .\Add_Powershell_Context_Menu.ps1

Once executed, the script will add new context menu items. Right-click on any folder or the desktop background to see the new options.

## Safety and Security

Modifying the Windows Registry can have significant effects on your system. Only run scripts from trusted sources.
Ensure you understand what the script is doing before running it. Review the script code to ensure it's safe to use on your system.

## Customization

You can customize the script to change the names of the context menu items or to add additional functionality. Please ensure you have a good understanding of Windows Registry and PowerShell scripting before making any changes.
Uninstallation

The script also includes functionality to remove the added context menu items:

    Run the script again.
    When prompted, choose the uninstall option.

This will remove the added registry entries and revert the context menu to its original state.

## Contributing

If you have suggestions for improving the script or have developed additional features, feel free to fork the project and submit a pull request.
