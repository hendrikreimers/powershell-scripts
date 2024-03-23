# Docx to PDF PowerShell Script

This project contains a PowerShell script designed to convert Microsoft Word documents (.docx and .doc) to PDF format. It integrates into the Windows context menu for easy access and batch conversion capabilities.

## Script Overview

- `_DocxToPdf-ContextMenu.ps1`: Installs the necessary registry entries to add the script to the Windows context menu.
- `DocxToPdf.ps1`: The main script that performs the conversion from DOCX or DOC to PDF.

## Requirements

- Windows OS with PowerShell.
- Administrative privileges for registry changes and script execution.
- Microsoft Word installed on the system, as this script utilizes Word's capabilities for document conversion.

## Setup

1. Replace `C:\Users\YOUR_USERNAME\PowerShellScripts\` with your scripts directory path.
2. Ensure you understand the script will modify Windows registry settings and requires administrative privileges to run.

## Usage

After running the `_DocxToPdf-ContextMenu.ps1` script:

- Right-click on a folder with Word documents and select "Convert .doc(x) to PDF" from the context menu.
- Alternatively, right-click on an individual .docx or .doc file and choose "Convert to PDF" to convert a single document.

## Safety and Security

- Before running the script, back up your registry and documents.
- Understand that converting and renaming files may overwrite existing documents. Ensure you have backup copies.
- Review and confirm all script actions, particularly those modifying the registry and converting files.

## Contributing

Contributions to extend functionality or improve the script are welcome. Please submit pull requests with your changes or enhancements.

