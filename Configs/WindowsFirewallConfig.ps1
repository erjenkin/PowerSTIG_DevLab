Configuration WindowsFirewall_config
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
         WindowsFirewall BaseLineSettings
        {

        }
    }
}

WindowsFirewall_config
