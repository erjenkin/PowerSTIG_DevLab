Configuration SqlServerInstance_Config
{
    param
    (
        [parameter()]
        [string]
        $NodeName = 'localhost'
    )

     Import-DscResource -ModuleName PowerStig 
     $hostname = hostname

     Node $NodeName
    {
        SqlServer Instance
        {
            SqlVersion     = '2012'
            SqlRole        = 'Instance'
            ServerInstance = $hostname

         }
    }
}

SqlServerInstance_Config
