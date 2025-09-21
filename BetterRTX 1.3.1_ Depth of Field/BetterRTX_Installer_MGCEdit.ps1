# 本源代码仅限于链接到 Minecraft RTX 服务器的场合使用，不得在其他任何场合分发
# 本安装程序的源代码仅供个人用途修改，不得擅自传播
# 未经许可，严禁分发
# 版本 1.0.1 更新日志
# - 修正了安装程序错误地在 System32 目录而非所在目录运行的问题
# - 增加了将程序安装到 Minecraft Preview Edition 的功能
# - 优化了错误信息
# - 安装完成后将自动删除下载的文件，本地安装的文件除外。



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
    Write-Host "|______________________________快速安装器_______________________________|"
    Write-Host "                                                                       "
    Write-Host " _______________________________________________________________________ "
    Write-Host "|                                                                       |"
#   Write-Host "|              适用于 Minecraft RTX 的快速安装器 v1.0.1.2               |"
    Write-Host "|             官方 BetterRTX 安装程序 | 禁止任何未授权分发              |"
    Write-Host "|_______________________________________________________________________|"
    Write-Host "    原作归属：@-jason#2112 和 @NotJohnnyTamale#6389 中文版制作：MGC社区    "
}
Clear-Host
InstallerLogo
Write-Host ""
Write-Host ""
Write-Host ""
Write-Host "选择游戏版本："
Write-Host "1): 我的世界基岩版 正式版 (默认)"
Write-Host "2): 我的世界基岩版 预览版 (拓展) (不推荐，BetterRTX基于正式版制作，预览版可能存在当前版本无法兼容的功能问题)"

$location = Read-Host -Prompt "输入数字"
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
        Write-Error "无效的选择"
        Start-Sleep -Seconds 5
        exit
    }
}
Clear-Host
# 路径: installer.ps1
# 设置文件、应用程序和 URL 位置
$iobu = "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\IObit Unlocker\IObit Unlocker.lnk"
$materialsLocation = Join-Path $installationLocation "data\renderer\materials";
$tonemapping = Join-Path $materialsLocation "RTXPostFX.Tonemapping.material.bin";
$rtxStub = Join-Path $materialsLocation "RTXStub.material.bin";
$newTonemapping = Join-Path $PSScriptRoot "RTXPostFX.Tonemapping.material.bin";
$newStub = Join-Path $PSScriptRoot "RTXStub.material.bin";
# 从服务器中下载文件
$url = "https://mgcfiles.skiesworld.com/BetterRTX/BetterRTX.json"

$uninstallStub = "https://mgcfiles.skiesworld.com/VanillaRTX/RTXStub.material.bin"
$uninstallTonemapping = "https://mgcfiles.skiesworld.com/VanillaRTX/RTXPostFX.Tonemapping.material.bin"
InstallerLogo
Write-Host ""

# 检查 IOBit Unlocker
Write-Host "正在检查 IObit Unlocker..."
if (([System.IO.File]::Exists($iobu))){
    Write-Host "IObit Unlocker 已安装"
} else {
    Write-Error "IObit Unlocker 未安装"
    Write-Error "请访问以下地址以查看 IObit Unlocker ，并重新运行此脚本"
    Write-Host "https://www.iobit.com/en/iobit-unlocker.php"
    Start-Sleep -Seconds 10
    exit
}


# 向用户显示 BetterRTX 快速安装程序提示
Start-Sleep -Seconds 2


