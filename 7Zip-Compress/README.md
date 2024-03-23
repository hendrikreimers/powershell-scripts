# 7-Zip PowerShell Scripts

This project contains a set of PowerShell scripts designed to compress directories using 7-Zip. It includes scripts for compressing individual directories, subdirectories, and adding context menu options for these functions in Windows.

## Scripts Overview

- `7Zip-Compress-All.ps1`: Compresses multiple subfolders into separate zip files.
- `7Zip-Subfolders.ps1`: Compresses subfolders individually in the location specified.
- `_7Zip-CompressAll-ContextMenus.ps1`: Adds context menu options to compress all folders in a directory.
- `_7Zip-Subfolders-ContextMenu.ps1`: Adds context menu options to compress subfolders within a directory.

## Requirements

- Windows OS with PowerShell.
- [7-Zip](https://www.7-zip.org/download.html) installed (the scripts expect it to be installed in `C:\Program Files\7-Zip`).

## Setup

1. Replace `C:\Users\YOUR_USERNAME\PowerShellScripts` with your scripts directory path.
2. Ensure you have administrative privileges as some scripts modify Windows registry settings.
3. Review each script to understand the operations performed, especially registry modifications.

## Usage

- To compress all subfolders in a directory: `.\7Zip-Compress-All.ps1 [source directory]`
- To add right-click context menu options, run the context menu scripts as an administrator.

## Safety and Security

- Back up your registry before running scripts that modify it.
- Understand that these scripts run with high privileges and can affect your system settings.
- Confirm that the path to 7-Zip is correct and points to a legitimate installation.

## Contributing

Feel free to fork this project and submit pull requests for additional functionalities or improvements.

