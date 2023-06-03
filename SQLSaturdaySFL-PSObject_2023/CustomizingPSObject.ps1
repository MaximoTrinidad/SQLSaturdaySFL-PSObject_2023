<#	
	.NOTES
	===========================================================================
	 Created with: 	SAPIEN Technologies, Inc., PowerShell Studio 2023 v5.8.222
	 Created on:   	6/2/2023 10:33 AM
	 Created by:   	max_t@hotmail.com
	 Organization: 	On My Own...
	 Filename:     	CustomizingPSObject.ps1
	===========================================================================
	.DESCRIPTION
			CustomizingPSObject
#>

## - 
## - Method1 - custom expressions:
## - 

## - Formatting the row column:
$row.tostring("[0000000]")

## - Sample of adding a custom expression for row column - structure:
@{ l = 'row'; e = { "[" + $global:row.tostring("D") + "]"; ++$global:row }; }, "...[<Add more properties>]...";

## - Working wih your PS Data Object:
## -
$global:row = 0;
$global:sqlData | Select-Object -first 3 @{ l = 'row'; e = { "[" + $global:row.tostring("D") + "]"; ++$global:row }; }, *;

## - Some variations:
## - 1
$global:row = 0;
$($global:sqlData | Select-Object -first 3 @{ l = 'row'; e = { "[" + $global:row.tostring("D") + "]"; ++$global:row }; }, *;) | Out-GridView;

## - 2
$global:row = 0; $global:myNewDataObj= $null;
$global:myNewDataObj = $global:sqlData | Select-Object -first 3 @{ l = 'row'; e = { "[" + $global:row.tostring("D") + "]"; ++$global:row }; }, *;
$global:myNewDataObj | Out-GridView;

## - ********************************************************************************************************************************************
## - As you will notice...                                                                                                                    ***
## - ***  Only when using the 'System.Data.SqlClient' .NET Namespace.. gives you extra columns with the Data object!                          ***
## - ***  USE THE Get-Member cmdlet to explore the object and identfy which properties you want to display, then rebuild the PSObject again!  ***
## - ********************************************************************************************************************************************

$global:sqlData | get-member -MemberType Properties;
## - resultS:
#		DateKey
#		MovementDate
#		ProductKey
#		UnitCost
#		UnitsBalance
#		UnitsIn
#		UnitsOut

## - 3 (First 100 data rows)
$global:row = 0; $global:myNewDataObj = $null;
$global:myNewDataObj = $global:sqlData | Select-Object -first 100 @{ l = 'Row'; e = { "[" + $global:row.tostring("D") + "]"; ++$global:row }; }, DateKey, MovementDate, ProductKey, UnitCost, UnitsBalance, UnitsIn, UnitsOut;
$global:myNewDataObj | Out-GridView


## - 
## - Method2 - Adding new columns using 'Add-Member':
## - 

## - backup oiginal PS Data object:
## - 
$myNewDataObj_Original = $global:myNewDataObj;


## - Using the foreach to inject the new properties:
$i = 0; [string]$Process_Date = $((get-date).ToString('MM/dd/yyyy - hh:mm:ss tt'))
foreach ($r in $global:myNewDataObj)
{
	## - The following Add-member adds a property to the main PSObject:
	$r | Add-Member -NotePropertyName "Systemname" -NotePropertyValue $env:COMPUTERNAME;
	$r | Add-Member -NotePropertyName "Username" -NotePropertyValue $env:UserNAME;
	$r | Add-Member -NotePropertyName "Process_Date" -NotePropertyValue $Process_Date;
		
	## - Below code will show the progress bar:
	$percomplete = ($i / $myNewDataObj.count) * 100
	Write-Progress -Activity "Counting $i times" -PercentComplete $percomplete;
	++$i;
	
};

## - Shoold Display including added properties:
## - 
$myNewDataObj | get-member -MemberType *prop*;

## - Check data results with new property fields:
## - 

## - Format-table will truncate th result displayed:
$myNewDataObj | Format-Table;

## - limiting the # of records with the use of the 'Format-list' Cmdlet works:
$myNewDataObj | Select-Object -first 3 | Format-List;

## - for better data displayed use the 'Out-Gridview' Cmdlet:
$myNewDataObj | Out-GridView;
