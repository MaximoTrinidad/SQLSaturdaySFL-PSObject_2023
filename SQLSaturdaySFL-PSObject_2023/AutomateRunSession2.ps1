<#	
	.NOTES
	===========================================================================
	 Created with: 	SAPIEN Technologies, Inc., PowerShell Studio 2022 v5.8.213
	 Created on:   	3/27/2023 10:53 AM
	 Created by:   	max_t@hotmail.com
	 Organization: 	Teksystem, inc.
	 Filename:     	AutomateRunSession2.ps1
	===========================================================================
	.DESCRIPTION
		A description of the file.
#>


function Get-AutoPSSession2
{

	$Arglist = '-noexit', '-noprofile', {
	$execline = @'
$Host.ui.RawUI.WindowTitle= '*** [PSSession-SqlClientb] ***'
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
		
		## - Add list of funtions andd execute Script file:
		## -
		Get-HelloWorld1;
		Get-folderlist -enterfolder "C:\temp";
		Invoke-Item "C:\Temp\Folderlist.txt";
		
		. c:\SQLSaturdaySFL-PSObject_2023\Sample-SQLMethod1_SqlClientb.ps1;
		
		## - Comment the line below if you want this session prompt to remain open:
		#exit
};
Start-Process powershell -ArgumentList $Arglist;

};

Get-AutoPSSession2