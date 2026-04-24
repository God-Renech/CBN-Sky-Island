Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$repoRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$overmapSpecialPath = Join-Path $repoRoot 'overmap_special.json'

Describe 'Sky Island z-level layout' {
    It 'places the island on z-levels 9 and 8 for the performance check' {
        $specials = Get-Content -LiteralPath $overmapSpecialPath -Raw | ConvertFrom-Json
        $skyIsland = $specials | Where-Object { $_.id -eq 'Sky Island' }

        $skyIsland | Should Not BeNullOrEmpty

        $zLevels = @($skyIsland.overmaps | ForEach-Object { [int]$_.point[2] })

        @($zLevels | Where-Object { $_ -eq 9 }).Count | Should Be 9
        @($zLevels | Where-Object { $_ -eq 8 }).Count | Should Be 9
        ($zLevels | Sort-Object -Unique) -join ',' | Should Be '8,9'
    }
}
