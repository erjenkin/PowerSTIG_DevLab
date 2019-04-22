Configuration InternetExplorer_Config
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
        InternetExplorer InternetExplorerSettings
        {
            BrowserVersion = '11'
        }
    }
}

InternetExplorer_Config