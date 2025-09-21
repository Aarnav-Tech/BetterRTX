# BetterRTX for Minecraft Bedrock 1.21+ (WINDOWS ONLY)

**BetterRTX** is a modified RTX shader pack for Minecraft Bedrock Edition.  
This repository provides the **English-translated installer script** and instructions for users who can’t access the original [Chinese site](https://www.minegraph.cn/be/shaderpacks/65).

---

## Features

- Full BetterRTX shader support for Minecraft Bedrock Edition
- Multiple presets including Motion Blur, Depth of Field, and Cinematic presets
- Easy installer script for Windows ([requires **IObit Unlocker**](https://www.iobit.com/en/iobit-unlocker.php))
- Option to uninstall or revert to vanilla RTX

---

## Requirements

- Minecraft Bedrock Edition (or Minecraft Preview Edition)
- Windows 10 or later
- [IObit Unlocker](https://www.iobit.com/en/iobit-unlocker.php)
- Administrative privileges

## Minimum Requirements for Ray Tracing in Minecraft: Bedrock Edition for Windows

- OS (Operation Systems): Windows 10+ 64-bit  
- GPU: DirectX hardware ray tracing capable GPU like NVIDIA GeForce® RTX 20 Series and higher, and AMD Radeon™ RX 6000 Series and higher 
- Hardware: PC; Virtual reality headsets and Mixed Reality (MR) headsets are not supported  
- CPU: Intel Core i5 or equivalent  
- RAM: >8 GB of RAM   
- A version of Minecraft: Bedrock Edition at 1.16.200 or higher 

---

## Installation

1. Download the repository or clone it:

```bash
git clone https://github.com/Aarnav-Tech/BetterRTX.git
cd BetterRTX
```
2. For local install make sure that the script is in the folder of the shader present.
   
3.  I recommend local install as the one online the links are broken and doesnt work sometimes.

4. Run Powershell (in the same directory as your script) as Administrator and paste:
```bash
Set-ExecutionPolicy -Scope CurrentUser Bypass
.\BetterRTX_Installer_MGCEdit.ps1
```
5. Follow on screen prompts. (Preview version not recommended though.)

## Uninstallation
Run:
```bash
Set-ExecutionPolicy -Scope CurrentUser Bypass
.\BetterRTX_Installer_MGCEdit.ps1
```
And choose uninstall after first screen.

## Description of shaders included.
- BetterRTX: A modified, basic version. If you're unsure which one to choose, start with this option to experience the difference from official RTX!
- BetterRTX with Motion Blur: Adds additional motion blur.
- BetterRTX with Depth of Field: Additional depth of field.
- BetterRTX Experimental: Experimental version with entity lighting, etc.
- Kelly's Better RTX Preset: Adjusted tones, added brightness and darkness, tweaked lighting, and added depth of field.(Good with Kelly's RTX resource pack)
- Realistic RTX (TheBlackDragon's Edit): Adjusts many parameters to bring the tones closer to life, with motion blur.
- BetterRTX Prizma Preset: has a different style and does not pursue extremely realistic images.
- BetterRTX JG's Cinematic Presets: Available in full color and desaturated versions, they provide depth of field, ACES tone mapping, sun angle modification, sharp shadows, rainy day wetness, and small puddles. **Not suitable for survival mode** .


## Additional / Optional Resources
- Recommended V2000 Fogg05 PBR Pack: https://afdian.net/a/Fogg05

- Defined PBR Pack: https://www.patreon.com/MADLAD3718

- Kelly’s RTX: https://discord.gg/stw2JGjbWm

- BetterRTX Discord: https://discord.gg/minecraft-rtx-691547840463241267

## Post Install
1. `Settings > Video > Allow In-game Graphic Mode Switching` Make sure to enable this!
2. As you can't select Ray-Tracing Option in the main menu only in-game due to this [bug](https://bugs.mojang.com/browse/MCPE/issues/MCPE-191513)
3. Enable your resource pack (if downloaded any).
4. Go to your world then, `Settings > Video > Select Ray Tracing`
5. **ENJOY!**

## Support
If you run into issues please drop me an email and i'll try to respond ASAP.
[aarnav1lokesh@gmail.com](mailto:aarnav1lokesh@gmail.com)
