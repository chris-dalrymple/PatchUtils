Function Confirm-IsDirectory()
{
    Param (
        [Parameter(Mandatory=$true, Position=1)]
        [string]$filename
    )

    if (Test-Path $filename -PathType "Container")
    {
        return $true
    }

    return $false
}