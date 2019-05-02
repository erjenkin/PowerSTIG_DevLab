Configuration SqlServerDatabase_Config
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
        SqlServer Database
        {
            SqlVersion     = '2012'
            SqlRole        = 'Database'
            ServerInstance = $hostname
            Database       = 'TestDataBase'

         }
    }
}

SqlServerDatabase_Config
