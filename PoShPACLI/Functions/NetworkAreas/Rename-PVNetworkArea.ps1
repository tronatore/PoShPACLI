﻿Function Rename-PVNetworkArea {

	<#
	.SYNOPSIS
	Renames an existing Network Area.

	.DESCRIPTION
	Exposes the PACLI Function: "RENAMENETWORKAREA"

	.PARAMETER vault
	The defined Vault name

	.PARAMETER user
	The Username of the authenticated User.

	.PARAMETER networkArea
	The name of the Network Area.

	.PARAMETER newName
	The new name of the Network Area.

	.PARAMETER sessionID
	The ID number of the session. Use this parameter when working
	with multiple scripts simultaneously. The default is ‘0’.

	.EXAMPLE
	Rename-PVNetworkArea -vault lab -user administrator -networkArea All\EMEA -newName All\EU

	Renames network area EMEA to EU

	.NOTES
	AUTHOR: Pete Maan

	#>

	[CmdLetBinding()]
	[Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSShouldProcess", "", Justification = "ShouldProcess handling is in Invoke-PACLICommand")]
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
		[string]$networkArea,

		[Parameter(
			Mandatory = $True,
			ValueFromPipelineByPropertyName = $True)]
		[string]$newName,

		[Parameter(
			Mandatory = $False,
			ValueFromPipelineByPropertyName = $True)]
		[int]$sessionID
	)

	PROCESS {

		$Return = Invoke-PACLICommand $Script:PV.ClientPath RENAMENETWORKAREA $($PSBoundParameters.getEnumerator() |
				ConvertTo-ParameterString)

		if($Return.ExitCode -eq 0) {

			Write-Verbose "Network Area Renamed to $newName"

			[PSCustomObject] @{

				"vault"     = $vault
				"user"      = $user
				"sessionID" = $sessionID

			} | Add-ObjectDetail -TypeName pacli.PoShPACLI

		}

	}

}