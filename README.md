# Powershell Onboarder

## Overview
Powershell Onboarder is a script designed to facilitate the setup and configuration of new Windows computers. The tool provides an interactive user interface to install essential software, manage computer naming conventions, and apply custom settings using PowerShell.

## Detailed Description
The Powershell Onboarder aims to simplify the onboarding process by automating common setup tasks. It allows users to select and install programs like Google Chrome, Adobe Reader, and 7-Zip via checkboxes. It also provides options to rename the computer with predefined prefixes and include the computer's serial number.

The script can change the desktop background to a selected image and prompts the user to restart the computer to apply changes. It's built using Windows Forms for user interaction, making it intuitive and user-friendly.

## Key Features and Benefits
- **Interactive User Interface**: Built using Windows Forms, the script provides a simple and engaging way to configure new machines.
- **Automated Software Installation**: Install common applications easily via checkboxes and the use of Chocolatey package manager.
- **Customizable Computer Naming**: Rename the computer using a defined prefix and the serial number, ensuring compliance with organizational naming conventions.
- **Background Customization**: Instantly change the desktop background using a user-provided image.
- **Restart Prompt**: Automatically prompt for a system restart to apply all changes effectively.

## System Requirements and Prerequisites
- **Operating System**: Windows
- **Dependencies**: 
  - PowerShell
  - Chocolatey (for software installation)
- **Hardware**: A network connection is required for downloading applications.

## Usage Examples

### Basic Usage with Default Parameters

The simplest way to run the Powershell Onboarder is to execute the script directly:

```powershell
.\Onboarding.ps1
```

**Expected Output:**
- A Windows Forms GUI will appear with checkboxes for software installation
- Current computer name and serial number will be displayed
- Options for renaming the computer will be available

### Advanced Usage with Custom Options

#### Example 1: Installing Multiple Applications
1. Run the script: `.\Onboarding.ps1`
2. In the GUI, check the boxes for desired applications:
   - ✅ Google Chrome
   - ✅ Adobe Reader
   - ✅ 7-Zip Archiver
3. Click "Run" to install all selected applications

**Expected Output:**
```
Chocolatey will install:
- googlechrome
- adobereader
- 7zip
```

#### Example 2: Computer Renaming with Prefix
1. Run the script and locate the renaming section
2. Enter a prefix in the "Quick Rename" field (e.g., "WS")
3. The system will automatically append the serial number

**Result:** Computer will be renamed to `WS-ABC1234` (where ABC1234 is the last 7 characters of the serial number)

#### Example 3: Full Custom Computer Name
1. In the "Full Rename" field, enter the complete desired name: `OFFICE-LAPTOP-01`
2. Ensure the name is 15 characters or less
3. Click "Run" to apply changes

**Expected Output:** Computer will be renamed to `OFFICE-LAPTOP-01`

### Common Use Cases and Workflows

#### Workflow 1: New Employee Workstation Setup
```powershell
# Run the onboarding script
.\Onboarding.ps1

# Typical selections for a new employee:
# ✅ Google Chrome (web browsing)
# ✅ Adobe Reader (document viewing)
# ✅ 7-Zip Archiver (file compression)
# ✅ Admin Background (corporate branding)
# Quick Rename: "EMP" (results in EMP-ABC1234)
# ✅ Restart computer
```

**Expected Results:**
- All selected software installed via Chocolatey
- Desktop background changed to corporate image
- Computer renamed with employee prefix
- System restart scheduled

#### Workflow 2: Installing Additional Software
```powershell
# For custom applications not in the preset list:
# 1. Check "Other:" checkbox
# 2. Enter comma-separated package names in the text field
```

**Example Input:**
```
notepadplusplus, vlc, git
```

**Expected Output:**
```
choco install notepadplusplus -y
choco install vlc -y
choco install git -y
```

#### Workflow 3: Configuration Only (No Software Installation)
```powershell
# Run script for naming and background changes only:
# 1. Leave all software checkboxes unchecked
# 2. ✅ Admin Background
# 3. Set computer name as needed
# 4. ✅ Restart computer
```

**Expected Results:**
- Desktop background updated
- Computer renamed
- No software installations
- System restart

### Expected Output and Results

#### Successful Execution Messages

**During Execution:**
```
Chocolatey installation starting...
Installing googlechrome...
Installing adobereader...
Renaming computer to: WS-ABC1234
```

**Completion Message (with restart):**
```
"All changes have been implemented successfully, the computer will now restart."
```

**Completion Message (without restart):**
```
"All changes have now been implemented successfully.

If the computer was renamed, it will need to restart for 
changes to take effect."
```

#### Error Handling Examples

**Blank Computer Name:**
```
"PC Name cannot be blank"
```

**Name Too Long:**
```
"PC Name cannot be longer than 15 characters"
```

**Conflicting Rename Options:**
```
"Must only fill in one rename option"
```

**Prefix Too Long:**
```
"PC Prefix cannot be longer than 7 characters"
```

### PowerShell Execution Policy Requirements

Before running the script, ensure proper execution policy:

```powershell
# Check current execution policy
Get-ExecutionPolicy

# If needed, set execution policy (run as Administrator)
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser

# Then run the onboarding script
.\Onboarding.ps1
```

### File Dependencies

Ensure these files are in the same directory as `Onboarding.ps1`:
- `Resources\OBLogo.ico` - Application icon
- `Background1.jpg` - Corporate background image (if using admin background option)

### Network Requirements

The script requires internet connectivity for:
- Chocolatey package manager installation
- Software package downloads
- Package repository access

**Firewall Considerations:**
- Allow PowerShell.exe outbound connections
- Allow access to chocolatey.org and associated CDNs
- Ensure Windows Update services are accessible

## Installation Instructions

To install Powershell Onboarder, follow these steps:

1. **Clone the Repository:**

   ```sh
   git clone <repository-url>
   ```

2. **Navigate to the Directory:**

   ```sh
   cd Powershell-Onboarder
   ```

3. **Ensure all dependencies are in place:**

   Ensure the following files are present:
   - `Resources\OBLogo.ico`
   - `Background1.jpg`

4. **Check PowerShell Execution Policy:**

   Ensure it is set appropriately:

   ```powershell
   Get-ExecutionPolicy
   ```

   If needed:

   ```powershell
   Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
   ```

5. **Run the Script:**

   Execute the onboarding script:
   
   ```powershell
   .\Onboarding.ps1
   ```

## Configuration Options

The script provides configuration options through an interactive user interface:

- **Software Installation:** Choose applications to install via checkboxes.
- **Computer Naming:** Options to rename computers using prefixes and serial numbers.
- **Background Customization:** Change the desktop background to a corporate image.
- **Restart Prompt:** Optionally restart the system to apply changes.

## Contributing Guidelines

We welcome contributions from the community. Please follow these steps to contribute:

1. Fork the repository.
2. Create a new feature branch.
3. Commit your changes and ensure they are well-documented.
4. Create a pull request with a detailed explanation of changes.

## License Information

Powershell Onboarder is licensed under the MIT License. For more details, please refer to the `LICENSE` file in the repository.

## Contact/Support Information

For support or additional information, please contact:

- **Email:** support@example.com
- **GitHub Issues:** Open an issue in the repository for bug reports or feature requests.
