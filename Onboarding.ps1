Add-Type -Assembly System.Windows.Forms
Add-Type -AssemblyName PresentationFramework
[System.Windows.Forms.Application]::EnableVisualStyles()
$iconBase64 = [Convert]::ToBase64String((Get-Content ".\Resources\OBLogo.ico" -Encoding Byte))
$iconBytes       = [Convert]::FromBase64String($iconBase64)
$stream1          = [System.IO.MemoryStream]::new($iconBytes, 0, $iconBytes.Length)


Function SamOnboarder {

# form setup
$main_form = New-Object System.Windows.Forms.Form
$main_form.Text ='Onboarding'
$main_form.Width = 540
$main_form.Height = 300
$main_form.Icon = [System.Drawing.Icon]::FromHandle(([System.Drawing.Bitmap]::new($stream1).GetHIcon()))
$main_form.StartPosition = 'CenterScreen'
$main_form.AutoSize = $true
$main_form.Topmost = $true

# creating variables

# computername
$cname = wmic bios get serialnumber
$cname = ($cname -join ".")
$cname = $cname.ToString()
$cname = $cname.trim(" ",".")
$cname = $cname.Substring($cname.length - 7, 7)
$serial = "Serial Number: " + $cname
$pcname = "Current Name: " + $env:computername


# administrator background
$btac = New-Object System.Windows.Forms.CheckBox
$btac.Location = New-Object System.Drawing.Point(20,18)
$btac.Size = new-object System.Drawing.Size(200,40)
$btac.Checked = $false
$btac.Text = "Would you like the Admin Background?"
$main_form.Controls.Add($btac)

# programs
$Label1 = New-Object System.Windows.Forms.Label
$Label1.Text = "Select Programs to install:"
$Label1.Location  = New-Object System.Drawing.Point(18,60)
$Label1.AutoSize = $true
$main_form.Controls.Add($Label1)

# Chrome
$chrome = New-Object System.Windows.Forms.CheckBox
$chrome.Location = New-Object System.Drawing.Point(20,78)
$chrome.AutoSize = $true
$chrome.Checked = $false
$chrome.Text = "Google Chrome"
$main_form.Controls.Add($chrome)

# Adobe
$adobe = New-Object System.Windows.Forms.CheckBox
$adobe.Location = New-Object System.Drawing.Point(20,96)
$adobe.AutoSize = $true
$adobe.Checked = $false
$adobe.Text = "Adobe Reader"
$main_form.Controls.Add($adobe)

# 7-Zip
$7zip = New-Object System.Windows.Forms.CheckBox
$7zip.Location = New-Object System.Drawing.Point(20,114)
$7zip.AutoSize = $true
$7zip.Checked = $false
$7zip.Text = "7-Zip Archiver"
$main_form.Controls.Add($7zip)

# Other Programs Checkbox
$otherprog = New-Object System.Windows.Forms.CheckBox
$otherprog.Location = New-Object System.Drawing.Point(20,132)
$otherprog.AutoSize = $true
$otherprog.Checked = $false
$otherprog.Text = "Other:"
$main_form.Controls.Add($otherprog)

# Other Progs Label
$Label2 = New-Object System.Windows.Forms.Label
$Label2.Text = "Enter other programs, seperated by commas"
$Label2.Location  = New-Object System.Drawing.Point(18,162)
$Label2.AutoSize = $true
$main_form.Controls.Add($Label2)

# Textbox for other programs
$otherlist = New-Object System.Windows.Forms.Textbox
$otherlist.Location  = New-Object System.Drawing.Point(18,180)
$otherlist.AutoSize = $true
$main_form.Controls.Add($otherlist)




# RENAMING PROMPTS

# Serial Label
$Lserial = New-Object System.Windows.Forms.Label
$Lserial.Text = $serial
$Lserial.Location  = New-Object System.Drawing.Point(280,22)
$Lserial.AutoSize = $true
$main_form.Controls.Add($Lserial)

# PC Name Label
$Lpcname = New-Object System.Windows.Forms.Label
$Lpcname.Text = $pcname
$Lpcname.Location  = New-Object System.Drawing.Point(280,40)
$Lpcname.AutoSize = $true
$main_form.Controls.Add($Lpcname)

# Keep same name checkbox
$keepname = New-Object System.Windows.Forms.CheckBox
$keepname.Location = New-Object System.Drawing.Point(293,63)
$keepname.AutoSize = $true
$keepname.Checked = $false
$keepname.Text = "Keep the Current PC Name"
$main_form.Controls.Add($keepname)

# Instructions
$renameinstr = New-Object System.Windows.Forms.Label
$renameinstr.Text = "For renaming, fill in one of the options below"
$renameinstr.Location = New-Object System.Drawing.Point(280,90)
$renameinstr.AutoSize = $true
$main_form.Controls.Add($renameinstr)

# Quick Label
$quickl = New-Object System.Windows.Forms.Label
$quickl.Text = "Quick Rename: "
$quickl.Location = New-Object System.Drawing.Point(280,113)
$quickl.AutoSize = $true
$main_form.Controls.Add($quickl)

# Quick Rename Prefix Textbox
$renamepre = New-Object System.Windows.Forms.Textbox
$renamepre.Location  = New-Object System.Drawing.Point(380,110)
$renamepre.AutoSize = $true
$renamepre.Size = new-object System.Drawing.Size(35,20)
$main_form.Controls.Add($renamepre)

# Quick Rename Serial Included
$renamepost = New-Object System.Windows.Forms.Label
$renamepost.Text = "- $cname"
$renamepost.Location = New-Object System.Drawing.Point(415,113)
$renamepost.AutoSize = $true
$main_form.Controls.Add($renamepost)

# Long Rename Prefix
$longr = New-Object System.Windows.Forms.Label
$longr.Text = "Full Rename: "
$longr.Location = New-Object System.Drawing.Point(280,135)
$longr.AutoSize = $true
$main_form.Controls.Add($longr)
 
# Long Rename Textbox
$rename = New-Object System.Windows.Forms.Textbox
$rename.Location  = New-Object System.Drawing.Point(380,132)
$rename.AutoSize = $true
$main_form.Controls.Add($rename)



# restart checkbox
$restartpc = New-Object System.Windows.Forms.Checkbox
$restartpc.Location = New-Object System.Drawing.Point(280,180)
$restartpc.AutoSize = $true
$restartpc.Checked = $false
$restartpc.Text = "Would you like to restart the computer?"
$main_form.Controls.Add($restartpc)



# OK/Cancel buttons

$cancelButton = New-Object System.Windows.Forms.Button
$cancelButton.Location = New-Object System.Drawing.Point(340,220)
$cancelButton.Size = New-Object System.Drawing.Size(75,23)
$cancelButton.Text = 'Cancel'
$cancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
$main_form.CancelButton = $cancelButton
$main_form.Controls.Add($cancelButton)


$runButton = New-Object System.Windows.Forms.Button
$runButton.Location = New-Object System.Drawing.Point(420,220)
$runButton.Size = New-Object System.Drawing.Size(75,23)
$runButton.Text = 'Run'
$runButton.Add_Click({OnButtonClick})
$main_form.Controls.Add($runButton)


# show the form
$result = $main_form.ShowDialog()


clear



SamResults

}


