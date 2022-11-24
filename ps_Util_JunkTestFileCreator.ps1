#########################################
#
# Generate junk test files
#
# MVogwell - Nov 2022 - v1.1
#
#

[CmdletBinding()]
param (
	[Parameter(Mandatory=$true)][int]$JunkFileSizeMB,
	[Parameter(Mandatory=$false)][string]$JunkFileName
)

$ErrorActionPreference = "Stop"

Write-Output "`n`nJunk file creator - can be used for baseline network copy tests - v1.1 - MVogwell - Nov 2022`n`n"

[int]$iJunkFileSize = $JunkFileSizeMB

# If the size has not been entered by the script arguments
if($iJunkFileSize -le 0) {
	Do {
		Try {
			[int]$iJunkFileSize = read-host "Enter the size of the junk file (as a number in MB)"
		}
		Catch {
			[int]$iJunkFileSize = 0

			Write-Output "`t--- That's not a valid number!! Try again..."
		}
	} While ($iJunkFileSize -le 0)
}

# Convert the size from MB to bytes
$iJunkFileSizeBytes = $iJunkFileSize * 1024 * 1024

# Set the file path
Write-Output "*** Creating file $sDestFile at $iJunkFileSize MB"

if([string]::IsNullOrEmpty($JunkFileName)) {
	$sDestFile = $PSScriptRoot + "\JunkTestFile_" + $iJunkFileSize + "MB.txt"
}
else {
	$sDestFile = $JunkFileName
}

# Make sure the file can be created before continuing
Try {
	$bFileValid = $True
	$null = New-Item $sDestFile -ItemType "File" -Force
}
Catch {
	$sErrMsg = ("It has not been possible to create the junk file. Error: " + $Error[0].Exception.Message)

	$bFileValid = $False

	Write-Output "`t--- $sErrMsg `n"
}

# If the file path is valid then generate the contents of the file
if ($bFileValid) {
	Try {
		Write-Output "`t=== Start time: $(Get-Date -Format "HH:mm:ss"). Please wait..."

		$stream = [System.IO.StreamWriter]::new( $sDestFile )

		Do {
			$stream.writeline("11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111	1111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111	1111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111	111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111")
		} While ((get-item $sDestFile).length -lt $iJunkFileSizeBytes )

		Write-Output "`t`t+++ Complete"
		Write-Output "`t`t+++ End time: $(Get-Date -Format "HH:mm:ss")`n"
	}
	Catch {
		$sErrMsg = ("It has not been possible to create the file. Error: " + $Error[0].Exception.Message)
		Write-Output "`t`t--- $sErrMsg"
	}
	Finally {
		$stream.close()
	}
}