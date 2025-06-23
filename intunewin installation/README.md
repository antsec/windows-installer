# 📦 Deploy AntSec certificate files using Intune (.intunewin)

This guide documents how to deploy `certificate.key` and `certificate.crt` to the following path on Windows devices using Microsoft Intune:

```
C:\Program Files\AntSec\Certificates
```

## 🧾 Files to Deploy

- `certificate.key`
- `certificate.crt`

## 📁 Folder Structure

Create the following folder structure locally:

```
C:\IntunePkg\Source
│
├── certificate.key
├── certificate.crt
└── install.ps1
```

## 📝 PowerShell Script: `install.ps1`

This script copies the certificate files to `C:\Program Files\AntSec\Certificates`. Ensure that the script runs with elevated permissions (SYSTEM context via Intune).

```powershell
$TargetPath = "C:\Program Files\AntSec\Certificates"

# Create the folder if it doesn't exist
if (!(Test-Path -Path $TargetPath)) {
    New-Item -Path $TargetPath -ItemType Directory -Force
}

# Copy certificate files
Copy-Item -Path "$PSScriptRoot\certificate.key" -Destination $TargetPath -Force
Copy-Item -Path "$PSScriptRoot\certificate.crt" -Destination $TargetPath -Force
```

## 🧰 Create the .intunewin Package

1. Download the [Win32 Content Prep Tool](https://learn.microsoft.com/en-us/mem/intune/apps/apps-win32-app-management#prepare-the-win32-app-content)
2. Package the files using this command:

```cmd
IntuneWinAppUtil.exe -c "C:\IntunePkg\Source" -s install.ps1 -o "C:\IntunePkg\Output"
```

- `-c`: Folder with your source files  
- `-s`: The setup script (`install.ps1`)  
- `-o`: Output folder for the generated `.intunewin` file  

## 🎯 Intune Configuration

1. Go to **Intune Admin Center** → **Apps** → **Windows** → **Add**
2. **App type**: Select *Win32 app*
3. **App package file**: Upload the `.intunewin` file from the output directory
4. **Install command**:

```powershell
powershell.exe -ExecutionPolicy Bypass -File install.ps1
```

5. **Uninstall command** (optional):

```powershell
Remove-Item "C:\Program Files\AntSec\Certificates\certificate.key" -Force
Remove-Item "C:\Program Files\AntSec\Certificates\certificate.crt" -Force
```

6. **Detection Rules**:
    - **Rule Type**: File  
    - **Path**: `C:\Program Files\AntSec\Certificates\`  
    - **File or folder**: `certificate.crt`  
    - **Detection method**: *File exists*  

7. **Requirements**:
    - OS: Windows 10/11  
    - Architecture: Match your target devices (x64, etc.)

8. **Assignments**: Assign to appropriate device groups