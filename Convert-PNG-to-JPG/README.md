# Convert Images PowerShell Script

This project contains a PowerShell script designed to convert PNG and JPG images to optimized JPG format. It offers batch conversion capabilities within a directory, allowing users to adjust the image quality and size, including the option to convert existing JPGs to a new quality level and resolution.

## Script Overview

- `Convert-PNG-to-JPG.ps1`: The main script that users run to convert images.
- `Convert-PNG-to-JPG.functions.ps1`: Contains the necessary functions used by the main script, including image conversion, file deletion, and dialog handling.

## Requirements

- Windows OS with PowerShell.
- Administrative privileges for registry changes and script execution.
- Understanding of the implications of converting and potentially deleting original image files.

## Setup

1. Replace `C:\Users\YOUR_USERNAME\PowerShellScripts\` with your scripts directory path.
2. Make sure you are aware that the script can modify Windows registry settings and might require administrative privileges.

## Usage

Right-click on the folder containing PNG images and select "Convert PNG to JPG" from the context menu. Follow the dialog prompts to set conversion preferences. You can control the resize ratio, quality, and whether to delete the original PNG files.

## Safety and Security

- Back up your images and registry before running the script.
- Be cautious of the deletion option for original images. Ensure you have copies of your images before converting.
- Review the script to understand the registry changes it makes. Be aware that running scripts with administrative privileges can impact your system settings and data.

## Contributing

Contributions to improve the script or add new features are welcome. Please submit pull requests with your proposed changes.

