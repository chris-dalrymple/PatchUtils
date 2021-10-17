Function Remove-PatchFile
{

<#PSScriptInfo

.VERSION 1.0

.GUID 4ba554d2-f056-4d23-a047-d0fbc8a191d2

.AUTHOR chrisdalrymple

.DESCRIPTION
"Remove links associated with installed patch files and restore backed-up originals."

#>

    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$true, Position=1)]
        [string]$Path
    )

    $PathFile = Resolve-Path -Path $Path

    if ((Test-Path -Path $PathFile -PathType 'Leaf') -And (Confirm-IsLink -Path $PathFile -LinkType 'SymbolicLink'))
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
        # Are there any backup files present in this directory? If not, we're done.
        $BackupFiles = Get-ChildItem -Path (Join-Path -Path $PathFile -ChildPath *) -Include "*.bkup"

        if (($BackupFiles).Count -gt 0)
        {
            foreach ($file in $BackupFiles) 
            {
                $TargetFile = Join-Path -Path $PathFile -ChildPath ($file -split ".bkup")[0]
                if ((Test-Path -Path $TargetFile -PathType 'Leaf') -And (Confirm-IsLink -Path $TargetFile -LinkType 'SymbolicLink'))
                {
                    Remove-Item -Path $TargetFile
                    Move-Item -Path $file -Destination $TargetFile
                }
                elseif (-Not (Test-Path -Path $TargetFile -PathType 'Leaf'))
                {
                    Move-Item -Path $file -Destination $TargetFile
                }
                else
                {
                    Write-Warning -Message "Skipping restoration of \'$file\'. Target \'$TargetFile\' exists and is not a link."    
                }
            }
        }
    }
}