Function Confirm-IsLink
{    
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$true, Position=1)]
        [ValidateScript({})]
        [string]$Source,
        [Parameter(Mandatory=$false, Position=2)]
        [string]$LinkType
    )

    # Translate parameter into absolute paths
    $SourceFile = Resolve-Path -Path $Source

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