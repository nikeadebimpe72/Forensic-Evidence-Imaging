
Get-ChildItem -Path $PSScriptRoot\Functions | 
    ForEach-Object -Process {. $PSItem.FullName}

