Configuration WindowsClient_Config
{
    param
    (
        [parameter()]
        [string]
        $NodeName = 'localhost'
    )

    Import-DscResource -ModuleName PowerStig -ModuleVersion 3.2.0

    Node $NodeName
    {
        WindowsClient BaseLineSettings
        {
            OsVersion = '10'
            DomainName = 'local.test'
            ForestName = 'local.test'
        }
    }
}

WindowsClient_Config
