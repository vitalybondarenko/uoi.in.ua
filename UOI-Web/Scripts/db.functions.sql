-- EntityCol

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID (N'dbo.EntityCol', N'tf') IS NOT NULL
    DROP Function dbo.EntityCol;
GO

CREATE FUNCTION dbo.EntityCol (@Name nvarchar(50))
RETURNS @T TABLE
  (
     [coll] xml
  )
AS

BEGIN

if @name='uoi'
	insert @t select xdata from dbo.uoi 
	
	else if @name='ioi'
	insert @t select xdata from dbo.ioi  
	
	else if @name='camp'
	insert @t select xdata from dbo.camp
	
	else if @name='union'
	insert @t select xdata from dbo.[union]
	
	else if @name='team'
	insert @t select xdata from dbo.team
	
	else if @name='person'
	insert @t select xdata from dbo.person
	
	else if @name='interview'
	insert @t select xdata from dbo.interview
	
	else if @name='article'
	insert @t select xdata from dbo.article
	
	else if @name='news'
	insert @t select xdata from dbo.news
	
	else if @name='literature'
	insert @t select xdata from dbo.literature
	
	else if @name='topic'
	insert @t select xdata from dbo.topic
	
	else if @name='links'
	insert @t select xdata from dbo.links
	
	else if @name='menu'
	insert @t select xdata from dbo.menu
	
	else if @name='text'
	insert @t select xdata from dbo.[text]

	else if @name='deliveries'
	insert @t select xdata from dbo.[deliveries]

	else if @name='about'
	insert @t select xdata from dbo.[about]

	else if @name='headerimage'
	insert @t select xdata from dbo.[headerimage]

RETURN
END


GO
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF

-- Entity

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID (N'dbo.Entity', N'fn') IS NOT NULL
    DROP Function dbo.Entity;
GO

CREATE FUNCTION dbo.[Entity] (@Type nvarchar(50), @Name nvarchar(50)) RETURNS xml
AS

BEGIN

declare @xml xml

