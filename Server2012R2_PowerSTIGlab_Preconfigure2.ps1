#Install SQL
$SQLDownloadLocation = "C:\SQL.iso"
$SQL = "https://download.microsoft.com/download/4/C/7/4C7D40B9-BCF8-4F8A-9E76-06E9B92FE5AE/ENU/SQLFULL_ENU.iso"
$wc = New-Object net.webclient
$wc.Downloadfile($SQL, $SQLDownloadLocation)

$currentUserName = (Get-LocalGroupMember -Group "Administrators").Name

$mountVolume = Mount-DiskImage -ImagePath $SQLDownloadLocation -PassThru
$driveLetter = ($mountVolume | Get-Volume).DriveLetter
$drivePath = $driveLetter + ":"
push-location -path "$drivePath"

.\Setup.exe /q /ACTION=Install /FEATURES=SQLEngine,LocalDB,Tools /UpdateEnabled /UpdateSource=MU /X86=false /INSTANCENAME=MSSQLSERVER /INSTALLSHAREDDIR="C:\Program Files\Microsoft SQL Server" /INSTALLSHAREDWOWDIR="C:\Program Files (x86)\Microsoft SQL Server" /INSTANCEDIR="C:\Program Files\Microsoft SQL Server" /AGTSVCACCOUNT="NT Service\SQLSERVERAGENT" /AGTSVCSTARTUPTYPE="Manual" /SQLSVCSTARTUPTYPE="Automatic" /SQLCOLLATION="SQL_Latin1_General_CP1_CI_AS" /SQLSVCACCOUNT="NT Service\MSSQLSERVER" /SECURITYMODE="SQL" /SAPWD="Passw0rd" /SQLSYSADMINACCOUNTS="$currentUserName" /IACCEPTSQLSERVERLICENSETERMS
pop-location
Dismount-DiskImage -ImagePath $SQLDownloadLocation

Write-EventLog -LogName Application -Source 'BuildScript' -EntryType Information -EventId 1 -Message 'Installed Server Apps'

Write-EventLog -LogName Application -Source 'BuildScript' -EntryType Information -EventId 1 -Message 'Configure Roles and Features'
Install-WindowsFeature -name DNS -IncludeManagementTools -IncludeAllSubFeature
Install-WindowsFeature -name Web-Server -IncludeManagementTools -IncludeAllSubFeature
Write-EventLog -LogName Application -Source 'BuildScript' -EntryType Information -EventId 1 -Message 'Configured Roles and Features'

Write-EventLog -LogName Application -Source 'BuildScript' -EntryType Information -EventId 1 -Message 'Configuring git'
git config --add --system http.sslverify false
git config --add --system credential.helper wincred
Write-EventLog -LogName Application -Source 'BuildScript' -EntryType Information -EventId 1 -Message 'Configured git'

Write-EventLog -LogName Application -Source 'BuildScript' -EntryType Information -EventId 1 -Message 'Installing Pester'
$null = Find-PackageProvider -Name 'Nuget' -ForceBootstrap -IncludeDependencies
Install-Module Pester -Force -SkipPublisherCheck -Confirm:$false
Write-EventLog -LogName Application -Source 'BuildScript' -EntryType Information -EventId 1 -Message 'Installed Pester'

Write-EventLog -LogName Application -Source 'BuildScript' -EntryType Information -EventId 1 -Message 'Updating Help'
Update-Help -Force -Confirm:$false
Write-EventLog -LogName Application -Source 'BuildScript' -EntryType Information -EventId 1 -Message 'Updated Help'

Write-EventLog -LogName Application -Source 'BuildScript' -EntryType Information -EventId 1 -Message 'Configuring WinRM'
$null = winrm quickconfig -quiet
Write-EventLog -LogName Application -Source 'BuildScript' -EntryType Information -EventId 1 -Message 'Configured WinRM'

Install-module Powerstig -Force -Confirm:$false

Write-EventLog -LogName Application -Source 'BuildScript' -EntryType Information -EventId 1 -Message 'Copying Technlogy Configs'
Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/erjenkin/PowerSTIG_DevLab/master/Configs/IisServerConfig.ps1' -OutFile 'C:\IisServerConfig.ps1'
Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/erjenkin/PowerSTIG_DevLab/master/Configs/IisSiteConfig.ps1' -OutFile 'C:\IisSiteConfig.ps1'
Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/erjenkin/PowerSTIG_DevLab/master/Configs/SqlServerDatabaseConfig.ps1' -OutFile 'C:\SqlServerDatabaseConfig.ps1'
Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/erjenkin/PowerSTIG_DevLab/master/Configs/SqlServerInstanceConfig.ps1' -OutFile 'C:\SqlServerInstanceConfig.ps1'
Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/erjenkin/PowerSTIG_DevLab/master/Configs/WindowsDnsServerConfig.ps1' -OutFile 'C:\WindowsDnsServerConfig.ps1'
Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/erjenkin/PowerSTIG_DevLab/master/Configs/WindowsServerDCConfig.ps1' -OutFile 'C:\WindowsServerDCConfig.ps1'
Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/erjenkin/PowerSTIG_DevLab/master/Configs/WindowsServerMSConfig.ps1' -OutFile 'C:WindowsServerMSConfig.ps1'
Write-EventLog -LogName Application -Source 'BuildScript' -EntryType Information -EventId 1 -Message 'Copied Technlogy Configs'

Write-EventLog -LogName Application -Source 'BuildScript' -EntryType Information -EventId 1 -Message 'Copying Post Configuration Script'
Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/erjenkin/PowerSTIG_DevLab/master/Server2012R2_PowerSTIGlab_PostConfigure.ps1' -OutFile 'C:\Server2012R2_PowerSTIGlab_PostConfigure.ps1'
Write-EventLog -LogName Application -Source 'BuildScript' -EntryType Information -EventId 1 -Message 'Copied Post Configuration Script'

Set-ExecutionPolicy unrestricted -force
