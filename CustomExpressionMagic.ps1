<#	
	.NOTES
	===========================================================================
	 Created with: 	SAPIEN Technologies, Inc., PowerShell Studio 2022 v5.8.213
	 Created on:   	5/30/2023 9:58 PM
	 Created by:   	max_trinidad@hotmail.com	 Organization: 	
	 Filename:     	CustomExpressionMagic.ps1
	===========================================================================
	.DESCRIPTION
		Custom Expression Magic
(See blog post: http://www.maxtblog.com/2023/03/powershell-psobjects-think-outside-the-box/)
#>


## - Working with my Windows files:
$myWindowsFilesList = $null;
$myWindowsFilesList = dir c:\Windows -Recurse -ErrorVariable flerr;
$myWindowsFilesList.count
$flerr | Get-Member;

$flerr[50 .. 54].exception.message
$myWindowsFilesList[20 .. 25]
$myWindowsfilesList[163300 .. 163315] | Select-Object name, mode, lastwritetime, length;



## - adding a custom row column structure:
@{ l = 'row'; e = { "[" + $global:row.tostring("D") + "]"; ++$global:row }; }, "...[<Add more properties>]...";


$global:cnt = 0;
$myWindowsfilesList[0 .. 25] `
| select @{ l = 'row'; e = { "[" + $global:row.tostring("D") + "]"; ++$global:row }; }, name, mode, lastwritetime, length `
| Format-Table;


$cnt = 0;
$myWindowsfilesList[163300 .. 163315] `
| Select-Object @{ l = 'row'; e = { $global:row.tostring("[0000000]"); ++$global:row }; }, name, mode, lastwritetime, length `
| Format-Table;


$global:row = 0
$myWindowsfilesList[163300 .. 163315] `
| Select-Object @{ l = 'row'; e = { $global:row.tostring("[0000000]"); ++$global:row }; }, name, mode, lastwritetime, length `
| Format-Table;

## -
## - Adding two new column:
## - 
$flerr = $null;
$myWindowsFilesList = dir c:\Windows -Recurse -ErrorVariable flerr -ErrorAction SilentlyContinue;
$myWindowsFilesList.count;

## - to preserve row column as part of the data PSobject: 
$myWindowsFilesList = dir c:\Windows -Recurse -ErrorVariable flerr -ErrorAction SilentlyContinue;
$row = 0; $myNewWindowsfilesList = $null;
$myNewWindowsfilesList = $myWindowsfilesList `
| Select-Object @{ l = 'row'; e = { $global:row.tostring("[0000000]"); ++$global:row }; }, name, mode, lastwritetime, length;

## - verify the 'Row' column has been added:
$myNewWindowsfilesList | Get-Member -MemberType Properties;

## - list a small range of rows:
$myNewWindowsfilesList[1633.. 1645] | Format-Table;

## -
## - Adding two new column:
## - 
$i = 0;
foreach ($r in $myNewWindowsfilesList)
{
	## - The following Add-member adds a property to the main PSObject:
	$r | Add-Member -NotePropertyName "Systemname" -NotePropertyValue $env:COMPUTERNAME;
	$r | Add-Member -NotePropertyName "Username" -NotePropertyValue $env:UserNAME;
	
	## - Below code will show the progress bar:
	$percomplete = ($i / $myNewWindowsfilesList.count) * 100
	Write-Progress -Activity "Counting $i times" -PercentComplete $percomplete;
	++$i;
	
};

## - list PSObject properties with the new two columns:
$myNewWindowsfilesList | Get-Member -MemberType Properties;
$myNewWindowsfilesList[16339 .. 16345] | Format-Table

## - 
## - BONUS - Check how many errors were saved, list a few of the messages
## -
$flerr.count
$flerr[50 .. 54].exception.message

## - 
## - To prevent displaying exception in the console add the parameter ' -ErrorAction SilentlyContinue':
## -
$flerr = $null;
$myWindowsFilesList = dir c:\Windows -Recurse -ErrorVariable flerr -ErrorAction SilentlyContinue;
$flerr.count
