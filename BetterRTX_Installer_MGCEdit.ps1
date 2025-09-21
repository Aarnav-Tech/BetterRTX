# This script installs the BetterRTX mod for Minecraft RTX, making it easy for users to use.
# The installer modifies certain system files, so use responsibly.
# Version 1.0.1 changelog:
# - Ensures system files in System32 are handled properly
# - Supports Minecraft Preview Edition installation
# - Fixes some previous issues
# - Installer can remove/reinstall files safely

Clear-Host
Write-Host $PSScriptRoot
Write-Host $PSScriptRoot

function InstallerLogo {
    Write-Host " _______________________________________________________________________"
    Write-Host "|   ____           _     _                   _____    _______  __   __  |"
    Write-Host "|  |  _ \         | |   | |                 |  __ \  |__   __| \ \ / /  |"
    Write-Host "|  | |_) |   ___  | |_  | |_    ___   _ __  | |__) |    | |     \ V /   |"
    Write-Host "|  |  _ <   / _ \ | __| | __|  / _ \ | '__| |  _  /     | |      > <    |"
    Write-Host "|  | |_) | |  __/ | |_  | |_  |  __/ | |    | | \ \     | |     / . \   |"
    Write-Host "|  |____/   \___|  \__|  \__|  \___| |_|    |_|  \_\    |_|    /_/ \_\  |"
    Write-Host "|______________________________BetterRTX Installer______________________|"
    Write-Host "                                                                       "
    Write-Host " _______________________________________________________________________ "
    Write-Host "|                                                                       |"
    Write-Host "|             BetterRTX Installer | Use responsibly                    |"
    Write-Host "|_______________________________________________________________________|"
    Write-Host "    Original authors: @-jason#2112 & @NotJohnnyTamale#6389, thanks to MGC community, Translated by Aarnav-Tech(gh)"
}

Clear-Host
InstallerLogo
Write-Host ""
Write-Host ""
Write-Host ""
Write-Host "Select Minecraft version:"
Write-Host "1): Official Bedrock Edition (default)"
Write-Host "2): Minecraft Preview Edition (experimental) (may not work with the latest BetterRTX version)"

$location = Read-Host -Prompt "Your choice"
Switch ($location) {
    1 { # Minecraft Bedrock Edition    
        $installationLocation = Get-AppxPackage -Name "Microsoft.MinecraftUWP*" | Select-Object -ExpandProperty InstallLocation;
        continue
    }
    2 { # Minecraft Preview Edition
        $installationLocation = Get-AppxPackage -Name "Microsoft.MinecraftWindowsBeta*" | Select-Object -ExpandProperty InstallLocation;
        continue
    }
    default {
        Write-Error "Invalid selection"
        Start-Sleep -Seconds 5
        exit
    }
}

Clear-Host

# Paths to required files
$iobu = "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\IObit Unlocker\IObit Unlocker.lnk"
$materialsLocation = Join-Path $installationLocation "data\renderer\materials";
$tonemapping = Join-Path $materialsLocation "RTXPostFX.Tonemapping.material.bin";
$rtxStub = Join-Path $materialsLocation "RTXStub.material.bin";
$newTonemapping = Join-Path $PSScriptRoot "RTXPostFX.Tonemapping.material.bin";
$newStub = Join-Path $PSScriptRoot "RTXStub.material.bin";
# URL for latest BetterRTX release
$url = "https://mgcfiles.skiesworld.com/BetterRTX/BetterRTX.json"

$uninstallStub = "https://mgcfiles.skiesworld.com/VanillaRTX/RTXStub.material.bin"
$uninstallTonemapping = "https://mgcfiles.skiesworld.com/VanillaRTX/RTXPostFX.Tonemapping.material.bin"

InstallerLogo
Write-Host ""

# Check IObit Unlocker
Write-Host "Checking for IObit Unlocker..."
if (([System.IO.File]::Exists($iobu))){
    Write-Host "IObit Unlocker is installed"
} else {
    Write-Error "IObit Unlocker not found"
    Write-Error "Please install it from the official site:"
    Write-Host "https://www.iobit.com/en/iobit-unlocker.php"
    Start-Sleep -Seconds 10
    exit
}

# Wait 2 seconds before continuing
Start-Sleep -Seconds 2

