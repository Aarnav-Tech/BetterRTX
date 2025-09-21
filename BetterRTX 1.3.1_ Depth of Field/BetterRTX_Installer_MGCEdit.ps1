# ��Դ������������ӵ� Minecraft RTX �������ĳ���ʹ�ã������������κγ��Ϸַ�
# ����װ�����Դ�������������;�޸ģ��������Դ���
# δ����ɣ��Ͻ��ַ�
# �汾 1.0.1 ������־
# - �����˰�װ���������� System32 Ŀ¼��������Ŀ¼���е�����
# - �����˽�����װ�� Minecraft Preview Edition �Ĺ���
# - �Ż��˴�����Ϣ
# - ��װ��ɺ��Զ�ɾ�����ص��ļ������ذ�װ���ļ����⡣



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
    Write-Host "|______________________________���ٰ�װ��_______________________________|"
    Write-Host "                                                                       "
    Write-Host " _______________________________________________________________________ "
    Write-Host "|                                                                       |"
#   Write-Host "|              ������ Minecraft RTX �Ŀ��ٰ�װ�� v1.0.1.2               |"
    Write-Host "|             �ٷ� BetterRTX ��װ���� | ��ֹ�κ�δ��Ȩ�ַ�              |"
    Write-Host "|_______________________________________________________________________|"
    Write-Host "    ԭ��������@-jason#2112 �� @NotJohnnyTamale#6389 ���İ�������MGC����    "
}
Clear-Host
InstallerLogo
Write-Host ""
Write-Host ""
Write-Host ""
Write-Host "ѡ����Ϸ�汾��"
Write-Host "1): �ҵ�������Ұ� ��ʽ�� (Ĭ��)"
Write-Host "2): �ҵ�������Ұ� Ԥ���� (��չ) (���Ƽ���BetterRTX������ʽ��������Ԥ������ܴ��ڵ�ǰ�汾�޷����ݵĹ�������)"

$location = Read-Host -Prompt "��������"
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
        Write-Error "��Ч��ѡ��"
        Start-Sleep -Seconds 5
        exit
    }
}
Clear-Host
# ·��: installer.ps1
# �����ļ���Ӧ�ó���� URL λ��
$iobu = "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\IObit Unlocker\IObit Unlocker.lnk"
$materialsLocation = Join-Path $installationLocation "data\renderer\materials";
$tonemapping = Join-Path $materialsLocation "RTXPostFX.Tonemapping.material.bin";
$rtxStub = Join-Path $materialsLocation "RTXStub.material.bin";
$newTonemapping = Join-Path $PSScriptRoot "RTXPostFX.Tonemapping.material.bin";
$newStub = Join-Path $PSScriptRoot "RTXStub.material.bin";
# �ӷ������������ļ�
$url = "https://mgcfiles.skiesworld.com/BetterRTX/BetterRTX.json"

$uninstallStub = "https://mgcfiles.skiesworld.com/VanillaRTX/RTXStub.material.bin"
$uninstallTonemapping = "https://mgcfiles.skiesworld.com/VanillaRTX/RTXPostFX.Tonemapping.material.bin"
InstallerLogo
Write-Host ""

# ��� IOBit Unlocker
Write-Host "���ڼ�� IObit Unlocker..."
if (([System.IO.File]::Exists($iobu))){
    Write-Host "IObit Unlocker �Ѱ�װ"
} else {
    Write-Error "IObit Unlocker δ��װ"
    Write-Error "��������µ�ַ�Բ鿴 IObit Unlocker �����������д˽ű�"
    Write-Host "https://www.iobit.com/en/iobit-unlocker.php"
    Start-Sleep -Seconds 10
    exit
}


# ���û���ʾ BetterRTX ���ٰ�װ������ʾ
Start-Sleep -Seconds 2


