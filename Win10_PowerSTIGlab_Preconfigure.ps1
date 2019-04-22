New-EventLog –LogName Application –Source 'BuildScript'

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
Start-Process "C:\VSCodeSetup.exe" -ArgumentList "/SP /verysilent /SUPRESSMSGBOXES" -Wait

#Install Firefox
$firefoxDownloadLocation = "c:\firefox.exe"
$firefox = "https://download.mozilla.org/?product=firefox-latest-ssl&os=win64&lang=en-US"
Invoke-WebRequest -Uri $firefox -OutFile $firefoxDownloadLocation
Start-Process "C:\firefox.exe" -ArgumentList "/S" -Wait

#Install Java
$javaDownloadLocation = "C:\Java.exe"
$java = 'https://javadl.oracle.com/webapps/download/AutoDL?BundleId=238726_478a62b7d4e34b78b671c754eaaf38ab'
Invoke-WebRequest -Uri $java -OutFile $javaDownloadLocation
Start-Process "C:\Java.exe" -ArgumentList "INSTALL_SILENT=Enable" -Wait

Write-EventLog -LogName Application -Source 'BuildScript' -EntryType Information -EventId 1 -Message 'Installed Win10 Apps'

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

Write-EventLog -LogName Application -Source 'BuildScript' -EntryType Information -EventId 1 -Message 'Increasing MaxEnvelope Size'
Set-Item -Path WSMan:\localhost\MaxEnvelopeSizekb -Value 8192
Write-EventLog -LogName Application -Source 'BuildScript' -EntryType Information -EventId 1 -Message 'Increased MaxEnvelope Size'

#Installs powerstig as a placeholder
install-module Powerstig -Force -Confirm:$false
