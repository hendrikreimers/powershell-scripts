# Robocopy PC Backup PowerShell Script

This project includes a PowerShell script designed for automated backup of user-defined directories using Robocopy, a robust file copy command-line tool included in Windows. The script leverages a configuration file to define source and destination paths for backup operations. Upon execution, it prompts for any necessary parameters not preset and initiates a backup process based on the settings defined in the `.ini` file.

When run, the script checks to ensure no other instances are running, then proceeds with the backup process, applying user-defined exclusions and maintaining directory structure integrity.

## Script Overview

- `Robocopy_PC_Backup.ps1`: Main script file that executes the backup process.
- `Robocopy_PC_Backup.ini`: Configuration file where users can specify source and destination paths for the backup operation.

## Requirements

- Windows operating system with PowerShell and Robocopy installed (available by default on Windows 7 and later versions).
- Administrative privileges might be required depending on the locations involved in the backup.

## Setup

1. Replace `YOUR_USERNAME` and `YOUR_TARGET_PATH` placeholders in the `Robocopy_PC_Backup.ini` file with your actual Windows username and desired backup paths.
2. Review and modify other backup path settings as needed, specifying different directories as desired.

## Usage

Execute the script from PowerShell:

    .\Robocopy_PC_Backup.ps1

Optionally, you can specify a different configuration file as an argument:

    .\Robocopy_PC_Backup.ps1 -configFile "C:\Path\To\Your\CustomConfig.ini"

## Features

Batch backup multiple directories.
Exclude specific subdirectories from being copied.
Control over copy operations' priority through the configuration file.

## Safety and Security

Ensure that the destination paths are secure and have appropriate access controls.
Verify that backups are completed successfully and test restoration processes periodically.
Consider encrypting sensitive data before backup if the destination is a shared or less secure location.

## Contributing

Feel free to fork this project and submit pull requests if you have suggestions for improvements or new features.
