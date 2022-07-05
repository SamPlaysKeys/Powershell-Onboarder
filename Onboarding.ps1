Add-Type -Assembly System.Windows.Forms
Add-Type -AssemblyName PresentationFramework
[System.Windows.Forms.Application]::EnableVisualStyles()
$iconBase64 = [Convert]::ToBase64String((Get-Content ".\Resources\OBLogo.ico" -Encoding Byte))
$iconBytes       = [Convert]::FromBase64String($iconBase64)
$stream1          = [System.IO.MemoryStream]::new($iconBytes, 0, $iconBytes.Length)


mode con:cols=18 lines=1

Function SamOnboarder {

#form setup
$main_form = New-Object System.Windows.Forms.Form
$main_form.Text ='Onboarding'
$main_form.Width = 600
$main_form.Height = 400
$main_form.Icon = [System.Drawing.Icon]::FromHandle(([System.Drawing.Bitmap]::new($stream1).GetHIcon()))
$main_form.StartPosition = 'CenterScreen'
$main_form.AutoSize = $true
$main_form.Topmost = $true

#creating variables

#computername
$cname = wmic bios get serialnumber
$cname = ($cname -join ".")
$cname = $cname.ToString()
$cname = $cname.trim(" ",".")
$cname = $cname.Substring($cname.length - 7, 7)
$serial = "Serial Number: " + $cname
$pcname = "Current Name: " + $env:computername


#administrator background
$btac = New-Object System.Windows.Forms.CheckBox
$btac.Location = New-Object System.Drawing.Point(10,15)
$btac.Size = new-object System.Drawing.Size(200,40)
$btac.Checked = $false
$btac.Text = "Would you like the Admin Background?"
$main_form.Controls.Add($btac)

#programs
$Label1 = New-Object System.Windows.Forms.Label
$Label1.Text = "Selet Programs to install:"
$Label1.Location  = New-Object System.Drawing.Point(8,60)
$Label1.AutoSize = $true
$main_form.Controls.Add($Label1)

$chrome = New-Object System.Windows.Forms.CheckBox
$chrome.Location = New-Object System.Drawing.Point(10,78)
$chrome.AutoSize = $true
$chrome.Checked = $false
$chrome.Text = "Google Chrome"
$main_form.Controls.Add($chrome)

$adobe = New-Object System.Windows.Forms.CheckBox
$adobe.Location = New-Object System.Drawing.Point(10,96)
$adobe.AutoSize = $true
$adobe.Checked = $false
$adobe.Text = "Adobe Reader"
$main_form.Controls.Add($adobe)

$7zip = New-Object System.Windows.Forms.CheckBox
$7zip.Location = New-Object System.Drawing.Point(10,114)
$7zip.AutoSize = $true
$7zip.Checked = $false
$7zip.Text = "7-Zip Archiver"
$main_form.Controls.Add($7zip)

$teams = New-Object System.Windows.Forms.CheckBox
$teams.Location = New-Object System.Drawing.Point(10,132)
$teams.AutoSize = $true
$teams.Checked = $false
$teams.Text = "Microsoft Teams"
$main_form.Controls.Add($teams)

$otherprog = New-Object System.Windows.Forms.CheckBox
$otherprog.Location = New-Object System.Drawing.Point(10,150)
$otherprog.AutoSize = $true
$otherprog.Checked = $false
$otherprog.Text = "Other:"
$main_form.Controls.Add($otherprog)

$Label2 = New-Object System.Windows.Forms.Label
$Label2.Text = "Enter other programs, seperated by commas"
$Label2.Location  = New-Object System.Drawing.Point(8,180)
$Label2.AutoSize = $true
$main_form.Controls.Add($Label2)

$otherlist = New-Object System.Windows.Forms.Textbox
$otherlist.Location  = New-Object System.Drawing.Point(8,198)
$otherlist.AutoSize = $true
$main_form.Controls.Add($otherlist)


#declare name
$Label3 = New-Object System.Windows.Forms.Label
$Label3.Text = "Would you like to rename the computer?"
$Label3.Location  = New-Object System.Drawing.Point(320,60)
$Label3.AutoSize = $true
$main_form.Controls.Add($Label3)

$renamepc = New-Object System.Windows.Forms.CheckBox
$renamepc.Location = New-Object System.Drawing.Point(528,60)
$renamepc.AutoSize = $true
$renamepc.Checked = $false
$main_form.Controls.Add($renamepc)

$Lserial = New-Object System.Windows.Forms.Label
$Lserial.Text = $serial
$Lserial.Location  = New-Object System.Drawing.Point(320,78)
$Lserial.AutoSize = $true
$main_form.Controls.Add($Lserial)

$Lpcname = New-Object System.Windows.Forms.Label
$Lpcname.Text = $pcname
$Lpcname.Location  = New-Object System.Drawing.Point(320,96)
$Lpcname.AutoSize = $true
$main_form.Controls.Add($Lpcname)

$qrename = New-Object System.Windows.Forms.Checkbox
$qrename.Text = "Would you like to Quick Rename?"
$qrename.Location  = New-Object System.Drawing.Point(320,125)
$qrename.AutoSize = $true
$qrename.Checked = $false
$main_form.Controls.Add($qrename)

$qrnexp = New-Object System.Windows.Forms.Label
$qrnexp.Text = "(This is option appends the serial number after the name/prefix.)"
$qrnexp.Location  = New-Object System.Drawing.Point(320,143)
$qrnexp.AutoSize = $true
$main_form.Controls.Add($qrnexp)

#rename
$Label4 = New-Object System.Windows.Forms.Label
$Label4.Text = "What would you like the new name (or Prefix) to be?"
$Label4.Location  = New-Object System.Drawing.Point(320,175)
$Label4.AutoSize = $true
$main_form.Controls.Add($Label4)

$rename = New-Object System.Windows.Forms.Textbox
$rename.Location  = New-Object System.Drawing.Point(320,193)
$rename.AutoSize = $true
$main_form.Controls.Add($rename)


#restart
$restartpc = New-Object System.Windows.Forms.Checkbox
$restartpc.Location = New-Object System.Drawing.Point(320,250)
$restartpc.AutoSize = $true
$restartpc.Checked = $false
$restartpc.Text = "Would you like to restart the computer?"
$main_form.Controls.Add($restartpc)





#ending buttons
$runButton = New-Object System.Windows.Forms.Button
$runButton.Location = New-Object System.Drawing.Point(500,320)
$runButton.Size = New-Object System.Drawing.Size(75,23)
$runButton.Text = 'Run'
$runButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
$main_form.AcceptButton = $runButton
$main_form.Controls.Add($runButton)

$cancelButton = New-Object System.Windows.Forms.Button
$cancelButton.Location = New-Object System.Drawing.Point(420,320)
$cancelButton.Size = New-Object System.Drawing.Size(75,23)
$cancelButton.Text = 'Cancel'
$cancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
$main_form.CancelButton = $cancelButton
$main_form.Controls.Add($cancelButton)


#show the form
$result = $main_form.ShowDialog()



clear

SamResults

}


