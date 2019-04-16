
# Backup databases with criteria

```sql
-- This script will keep on truckin' even after a backup fails.  If you want it to stop on the first failure
-- you will need to use try/catch logic to trap the error

set nocount on

declare
     @BackupPath nvarchar(max) = 'D:\Backups'
    ,@DateTime nvarchar(max)   = convert(nvarchar, getdate(), 20)
    --  You can rearrange the following. Just don't omit ## variables.  If you create a ## variable you will also need 
    --  to add the logic below that replaces the variable (see all of the "set @SqlCmd = replace"
    --  statements below)
    ,@FileFormat nvarchar(max) = '''#BackupPath#\#DatabaseName#-#UserName#-#DateTime#.bak'''
    -- The following will either Execute or Print the output SqlCmd.  The check below is for PRINT so
    -- You could use anything other than PRINT to execute
    ,@ExecOrPrint varchar(5)   = 'Print'

    set @DateTime = replace(@DateTime, '-', '')
    set @DateTime = replace(@DateTime, ':', '')
    set @DateTime = replace(@DateTime, ' ', '_')

declare @Databases TABLE (DatabaseName sysname NOT NULL)
insert into @Databases(DatabaseName)
--  This actually sets the criteria for the backup. The example below will get all non-system online databases
    select name from sys.databases where databasepropertyex(name, 'STATUS') = 'online' and name not in ('master','model','msdb', 'tempdb')

declare @DatabaseName sysname = (select min(DatabaseName) from @Databases)

while (@DatabaseName is not null) begin
    declare @SqlCmd nvarchar(MAX) = ('backup database #DatabaseName# to disk=' + @FileFormat)

    set @SqlCmd = replace (@SqlCmd, '#DatabaseName#', @DatabaseName)
    set @SqlCmd = replace (@SqlCmd, '#BackupPath#',   @BackupPath)
    set @SqlCmd = replace (@SqlCmd, '#UserName#',     suser_sname())
    set @SqlCmd = replace (@SqlCmd, '#DateTime#',     @DateTime)

    if (@ExecOrPrint = 'PRINT') begin
        print @SqlCmd
    end else begin
        exec (@SqlCmd)
    end

    set @DatabaseName = (select min(DatabaseName) from @Databases where DatabaseName > @DatabaseName)
end
```