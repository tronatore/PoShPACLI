﻿Function Add-PVFile {

	<#
	.SYNOPSIS
	Stores a file, that is currently on your local computer, in a secure
	location in a Safe.

	.DESCRIPTION
	Exposes the PACLI Function: "STOREFILE"

	.PARAMETER vault
	The defined Vault name

	.PARAMETER user
	The Username of the authenticated User.

	.PARAMETER safe
	The name of the Safe where the file will be stored.

	.PARAMETER folder
	The folder in the Safe where the file will be stored.

	.PARAMETER file
	The name of the file as it will be stored in the Safe.

	.PARAMETER localFolder
	The location on the User's terminal where the file is currently
	located.

	.PARAMETER localFile
	The name of the file to be stored in the Vault as it is on the User’s
	terminal.

	.PARAMETER deleteMacros
	Delete macros from the file

	.PARAMETER sessionID
	The ID number of the session. Use this parameter when working
	with multiple scripts simultaneously. The default is ‘0’.

	.EXAMPLE
	Add-PVFile -vault Lab -user administrator -safe caTools -folder Root -file pacli.exe `
	-localFolder D:\PACLI -localFile pacli.exe

	Stores local file, pacli.exe in the caTools safe

	.NOTES
	AUTHOR: Pete Maan

	#>

	[CmdLetBinding()]
	param(

		[Parameter(
			Mandatory = $True,
			ValueFromPipelineByPropertyName = $True)]
		[string]$vault,

		[Parameter(
			Mandatory = $True,
			ValueFromPipelineByPropertyName = $True)]
		[string]$user,

		[Parameter(
			Mandatory = $True,
			ValueFromPipelineByPropertyName = $True)]
		[Alias("Safename")]
		[string]$safe,

		[Parameter(
			Mandatory = $True,
			ValueFromPipelineByPropertyName = $True)]
		[string]$folder,

		[Parameter(
			Mandatory = $True,
			ValueFromPipelineByPropertyName = $True)]
		[string]$file,

		[Parameter(
			Mandatory = $True,
			ValueFromPipelineByPropertyName = $True)]
		[string]$localFolder,

		[Parameter(
			Mandatory = $True,
			ValueFromPipelineByPropertyName = $True)]
		[string]$localFile,

		[Parameter(
			Mandatory = $False,
			ValueFromPipelineByPropertyName = $True)]
		[switch]$deleteMacros,

		[Parameter(
			Mandatory = $False,
			ValueFromPipelineByPropertyName = $True)]
		[int]$sessionID
	)

	PROCESS {

		$Return = Invoke-PACLICommand $Script:PV.ClientPath STOREFILE $($PSBoundParameters.getEnumerator() |
				ConvertTo-ParameterString)

		if($Return.ExitCode -eq 0) {

			Write-Verbose "Stored File $file in Safe $safe "
			[PSCustomObject] @{

				"vault"     = $vault
				"user"      = $user
				"sessionID" = $sessionID

			} | Add-ObjectDetail -TypeName pacli.PoShPACLI

		}

	}

}