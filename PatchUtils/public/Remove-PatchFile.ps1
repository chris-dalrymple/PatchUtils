Function Remove-PatchFile
{
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$true, Position=1)]
        [string]$Path
    )

    $PathFile = Resolve-Path -Path $Path

    if ((Test-Path -Path $PathFile -PathType 'Leaf') -And (Confirm-IsLink -Source $PathFile -LinkType 'SymbolicLink'))
    {
        # Delete the requested link if it exists.
        $BackupPath = "${PathFile}.bkup"
        Remove-Item -Path $PathFile
        # Check for the existence of a backup and restore it.
        if (Test-Path -Path $BackupPath -PathType 'Leaf')
        {
            Move-Item -Path $BackupPath -Destination $PathFile
        }
    }
    elseif (Test-Path -Path $PathFile -PathType 'Container')
    {
        # We're in directory restore mode
        
    }
}