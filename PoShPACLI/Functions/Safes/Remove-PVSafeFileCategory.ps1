﻿Function Remove-PVSafeFileCategory {

	<#
    .SYNOPSIS
    Deletes a File Category at Safe level.

    .DESCRIPTION
    Exposes the PACLI Function: "DELETESAFEFILECATEGORY"

    .PARAMETER vault
    The defined Vault name

    .PARAMETER user
    The Username of the authenticated User.

    .PARAMETER safe
    The Safe where the File Categories is defined.

    .PARAMETER category
	The name of the File Category to delete.

    .PARAMETER sessionID
	The ID number of the session. Use this parameter when working
	with multiple scripts simultaneously. The default is ‘0’.

    .EXAMPLE
	Remove-PVSafeFileCategory -vault lab -user administrator -safe EU_Infra -category CISOcat1

	Deletes CISOcat1 file category from EU_Infra safe

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
			Mandatory = $False,
			ValueFromPipelineByPropertyName = $True)]
		[String]$safe,

		[Parameter(
			Mandatory = $True,
			ValueFromPipelineByPropertyName = $True)]
		[Alias("CategoryName")]
		[string]$category,

		[Parameter(
			Mandatory = $False,
			ValueFromPipelineByPropertyName = $True)]
		[int]$sessionID
	)

	PROCESS {

		$Return = Invoke-PACLICommand $Script:PV.ClientPath DELETESAFEFILECATEGORY $($PSBoundParameters.getEnumerator() |
				ConvertTo-ParameterString)

		if($Return.ExitCode -eq 0) {

			Write-Verbose "Deleted Safe File Category $category"

			[PSCustomObject] @{

				"vault"     = $vault
				"user"      = $user
				"sessionID" = $sessionID

			} | Add-ObjectDetail -TypeName pacli.PoShPACLI

		}

	}

}