$FunctionsPath = Join-Path -Path $PSScriptRoot -ChildPath ".."
$Functions = Get-ChildItem -Path $FunctionsPath -Filter "*.ps1"

foreach ($Function in $Functions) {
    . $Function.FullName
}

# Export functions
Export-ModuleMember -Function *

Write-Host "Functions Loaded"