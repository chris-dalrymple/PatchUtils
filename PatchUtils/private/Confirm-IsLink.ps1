Function Confirm-IsLink
{    
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$true, Position=1)]
        [string]$Path,
        [Parameter(Mandatory=$false, Position=2)]
        [string]$LinkType
    )

    # Translate parameter into absolute paths
    $SourceFile = Resolve-Path -Path $Path

    # Verify if the path entered is a link
    if ($LinkType)
    {
        return (Get-Item -Path $SourceFile).LinkType -eq $LinkType
    }
    else
    {
        return ((Get-Item -Path $SourceFile).LinkType)
    }
}