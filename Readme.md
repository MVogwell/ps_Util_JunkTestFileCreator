## ps_Util_JunkTestFileCreator

MVogwell - 01-03-18 - v1.0

## Synopsis

This is a powershell script to create a text file of a specific MB size. 

Parameters:

-JunkFileSizeMB	= Optional. Integer. The size of the junk file to create in MB

-JunkFileName	= Optional. String. Set a custom file name (otherwise JunkTestFile_<size>MB.txt will be used)
	
## Motivation

I'm using this to create custom sized files for network bandwidth testing over SMB


## Installation / Running the function

	This script does not need installing but needs to be run from a folder that is writable for the user running it.	

	Open Powershell and run the script. It may be necessary to change the Powershell ExeceutionPolicy. See https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.security/set-executionpolicy?view=powershell-6

	The junk file will be created in the same folder as the script is located.

	The JunkFileSizeMB parameter should be entered as an integer

	The JunkFileName should be a file name (e.g. Junk.txt)

## Examples
	.\ps_Util_JunkTestFileCreator.ps1
		This will run the script which will then ask for the file size. The output will be located in the same folder as the script and named JunkTestFile_<size>MB.txt

	.\ps_Util_JunkTestFileCreator.ps1 -JunkFileSizeMB 1
		This will create a file 1MB in size called JunkTestFile_1MB.txt in the same folder as the script.

	.\ps_Util_JunkTestFileCreator.ps1 -JunkFileSizeMB 1 -JunkFileName Junk.txt
		This will create a file 1MB in size called Junk.txt in the same folder as the script.
	
## License
	Free to use, change, and distribute. 

## Disclaimer

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

