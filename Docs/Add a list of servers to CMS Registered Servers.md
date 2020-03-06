# Add a list of servers to CMS Registered Servers

This script will add SqlServer1 and SqlServer2 to the "Some group that I've already created" group.  This group must already exist.  This is generally inspired by https://sqladm.blogspot.com/2009/06/central-registrered-servers.html.  This link has much more information about registered servers and groups.

```SQL

declare @ServerGroupName sysname = 'Backup migration from DB_Backups_LOB'
declare @ServerGroupId int = (select server_group_id from msdb.dbo.sysmanagement_shared_server_groups where name = @ServerGroupName)
declare @ServerId int = NULL   -- This is for the output parameter to sp_sysmanagement_add_shared_registered_server

declare @Servers table (ServerName sysname not null)
insert into @Servers 
	values 
         ('SqlServer1')
        ,('SqlServer2')


declare @ServerName sysname = (select min(ServerName) from @Servers)	

while (@ServerName is not null) begin 

	print @ServerName 
	exec msdb.dbo.sp_sysmanagement_add_shared_registered_server
		 @name            = @ServerName
		,@server_name     = @ServerName
		,@server_group_id = @ServerGroupId
		,@server_type     = 0
		,@server_id       = @ServerId output

	set @ServerName = (select min(ServerName) from @Servers where ServerName > @ServerName )
end
```
