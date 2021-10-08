Function Confirm-IsFile()
{
    Param (
        [Parameter(Mandatory=$true, Position=1)]
        [string]$filename
    )

    if (Test-Path $filename -PathType "Leaf")
    {
        return $true
    }

    return $false
}