Function Backup-InstallationFile
{
    param (
        [Parameter(Mandatory=$true, Position=1)]
        [string] $Target
    )

    # If file exists, rename with the .bkup extension, unless backup already exists
    $BackupTarget = $Target + ".bkup"
    if ((Test-Path -Path $Target -PathType 'Leaf') -and -not (Test-Path -Path $BackupTarget -PathType 'Leaf'))
    {
        Move-Item -Path $Target -Destination $BackupTarget
    }
}