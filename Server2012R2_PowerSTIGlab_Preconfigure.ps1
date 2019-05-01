New-EventLog –LogName Application –Source 'BuildScript'

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Write-EventLog -LogName Application -Source 'BuildScript' -EntryType Information -EventId 1 -Message 'Installing Pester'
$null = Find-PackageProvider -Name 'Nuget' -ForceBootstrap -IncludeDependencies
Install-Module Pester -Force -SkipPublisherCheck -Confirm:$false
Write-EventLog -LogName Application -Source 'BuildScript' -EntryType Information -EventId 1 -Message 'Installed Pester'

Write-EventLog -LogName Application -Source 'BuildScript' -EntryType Information -EventId 1 -Message 'Installing Win10 Apps'

#Install Git
$gitDownloadLocation = "c:\Git.exe"
$gitWindows = "https://github.com/git-for-windows/git/releases/download/v2.21.0.windows.1/Git-2.21.0-64-bit.exe"
Invoke-WebRequest -Uri $gitWindows -OutFile $gitDownloadLocation
Start-Process "C:\Git.exe" -ArgumentList "/SP /verysilent" -Wait

#Install VScode
$vsCodeDownloadLocation = "C:\VSCodeSetup.exe"
$vsCode = "https://go.microsoft.com/fwlink/?Linkid=852157"
Invoke-WebRequest -Uri $vsCode -OutFile $vsCodeDownloadLocation
Start-Process "C:\VSCodeSetup.exe" -ArgumentList "/VERYSILENT /MERGETASKS=!runcode" -Wait

#Install WMF	
$WMFDownloadLocation = "C:\WMF.msu"	
$WMF = "https://download.microsoft.com/download/6/F/5/6F5FF66C-6775-42B0-86C4-47D41F2DA187/Win8.1AndW2K12R2-KB3191564-x64.msu"
Invoke-WebRequest -Uri $WMF -OutFile $WMFDownloadLocation	
Start-Process "C:\WMF.msu" -ArgumentList "/quiet /forcerestart" -Wait
