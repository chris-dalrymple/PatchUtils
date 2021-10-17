Function Backup-InstallationFile
{
    param (
        [Parameter(Mandatory=$true, Position=1)]
        [string] $Path
    )

    # If file exists, rename with the .bkup extension, unless backup already exists
    $BackupTarget = $Path + ".bkup"
    if ((Test-Path -Path $Path -PathType 'Leaf') -and -not (Test-Path -Path $BackupTarget -PathType 'Leaf'))
    {
        Move-Item -Path $Path -Destination $BackupTarget
    }
}