<#	
	.NOTES
	===========================================================================
	 Created with: 	SAPIEN Technologies, Inc., PowerShell Studio 2023 v5.8.222
	 Created on:   	5/30/2023 9:58 PM
	 Created by:   	max_trinidad@hotmail.com
	 Organization: 	On My Own...
	 Filename:     	Sample-SQLMethod2b_SMO.ps1
	===========================================================================
	.DESCRIPTION
		Sample-SQLMethod2a_SMO - SQLServer Authentication, using SMO through: SQLPS, SQLServer, or DBATools:
#>

## - 
## - SQLServer Authentication Sample:
## - 
$UserId = 'sa';
$Password = '$SqlPwd01!';
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
"@;

## - Import-Module [SQLPS, SQLServer, or DBATools]to load SMO Assemblies:
## - 
Import-Module SqlServer;

## - Prepare connection to SQL Server - SQLServer Authentication:
## - 
$SQLSrvConn = `
new-object Microsoft.SqlServer.Management.Common.SqlConnectionInfo($SQLServerName, $UserId, $Password);
$SQLSrvObj = new-object Microsoft.SqlServer.Management.Smo.Server($SQLSrvConn);

## - Exploring your main SQLSrvObj all data object properies:
## - 
write-Host "Display all data object properies:" -ForegroundColor Yellow;
$SQLSrvObj  | get-member -MemberType Properties | Out-GridView;
Read-Host "Press Enter to continue";


## - Exploring the '.Information' .net object:
## -
$SQLSrvObj.Information | get-member | Out-GridView;
$SQLSrvObj.Information | get-member -MemberType Properties | Out-GridView;

## - Execute T-SQLQuery1:
## - 
[array]$sqlResult1 = $null; $GetVersion = $null;
$sqlResult1 = $SQLSrvObj.Databases[$DatabaseName].ExecuteWithResults($TSqlQuery1);
$GetVersion = $sqlResult1.tables.Rows;
Write-Host "My SQLServer Version is:=>[$($GetVersion.FullVersion.Split(' - ')[0])" -ForegroundColor Yellow;
Read-Host "Press Enter to continue";

$SQLSrvObj.Information | Select-Object Edition, HostPlatform, HostDistribution | Format-List;

## - Execute TSQLQuery2:
## - 
[array]$sqlResult2 = $null; $global:sqlData = $null;
$sqlResult2 = $SQLSrvObj.Databases[$DatabaseName].ExecuteWithResults($TSQLQuery2);
$global:sqlData = $sqlResult2.tables.Rows;

## - Check total of recorrds returned:
## - 
Write-Host "Total records in our data object:=> [$($global:sqlData.count)]" -ForegroundColor Yellow;
Read-Host "Press Enter to continue";

## - 
## - Expanding the data object with Customs Expression -> Adding a row column:
## - 



# Load the SMO assembly and create a Server object
[System.Reflection.Assembly]::LoadWithPartialName('Microsoft.SqlServer.SMO') | out-null
$server = New-Object ('Microsoft.SqlServer.Management.Smo.Server') $serverInstance



## - Set credentials for SQL Server Authentication:
$credential = Get-Credential
$server.ConnectionContext.LoginSecure = $false
$server.ConnectionContext.set_Login($credential.UserName)
$server.ConnectionContext.set_SecurePassword($credential.Password)

## Connect to the Server and get a few properties
$SQLSrvObj.Information | Select-Object Edition, HostPlatform, HostDistribution | Format-List

# Retrieve error logs since yesterday
$parameters = @{
	ServerInstance = $serverInstance
	Credential	   = $credential
	Since		   = 'Yesterday'
};
## - Prepare connection to SQL Server:
## - Windows Authentication:
$SQLSrvConn = `
new-object Microsoft.SqlServer.Management.Common.SqlConnectionInfo($SQLServerName);
## - SQLAuthentication:
#$SQLSrvConn = `
#new-object Microsoft.SqlServer.Management.Common.SqlConnectionInfo($SQLServerName, $SQLUserName, $SqlPwd);
$SQLSrvObj = new-object Microsoft.SqlServer.Management.Smo.Server($SQLSrvConn);

## - Sample T-SQL Queries:
$SqlQuery = 'Select @@Version as FullVersion';

## - Execute T-SQL Query:
[array]$result = $SQLSrvObj.Databases[$DatabaseName].ExecuteWithResults($SqlQuery);
$GetVersion = $result.tables.Rows;
## - Prepare connection to SQL Server:
## - Windows Authentication:
$SQLSrvConn = `
new-object Microsoft.SqlServer.Management.Common.SqlConnectionInfo($SQLServerName);
## - SQLAuthentication:
#$SQLSrvConn = `
#new-object Microsoft.SqlServer.Management.Common.SqlConnectionInfo($SQLServerName, $SqlUserID, $SqlPwd);
$SQLSrvObj = new-object Microsoft.SqlServer.Management.Smo.Server($SQLSrvConn);



## - Execute T-SQL Query:
[array]$result = $SQLSrvObj.Databases[$DatabaseName].ExecuteWithResults($SqlQuery);
$GetVersion = $result.tables.Rows;

## - 
## - Expanding the data object with Customs Expression -> Adding a row column:
## - 