Clear-Host
InstallerLogo
Write-Host ""
# 检查 minecraft
Write-Host "正在检查 Minecraft 是否已安装"
if (-not(Test-Path -Path `"$installationLocation`" -PathType Container)){
    Write-Host "Minecraft 已安装，正在继续..." 
} else {
    Write-Error "Minecraft 未安装"
    Write-Error "请访问以下地址以查看 Minecraft ，并重新运行此脚本"
    Write-Host "https://www.microsoft.com/en-us/p/minecraft-for-windows-10/9nblggh2jhxj"
    Start-Sleep -Seconds 10
    exit
}
Clear-Host
InstallerLogo
Write-Host ""
Write-Host ""
Write-Host ""
Write-Host "请选择安装方式："
Write-Host "1): 从云端安装（推荐）"
Write-Host "2): 从本地文件安装（高级）（需要你准备最新的文件并确保其与安装程序位于同一文件夹中）"
Write-Host "3): 卸载 BetterRTX"
Write-Host "4): 退出"
$selection = Read-Host -Prompt "请输入数字"

Clear-Host
InstallerLogo
Write-Host ""
Switch ($selection)
{
    1 { # 从服务器安装
        Write-Host "正在从云端下载最新的版本列表..."
        $releases = Invoke-WebRequest -URI $url -UseBasicParsing | ConvertFrom-Json;
        Write-Host "请选择要安装的预设："
        $i = 1
        foreach ($release in $releases)
        {
            $version = $release
            Write-Host "$($i)):  $($version.name)"
            $i++
        }
        $selectVersion = Read-Host -Prompt "请输入数字"
        $version = $releases[$SelectVersion - 1]
        $newStubUrl = $version.stub
        $newToneMappingUrl = $version.tonemapping
        Write-Host ""
        Write-Host "正在从服务器下载最新的 RTXStub.material.bin 和 RTXPostFX.Tonemapping.material.bin..."
        Invoke-WebRequest -URI $newStubUrl -OutFile $newStub -UseBasicParsing;
        Invoke-WebRequest -URI $newToneMappingUrl -OutFile $newTonemapping -UseBasicParsing;
        Write-Host "下载完毕"
        Write-Host ""
        continue
    }
    2 { # 从本地文件安装
        continue
    }
    3 { # 卸载
        Write-Host "开始卸载 BetterRTX..."
        Write-Host "正在下载最新的 原版 RTXStub.material.bin 和 RTXPostFX.Tonemapping.material.bin..."
        Invoke-WebRequest -URI $uninstallStub -OutFile $newStub -UseBasicParsing;
        Invoke-WebRequest -URI $uninstallTonemapping -OutFile $newTonemapping -UseBasicParsing;
        if ([System.IO.File]::Exists($rtxStub)) {
            Write-Host "正在移除旧版 RTXStub.material.bin..." 
            Start-Process -FilePath $iobu -ArgumentList "/Delete `"$rtxStub`"" -Wait
        }
        if ([System.IO.File]::Exists($tonemapping)) {
            Write-Host "正在移除旧版 RTXPostFX.Tonemapping.material.bin..." 
            Start-Process -FilePath $iobu -ArgumentList "/Delete `"$tonemapping`"" -Wait
        }
        Write-Host "正在嵌入 原版 RTXStub.material.bin..."
        Start-Process -FilePath $iobu -ArgumentList "/Copy `"$newStub`" `"$materialsLocation`"" -Wait
        Write-Host "正在嵌入 原版 RTXPostFX.Tonemapping.material.bin..." 
        Start-Process -FilePath $iobu -ArgumentList "/Copy `"$newTonemapping`" `"$materialsLocation`"" -Wait
        Remove-Item $newTonemapping
        Remove-Item $newStub
        Write-Host ""
        Write-Host "已完成 :("
        Write-Host "_______________________________________________________________________"
        Write-Host ""
        Write-Host ""
        Write-Host "对于你的离开我们感到十分抱歉。如果您有任何建议或问题，请在 Minecraft RTX Discord 中进行反馈"
        Write-Host "Discord 邀请链接：https://discord.gg/minecraft-rtx-691547840463241267"
        Write-Host "Discord 频道链接：https://discord.com/channels/691547840463241267/1101280299427561523"
        Start-Sleep -Seconds 10
        exit
    }
    4 {exit} # 退出安装程序
    default { # 如果用户输入了无效选项
        Write-Error "找不到选项，请重新启动程序。正在退出..."
        Start-Sleep -Seconds 5
        exit
    }
}
# Checks to see if the user has a RTXStub.material.bin
if ([System.IO.File]::Exists($newStub)){
    Write-Host "RTXStub.material.bin 存在，正在继续..."    
} else {
    Write-Error "RTXStub.material.bin 不存在"
    Start-Sleep -Seconds 10
    exit
}
# Checks to see if the user has a RTXPostFX.Tonemapping.material.bin
if ([System.IO.File]::Exists($newTonemapping)){
    Write-Host "RTXPostFX.Tonemapping.material.bin 存在，正在继续..." 
} else {
    Write-Error "RTXPostFX.Tonemapping.material.bin 不存在"
    Start-Sleep -Seconds 10
    exit
}
Write-Host ""
Write-Host ""
# 安装 BetterRTX
if ([System.IO.File]::Exists($rtxStub)) {
    Write-Host "移除旧版 RTXStub.material.bin..." 
    Start-Process -FilePath $iobu -ArgumentList "/Delete `"$rtxStub`"" -Wait
}
if ([System.IO.File]::Exists($tonemapping)) {
    Write-Host "移除旧版 RTXPostFX.Tonemapping.material.bin"... 
    Start-Process -FilePath $iobu -ArgumentList "/Delete `"$tonemapping`"" -Wait
}
Write-Host "正在嵌入 BetterRTX RTXStub.material.bin..."
Start-Process -FilePath $iobu -ArgumentList "/Copy `"$newStub`" `"$materialsLocation`"" -Wait
Write-Host "正在嵌入 BetterRTX RTXPostFX.Tonemapping.material.bin..." 
Start-Process -FilePath $iobu -ArgumentList "/Copy `"$newTonemapping`" `"$materialsLocation`"" -Wait
if (-not($selection -eq 2)) {
Remove-Item $newTonemapping
Remove-Item $newStub
}
Write-Host ""
Write-Host "安装已完成！"
Write-Host "_______________________________________________________________________"
Write-Host ""
Write-Host ""
Write-Host "感谢您安装 BetterRTX ！如果您有任何问题，请在 Minecraft RTX Discord 中进行反馈"
Write-Host "还有一件事！你仍然需要一个配合 RTX 的 PBR 资源包才能启用 BetterRTX ！"
Write-Host "推荐资源包："
Write-Host "【平方构想V2000】零雾〇五 Fogg05 推荐的资源包，在原版风格的基础上增加诸多效果如 PBR 反射（如金属块）、PBR 自发光（如紫水晶）。"
Write-Host "链接：https://afdian.net/a/Fogg05"
Write-Host "------"
Write-Host "【Defined PBR】BetterRTX 作者开发，除 PBR 反射外，有实体发光（需搭配实验版 Better RTX ）。"
Write-Host "链接（需自备翻墙工具）：https://www.patreon.com/MADLAD3718"
Write-Host "------"
Write-Host "Kelly's RTX：知名资源包，可搭配 Kelly 版 BetterRTX 使用。"
Write-Host "链接（需自备翻墙工具）：https://discord.gg/stw2JGjbWm"
Write-Host "------"
Write-Host "【国内 MGC 频道】"
Write-Host "链接：https://pd.qq.com/s/7lqo0embd"
Write-Host "【国外 BetterRTX 频道】"
Write-Host "链接：https://discord.gg/minecraft-rtx-691547840463241267"
Write-Host "链接：https://discord.com/channels/691547840463241267/1101280299427561523"

# 等待用户能够在离开前阅读消息
Start-Sleep -Seconds 10
exit
