Add-Type -Assembly System.Windows.Forms
Add-Type -AssemblyName PresentationFramework
[System.Windows.Forms.Application]::EnableVisualStyles()

$iconBase64 = [Convert]::ToBase64String((Get-Content ".\Resources\bt_logo.ico" -Encoding Byte))
$iconBytes       = [Convert]::FromBase64String($iconBase64)
$stream1          = [System.IO.MemoryStream]::new($iconBytes, 0, $iconBytes.Length)


Function ChrisOnboarder {
    Start-Process -FilePath ".\Resources\chrisonboard.bat" -wait
}

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


#btadmin account
$btac = New-Object System.Windows.Forms.CheckBox
$btac.Location = New-Object System.Drawing.Point(10,10)
$btac.Size = new-object System.Drawing.Size(200,30)
$btac.Checked = $false
$btac.Text = "Is this a BTAdmin account?"
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
$renamepc.Location = New-Object System.Drawing.Point(528,55)
$otherprog.AutoSize = $true
$otherprog.Checked = $false
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


#rename
$Label4 = New-Object System.Windows.Forms.Label
$Label4.Text = "If Yes, what would you like the new name to be?"
$Label4.Location  = New-Object System.Drawing.Point(320,140)
$Label4.AutoSize = $true
$main_form.Controls.Add($Label4)

$rename = New-Object System.Windows.Forms.Textbox
$rename.Location  = New-Object System.Drawing.Point(320,158)
$rename.AutoSize = $true
$main_form.Controls.Add($rename)


#restart
$Label5 = New-Object System.Windows.Forms.Label
$Label5.Text = "Would you like to restart the computer?"
$Label5.Location  = New-Object System.Drawing.Point(320,210)
$Label5.AutoSize = $true
$main_form.Controls.Add($Label5)

$restartpc = New-Object System.Windows.Forms.Checkbox
$restartpc.Location = New-Object System.Drawing.Point(322,223)
$otherprog.AutoSize = $true
$otherprog.Checked = $false
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




#code results
if ($result -eq [System.Windows.Forms.DialogResult]::OK) {
    
    
    #install choco
    Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
    
    #background change
    if ($btac.Checked) {

Copy-Item .\Resources\Background1.jpg C:\Windows\
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
choco install adobereader -y | Out-Host
} 
if ($chrome.Checked) {
choco install googlechrome -y | Out-Host
} 
if ($7zip.Checked) {
choco install 7zip -y | Out-Host
} 
if ($teams.Checked) {
choco install microsoft-teams -y | Out-Host
} 

#other program installs
if ($otherprog.checked) {
    #other Program installs
    $otherlist = $otherlist.text
    $otherobj = $otherlist.split(",")

	ForEach ($item in $otherobj) {
		choco install $item.trim() -y | Out-Host
        }

    }



if ($renamepc.Checked) {
    Rename-Computer -NewName $rename
    # For testing purposes: [void] [System.Windows.MessageBox]::Show( "AHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH", "Testing", "OK", "Warning" )
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

Function Generate-Launcher {

#form1
$form1 = New-Object System.Windows.Forms.Form
$form1.Text =' '
$form1.Width = 200
$form1.Height = 180
$form1.Icon = [System.Drawing.Icon]::FromHandle(([System.Drawing.Bitmap]::new($stream1).GetHIcon()))
$form1.StartPosition = 'CenterScreen'
$form1.FormBorderStyle = 'Fixed3D'
$form1.MaximizeBox = $false
$form1.MinimizeBox = $False
$form1.AutoSize = $true


$Labela = New-Object System.Windows.Forms.Label
$Labela.Location = New-Object System.Drawing.Point(40,3)
$Labela.Text = "Choose your Installer:"
$labela.AutoSize = $true
$form1.Controls.Add($Labela)

$samButton = New-Object System.Windows.Forms.Button
$samButton.Location = New-Object System.Drawing.Point(10,30)
$samButton.Size = New-Object System.Drawing.Size(80,100)
$samButton.Text = 'Sam'
$samButton.Add_Click({
    $form1.Dispose()
    SamOnboarder
})
$form1.AcceptButton = $samButton
$form1.Controls.Add($samButton)

$chrisButton = New-Object System.Windows.Forms.Button
$chrisButton.Location = New-Object System.Drawing.Point(100,30)
$chrisButton.Size = New-Object System.Drawing.Size(80,100)
$chrisButton.Text = 'Chris'
$chrisButton.Add_Click({
    $form1.Dispose()
    ChrisOnboarder
})
$form1.AcceptButton = $chrisButton
$form1.Controls.Add($chrisButton)

$form1.ShowDialog()

clear
}

#If you want to just run SamOnboarder, just uncomment the next line, and comment the line after it.
#SamOnboarder
Generate-Launcher
