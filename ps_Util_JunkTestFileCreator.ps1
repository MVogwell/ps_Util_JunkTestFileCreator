#########################################
#
# Generate junk test files
#
# MVogwell - March 2018
#
#

[CmdletBinding()]
param (
	[Parameter(Mandatory=$false)][int]$JunkFileSizeMB = 0,
	[Parameter(Mandatory=$false)][string]$JunkFileName = ""
)

$ErrorActionPreference = "Stop"

Function Test-StringIsValidFileName() {
	param (
		[Parameter(Mandatory=$true)][string]$sFileName	
	)
	
	# Check the string doesn't contain characters which are invalid in a Windows file name.
	if($sFileName -match '\\|\"|\/|\?|\:|\||\<|\>') {
		return $False	# Not a valid file name
	}
	Else {
		return $True	# A valid file name
	}
}

[int]$iJunkFileSize = $JunkFileSizeMB

write-host ""
write-host ""
write-host "Junk file creator - can be used for baseline network copy tests" -fore green

write-host ""

# If the size has not been entered by the script arguments
if($iJunkFileSize -eq 0) {
	Try {
		[int]$iJunkFileSize = read-host "Enter the size of the junk file (as a number in MB)"
	}
	Catch [ArgumentTransformationMetadataException] {
		write-host "That's not a number!! Try again"
		write-host
		write-output $Error[0] | select -property * | fl	
	}
	Catch {
		write-host "Something bad happened! Quiting..."
		write-host
		write-output $Error[0] | select -property * | fl
	}
	Finally {}
}

if(($iJunkFileSize -lt 1) -or ($iJunkFileSize -gt 3027)) {
	write-host "Unable to create the file. The Junk File Size much be between 1 and 3027"
}
Else {
	$iJunkFileSizeBytes = $iJunkFileSize * 1024 * 1024 # Convert the size from MB to bytes

	# Set the file path
	if($JunkFileName.length -eq 0) {
		$bFileNameValid = $True
		$sDestFile = $PSScriptRoot + "\JunkTestFile_" + $iJunkFileSize + "MB.txt"
	}
	Else {
		$bFileNameValid = Test-StringIsValidFileName -sFileName $JunkFileName
		if($bFileNameValid){ 
			$sDestFile = $PSScriptRoot + "\" + $JunkFileName
		}
		else {
			write-host 'You have an entered an invalid file name. File names cannot contain the characters " \ / | < > ? :' -fore red -back white
			write-host "Please try again..." -fore red -back white
			write-host ""
		}
	}

	if($bFileNameValid) {
		# Make sure the file can be created before continuing
		Try {
			$bFileValid = $True
			New-Item $sDestFile -ItemType "file" -Force | out-null
		}
		Catch {
			$bFileValid = $False
			write-host "It has not been possible to create the junk file" -fore red -back white
			write-host "Check the following path is writable:" -fore red -back white
			write-host $sDestFile -fore red -back white
			write-host ""
			write-output $Error[0] | select -property * | fl
			write-host ""
			write-host ""
		}
		Finally {}
		
		# If the file path is valid then generate the contents of the file
		Try {
			if($bFileValid) {
				
				write-host "Creating file $sDestFile at $iJunkFileSize MB" -fore yellow			
				write-host "Start time: $(get-date)"
				
				$stream = [System.IO.StreamWriter]::new( $sDestFile )
			
				Do {
					$stream.writeline("11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111	1111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111	1111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111	111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111")
					}
				While ((get-item $sDestFile).length -lt $iJunkFileSizeBytes )
				
				write-host ""
				write-host ""
				write-host "End time: $(get-date)"
				write-host "Complete" -fore green
				
				
				write-host ""
				write-host ""	
			}
		}
		Catch {
			write-host ""
			write-host "It has not been possible to create the file: "
			write-host ""
			write-output $Error[0] | select -property * | fl
		}
		Finally {
			$stream.close()
		}

	}
}
