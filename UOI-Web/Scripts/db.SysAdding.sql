-- AddTemplate

set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go

IF OBJECT_ID (N'dbo.AddTemplate', N'P') IS NOT NULL
    DROP Procedure dbo.AddTemplate;
GO

CREATE procedure dbo.AddTemplate (@UrlName varchar(50))
as

	insert into [sys.template] (urlname) values (@UrlName)
go

-- AddControl

set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go

IF OBJECT_ID (N'dbo.AddControl', N'P') IS NOT NULL
    DROP Procedure dbo.AddControl;
GO

CREATE procedure dbo.AddControl (@TemplateName varchar(50), @WebControlId varchar(50), @FriendlyName varchar(50))
as

	declare @templateId int
	select @templateId = id from [sys.template] where urlname = @TemplateName
	insert into [sys.control] (templateid, webcontrolid, friendlyname)
		values (@templateId, @WebControlId, @FriendlyName)
go

-- AddDataType

set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go

IF OBJECT_ID (N'dbo.AddDataType', N'P') IS NOT NULL
    DROP Procedure dbo.AddDataType;
GO

CREATE procedure dbo.AddDataType (@Name varchar(50), @XslFriendlyName varchar(50), @DataTableName varchar(50), @Schema xml)
as

	declare @xslId int
	select @xslId = id from [sys.xsl] where friendlyname = @XslFriendlyName
	insert into [sys.datatype] 
	([name], defaultxslid, datatablename, [schema]) 
	values (@Name, @xslId, @DataTableName, @Schema)
go

-- AddXsl

set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go

IF OBJECT_ID (N'dbo.AddXsl', N'P') IS NOT NULL
    DROP Procedure dbo.AddXsl;
GO

CREATE procedure dbo.AddXsl (@FriendlyName varchar(50), @DataTypeName varchar(50), @xData xml)
as

	declare @dataTypeId int
	select @dataTypeId = id from [sys.datatype] where [name] = @DataTypeName

	declare @id int
	set @id = (select top(1) id from [sys.xsl] where [friendlyname]=@FriendlyName)

	if @id is null
	begin
		insert into [sys.xsl] 
		(friendlyname, datatypeid, xdata) 
		values (@FriendlyName, @dataTypeId, @xData)
	end else
	begin
		update [sys.xsl]
		set
			[datatypeid] = @dataTypeId,
			[xdata] = @xData
		where id = @id
	end
go

-- AddPageType

set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go

IF OBJECT_ID (N'dbo.AddPageType', N'P') IS NOT NULL
    DROP Procedure dbo.AddPageType;
GO

CREATE procedure dbo.AddPageType (@TypeName varchar(50))
as

	insert into [sys.pagetype] (typename) values (@TypeName)
go

-- AddPage

set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go

IF OBJECT_ID (N'dbo.AddPage', N'P') IS NOT NULL
    DROP Procedure dbo.AddPage;
GO

CREATE procedure dbo.AddPage (@Name varchar(50), @ParentPage varchar(50), @ParentTemplate varchar(50), @TypeName varchar(50), @Visibility int)
as

	declare @parent int
	declare @pageTypeId int
	select @pageTypeId = id from [sys.pagetype] where typename = @TypeName
	if @pageTypeId is null return

	if @ParentPage is not null
	begin
		select @parent = id from [sys.page] where [name] = @ParentPage
		if @parent is null return

		insert into [sys.page]
		([name], parentid, templateid, typeid, visibility)
		values (@Name, @parent, null, @pageTypeId, @Visibility)
	end else
	begin
		select @parent = id from [sys.template] where [urlname] = @ParentTemplate
		if @parent is null return

		insert into [sys.page]
		([name], parentid, templateid, typeid, visibility)
		values (@Name, null, @parent, @pageTypeId, @Visibility)
	end
go

-- AddContent

set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go

IF OBJECT_ID (N'dbo.AddContent', N'P') IS NOT NULL
    DROP Procedure dbo.AddContent;
GO

CREATE procedure dbo.AddContent (@PageName varchar(50), @WebControlId varchar(50), @Description varchar(500), @XslFriendlyName varchar(50), @Query varchar(4000))
as

	declare @pageId int
	declare @templateId int
	declare @controlId int
	declare @xslId int
	
	select @templateId = dbo.TemplateOFPage(@PageName)
	select @controlId = id from [sys.control] 
	where 
		(templateid = @templateId) and
		(webcontrolid = @WebControlId)
	select @pageID = id from [sys.page] where [name] = @PageName
	select @xslId = id from [sys.xsl] where [friendlyname] = @XslFriendlyName

	insert into [sys.content] (pageid, controlid, description, xslid, query)
	values (@pageId, @controlId, @Description, @xslId, @Query)
go

-- AddParameter

set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go

IF OBJECT_ID (N'dbo.AddParameter', N'P') IS NOT NULL
    DROP Procedure dbo.AddParameter;
GO

CREATE procedure dbo.AddParameter (@PageName varchar(50), @WebControlId varchar(50),@Name varchar(50))
as

	declare @pageId int
	declare @templateId int
	declare @controlId int
	declare @contentId int
	
	select @templateId = dbo.TemplateOFPage(@PageName)
	select @controlId = id from [sys.control] 
	where 
		(templateid = @templateId) and
		(webcontrolid = @WebControlId)
	select @pageID = id from [sys.page] where [name] = @PageName
	select @contentId = id from [sys.content] 
	where 
		(pageid = @pageId) and
		(controlid = @controlId)

	insert into [sys.parameter] (contentid, [name])
		values (@contentId, @Name)
go