# Renaming Function (This also does some of the form results interpreting.)
# The length limiting is to avoid having to deal with the .NET limit of 15 characters for a computer's Hostname
function OnButtonClick {
    if ($keepname.Checked) {
        CloseGUI
    }
    else{ # changing the variables to strings, then evaluating and changing the name, after some error checking.
    $rename = $rename.Text
    $renamepre = $renamepre.Text
        if ($renamepre.Length -eq 0) {
            if ($rename.Length -eq 0) {
                [void] [System.Windows.MessageBox]::Show( "PC Name cannot be blank", "Renaming", "OK", "Warning" )
            }
            elseif ($rename.length -gt 15) {
                [void] [System.Windows.MessageBox]::Show( "PC Name cannot be longer than 15 characters", "Renaming", "OK", "Warning" )
            }
            else {
                Rename-Computer -NewName $rename
                # Uncomment the next line if you would like a notification of the renaming
                #[void] [System.Windows.MessageBox]::Show( "Success!!`nPC Name would be: $qrename", "PC Renaming", "OK", "Information" )
                CloseGUI
            }
        }
        elseif ($rename.Length -ne 0) {
            [void] [System.Windows.MessageBox]::Show( "Must only fill in one rename option", "Renaming", "OK", "Warning" )
        }
        elseif ($renamepre.Length -gt 7) {
            [void] [System.Windows.MessageBox]::Show( "PC Prefix cannot be longer than 7 characters", "Renaming", "OK", "Warning" )
        }    
        else {
            $renamepre = $renamepre.ToUpper()
            $qrename = $renamepre + "-" + $cname
            Rename-Computer -NewName $qrename
            # Uncomment the next line if you would like a notification of the renaming
            #[void] [System.Windows.MessageBox]::Show( "Success!!`nPC Name would be: $qrename", "PC Renaming", "OK", "Information" )
            CloseGUI
        }    
    }
}

function CloseGUI {
    $topform = $this.Parent
    $topForm.DialogResult = [System.Windows.Forms.DialogResult]::OK
    $topForm.Close()
    }

function SamResults {


# code results
if ($result -eq [System.Windows.Forms.DialogResult]::OK) {
    
    # install choco
    Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
    
    # background change
    if ($btac.Checked) {

Copy-Item .\Background1.jpg C:\Windows\
$imgPath="C:\Windows\Background1.jpg"

# create the Namespace and Class to allow changing the wallpaper instantly
$code = @' 
using System.Runtime.InteropServices; 
namespace Win32{ 
    
     public class Wallpaper{ 
        [DllImport("user32.dll", CharSet=CharSet.Auto)] 
         static extern int SystemParametersInfo (int uAction , int uParam , string lpvParam , int fuWinIni) ; 
         
         public static void SetWallpaper(string thePath){ 
            SystemParametersInfo(20,0,thePath,3); 
         }
    }
 } 
'@

add-type $code 

# Apply the Change on the system 
[Win32.Wallpaper]::SetWallpaper($imgPath)

}

# Application installs
if ($adobe.Checked) {
choco install adobereader -y
} 
if ($chrome.Checked) {
choco install googlechrome -y
} 
if ($7zip.Checked) {
choco install 7zip -y
} 
if ($teams.Checked) {
choco install microsoft-teams -y
} 

# other application installs
if ($otherprog.Checked) {
    #other Program installs
    $otherlist = $otherlist.text
    $otherobj = $otherlist.split(",")

	ForEach ($item in $otherobj) {
		choco install $item.trim() -y
        }

    }

# Restarting?
if ($restartpc.Checked) {
    Add-Type -AssemblyName PresentationFramework
    [void] [System.Windows.MessageBox]::Show( "All changes have been implemented successfully, the computer will now restart.", "Onboarding Complete", "OK", "Warning" )
    Start-sleep -s 1
    Restart-Computer
    }

if (-not($restartpc.Checked)) {
    Add-Type -AssemblyName PresentationFramework
    [void] [System.Windows.MessageBox]::Show( "All changes have now been implemented successfully.`n`nIf the computer was renamed, it will need to restart for `nchanges to take effect.", "Onboarding Complete", "OK", "Information" )
    }

}

}

SamOnboarder