Clear-Host
InstallerLogo
Write-Host ""
# Check Minecraft installation
Write-Host "Checking if Minecraft is installed..."
if (-not(Test-Path -Path `"$installationLocation`" -PathType Container)){
    Write-Host "Minecraft is installed, continuing..." 
} else {
    Write-Error "Minecraft not found"
    Write-Error "Please install Minecraft from the official site:"
    Write-Host "https://www.microsoft.com/en-us/p/minecraft-for-windows-10/9nblggh2jhxj"
    Start-Sleep -Seconds 10
    exit
}

Clear-Host
InstallerLogo
Write-Host ""
Write-Host ""
Write-Host ""
Write-Host "Select installation mode:"
Write-Host "1): Download latest release and install"
Write-Host "2): Install from local files"
Write-Host "3): Uninstall BetterRTX"
Write-Host "4): Exit"
$selection = Read-Host -Prompt "Your choice"

Clear-Host
InstallerLogo
Write-Host ""

Switch ($selection)
{
    1 { # Download & install
        Write-Host "Fetching list of available versions..."
        $releases = Invoke-WebRequest -URI $url -UseBasicParsing | ConvertFrom-Json;
        Write-Host "Select the version to install:"
        $i = 1
        foreach ($release in $releases)
        {
            $version = $release
            Write-Host "$($i)):  $($version.name)"
            $i++
        }
        $selectVersion = Read-Host -Prompt "Enter number"
        $version = $releases[$SelectVersion - 1]
        $newStubUrl = $version.stub
        $newToneMappingUrl = $version.tonemapping
        Write-Host ""
        Write-Host "Downloading RTXStub.material.bin and RTXPostFX.Tonemapping.material.bin..."
        Invoke-WebRequest -URI $newStubUrl -OutFile $newStub -UseBasicParsing;
        Invoke-WebRequest -URI $newToneMappingUrl -OutFile $newTonemapping -UseBasicParsing;
        Write-Host "Download complete"
        Write-Host ""
        continue
    }
    2 { # Install from local files
        continue
    }
    3 { # Uninstall
        Write-Host "Uninstalling BetterRTX..."
        Write-Host "Restoring original RTXStub.material.bin and RTXPostFX.Tonemapping.material.bin..."
        Invoke-WebRequest -URI $uninstallStub -OutFile $newStub -UseBasicParsing;
        Invoke-WebRequest -URI $uninstallTonemapping -OutFile $newTonemapping -UseBasicParsing;
        if ([System.IO.File]::Exists($rtxStub)) {
            Write-Host "Deleting existing RTXStub.material.bin..." 
            Start-Process -FilePath $iobu -ArgumentList "/Delete `"$rtxStub`"" -Wait
        }
        if ([System.IO.File]::Exists($tonemapping)) {
            Write-Host "Deleting existing RTXPostFX.Tonemapping.material.bin..." 
            Start-Process -FilePath $iobu -ArgumentList "/Delete `"$tonemapping`"" -Wait
        }
        Write-Host "Copying original RTXStub.material.bin..."
        Start-Process -FilePath $iobu -ArgumentList "/Copy `"$newStub`" `"$materialsLocation`"" -Wait
        Write-Host "Copying original RTXPostFX.Tonemapping.material.bin..." 
        Start-Process -FilePath $iobu -ArgumentList "/Copy `"$newTonemapping`" `"$materialsLocation`"" -Wait
        Remove-Item $newTonemapping
        Remove-Item $newStub
        Write-Host ""
        Write-Host "Uninstallation complete :("
        Write-Host "_______________________________________________________________________"
        Write-Host ""
        Write-Host "For more updates and BetterRTX info, join the Minecraft RTX Discord:"
        Write-Host "Discord server: https://discord.gg/minecraft-rtx-691547840463241267"
        Start-Sleep -Seconds 10
        exit
    }
    4 {exit} # Exit installer
    default { # Invalid selection
        Write-Error "Invalid selection, exiting..."
        Start-Sleep -Seconds 5
        exit
    }
}

# Check downloaded files
if ([System.IO.File]::Exists($newStub)){
    Write-Host "RTXStub.material.bin found, continuing..."    
} else {
    Write-Error "RTXStub.material.bin missing"
    Start-Sleep -Seconds 10
    exit
}
if ([System.IO.File]::Exists($newTonemapping)){
    Write-Host "RTXPostFX.Tonemapping.material.bin found, continuing..." 
} else {
    Write-Error "RTXPostFX.Tonemapping.material.bin missing"
    Start-Sleep -Seconds 10
    exit
}

Write-Host ""
Write-Host ""

# Install BetterRTX
if ([System.IO.File]::Exists($rtxStub)) {
    Write-Host "Deleting existing RTXStub.material.bin..." 
    Start-Process -FilePath $iobu -ArgumentList "/Delete `"$rtxStub`"" -Wait
}
if ([System.IO.File]::Exists($tonemapping)) {
    Write-Host "Deleting existing RTXPostFX.Tonemapping.material.bin..." 
    Start-Process -FilePath $iobu -ArgumentList "/Delete `"$tonemapping`"" -Wait
}
Write-Host "Copying BetterRTX RTXStub.material.bin..."
Start-Process -FilePath $iobu -ArgumentList "/Copy `"$newStub`" `"$materialsLocation`"" -Wait
Write-Host "Copying BetterRTX RTXPostFX.Tonemapping.material.bin..." 
Start-Process -FilePath $iobu -ArgumentList "/Copy `"$newTonemapping`" `"$materialsLocation`"" -Wait

if (-not($selection -eq 2)) {
    Remove-Item $newTonemapping
    Remove-Item $newStub
}

Write-Host ""
Write-Host "Installation complete!"
Write-Host "_______________________________________________________________________"
Write-Host ""
Write-Host ""
Write-Host "To enjoy full BetterRTX features, you may need additional RTX and PBR resource packs."
Write-Host "Recommended V2000 Fogg05 pack enhances reflections (PBR) and emissive blocks (PBR) in original textures."
Write-Host "More info: https://afdian.net/a/Fogg05"
Write-Host "------"
Write-Host "Defined PBR by BetterRTX author adds real emissive PBR blocks."
Write-Host "More info: https://www.patreon.com/MADLAD3718"
Write-Host "------"
Write-Host "Kelly's RTX is compatible with Kelly BetterRTX."
Write-Host "More info: https://discord.gg/stw2JGjbWm"
Write-Host "------"
Write-Host "MGC Resources:"
Write-Host "https://pd.qq.com/s/7lqo0embd"
Write-Host "BetterRTX Discord:"
Write-Host "https://discord.gg/minecraft-rtx-691547840463241267"
Write-Host "https://discord.com/channels/691547840463241267/1101280299427561523"

# Wait 10 seconds before exiting
Start-Sleep -Seconds 10
exit
