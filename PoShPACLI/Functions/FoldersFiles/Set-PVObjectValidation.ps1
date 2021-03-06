﻿Function Set-PVObjectValidation {

	<#
	.SYNOPSIS
	Validates a file in a Safe that requires content validation before
	users can access the objects in it.

	.DESCRIPTION
	Exposes the PACLI Function: "VALIDATEOBJECT"

	.PARAMETER vault
	The defined Vault name

	.PARAMETER user
	The Username of the authenticated User.

	.PARAMETER safe
	The name of the Safe in which the file is stored.

	.PARAMETER folder
	The name of the folder in which the file is stored.

	.PARAMETER object
	The name of the file to validate.

	.PARAMETER internalName
	The internal name of the file version to validate

	.PARAMETER validationAction
	The type of validation action that take place.
	Possible values are:
		VALID
		INVALID
		PENDING

	.PARAMETER reason
	The reason for validating the file.

	.PARAMETER sessionID
	The ID number of the session. Use this parameter when working
	with multiple scripts simultaneously. The default is ‘0’.

	.EXAMPLE
	Set-PVObjectValidation -vault lab -user administrator -safe Prod_Env -folder root -object Oracle-sys `
	-internalName 000000000000011 -validationAction INVALID -reason OK -sessionID 0

	Marks specified version of Oracle-sys in Prod_Env as INVALID.

	.NOTES
	AUTHOR: Pete Maan

	#>

	[CmdLetBinding(SupportsShouldProcess)]
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
		[Alias("Safename")]
		[string]$safe,

		[Parameter(
			Mandatory = $True,
			ValueFromPipelineByPropertyName = $True)]
		[string]$folder,

		[Parameter(
			Mandatory = $True,
			ValueFromPipelineByPropertyName = $True)]
		[string]$object,

		[Parameter(
			Mandatory = $True,
			ValueFromPipelineByPropertyName = $True)]
		[string]$internalName,

		[Parameter(
			Mandatory = $True,
			ValueFromPipelineByPropertyName = $True)]
		[ValidateSet("VALID", "INVALID", "PENDING")]
		[string]$validationAction,

		[Parameter(
			Mandatory = $True,
			ValueFromPipelineByPropertyName = $True)]
		[string]$reason,

		[Parameter(
			Mandatory = $False,
			ValueFromPipelineByPropertyName = $True)]
		[int]$sessionID
	)

	PROCESS {

		$Return = Invoke-PACLICommand $Script:PV.ClientPath VALIDATEOBJECT $($PSBoundParameters.getEnumerator() |
				ConvertTo-ParameterString -donotQuote validationAction)

		if($Return.ExitCode -eq 0) {

			Write-Verbose "File $file Marked as $ValidationAction"

			[PSCustomObject] @{

				"vault"     = $vault
				"user"      = $user
				"sessionID" = $sessionID

			} | Add-ObjectDetail -TypeName pacli.PoShPACLI

		}

	}

}