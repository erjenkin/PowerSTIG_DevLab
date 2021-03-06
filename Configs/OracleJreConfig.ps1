Configuration OracleJRE_Config
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
        OracleJRE OracleConfiguration
        {
            ConfigPath = 'C:\Windows\Sun\Java\Deployment\deployment.config'
            PropertiesPath = 'C:\Windows\Java\Deployment\deployment.properties'
        }
    }
}

OracleJRE_Config
