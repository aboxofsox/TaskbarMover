Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$Position = @{
    Left = "00"
    Top = "01"
    Right = "02"
    Bottom = "03"  
}

$Window = New-Object System.Windows.Forms.Form
$Window.Text = 'Relocate Taskbar'
$Window.Size = New-Object System.Drawing.Size(300,150)
$Window.STartPosition = 'CenterScreen'

$OK = New-Object System.Windows.Forms.Button
$OK.Location = New-Object System.Drawing.Point(75,80)
$OK.Size = New-Object System.Drawing.Size(75, 23)
$OK.Text = 'Ok'
$OK.DialogResult = [System.Windows.Forms.DialogResult]::OK
$Window.AcceptButton = $OK
$Window.Controls.Add($OK)

$Cancel = New-Object System.Windows.Forms.Button
$Cancel.Location = New-Object System.Drawing.Point(150,80)
$Cancel.Size = New-Object System.Drawing.Size(75,23)
$Cancel.Text = 'Cancel'
$Cancel.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
$Window.CancelButton = $Cancel
$Window.Controls.Add($Cancel)

$Select = New-Object System.Windows.Forms.ComboBox
$Select.Location = New-Object System.Drawing.Point(10,20)
$Select.Size = New-Object System.Drawing.Size(250, 20)
$Select.Items.Add('-- Taskbar Position --')
$Select.Items.Add('Left')
$Select.Items.Add('Top')
$Select.Items.Add('Right')
$Select.Items.Add('Bottom')
$Select.SelectedIndex = 0
$Select.DropDownStyle = [System.Windows.Forms.ComboBoxStyle]::DropDownList
$Window.Controls.Add($Select)

# Soon™️
# $MultiMonitor = New-Object System.Windows.Forms.CheckBox
# $MultiMonitor.Location = New-Object System.Drawing.Point(10,50)
# $MultiMonitor.Size = New-Object System.Drawing.Size(250, 20)
# $MultiMonitor.Text = 'Multi-Display'
# $Window.Controls.Add($MultiMonitor)

$Window.Topmost = $true

$Window.Add_Shown({$Select.Select()})

$Result = $Window.ShowDialog()

if ($Result -eq [System.Windows.Forms.DialogResult]::OK) {
    $Pos = $Position[$Select.Text]
    $NewValue = "30,00,00,00,fe,ff,ff,ff,7a,f4,00,00,$Pos,00,00,00,30,00,00,00,30,00,00,00,00,00,00,00,00,00,00,00,00,0a,00,00,30,00,00,00,60,00,00,00,01,00,00,00"
    $Hex = $NewValue.Split(',') | ForEach-Object {"0x$_"}
    Set-ItemProperty -Path Registry::HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\StuckRects3 -Name Settings -Value ([byte[]]$Hex)
    Stop-Process -Name explorer
 
}