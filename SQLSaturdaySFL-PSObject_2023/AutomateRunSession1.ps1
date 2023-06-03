<#	
	.NOTES
	===========================================================================
	 Created with: 	SAPIEN Technologies, Inc., PowerShell Studio 2022 v5.8.213
	 Created on:   	3/27/2023 10:53 AM
	 Created by:   	max_t@hotmail.com
	 Organization: 	Teksystem, inc.
	 Filename:     	AutomateRunSession1.ps1
	===========================================================================
	.DESCRIPTION
		A description of the file.
#>


function Get-AutoPSSession1
{

	$Arglist = '-noexit', '-noprofile', {
	$execline = @'
$Host.ui.RawUI.WindowTitle= '*** [POSHSession-SQLMethod1_SqlClienta] ***'
'@;
		Invoke-Expression $execline; Read-Host "Press Enter to continue!";
		function Get-HelloWorld1
		{
			param ()
			Write-Host "Hello World"
		};
		
		function Get-folderlist
		{
			param (
				$enterfolder
			)
			Get-ChildItem -Path $enterfolder | Out-File -FilePath "C:\Temp\Folderlist.txt";
			
		};
## - add list of funtions:
	Get-HelloWorld1
	Get-folderlist -enterfolder "C:\temp"
	Invoke-Item "C:\Temp\Folderlist.txt";
	. c:\SQLSaturdaySFL\Sample-SQLMethod1_SqlClienta.ps1;
	
	exit
};
Start-Process powershell -ArgumentList $Arglist;
	exit
};