select @xml = (select top(1) coll from dbo.EntityCol(@Type) where coll.exist('/*[@name= 

sql:variable("@Name") ]')=1)

return @xml
END

GO
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF

-- ViewAttachment

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID (N'dbo.ViewAttachment', N'tf') IS NOT NULL
    DROP Function dbo.ViewAttachment;
GO

CREATE FUNCTION dbo.ViewAttachment ()
RETURNS @T TABLE
  (
     at_Id int, at_Name varchar(50), at_Value varbinary(max), at_Description varchar(100), at_FileName varchar(250), at_ContentType varchar(100)
  )
AS

BEGIN

	insert @t select 
		id as at_id, 
		[name] as at_name,
		[value] as at_value,
		[description] as at_description,
		[filename] as at_filename,
		[contenttype] as at_contenttype
	from [sys.attachment]

RETURN
END


GO
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF

-- ViewContent

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID (N'dbo.ViewContent', N'tf') IS NOT NULL
    DROP Function dbo.ViewContent;
GO

CREATE FUNCTION dbo.ViewContent ()
RETURNS @T TABLE
  (
     ct_Id int, pg_Name varchar(50), cl_WebControlId varchar(50), ct_Description varchar(500), xs_FriendlyName varchar(50), cl_Query varchar(4000)
  )
AS

BEGIN

	insert @t select 
		[sys.content].id as ct_id, 
		[sys.page].[name] as pg_name,
		[sys.control].webcontrolid as cl_webcontrolid,
		[sys.content].description as ct_description,
		[sys.xsl].friendlyname as xs_friendlyname,
		[sys.content].query as ct_query
	from [sys.page], [sys.content], [sys.control], [sys.xsl]
	where 
		([sys.content].pageid = [sys.page].id) and
		([sys.content].controlid = [sys.control].id) and
		([sys.content].xslid = [sys.xsl].id)

RETURN
END
GO

-- ViewControl

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID (N'dbo.ViewControl', N'tf') IS NOT NULL
    DROP Function dbo.ViewControl;
GO

CREATE FUNCTION dbo.ViewControl ()
RETURNS @T TABLE
  (
     cl_Id int, tm_UrlName varchar(50), cl_WebControlId varchar(50), cl_FriendlyName varchar(50)
  )
AS

BEGIN

	insert @t select 
		[sys.control].id as cl_id, 
		[sys.template].urlname as tm_urlname,
		[sys.control].webcontrolid as cl_webcontrolid, 
		[sys.control].friendlyname as cl_friendlyname
	from [sys.template], [sys.control] where [sys.template].id=[sys.control].templateid
	
RETURN
END
GO

-- ViewDataType

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID (N'dbo.ViewDataType', N'tf') IS NOT NULL
    DROP Function dbo.ViewDataType;
GO

CREATE FUNCTION dbo.ViewDataType ()
RETURNS @T TABLE
  (
     dt_Id int, dt_Name varchar(50), dt_DefaultXslId varchar(50), dt_DataTableName varchar(50), dt_schema xml
  )
AS

BEGIN

	insert @t 
	select 
		[sys.datatype].id as dt_id,
		[sys.datatype].[name] as dt_name,
		[sys.datatype].defaultxslid as dt_defaultxslid,
		[sys.datatype].datatablename as dt_datatablename,
		[sys.datatype].[schema] as dt_schema
	from [sys.datatype]

RETURN
END
GO

-- ViewPage

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID (N'dbo.ViewPage', N'tf') IS NOT NULL
    DROP Function dbo.ViewPage;
GO

CREATE FUNCTION dbo.ViewPage ()
RETURNS @T TABLE
  (
     pg_Id int, pg_Name varchar(50), pg_ParentId int, tm_Id int, pt_TypeName varchar(50), pg_Visibility int
  )
AS

BEGIN

	insert @t select 
		[sys.page].id as pg_id, 
		[sys.page].[name] as pg_name,
		[sys.page].parentid as pg_parentid,
		[sys.page].templateid as tm_id,
		[sys.pagetype].typename as pt_typename,
		[sys.page].visibility as pg_visibility
	from [sys.page], [sys.pagetype]
	where [sys.page].typeid = [sys.pagetype].id

RETURN
END
GO

-- ViewPageType

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID (N'dbo.ViewPageType', N'tf') IS NOT NULL
    DROP Function dbo.ViewPageType;
GO

CREATE FUNCTION dbo.ViewPageType ()
RETURNS @T TABLE
  (
     pt_Id int, pt_TypeName varchar(50)
  )
AS

BEGIN

	insert @t select id as pt_id, typename as pt_typename from [sys.pagetype]
	

RETURN
END
GO

-- ViewParameter

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID (N'dbo.ViewParameter', N'tf') IS NOT NULL
    DROP Function dbo.ViewParameter;
GO

CREATE FUNCTION dbo.ViewParameter ()
RETURNS @T TABLE
  (
     pr_Id int, pg_Name varchar(50), cl_WebControlId varchar(50), pr_Name varchar(50)
  )
AS

BEGIN

	insert @t 
	select 
		[sys.parameter].id as pr_Id,
		[sys.page].[name] as pg_name,
		[sys.control].webcontrolid as cl_webcontrolid,
		[sys.parameter].[name] as pr_name
	from [sys.control], [sys.content], [sys.parameter], [sys.page]
	where 
		([sys.parameter].contentid = [sys.content].id) and
		([sys.content].pageid = [sys.page].id) and
		([sys.content].controlid = [sys.control].id)
	

RETURN
END
GO

-- ViewTemplate

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID (N'dbo.ViewTemplate', N'tf') IS NOT NULL
    DROP Function dbo.ViewTemplate;
GO

CREATE FUNCTION dbo.ViewTemplate ()
RETURNS @T TABLE
  (
     tm_Id int, tm_UrlName varchar(50)
  )
AS

BEGIN

	insert @t select id as tm_id, urlname as tm_urlname from [sys.template]
	

RETURN
END
GO

-- ViewXsl

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID (N'dbo.ViewXsl', N'tf') IS NOT NULL
    DROP Function dbo.ViewXsl;
GO

CREATE FUNCTION dbo.ViewXsl ()
RETURNS @T TABLE
  (
     xs_Id int, xs_FriendlyName varchar(50), dt_Name varchar(50), xs_xData xml
  )
AS

BEGIN

	insert @t 
	select 
		[sys.xsl].id as xs_id,
		[sys.xsl].friendlyname as xs_friendlyname,
		[sys.datatype].[name] as dt_name,
		[sys.xsl].xdata as xs_xdata
	from [sys.xsl], [sys.datatype]
	where 
		([sys.xsl].datatypeid = [sys.datatype].id)

RETURN
END
GO

-- TemplateOfPage

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID (N'dbo.TemplateOfPage', N'fn') IS NOT NULL
    DROP Function dbo.TemplateOfPage;
GO

CREATE FUNCTION [dbo].[TemplateOfPage] (@Name nvarchar(50)) RETURNS int
AS

BEGIN

declare @id int
declare @pageType varchar(50)
	
	select @pageType = [sys.pagetype].typename 
	from [sys.page], [sys.pagetype] 
	where 
		([sys.page].[name] = @Name) and
		([sys.page].[typeid] = [sys.pagetype].[id])

	if @pageType = 'TemplateLink'
	begin
		select @id = templateid 
		from [sys.page]
		where 
			([name] = @name)
	end else
	begin
		select @id = parentid 
		from [sys.page]
		where 
			([name] = @name)
		declare @parentName varchar(50)
		select @parentName = [name] from [sys.page] where id = @id
		select @id = dbo.TemplateOfPage(@parentName)
	end
	return @id
END
GO
