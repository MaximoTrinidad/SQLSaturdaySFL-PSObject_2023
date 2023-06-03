<#	
	.NOTES
	===========================================================================
	 Created with: 	SAPIEN Technologies, Inc., PowerShell Studio 2023 v5.8.222
	 Created on:   	5/27/2023 9:58 PM
	 Created by:   	max_t@hotmail.com
	 Organization: 	On My Own...
	 Filename:     	sample-SQLMethod1_SqlClientb.ps1
	===========================================================================
	.DESCRIPTION
			Sample-SQLMethod1_SqlClientb - SQLServer Authentication.
			.net -> System.Data.SqlClient.
#>

## - 
## - SQLServer Authentication Sample:
## - 
Write-Host "SQLServer Authentication Sample`r`n" -ForegroundColor Yellow;
Read-Host "Press Enter to continue";

## - Initializing credentials and SQL/db Instance:
## - 
$UserId = 'sa';
$Password = '$SqlPwd01!';
$SQLServerName = 'MXINSPLAP01A';
$DatabaseName = 'AdventureWorksDW2019'

Write-Host "Initializing credentials and SQL/db Instance:`r`n" -ForegroundColor Yellow;
Read-Host "Press Enter to continue";

$TSQLQuery = @"
SELECT  [ProductKey]
      ,[DateKey]
      ,[MovementDate]
      ,[UnitCost]
      ,[UnitsIn]
      ,[UnitsOut]
      ,[UnitsBalance]
  FROM [AdventureWorksDW2019].[dbo].[FactProductInventory]
"@
write-host "T-SQL query to build PS SQLData Object: `r`n $($TSQLquery)`r`n" -ForegroundColor cyan;
Read-Host "Press Enter to continue";

## - Connection Settings:
## - 
$SqlconnString = $null; $sqlconn = $null;
$SqlconnString = "Server=$SQLServerName; Database=$DatabaseName; timeout=65535; User Id=$UserId ;Password=$Password";
$sqlconn = New-Object System.Data.SqlClient.SqlConnection($SqlconnString);
write-host "Getting connected to SQLServer via SQLClient...`r`n" -ForegroundColor yellow;
Read-Host "Press Enter to continue";

## - Execute TSQLQuery:
## - 
$global:sqlData = $null; $sqladapter = $null; $sqldatatable = $null;
$sqladapter = New-Object System.Data.SqlClient.SqlDataAdapter($TSQLQUery, $sqlconn);
$sqldatatable = New-Object System.Data.DataTable;
$sqladapter.Fill($sqldatatable);
$global:sqlData = $sqldatatable.Rows;
$sqlconn.Close();
Write-Host "Execute TSQLQuery to build data object... `r`n" -ForegroundColor Yellow;
Read-Host "Press Enter to continue";

## - Total of records pulled from the table:
## - 
Write-Host "Total records in our data object:=> [$($global:sqlData.count)]" -ForegroundColor Yellow;
Read-Host "`r`nTotal Record count... `r`n";

## - 
## - Exploring your data object:
## - 

## - Display the type of the data object:
Write-Host "Display the type of the data object:`r`n[$($global:sqlData.gettype().Name)]" -ForegroundColor Yellow;
Read-Host "Press Enter to continue";

## - Display all data object properies:
write-Host "Display all data object properies:" -ForegroundColor Yellow;
$global:sqlData| get-member -MemberType Properties | ogv;
Read-Host "Press Enter to continue";

## - Display data in powerShell data object:
Write-Host "Display data in powerShell data object:" -ForegroundColor Yellow;
$global:sqlData| Select-Object -First 10  | Out-GridView;
Read-Host "Press Enter to continue";

## - 
## - Expanding the data object with Customs Expression -> Adding a row column:
## - 


