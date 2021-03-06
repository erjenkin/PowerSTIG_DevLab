#get current PowerSTIG version path
$currentModuleVersion = (Get-ChildItem -Path 'C:\Program Files\WindowsPowerShell\Modules\PowerSTIG').Name
$currentModulePath = "C:\Program Files\WindowsPowerShell\Modules\PowerSTIG\" + $currentModuleVersion.Trim("'")+"\"

#clones your branch to this VM
git clone -b "YOUBRANCHHERE" https://github.com/Microsoft/PowerStig.git c:\Github -q

#get modules required by your branch and updates modules locally
$ModulesTest = Get-Content C:\Github\PowerStig.psd1 | Select-String -Pattern "ModuleName = '(.*)'; ModuleVersion = '(.*)'" | % {"Install-Module $($_.matches.groups[1]) -RequiredVersion $($_.matches.groups[2]) -force"} >> C:\Modules.ps1
C:\Modules.ps1

#copy required files from your branch to PowerSTIG  module directory
$itemsToCopy = "PowerStig.psd1", "PowerStig.psm1"

foreach($item in $itemsToCopy)
{
$path = "C:\Github\" + $item
$destination = $currentModulePath + $item
Copy-Item -Path $path -Destination $destination -force -Recurse
}

$dirToCopy = "DSCResources", "Module", "StigData\Processed"

foreach($dir in $dirToCopy)
{
$path = "C:\Github\" + $dir
$destination = $currentModulePath
Copy-Item -Path $path -Destination $destination -force -Recurse
}

#update PowerSTIG version if newer than current release
$powerstigVersion = Get-Content C:\Github\PowerStig.psd1 | Select-String -Pattern "ModuleVersion = (.*)" 
$version = $powerstigVersion.matches.groups[1].Value
Rename-Item -Path $currentModulePath -newName $version.trim("'") -verbose

#update MaxEnvelope Size
Set-Item -Path WSMan:\localhost\MaxEnvelopeSizekb -Value 8192
