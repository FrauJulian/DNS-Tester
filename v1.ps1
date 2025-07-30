param(
    [string]$DnsServer        = '1.1.1.1',
    [int]   $QueriesPerDomain = 3,
    [string]$DomainsFile      = 'Domains.txt',
    [string]$ResultsFile      = 'Results.csv'
)

# Domains einlesen
if (-not (Test-Path $DomainsFile)) {
    Write-Error "Domains-File '$DomainsFile' not found."
    exit 1
}
$domains = Get-Content $DomainsFile

"domain,query,response_ms" | Out-File -FilePath $ResultsFile -Encoding UTF8

foreach ($domain in $domains) {
    for ($i = 1; $i -le $QueriesPerDomain; $i++) {
        $sw = [System.Diagnostics.Stopwatch]::StartNew()
        try {
            Resolve-DnsName -Name $domain -Server $DnsServer -ErrorAction Stop | Out-Null
            $sw.Stop()
            $ms = [math]::Round($sw.Elapsed.TotalMilliseconds, 2)
        }
        catch {
            $sw.Stop()
            $ms = 'ERR'
        }

        Write-Host "[$domain] Query $($i): $($ms) ms"
        "$($domain),$($i),$($ms)" | Out-File -FilePath $ResultsFile -Append -Encoding UTF8
    }
}

# Statistik
$results = Import-Csv $ResultsFile | Where-Object { $_.response_ms -ne 'ERR' } `
    | Select-Object @{n='response_ms';e={[double]$_.response_ms}}
$avg = [math]::Round(($results | Measure-Object response_ms -Average).Average,2)
$min = ($results | Measure-Object response_ms -Minimum).Minimum
$max = ($results | Measure-Object response_ms -Maximum).Maximum

Write-Host ''
Write-Host "==== Stats ===="
Write-Host "Average: $avg ms"
Write-Host "Shortest: $min ms"
Write-Host "Longest: $max ms"
