Configuration WindowsServerMS_Config
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
            OsRole      = 'MS'
            ForestName  = 'test.local'
            DomainName  = 'test.local'

         }
    }
}

WindowsServerMS_Config
