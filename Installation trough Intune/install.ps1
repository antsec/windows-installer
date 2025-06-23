$TargetPath = "C:\Program Files\AntSec\Certificates"

# Create the folder if it doesn't exist
if (!(Test-Path -Path $TargetPath)) {
    New-Item -Path $TargetPath -ItemType Directory -Force
}

# Copy certificate files
Copy-Item -Path "$PSScriptRoot\certificate.key" -Destination $TargetPath -Force
Copy-Item -Path "$PSScriptRoot\certificate.crt" -Destination $TargetPath -Force