Configuration Firefox_Config
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
        Firefox FirefoxConfiguration
        {

        }
    }
}

Firefox_Config