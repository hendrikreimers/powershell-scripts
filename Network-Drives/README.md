# Network Drives PowerShell Script

This project consists of a PowerShell script designed to map network drives based on a configuration file. The script supports multiple network drives and uses a customizable INI file for settings. When executed, it displays a dialog box prompting the user for a username and password, which are then used to connect to the specified network shares. This functionality is particularly useful for automating the setup of network drives on multiple systems or for users who frequently connect to different network resources.

## Script Overview

- `NetworkDrives.ps1`: The main script that maps network drives based on the settings specified in the INI configuration file.
- `NetworkDrives.functions.ps1`: Contains the functions used by the main script, such as dialog display and network testing.
- `NetworkDrives.ini`: A configuration file where users can specify network drive settings like paths, usernames, and passwords.

## Requirements

- Windows OS with PowerShell.
- Proper network permissions to access and map the specified drives.
- Administrative privileges might be required for mapping network drives and executing the script.

## Setup

1. Fill in your network details in the `NetworkDrives.ini` file, replacing placeholders like `YOUR_USERNAME` and `192.168.64.10` with your actual network credentials and IP address.
2. Ensure your user account has the necessary permissions to access the network resources defined in the configuration file.

## Usage

Run the `NetworkDrives.ps1` script to map the network drives as specified in your INI file. The script will prompt for credentials if not fully specified in the configuration file.

## Safety and Security

- Avoid storing sensitive information, such as passwords, in plain text within the INI file.
- Ensure that the network paths and credentials provided are secure and that you have permissions to access them.
- Be aware that the script will temporarily hide the console window during execution; this is normal behavior.

## Contributing

Feel free to contribute to this project by suggesting improvements or adding new features. Submit pull requests with your proposed changes or enhancements.

