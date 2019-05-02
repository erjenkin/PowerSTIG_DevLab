$powerstigVersion = Get-Content C:\Github\PowerStig.psd1 | Select-String -Pattern "ModuleVersion = (.*)" 
$version = $powerstigVersion.matches.groups[1].Value
Rename-Item -Path $currentModulePath -newName $version.trim("'") -verbose

#update MaxEnvelope Size
Set-Item -Path WSMan:\localhost\MaxEnvelopeSizekb -Value 8192

#Create test database
Configuration Example
{

    Import-DscResource -ModuleName SqlServerDsc
    $hostname = hostname

    node localhost
    {
        SqlDatabase Create_Database
        {
            Ensure       = 'Present'
            ServerName   = $hostname
            InstanceName = 'MSSQLSERVER'
            Name         = 'TestDatabase'
        }
    }
}
Example

Start-DscConfiguration .\Example -wait -verbose -force
