Configuration WindowsDefender_Config
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
        WindowsDefender BaseLineSettings
        {

        }
    }
}

WindowsDefender_Config
