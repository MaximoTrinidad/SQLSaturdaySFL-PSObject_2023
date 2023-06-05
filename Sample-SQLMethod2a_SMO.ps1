<#	
	.NOTES
	===========================================================================
	 Created with: 	SAPIEN Technologies, Inc., PowerShell Studio 2023 v5.8.222
	 Created on:   	5/30/2023 9:58 PM
	 Created by:   	max_trinidad@hotmail.com
	 Organization: 	On My Own...
	 Filename:     	Sample-SQLMethod2a_SMO.ps1
	===========================================================================
	.DESCRIPTION
		Sample-SQLMethod2a_SMO - Windows Authentication, using SMO through: SQLPS, SQLServer, or DBATools:
#>

## - 
## - Windows ASuthentication Sample:
## - 

$SQLServerName = 'MXINSPLAP01A';
$DatabaseName = 'AdventureWorksDW2019';

## - Sample T-SQL Queries:
## - 
$TSQLQuery1 = 'Select @@Version as FullVersion';

$TSQLQuery2 = @"
SELECT  [ProductKey]
      ,[DateKey]
      ,[MovementDate]
      ,[UnitCost]
      ,[UnitsIn]
      ,[UnitsOut]
      ,[UnitsBalance]
  FROM [AdventureWorksDW2019].[dbo].[FactProductInventory]
"@

## - Using SMO through: SQLPS, SQLServer, or DBATools:
## - Import-module to load SMO Assemblies:
## - 
Import-Module SqlServer;

## - Prepare connection to SQL Server - Windows Authentication:
## - 
$SQLSrvConn = `
new-object Microsoft.SqlServer.Management.Common.SqlConnectionInfo($SQLServerName);
$SQLSrvObj = new-object Microsoft.SqlServer.Management.Smo.Server($SQLSrvConn);

## - Exploring your main SQLSrvObj all data object properies:
## - 
write-Host "Display all data object properies:" -ForegroundColor Yellow;
$SQLSrvObj | get-member -MemberType Properties | Out-GridView;
Read-Host "Press Enter to continue";


## - Exploring the '.Information' .net object:
## -
$SQLSrvObj.Information | get-member | Out-GridView;
$SQLSrvObj.Information | get-member -MemberType Properties | Out-GridView;

## - Execute TSQLQuery1:
## - 
[array]$sqlResult1 = $null; $GetVersion = $null;
$global:sqlResult1 = $SQLSrvObj.Databases[$DatabaseName].ExecuteWithResults($TSQLQuery1);
$GetVersion = $global:sqlresult.tables.Rows;
Write-Host "My SQLServer Version is:=>[$($GetVersion.FullVersion.Split(' - ')[0])" -ForegroundColor Yellow;
Read-Host "Press Enter to continue";

$SQLSrvObj.Information | Select-Object Edition, HostPlatform, HostDistribution | Format-List;

## - Execute TSQLQuery2:
## - 
$global:sqlData = $null;
[array]$sqlResult2 = $null; $global:sqlData = $null;
$sqlResult2 = $SQLSrvObj.Databases[$DatabaseName].ExecuteWithResults($TSqlQuery2);
$global:sqlData = $sqlResult2.tables.Rows;

## - Check total of recorrds returned:
## - 
Write-Host "Total records in our data object:=> [$($global:sqlData.count)]" -ForegroundColor Yellow;
Read-Host "Press Enter to continue";

## - 
## - Expanding the data object with Customs Expression -> Adding a row column:
## - 




