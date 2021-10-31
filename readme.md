# Move Win11 Taskbar

## Usage

- Run `start.bat`
- From the terminal `PowerShell -ExecutionPolicy RemoteSigned -File ./taskbar.ps1`

## Backup Registry Key
Export `Computer\HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\StuckRects3` somewhere, just in case.

## What to Expect

The script changes the binary value of the above registry key. When it's done, it'll restart `explorer.exe`. Any folders, or files, you have open in the file explorer will be closed, including the folder you ran the script from.

#### Soon™️
- [ ] Multiple displays
- [ ] Vertical align tasbar icons
- [ ] Fix system tray when taskbar is aligned on the left or right
