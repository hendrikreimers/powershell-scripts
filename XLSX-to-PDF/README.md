# Xlsx to PDF PowerShell Script

This project contains a PowerShell script designed to convert Microsoft Excel sheets (.xlsx and .xls) to PDF format. It integrates into the Windows context menu for easy access and batch conversion capabilities.

## Script Overview

- `_ExcelxToPdf-ContextMenu.ps1`: Installs the necessary registry entries to add the script to the Windows context menu.
- `ExcelToPdf.ps1`: The main script that performs the conversion from XLSX or XLS to PDF.

## Requirements

- Windows OS with PowerShell.
- Administrative privileges for registry changes and script execution.
- Microsoft Excel installed on the system, as this script utilizes Excel's capabilities for sheets conversion.

## Setup

1. Replace `C:\Users\YOUR_USERNAME\PowerShellScripts\` with your scripts directory path.
2. Ensure you understand the script will modify Windows registry settings and requires administrative privileges to run.

## Usage

After running the `_ExcelToPdf-ContextMenu.ps1` script:

- Right-click on a folder with Excel sheets and select "Convert .xls(x) to PDF" from the context menu.
- Alternatively, right-click on an individual .xlsx or .xls file and choose "Convert to PDF" to convert a single sheet.

## Safety and Security

- Before running the script, back up your registry and sheets.
- Understand that converting and renaming files may overwrite existing sheets. Ensure you have backup copies.
- Review and confirm all script actions, particularly those modifying the registry and converting files.

## Contributing

Contributions to extend functionality or improve the script are welcome. Please submit pull requests with your changes or enhancements.

