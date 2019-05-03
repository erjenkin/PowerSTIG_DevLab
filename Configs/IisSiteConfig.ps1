Configuration IisSite_Config
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
        IisSite ServerConfiguration
        {
            IisVersion  = '8.5'
            WebSiteName = 'Default Web Site'
            WebAppPool  = 'DefaultAppPool'

         }
    }
}

IisSite_Config