Clear-Host
InstallerLogo
Write-Host ""
# ��� minecraft
Write-Host "���ڼ�� Minecraft �Ƿ��Ѱ�װ"
if (-not(Test-Path -Path `"$installationLocation`" -PathType Container)){
    Write-Host "Minecraft �Ѱ�װ�����ڼ���..." 
} else {
    Write-Error "Minecraft δ��װ"
    Write-Error "��������µ�ַ�Բ鿴 Minecraft �����������д˽ű�"
    Write-Host "https://www.microsoft.com/en-us/p/minecraft-for-windows-10/9nblggh2jhxj"
    Start-Sleep -Seconds 10
    exit
}
Clear-Host
InstallerLogo
Write-Host ""
Write-Host ""
Write-Host ""
Write-Host "��ѡ��װ��ʽ��"
Write-Host "1): ���ƶ˰�װ���Ƽ���"
Write-Host "2): �ӱ����ļ���װ���߼�������Ҫ��׼�����µ��ļ���ȷ�����밲װ����λ��ͬһ�ļ����У�"
Write-Host "3): ж�� BetterRTX"
Write-Host "4): �˳�"
$selection = Read-Host -Prompt "����������"

Clear-Host
InstallerLogo
Write-Host ""
Switch ($selection)
{
    1 { # �ӷ�������װ
        Write-Host "���ڴ��ƶ��������µİ汾�б�..."
        $releases = Invoke-WebRequest -URI $url -UseBasicParsing | ConvertFrom-Json;
        Write-Host "��ѡ��Ҫ��װ��Ԥ�裺"
        $i = 1
        foreach ($release in $releases)
        {
            $version = $release
            Write-Host "$($i)):  $($version.name)"
            $i++
        }
        $selectVersion = Read-Host -Prompt "����������"
        $version = $releases[$SelectVersion - 1]
        $newStubUrl = $version.stub
        $newToneMappingUrl = $version.tonemapping
        Write-Host ""
        Write-Host "���ڴӷ������������µ� RTXStub.material.bin �� RTXPostFX.Tonemapping.material.bin..."
        Invoke-WebRequest -URI $newStubUrl -OutFile $newStub -UseBasicParsing;
        Invoke-WebRequest -URI $newToneMappingUrl -OutFile $newTonemapping -UseBasicParsing;
        Write-Host "�������"
        Write-Host ""
        continue
    }
    2 { # �ӱ����ļ���װ
        continue
    }
    3 { # ж��
        Write-Host "��ʼж�� BetterRTX..."
        Write-Host "�����������µ� ԭ�� RTXStub.material.bin �� RTXPostFX.Tonemapping.material.bin..."
        Invoke-WebRequest -URI $uninstallStub -OutFile $newStub -UseBasicParsing;
        Invoke-WebRequest -URI $uninstallTonemapping -OutFile $newTonemapping -UseBasicParsing;
        if ([System.IO.File]::Exists($rtxStub)) {
            Write-Host "�����Ƴ��ɰ� RTXStub.material.bin..." 
            Start-Process -FilePath $iobu -ArgumentList "/Delete `"$rtxStub`"" -Wait
        }
        if ([System.IO.File]::Exists($tonemapping)) {
            Write-Host "�����Ƴ��ɰ� RTXPostFX.Tonemapping.material.bin..." 
            Start-Process -FilePath $iobu -ArgumentList "/Delete `"$tonemapping`"" -Wait
        }
        Write-Host "����Ƕ�� ԭ�� RTXStub.material.bin..."
        Start-Process -FilePath $iobu -ArgumentList "/Copy `"$newStub`" `"$materialsLocation`"" -Wait
        Write-Host "����Ƕ�� ԭ�� RTXPostFX.Tonemapping.material.bin..." 
        Start-Process -FilePath $iobu -ArgumentList "/Copy `"$newTonemapping`" `"$materialsLocation`"" -Wait
        Remove-Item $newTonemapping
        Remove-Item $newStub
        Write-Host ""
        Write-Host "����� :("
        Write-Host "_______________________________________________________________________"
        Write-Host ""
        Write-Host ""
        Write-Host "��������뿪���Ǹе�ʮ�ֱ�Ǹ����������κν�������⣬���� Minecraft RTX Discord �н��з���"
        Write-Host "Discord �������ӣ�https://discord.gg/minecraft-rtx-691547840463241267"
        Write-Host "Discord Ƶ�����ӣ�https://discord.com/channels/691547840463241267/1101280299427561523"
        Start-Sleep -Seconds 10
        exit
    }
    4 {exit} # �˳���װ����
    default { # ����û���������Чѡ��
        Write-Error "�Ҳ���ѡ��������������������˳�..."
        Start-Sleep -Seconds 5
        exit
    }
}
# Checks to see if the user has a RTXStub.material.bin
if ([System.IO.File]::Exists($newStub)){
    Write-Host "RTXStub.material.bin ���ڣ����ڼ���..."    
} else {
    Write-Error "RTXStub.material.bin ������"
    Start-Sleep -Seconds 10
    exit
}
# Checks to see if the user has a RTXPostFX.Tonemapping.material.bin
if ([System.IO.File]::Exists($newTonemapping)){
    Write-Host "RTXPostFX.Tonemapping.material.bin ���ڣ����ڼ���..." 
} else {
    Write-Error "RTXPostFX.Tonemapping.material.bin ������"
    Start-Sleep -Seconds 10
    exit
}
Write-Host ""
Write-Host ""
# ��װ BetterRTX
if ([System.IO.File]::Exists($rtxStub)) {
    Write-Host "�Ƴ��ɰ� RTXStub.material.bin..." 
    Start-Process -FilePath $iobu -ArgumentList "/Delete `"$rtxStub`"" -Wait
}
if ([System.IO.File]::Exists($tonemapping)) {
    Write-Host "�Ƴ��ɰ� RTXPostFX.Tonemapping.material.bin"... 
    Start-Process -FilePath $iobu -ArgumentList "/Delete `"$tonemapping`"" -Wait
}
Write-Host "����Ƕ�� BetterRTX RTXStub.material.bin..."
Start-Process -FilePath $iobu -ArgumentList "/Copy `"$newStub`" `"$materialsLocation`"" -Wait
Write-Host "����Ƕ�� BetterRTX RTXPostFX.Tonemapping.material.bin..." 
Start-Process -FilePath $iobu -ArgumentList "/Copy `"$newTonemapping`" `"$materialsLocation`"" -Wait
if (-not($selection -eq 2)) {
Remove-Item $newTonemapping
Remove-Item $newStub
}
Write-Host ""
Write-Host "��װ����ɣ�"
Write-Host "_______________________________________________________________________"
Write-Host ""
Write-Host ""
Write-Host "��л����װ BetterRTX ����������κ����⣬���� Minecraft RTX Discord �н��з���"
Write-Host "����һ���£�����Ȼ��Ҫһ����� RTX �� PBR ��Դ���������� BetterRTX ��"
Write-Host "�Ƽ���Դ����"
Write-Host "��ƽ������V2000�������� Fogg05 �Ƽ�����Դ������ԭ����Ļ������������Ч���� PBR ���䣨������飩��PBR �Է��⣨����ˮ������"
Write-Host "���ӣ�https://afdian.net/a/Fogg05"
Write-Host "------"
Write-Host "��Defined PBR��BetterRTX ���߿������� PBR �����⣬��ʵ�巢�⣨�����ʵ��� Better RTX ����"
Write-Host "���ӣ����Ա���ǽ���ߣ���https://www.patreon.com/MADLAD3718"
Write-Host "------"
Write-Host "Kelly's RTX��֪����Դ�����ɴ��� Kelly �� BetterRTX ʹ�á�"
Write-Host "���ӣ����Ա���ǽ���ߣ���https://discord.gg/stw2JGjbWm"
Write-Host "------"
Write-Host "������ MGC Ƶ����"
Write-Host "���ӣ�https://pd.qq.com/s/7lqo0embd"
Write-Host "������ BetterRTX Ƶ����"
Write-Host "���ӣ�https://discord.gg/minecraft-rtx-691547840463241267"
Write-Host "���ӣ�https://discord.com/channels/691547840463241267/1101280299427561523"

# �ȴ��û��ܹ����뿪ǰ�Ķ���Ϣ
Start-Sleep -Seconds 10
exit
