# Define the path to the input CSV file and the output JSON file

function display-header {
    Write-Host --------------------------------------
    Write-Host     Assignment 5 Part 1
    Write-Host     Adenike Oloyede - 300373205
    Write-Host --------------------------------------
}

function Test-Port {
    param (
        [string]$Server,
        [int]$Port
    )
    try {
        $connection = Test-NetConnection -ComputerName $Server -Port $Port -WarningAction SilentlyContinue
        if ($connection.TcpTestSucceeded) {
            return "Open"
        } else {
            return "Closed"
        }
    } catch {
        Write-Warning "An error occurred testing $Server on port $Port : $_"
        return "Error"
    }
}

try {
   
    $servers = Import-Csv .\servers.csv

    display-header
    
    
    $results = @()

    
    foreach ($row in $servers) {
       
        $serverList = $row.Servers -split ","
        $ports = $row.Ports -split ","
        
        foreach ($server in $serverList) {
           
            $infoHash = @{}

            foreach ($port in $ports) {
                
                $portInt = [int]$port
              
                $status = Test-Port -Server $server -Port $portInt
                Write-Host "checking server $server  "
                   " Port $port : $status"

               
                $infoHash[$port] = $status
            }

            Write-Host "--------------------------------"
            $result = [PSCustomObject]@{
                Server = $server
                Info   = $infoHash
            }

           
            $results += $result
        }
    }

   
    $results | Format-Table -Property Server, Info 

    $results | ConvertTo-Json | Out-File -FilePath ".\assign05_part1_AOl205.json" -Force

    Write-Host "Results exported to port_status.json successfully."
} catch {
    Write-Error "An error occurred: $_"
}
