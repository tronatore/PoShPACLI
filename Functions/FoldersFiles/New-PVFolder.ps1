﻿Function New-PVFolder {

	<#
    .SYNOPSIS
    	Adds a folder to the specified Safe.

    .DESCRIPTION
    	Exposes the PACLI Function: "ADDFOLDER"

    .PARAMETER vault
        The name of the Vault to which to add a folder.

    .PARAMETER user
        The Username of the User who is carrying out the task.

    .PARAMETER safe
        The name of the Safe to which to add the folder.

    .PARAMETER folder
        The name of the new folder.

    .PARAMETER sessionID
    	The ID number of the session. Use this parameter when working
        with multiple scripts simultaneously. The default is ‘0’.

    .EXAMPLE
    	New-PVFolder -vault lab -user administrator -safe Reports -folder Root\AuditReports\2017

		Adds folder "2017" to the AuditReports folder under the Root location in safe "Reports"
    .NOTES
    	AUTHOR: Pete Maan
    	LASTEDIT: August 2017
    #>

	[CmdLetBinding(SupportsShouldProcess)]
	param(
		[Parameter(Mandatory = $True)][string]$vault,
		[Parameter(Mandatory = $True)][string]$user,
		[Parameter(Mandatory = $True)][string]$safe,
		[Parameter(Mandatory = $True)][string]$folder,
		[Parameter(Mandatory = $False)][int]$sessionID
	)

	If(!(Test-PACLI)) {

		#$pacli variable not set or not a valid path

	}

	Else {

		#$PACLI variable set to executable path

		$Return = Invoke-PACLICommand $pacli ADDFOLDER $($PSBoundParameters.getEnumerator() | ConvertTo-ParameterString)

		if($Return.ExitCode) {

			Write-Error $Return.StdErr

		}

		elseif($Return.ExitCode -eq 0) {

			Write-Verbose "Folder $folder Created"

		}

	}

}