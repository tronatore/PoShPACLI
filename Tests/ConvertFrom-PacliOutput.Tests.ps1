#Get Current Directory
$Here = Split-Path -Parent $MyInvocation.MyCommand.Path

#Get Function Name
$FunctionName = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -Replace ".Tests.ps1"

#Assume ModuleName from Repository Root folder
$ModuleName = Split-Path (Split-Path $Here -Parent) -Leaf

#Resolve Path to Module Directory
$ModulePath = Resolve-Path "$Here\..\$ModuleName"

#Define Path to Module Manifest
$ManifestPath = Join-Path "$ModulePath" "$ModuleName.psd1"

#Preference file must be removed and module must be re-imported for tests to complete
Remove-Item -Path "$env:HOMEDRIVE$env:HomePath\PV_Configuration.xml" -Force -ErrorAction SilentlyContinue
Remove-Module -Name $ModuleName -Force -ErrorAction SilentlyContinue
Import-Module -Name "$ManifestPath"  -ArgumentList $true -Force -ErrorAction Stop

BeforeAll {

	#$Script:RequestBody = $null

}

AfterAll {

	#$Script:RequestBody = $null

}

Describe $FunctionName {

	InModuleScope $ModuleName {

		Context "Mandatory Parameters" {

			$Parameters = @{Parameter = 'pacliOutput'}

			It "specifies parameter <Parameter> as mandatory" -TestCases $Parameters {

				param($Parameter)

				(Get-Command ConvertFrom-PacliOutput).Parameters["$Parameter"].Attributes.Mandatory | Should Be $true

			}



		}

		Context "Default" {

			BeforeEach {

				$InputObj = '"TestValue","YES","Mon Mar 25 01:45:00 2013","NO","14","\","19","0","NO","704","YES","NO","NO","NO","Quote"Test"'

			}

			It "executes without exception" {

				{$InputObj | ConvertFrom-PacliOutput} | Should Not throw

			}

			It "outputs array" {

				($InputObj | ConvertFrom-PacliOutput).gettype() | Select-Object -ExpandProperty BaseType | Should Be "Array"

			}

			It "outputs array with expected length" {

				($InputObj | ConvertFrom-PacliOutput).length | Should Be 15

			}

		}

	}

}