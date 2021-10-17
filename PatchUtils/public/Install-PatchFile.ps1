function Install-PatchFile
{
<#PSScriptInfo

.VERSION 1.0

.GUID 2a962657-11e4-41b6-a514-2bf7c0fac9a5

.AUTHOR chrisdalrymple

.COMPANYNAME

.COPYRIGHT

.TAGS

.LICENSEURI

.PROJECTURI

.ICONURI

.EXTERNALMODULEDEPENDENCIES 

.REQUIREDSCRIPTS

.EXTERNALSCRIPTDEPENDENCIES

.RELEASENOTES


.PRIVATEDATA

#>

<# 

.DESCRIPTION 
 "Check script level variable scope." 

#> 
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$true, Position=1)]
        [ValidateScript({Test-Path -Path $_ -PathType 'Leaf'})]
        [string]$PatchPath,
        [Parameter(Mandatory=$true, Position=2)]
        [ValidateScript({Test-Path -Path $_ -PathType 'Container'})]
        [string]$DestPath
    )

    # Translate parameters into absolute paths
    $SourceFile = Resolve-Path -Path $PatchPath
    $Destination = Resolve-Path -Path $DestPath

    # If same file exists in destination directory, rename it to $filename.bkup
    $PatchFileName = Split-Path -Path $SourceFile -Leaf
    $OriginalFilePath = Join-Path -Path $Destination -ChildPath $PatchFileName
    Backup-InstallationFile -Path $OriginalFilePath

    # Create a symlink to the patch file in the destination directory, if it doesn't already exist
    if (-Not (Test-Path -Path $OriginalFilePath -PathType 'Leaf'))
    {
        New-Item -Path $OriginalFilePath -ItemType SymbolicLink -Value $SourceFile
    }
    else
    {
        Write-Warning -Message "File or link already exists at $OriginalFilePath"
    }
}
