function Get-ServerInfoAOl205 {
    param (
        [Parameter(Mandatory=$true)]
        [object[]]$cimInfo
    )

    $serverInfo = @()
    foreach ($item in $cimInfo) {
        $cimData = Get-CimInstance -ClassName $item.Class | Select-Object -ExpandProperty $item.Property

        # Creating a custom object with Info and Value
        [PSCustomObject]@{
            Info = $item.Info
            Value = $cimData
            
        }
    }

    return $serverInfo
}
