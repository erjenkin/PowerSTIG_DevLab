Configuration WindowsServerDC_Config
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
        WindowsServer BaseLineSettings
        {
            OsVersion   = '2012R2'
            OsRole      = 'DC'
            ForestName  = 'test.local'
            DomainName  = 'test.local'

         }
    }
}

WindowsServerDC_Config
