Configuration WindowsDnsServer_Config
{
    param
    (
        [parameter()]
        [string]
        $NodeName = 'localhost'
    )

     Import-DscResource -ModuleName PowerStig 

     Node $NodeName
    {
        WindowsDnsServer BaseLineSettings
        {
            OsVersion   = '2012R2'
            ForestName  = 'test.local'
            DomainName  = 'test.local'

         }
    }
}

WindowsDnsServer_Config
