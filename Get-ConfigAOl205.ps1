#$configFile = "config.json"
function Get-ConfigAOl205 {
    param (
        [string]$configFile
    )
    $configContent = Get-Content -Path $configFile -Raw
    $configInfo = $configContent | ConvertFrom-Json
    
    return $configInfo
}

