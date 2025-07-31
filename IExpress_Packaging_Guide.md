# IExpress Packaging Guide: Converting Onboarding.ps1 to EXE

## Table of Contents
1. [Introduction to IExpress](#introduction-to-iexpress)
2. [Prerequisites](#prerequisites)
3. [Step-by-Step Packaging Process](#step-by-step-packaging-process)
4. [Configuration Options and Best Practices](#configuration-options-and-best-practices)
5. [Troubleshooting Common Issues](#troubleshooting-common-issues)
6. [Advanced Considerations](#advanced-considerations)

## Introduction to IExpress

### What is IExpress?
IExpress is a built-in Windows utility that creates self-extracting executable files. It has been included with Windows since Windows 95 and provides a simple way to package files and scripts into a single executable.

### Why Use IExpress for PowerShell Scripts?
When packaging `Onboarding.ps1` as an EXE, IExpress offers several advantages:

- **Native Windows Tool**: No third-party software required
- **Self-Contained**: Creates a single executable that contains all necessary files
- **Execution Control**: Can automatically run the PowerShell script after extraction
- **Professional Distribution**: Provides a more professional appearance than distributing raw scripts
- **Bypass Execution Policy**: The wrapper can help circumvent PowerShell execution policy restrictions
- **User-Friendly**: End users don't need to know how to run PowerShell scripts

### Limitations to Consider
- **Size Overhead**: The resulting EXE will be larger than the original script
- **Antivirus Detection**: Some antivirus software may flag self-extracting executables
- **Limited Customization**: IExpress has basic customization options compared to commercial packaging tools
- **Windows Only**: Only works on Windows systems

## Prerequisites

### System Requirements
- Windows operating system (Windows 7 or later recommended)
- Administrative privileges (may be required for some operations)
- PowerShell installed (default on modern Windows)

### Required Files
Before starting, ensure you have:
1. `Onboarding.ps1` - Your PowerShell script
2. Any additional files or dependencies your script requires
3. Optional: Custom icon file (.ico format) for the executable

### Preparation Steps
1. **Test Your Script**: Ensure `Onboarding.ps1` works correctly when run manually
2. **Gather Dependencies**: Collect all files your script needs (modules, config files, etc.)
3. **Create Working Directory**: Set up a clean folder to work from (e.g., `C:\PackagingWork\`)
4. **Plan Execution Strategy**: Decide how the script should run (visible/hidden, parameters, etc.)

## Step-by-Step Packaging Process

### Step 1: Launch IExpress
1. Press `Win + R` to open the Run dialog
2. Type `iexpress` and press Enter
3. If prompted by User Account Control, click "Yes"

**Alternative method:**
- Open Command Prompt as Administrator
- Type `iexpress` and press Enter

### Step 2: Choose Package Type
1. The IExpress Wizard will open
2. Select "Create new Self Extraction Directive file"
3. Click "Next"

**Description**: This option creates a new package configuration that you can save and reuse later.

### Step 3: Select Extraction Purpose
1. Choose "Extract files and run an installation command"
2. Click "Next"

**Why this option**: This allows the package to automatically execute your PowerShell script after extraction.

### Step 4: Specify Package Title
1. Enter a descriptive title: "Onboarding Script Package"
2. This title will appear in dialog boxes during extraction
3. Click "Next"

### Step 5: Configure Confirmation Prompt
1. Choose "Prompt user with" if you want users to see a confirmation dialog
2. Enter a message like: "This will run the employee onboarding process. Continue?"
3. Alternatively, select "No prompt" for silent execution
4. Click "Next"

**Best Practice**: Include a prompt for transparency, especially in corporate environments.

### Step 6: License Agreement (Optional)
1. If you want to display a license or terms:
   - Select "Display a license"
   - Browse to your license text file
2. For most cases, select "Do not display a license"
3. Click "Next"

### Step 7: Add Files to Package
1. Click "Add" to add files to your package
2. **Required**: Add `Onboarding.ps1`
3. **Optional**: Add any additional files your script needs:
   - Configuration files
   - PowerShell modules
   - Data files
   - Icons or resources
4. Continue clicking "Add" for each file
5. When finished, click "Next"

**Important**: All files will be extracted to the same temporary directory when the EXE runs.

### Step 8: Configure Installation Program
This is the crucial step for PowerShell execution:

1. In "Install Program" field, enter one of these options:

   **Option A - Visible PowerShell Window:**
   ```
   powershell.exe -ExecutionPolicy Bypass -File "Onboarding.ps1"
   ```

   **Option B - Hidden PowerShell Window:**
   ```
   powershell.exe -WindowStyle Hidden -ExecutionPolicy Bypass -File "Onboarding.ps1"
   ```

   **Option C - With Parameters:**
   ```
   powershell.exe -ExecutionPolicy Bypass -File "Onboarding.ps1" -Parameter1 "Value1"
   ```

2. Leave "Post Install Command" empty (unless you need cleanup)
3. Click "Next"

**Security Note**: The `-ExecutionPolicy Bypass` parameter circumvents PowerShell's execution policy for this script only.

### Step 9: Configure Window Display
1. Choose how the extraction process appears:
   - **Default**: Standard extraction dialog
   - **Hidden**: No extraction window (recommended for professional deployment)
   - **Minimized**: Extraction window starts minimized
2. Click "Next"

### Step 10: Finished Message
1. Choose what happens after completion:
   - **No message**: Silent completion
   - **Display message**: Show custom completion message
2. If displaying a message, enter something like: "Onboarding process completed successfully."
3. Click "Next"

### Step 11: Package Name and Options
1. **Package Name**: Enter the full path for your EXE file
   - Example: `C:\PackagingWork\EmployeeOnboarding.exe`
2. **Options**:
   - ☑ **Store files using Long File Name inside Package**: Recommended (checked)
   - ☐ **Hide File Extracting Progress Animation from User**: Check for silent operation
3. Click "Next"

### Step 12: Configure Restart Options
1. Most PowerShell scripts don't require restart
2. Select "No restart"
3. Click "Next"

### Step 13: Save Self Extraction Directive (SED)
1. Choose "Save Self Extraction Directive (SED) file"
2. Specify location: `C:\PackagingWork\Onboarding.sed`
3. This allows you to rebuild the package later with modifications
4. Click "Next"

### Step 14: Create Package
1. Review all settings in the summary
2. Click "Next" to begin package creation
3. IExpress will create your executable file
4. When complete, click "Finish"

## Configuration Options and Best Practices

### PowerShell Execution Options

#### Execution Policy Handling
```powershell
# Most permissive (use with caution)
powershell.exe -ExecutionPolicy Bypass -File "Onboarding.ps1"

# More secure alternative
powershell.exe -ExecutionPolicy RemoteSigned -File "Onboarding.ps1"

# For signed scripts only
powershell.exe -ExecutionPolicy AllSigned -File "Onboarding.ps1"
```

#### Window Visibility Options
```powershell
# Visible window (good for debugging)
powershell.exe -ExecutionPolicy Bypass -File "Onboarding.ps1"

# Hidden window (professional deployment)
powershell.exe -WindowStyle Hidden -ExecutionPolicy Bypass -File "Onboarding.ps1"

# Minimized window (compromise)
powershell.exe -WindowStyle Minimized -ExecutionPolicy Bypass -File "Onboarding.ps1"
```

#### Advanced PowerShell Parameters
```powershell
# No profile loading (faster startup)
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "Onboarding.ps1"

# Non-interactive mode
powershell.exe -NonInteractive -ExecutionPolicy Bypass -File "Onboarding.ps1"

# Combination for production
powershell.exe -NoProfile -NonInteractive -WindowStyle Hidden -ExecutionPolicy Bypass -File "Onboarding.ps1"
```

### Best Practices for Professional Deployment

#### 1. File Organization
```
PackagingWork/
├── Source/
│   ├── Onboarding.ps1
│   ├── config.json
│   └── modules/
├── Build/
│   ├── Onboarding.sed
│   └── EmployeeOnboarding.exe
└── Documentation/
    └── deployment_notes.txt
```

#### 2. Version Control
- Include version information in the package title
- Maintain separate SED files for different versions
- Document changes between versions

#### 3. Security Considerations
- **Code Signing**: Consider signing your final EXE with a valid certificate
- **Antivirus Testing**: Test the package with your organization's antivirus software
- **Least Privilege**: Ensure the script doesn't require unnecessary elevated permissions

#### 4. Error Handling in PowerShell Script
Add robust error handling to your `Onboarding.ps1`:

```powershell
try {
    # Your onboarding logic here
    Write-Host "Starting onboarding process..."
    
    # Log success
    $logPath = "$env:TEMP\onboarding.log"
    "Onboarding completed successfully at $(Get-Date)" | Out-File -FilePath $logPath -Append
    
} catch {
    # Log errors
    $errorMsg = "Onboarding failed: $($_.Exception.Message)"
    $errorMsg | Out-File -FilePath "$env:TEMP\onboarding_error.log" -Append
    
    # Show user-friendly error
    [System.Windows.Forms.MessageBox]::Show($errorMsg, "Onboarding Error", "OK", "Error")
    exit 1
}
```

#### 5. User Experience Enhancements
- Provide clear progress indicators
- Include helpful error messages
- Consider creating a simple GUI with Windows Forms if appropriate

### Advanced Configuration Options

#### Custom Icons
1. Create or obtain a .ico file for your executable
2. Use a tool like Resource Hacker to add the icon after EXE creation
3. Or use commercial packaging tools for better icon support

#### Multiple File Dependencies
For complex scripts with many dependencies:
```powershell
# In your Install Program command
powershell.exe -ExecutionPolicy Bypass -Command "& { Set-Location '%TEMP%'; . '.\Onboarding.ps1' }"
```

#### Environment-Specific Builds
Create different SED files for different environments:
- `Onboarding-Dev.sed`
- `Onboarding-Test.sed` 
- `Onboarding-Prod.sed`

## Troubleshooting Common Issues

### Issue 1: "PowerShell is not recognized"
**Symptoms**: Error message stating PowerShell cannot be found

**Solutions**:
1. **Use full path to PowerShell**:
   ```
   C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -ExecutionPolicy Bypass -File "Onboarding.ps1"
   ```

2. **For PowerShell Core (7+)**:
   ```
   pwsh.exe -ExecutionPolicy Bypass -File "Onboarding.ps1"
   ```

3. **Environment variable issue**: Verify PATH includes PowerShell directory

### Issue 2: Execution Policy Errors
**Symptoms**: Script fails to run due to execution policy restrictions

**Solutions**:
1. **Most Effective**: Use `-ExecutionPolicy Bypass`
2. **Alternative**: Use `-ExecutionPolicy Unrestricted`
3. **For signed scripts**: Use `-ExecutionPolicy RemoteSigned`
4. **System-wide fix** (not recommended for distribution):
   ```powershell
   Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
   ```

### Issue 3: Script Runs but Fails Silently
**Symptoms**: EXE runs but script doesn't work as expected

**Debugging Steps**:
1. **Test with visible window first**:
   ```
   powershell.exe -ExecutionPolicy Bypass -File "Onboarding.ps1"
   ```

2. **Add logging to your script**:
   ```powershell
   Start-Transcript -Path "$env:TEMP\onboarding_log.txt"
   # Your script content
   Stop-Transcript
   ```

3. **Test script independently**: Run the PowerShell script outside of IExpress first

4. **Check working directory**: Scripts may fail if they expect to run from a specific location

### Issue 4: Antivirus Detection
**Symptoms**: Antivirus software blocks or quarantines the EXE

**Solutions**:
1. **Code Signing**: Sign the executable with a valid certificate
2. **Whitelist**: Add the EXE to antivirus exclusions
3. **Alternative Packaging**: Consider other packaging methods if this is persistent
4. **Submit for Analysis**: Submit false positives to antivirus vendors

### Issue 5: Files Not Found After Extraction
**Symptoms**: PowerShell script can't find dependent files

**Solutions**:
1. **Verify all files are included** in the IExpress package
2. **Use relative paths** in your PowerShell script
3. **Set working directory** in the Install Program command:
   ```
   cmd.exe /c "cd /d %TEMP% && powershell.exe -ExecutionPolicy Bypass -File Onboarding.ps1"
   ```

### Issue 6: Permission Errors
**Symptoms**: Script fails with access denied errors

**Solutions**:
1. **Run as Administrator**: Configure the EXE to request elevation
2. **Use RunAs**: Package with runas command if elevation is needed
3. **Modify script permissions**: Ensure script doesn't require unnecessary elevated access
4. **Temporary directory issues**: Use `$env:TEMP` for temporary files

### Issue 7: Long Path Issues
**Symptoms**: Files with long names fail to extract or run

**Solutions**:
1. **Enable Long File Name support** in IExpress (should be checked)
2. **Shorten file names** if possible
3. **Use PowerShell Core** which has better long path support

### Issue 8: Script Parameters Not Working
**Symptoms**: PowerShell script doesn't receive expected parameters

**Solutions**:
1. **Verify parameter syntax**:
   ```
   powershell.exe -ExecutionPolicy Bypass -File "Onboarding.ps1" -UserName "John" -Department "IT"
   ```

2. **Use proper quoting** for parameters with spaces:
   ```
   powershell.exe -ExecutionPolicy Bypass -File "Onboarding.ps1" -UserName "John Doe"
   ```

3. **Test parameter handling** in your PowerShell script:
   ```powershell
   param(
       [string]$UserName,
       [string]$Department
   )
   
   Write-Host "Received parameters: UserName=$UserName, Department=$Department"
   ```

### Diagnostic Commands for Troubleshooting

#### Test PowerShell Execution
```cmd
powershell.exe -ExecutionPolicy Bypass -Command "Write-Host 'PowerShell is working'"
```

#### Check Execution Policy
```powershell
Get-ExecutionPolicy -List
```

#### Verify File Extraction
Add temporary pause to see extracted files:
```
powershell.exe -ExecutionPolicy Bypass -Command "Get-ChildItem; Read-Host 'Press Enter to continue'; . '.\Onboarding.ps1'"
```

## Advanced Considerations

### Security Hardening
1. **Input Validation**: Ensure your PowerShell script validates all inputs
2. **Principle of Least Privilege**: Run with minimum required permissions
3. **Audit Logging**: Include comprehensive logging for security audits
4. **Network Security**: If script accesses network resources, use secure protocols

### Enterprise Deployment
1. **Group Policy**: Consider deploying via Group Policy for domain environments
2. **SCCM Integration**: Package can be deployed through System Center Configuration Manager
3. **Testing Matrix**: Test across different Windows versions and configurations
4. **Rollback Plan**: Prepare procedures for rolling back if issues occur

### Performance Optimization
1. **Startup Time**: Use `-NoProfile` to reduce PowerShell startup time
2. **Resource Usage**: Monitor memory and CPU usage during execution
3. **Network Dependencies**: Minimize network calls or implement retry logic
4. **Caching**: Cache frequently accessed data locally when possible

### Maintenance and Updates
1. **Version Tracking**: Implement version checking in your PowerShell script
2. **Auto-Update Capability**: Consider building update mechanisms into the script
3. **Configuration Management**: Externalize configuration to separate files
4. **Monitoring**: Implement success/failure reporting for deployed packages

---

## Summary

IExpress provides a simple, built-in solution for packaging PowerShell scripts as executable files. While it has limitations compared to commercial solutions, it's effective for many use cases, especially internal enterprise deployments.

**Key Success Factors**:
- Thorough testing of the PowerShell script before packaging
- Proper configuration of execution policies and parameters
- Comprehensive error handling and logging
- Testing across target environments
- Documentation of the packaging process for future updates

**When to Consider Alternatives**:
- Need for advanced customization or branding
- Complex installer requirements
- Cross-platform deployment needs
- Advanced security requirements

By following this guide, you should be able to successfully package your `Onboarding.ps1` script as a professional, distributable executable file.
