Configuration IisServer_Config
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
        IisServer ServerConfiguration
        {
            IisVersion  = '8.5'
            LogPath     = 'c:\temp.log'

         }
    }
}

IisServer_Config
