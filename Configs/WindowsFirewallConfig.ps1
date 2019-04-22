Configuration WindowsFirewall_config
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
         WindowsFirewall BaseLineSettings
        {

        }
    }
}

WindowsFirewall_config
