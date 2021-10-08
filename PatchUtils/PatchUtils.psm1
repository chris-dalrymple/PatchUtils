#Get public and private function definition files.
$Public  = @( Get-ChildItem -Path $PSScriptRoot\Public\*.ps1 -ErrorAction SilentlyContinue )
$Private = @( Get-ChildItem -Path $PSScriptRoot\Private\*.ps1 -ErrorAction SilentlyContinue )

#Dot source the files
Foreach($import in @($Public + $Private))
{
    Try
    {
        . $import.fullname
    }
    Catch
    {
        Write-Error -Message "Failed to import function $($import.fullname): $_"
    }
}

# Here I might...
# Read in or create an initial config file and variable
# Export Public functions ($Public.BaseName) for WIP modules
# Set variables visible to the module and its functions only

#region load module variables
# $PoshSdkConfig = [Ordered]@{
#     PsdkDir = Join-Path -Path ([System.Environment]::GetFolderPath('UserProfile')) -ChildPath '.posh_sdkman'
#     AutoAnswer = $false
#     AutoUpdate = $false
#     IsInitialized = $false
#     Service = 'https://api.sdkman.io'
#     BroadcastService = 'https://api.sdkman.io/2'
#     BaseVersion = '1.3.13'

#     MetaPath = $null
#     CandidatesPath = $null
#     BroadcastPath = $null
#     ApiVersionPath = $null
#     ArchivesPath = $null
#     TempPath = $null

#     ApiNewVersion = $false
#     NewVersion = $false
#     VersionPath = Join-Path -Path $PSScriptRoot -ChildPath "VERSION.txt"
#     VersionService = $null

#     Available = $true
#     Online = $true
#     ForceOffline = $false
#     Candidates = $null
#     FirstRun = $true

#     UnzipOnPath = $false
# }
# New-Variable -Name PoshSdkConfig -Value $PoshSdkConfig -Scope Script -Force

# $PoshSdkConfig.MetaPath = Join-Path -Path $PoshSdkConfig.PsdkDir -ChildPath '.meta'
# $PoshSdkConfig.CandidatesPath = Join-Path -Path $PoshSdkConfig.MetaPath -ChildPath 'candidates.txt'
# $PoshSdkConfig.BroadcastPath = Join-Path -Path $PoshSdkConfig.MetaPath -ChildPath 'broadcast.txt'
# $PoshSdkConfig.ApiVersionPath = Join-Path -Path $PoshSdkConfig.MetaPath -ChildPath 'version.txt'
# $PoshSdkConfig.ArchivesPath = Join-Path -Path $PoshSdkConfig.MetaPath -ChildPath 'archives'
# $PoshSdkConfig.TempPath = Join-Path -Path $PoshSdkConfig.MetaPath -ChildPath 'tmp'
#endregion load module variables



Export-ModuleMember -Function $Public.Basename