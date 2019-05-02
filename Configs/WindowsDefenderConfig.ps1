Configuration WindowsDefender_Config
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
        WindowsDefender BaseLineSettings
        {

        }
    }
}

WindowsDefender_Config