function SamResults {

mode con:cols=90 lines=30

#code results
if ($result -eq [System.Windows.Forms.DialogResult]::OK) {
    
    
    #install choco
    Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
    
    #background change
    if ($btac.Checked) {

Copy-Item .\Background1.jpg C:\Windows\
$imgPath="C:\Windows\Background1.jpg"
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

#Apply the Change on the system 
[Win32.Wallpaper]::SetWallpaper($imgPath)

}

#Program installs
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

#other program installs
if ($otherprog.checked) {
    #other Program installs
    $otherlist = $otherlist.text
    $otherobj = $otherlist.split(",")

	ForEach ($item in $otherobj) {
		choco install $item.trim() -y
        }

    }



if ($renamepc.Checked) {
    if ($qrename.Checked) {
        $qname = $rename + "-" + $cname
        Rename-Computer -NewName $qname.Text
    }
    else {
    Rename-Computer -NewName $rename.Text
    # For testing purposes: [void] [System.Windows.MessageBox]::Show( "AHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH", "Testing", "OK", "Warning" )
    }
    }

if ($restartpc.Checked) {
    Add-Type -AssemblyName PresentationFramework
    [void] [System.Windows.MessageBox]::Show( "All changes have been implemented successfully, the computer will now restart.", "Onboarding Complete", "OK", "Warning" )
    Start-sleep -s 1
    Restart-Computer
    }

if (-not($restartpc.Checked)) {
    Add-Type -AssemblyName PresentationFramework
    [void] [System.Windows.MessageBox]::Show( "All changes have now been implemented successfully.", "Onboarding Complete", "OK", "Information" )
    }



}


}

SamOnboarder
