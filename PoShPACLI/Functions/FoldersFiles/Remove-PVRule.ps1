﻿Function Remove-PVRule {

	<#
	.SYNOPSIS
	Deletes a service rule

	.DESCRIPTION
	Exposes the PACLI Function: "DELETERULE"

	.PARAMETER vault
	The defined Vault name

	.PARAMETER user
	The Username of the authenticated User.

	.PARAMETER ruleID
	The unique ID of the rule to delete.

	.PARAMETER userName
	The user who will be affected by the rule.

	.PARAMETER safeName
	The Safe where the rule is applied.

	.PARAMETER fullObjectName
	The file, password, or folder that the rule applies to.

	.PARAMETER isFolder
	Whether the rule applies to files and passwords or for folders.
		NO – Indicates files and passwords
		YES – Indicates folders

	.PARAMETER sessionID
	The ID number of the session. Use this parameter when working
	with multiple scripts simultaneously. The default is ‘0’.

	.EXAMPLE
	Remove-PVRule -vault Lab -user administrator -ruleID 15 -userName kenny -safeName IDM `
	-fullObjectName root\IDMPass -isFolder:$false

	Deletes OLAC rule 15 from object

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
		[string]$ruleID,

		[Parameter(
			Mandatory = $True,
			ValueFromPipelineByPropertyName = $True)]
		[string]$userName,

		[Parameter(
			Mandatory = $True,
			ValueFromPipelineByPropertyName = $True)]
		[string]$safeName,

		[Parameter(
			Mandatory = $True,
			ValueFromPipelineByPropertyName = $True)]
		[string]$fullObjectName,

		[Parameter(
			Mandatory = $False,
			ValueFromPipelineByPropertyName = $True)]
		[switch]$isFolder,

		[Parameter(
			Mandatory = $False,
			ValueFromPipelineByPropertyName = $True)]
		[int]$sessionID
	)

	PROCESS {

		$Return = Invoke-PACLICommand $Script:PV.ClientPath DELETERULE $($PSBoundParameters.getEnumerator() |
				ConvertTo-ParameterString -donotQuote ruleID)

		if($Return.ExitCode -eq 0) {

			Write-Verbose "Rule $RuleID Deleted"

			[PSCustomObject] @{

				"vault"     = $vault
				"user"      = $user
				"sessionID" = $sessionID

			} | Add-ObjectDetail -TypeName pacli.PoShPACLI

		}

	}

}