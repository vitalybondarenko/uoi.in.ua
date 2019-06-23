-- LoadXml

set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go

IF OBJECT_ID (N'dbo.LoadXml', N'P') IS NOT NULL
    DROP Procedure dbo.LoadXml;
GO

CREATE procedure dbo.LoadXml (@FileName nvarchar(200), @return_xml xml output)
as
declare @query nvarchar(1000)
declare @param nvarchar(200)

set @param = '@xmlExec xml OUTPUT'

set @query = 'select @xmlExec = (select a.bulkcolumn from openrowset(bulk ''' + @FileName + ''', single_blob) as a)'
	
exec sp_executesql @query, @param, @xmlExec=@return_xml OUTPUT
go

-- LoadXml_Path

set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go

IF OBJECT_ID (N'dbo.LoadXml_Path', N'P') IS NOT NULL
    DROP Procedure dbo.LoadXml_Path;
GO

CREATE procedure dbo.LoadXml_Path (@FileName nvarchar(200), @return_xml xml output)
as
declare @query nvarchar(1000)
declare @param nvarchar(200)

set @param = '@xmlExec xml OUTPUT'

set @query = (select top(1) [value] from [temp.data] where [key]='path')
set @FileName = @query + '\' + @FileName
set @query = 'select @xmlExec = (select a.bulkcolumn from openrowset(bulk ''' + @FileName + ''', single_blob) as a)'
	
exec sp_executesql @query, @param, @xmlExec=@return_xml OUTPUT
go

-- LoadAtt

set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go

IF OBJECT_ID (N'dbo.LoadAtt', N'P') IS NOT NULL
    DROP Procedure dbo.LoadAtt;
GO

CREATE procedure dbo.LoadAtt (@FileName nvarchar(200), @return_att varbinary(max) output)
as
declare @query nvarchar(1000)
declare @param nvarchar(200)

set @param = '@attExec varbinary(max) OUTPUT'

set @query = 'select @attExec = (select a.bulkcolumn from openrowset(bulk ''' + @FileName + ''', single_blob) as a)'
	
exec sp_executesql @query, @param, @attExec=@return_att OUTPUT
go

-- LoadAtt_Path

set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go

IF OBJECT_ID (N'dbo.LoadAtt_Path', N'P') IS NOT NULL
    DROP Procedure dbo.LoadAtt_Path;
GO

CREATE procedure dbo.LoadAtt_Path (@FileName nvarchar(250), @return_att varbinary(max) output)
as
declare @query nvarchar(1000)
declare @param nvarchar(200)

set @param = '@attExec varbinary(max) OUTPUT'

set @query = (select top(1) [value] from [temp.data] where [key]='path')
set @FileName = @query + '\' + @FileName
set @query = 'select @attExec = (select a.bulkcolumn from openrowset(bulk ''' + @FileName + ''', single_blob) as a)'
	
exec sp_executesql @query, @param, @attExec=@return_att OUTPUT
go

-- UpdateEntity

set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go

IF OBJECT_ID (N'dbo.UpdateEntity', N'P') IS NOT NULL
    DROP Procedure dbo.UpdateEntity;
GO

CREATE procedure dbo.UpdateEntity (@Type nvarchar(50), @NewXml xml)
as
declare @name nvarchar(50)
declare @id int
declare @query nvarchar(1000)

set @name = @NewXml.value('/*[1]/@name','nvarchar(50)')
if (@name='' or @name is null)
	return

set @query = 'select @out_id = id from [' + @Type + '] where xdata.exist(''/*[1][@name = "' + @name + '"]'')=1'
exec sp_executesql @query, N'@out_id int OUTPUT', @out_id = @id OUTPUT

if @id is null
begin
	set @query = 'insert into [' + @Type + '](xdata) values (@updXml)'
	exec sp_executesql @query, N'@updXml xml', @updXml = @NewXml
end else
begin
	set @query = 'update [' + @Type + '] set xdata = @updXml where id = @upd_id'
	exec sp_executesql @query, N'@updXml xml, @upd_id int', @updXml = @NewXml, @upd_id = @id
end

go

-- UpdateAtt

set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go

IF OBJECT_ID (N'dbo.UpdateAtt', N'P') IS NOT NULL
    DROP Procedure dbo.UpdateAtt;
GO

CREATE procedure dbo.UpdateAtt (@Name varchar(50), @Value varbinary(max), @Description varchar(100), @FileName varchar(250), @ContentType varchar(100))
as
declare @id int
set @id = (select top(1) id from [sys.attachment] where [name]=@Name)

if @id is null
begin
	insert into [sys.attachment] ([name], [value], [description], [filename], [contenttype])
	values (@Name, @Value, @Description, @FileName, @ContentType)
end else
begin
	update [sys.attachment]
	set
		[name] = @Name,
		[value] = @Value,
		[description] = @Description,
		[filename] = @FileName,
		[contenttype] = @ContentType
	where id = @id
end

go

-- UpdateEntityFromFile

set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go

IF OBJECT_ID (N'dbo.UpdateEntityFromFile', N'P') IS NOT NULL
    DROP Procedure dbo.UpdateEntityFromFile;
GO

CREATE procedure dbo.UpdateEntityFromFile (@Type nvarchar(50), @FileName nvarchar(200))
as

declare @xml xml
exec LoadXml @FileName, @return_xml = @xml output
exec UpdateEntity @Type, @xml

go

-- UpdateEntityFromFile_Path

set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go

IF OBJECT_ID (N'dbo.UpdateEntityFromFile_Path', N'P') IS NOT NULL
    DROP Procedure dbo.UpdateEntityFromFile_Path;
GO

CREATE procedure dbo.UpdateEntityFromFile_Path (@Type nvarchar(50), @FileName nvarchar(250))
as

declare @xml xml
exec LoadXml_Path @FileName, @return_xml = @xml output
exec UpdateEntity @Type, @xml

go

-- UpdateAttFromFile

set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go

IF OBJECT_ID (N'dbo.UpdateAttFromFile', N'P') IS NOT NULL
    DROP Procedure dbo.UpdateAttFromFile;
GO

CREATE procedure dbo.UpdateAttFromFile (@Name varchar(50), @AttFileName varchar(250), @Description varchar(100), @FileName varchar(250), @ContentType varchar(100))
as

	declare @Value varbinary(max)
	exec LoadAtt @AttFileName, @return_att = @Value output
	exec UpdateAtt @Name, @Value, @Description, @FileName, @ContentType

go

-- UpdateAttFromFile_Path

set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go

IF OBJECT_ID (N'dbo.UpdateAttFromFile_Path', N'P') IS NOT NULL
    DROP Procedure dbo.UpdateAttFromFile_Path;
GO

CREATE procedure dbo.UpdateAttFromFile_Path (@Name varchar(50), @AttFileName varchar(250), @Description varchar(100), @FileName varchar(250), @ContentType varchar(100))
as

	declare @Value varbinary(max)
	exec LoadAtt_Path @AttFileName, @return_att = @Value output
	exec UpdateAtt @Name, @Value, @Description, @FileName, @ContentType

go

-- UpdateEntityTable

set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go

IF OBJECT_ID (N'dbo.UpdateEntityTable', N'P') IS NOT NULL
    DROP Procedure dbo.UpdateEntityTable;
GO

CREATE procedure dbo.UpdateEntityTable (@Type nvarchar(50))
as
declare @query nvarchar(1000)

-- check table
set @query = 'IF OBJECT_ID (N''dbo.' + @Type + ''', N''u'') IS NOT NULL DROP Table dbo.[' + @Type + ']'
exec (@query)

-- create table
set @query = 'CREATE Table dbo.[' + @Type + '] (id int PRIMARY KEY identity(1,1), xdata xml NOT NULL)'
exec (@query)

-- create primary index
set @query = 'create primary xml index idx_xdata on dbo.[' + @Type + '](xdata)'
exec (@query)

declare @prefix nvarchar(100)
declare @sufix nvarchar(100)
set @prefix = 'create xml index idx_xdata_'
set @sufix = ' on dbo.[' + @Type + '](xdata) using xml index idx_xdata FOR '

-- create path index
set @query = 'path'
set @query = @prefix + @query + @sufix + @query
exec (@query)

-- create property index
set @query = 'property'
set @query = @prefix + @query + @sufix + @query
exec (@query)

-- create value index
set @query = 'value'
set @query = @prefix + @query + @sufix + @query
exec (@query)

go
