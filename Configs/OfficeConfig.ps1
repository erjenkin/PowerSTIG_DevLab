Configuration Outlook2016
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
        Office Outlook2016Settings
        {
            OfficeApp = 'Outlook2016'
        }
    }
}

Outlook2016

Configuration Excel2016
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
        Office Excel2016Settings
        {
            OfficeApp = 'Excel2016'
        }
    }
}

Excel2016

Configuration Word2016
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
        Office Word2016Settings
        {
            OfficeApp = 'Word2016'
        }
    }
}

Word2016

Configuration PowerPoint2016
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
        Office Outlook2016Settings
        {
            OfficeApp = 'PowerPoint2016'
        }
    }
}

PowerPoint2016