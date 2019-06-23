-- Delete objects

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_sys.content_sys.control]') AND parent_object_id = OBJECT_ID(N'[dbo].[sys.content]'))
ALTER TABLE [dbo].[sys.content] DROP CONSTRAINT [FK_sys.content_sys.control]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_sys.content_sys.page]') AND parent_object_id = OBJECT_ID(N'[dbo].[sys.content]'))
ALTER TABLE [dbo].[sys.content] DROP CONSTRAINT [FK_sys.content_sys.page]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_sys.content_sys.xsl]') AND parent_object_id = OBJECT_ID(N'[dbo].[sys.content]'))
ALTER TABLE [dbo].[sys.content] DROP CONSTRAINT [FK_sys.content_sys.xsl]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_sys.page_sys.page]') AND parent_object_id = OBJECT_ID(N'[dbo].[sys.page]'))
ALTER TABLE [dbo].[sys.page] DROP CONSTRAINT [FK_sys.page_sys.page]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_sys.page_sys.pagetype]') AND parent_object_id = OBJECT_ID(N'[dbo].[sys.page]'))
ALTER TABLE [dbo].[sys.page] DROP CONSTRAINT [FK_sys.page_sys.pagetype]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_sys.page_sys.template]') AND parent_object_id = OBJECT_ID(N'[dbo].[sys.page]'))
ALTER TABLE [dbo].[sys.page] DROP CONSTRAINT [FK_sys.page_sys.template]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_sys.control_sys.template]') AND parent_object_id = OBJECT_ID(N'[dbo].[sys.control]'))
ALTER TABLE [dbo].[sys.control] DROP CONSTRAINT [FK_sys.control_sys.template]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_sys.parameter_sys.content]') AND parent_object_id = OBJECT_ID(N'[dbo].[sys.parameter]'))
ALTER TABLE [dbo].[sys.parameter] DROP CONSTRAINT [FK_sys.parameter_sys.content]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_sys.datatype_sys.xsl]') AND parent_object_id = OBJECT_ID(N'[dbo].[sys.datatype]'))
ALTER TABLE [dbo].[sys.datatype] DROP CONSTRAINT [FK_sys.datatype_sys.xsl]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_sys.xsl_sys.datatype]') AND parent_object_id = OBJECT_ID(N'[dbo].[sys.xsl]'))
ALTER TABLE [dbo].[sys.xsl] DROP CONSTRAINT [FK_sys.xsl_sys.datatype]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sys.content]') AND type in (N'U'))
DROP TABLE [dbo].[sys.content]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sys.pagetype]') AND type in (N'U'))
DROP TABLE [dbo].[sys.pagetype]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sys.template]') AND type in (N'U'))
DROP TABLE [dbo].[sys.template]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sys.page]') AND type in (N'U'))
DROP TABLE [dbo].[sys.page]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sys.control]') AND type in (N'U'))
DROP TABLE [dbo].[sys.control]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sys.parameter]') AND type in (N'U'))
DROP TABLE [dbo].[sys.parameter]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sys.datatype]') AND type in (N'U'))
DROP TABLE [dbo].[sys.datatype]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sys.xsl]') AND type in (N'U'))
DROP TABLE [dbo].[sys.xsl]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sys.attachment]') AND type in (N'U'))
DROP TABLE [dbo].[sys.attachment]

-- Create objects

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sys.attachment]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[sys.attachment](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](100) NULL,
	[value] [varbinary](max) NULL,
	[description] [varchar](100) NULL,
	[filename] [varchar](100) NULL,
	[contenttype] [varchar](100) NULL,
 CONSTRAINT [PK_sys.attachment] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sys.template]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[sys.template](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[urlname] [varchar](50) NOT NULL,
 CONSTRAINT [PK_sys.template] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sys.pagetype]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[sys.pagetype](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[typename] [varchar](50) NOT NULL,
 CONSTRAINT [PK_sys.pagetype] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sys.page]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[sys.page](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](50) NOT NULL,
	[parentid] [int] NULL,
	[templateid] [int] NULL,
	[typeid] [int] NOT NULL,
	[visibility] [int] NULL,
 CONSTRAINT [PK_sys.page] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [IX_sys.page_1] UNIQUE NONCLUSTERED 
(
	[name] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sys.control]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[sys.control](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[templateid] [int] NOT NULL,
	[webcontrolid] [varchar](50) NOT NULL,
	[friendlyname] [varchar](50) NOT NULL,
 CONSTRAINT [PK_sys.control] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sys.content]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[sys.content](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[pageid] [int] NOT NULL,
	[controlid] [int] NOT NULL,
	[description] [varchar](500) NULL,
	[xslid] [int] NOT NULL,
	[query] [varchar](4000) NULL,
 CONSTRAINT [PK_sys.content] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sys.datatype]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[sys.datatype](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](50) NOT NULL,
	[defaultxslid] [int] NULL,
	[datatablename] [varchar](50) NULL,
	[schema] [xml] NOT NULL,
 CONSTRAINT [PK_sys.data] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sys.xsl]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[sys.xsl](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[friendlyname] [varchar](50) NOT NULL,
	[datatypeid] [int] NOT NULL,
	[xdata] [xml] NOT NULL,
 CONSTRAINT [PK_xsl] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sys.parameter]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[sys.parameter](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[contentid] [int] NOT NULL,
	[name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_sys.parameter] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_sys.page_sys.page]') AND parent_object_id = OBJECT_ID(N'[dbo].[sys.page]'))
ALTER TABLE [dbo].[sys.page]  WITH NOCHECK ADD  CONSTRAINT [FK_sys.page_sys.page] FOREIGN KEY([parentid])
REFERENCES [dbo].[sys.page] ([id])
GO
ALTER TABLE [dbo].[sys.page] CHECK CONSTRAINT [FK_sys.page_sys.page]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_sys.page_sys.pagetype]') AND parent_object_id = OBJECT_ID(N'[dbo].[sys.page]'))
ALTER TABLE [dbo].[sys.page]  WITH NOCHECK ADD  CONSTRAINT [FK_sys.page_sys.pagetype] FOREIGN KEY([typeid])
REFERENCES [dbo].[sys.pagetype] ([id])
GO
ALTER TABLE [dbo].[sys.page] CHECK CONSTRAINT [FK_sys.page_sys.pagetype]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_sys.page_sys.template]') AND parent_object_id = OBJECT_ID(N'[dbo].[sys.page]'))
ALTER TABLE [dbo].[sys.page]  WITH NOCHECK ADD  CONSTRAINT [FK_sys.page_sys.template] FOREIGN KEY([templateid])
REFERENCES [dbo].[sys.template] ([id])
GO
ALTER TABLE [dbo].[sys.page] CHECK CONSTRAINT [FK_sys.page_sys.template]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_sys.control_sys.template]') AND parent_object_id = OBJECT_ID(N'[dbo].[sys.control]'))
ALTER TABLE [dbo].[sys.control]  WITH NOCHECK ADD  CONSTRAINT [FK_sys.control_sys.template] FOREIGN KEY([templateid])
REFERENCES [dbo].[sys.template] ([id])
GO
ALTER TABLE [dbo].[sys.control] CHECK CONSTRAINT [FK_sys.control_sys.template]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_sys.content_sys.control]') AND parent_object_id = OBJECT_ID(N'[dbo].[sys.content]'))
ALTER TABLE [dbo].[sys.content]  WITH NOCHECK ADD  CONSTRAINT [FK_sys.content_sys.control] FOREIGN KEY([controlid])
REFERENCES [dbo].[sys.control] ([id])
GO
ALTER TABLE [dbo].[sys.content] CHECK CONSTRAINT [FK_sys.content_sys.control]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_sys.content_sys.page]') AND parent_object_id = OBJECT_ID(N'[dbo].[sys.content]'))
ALTER TABLE [dbo].[sys.content]  WITH NOCHECK ADD  CONSTRAINT [FK_sys.content_sys.page] FOREIGN KEY([pageid])
REFERENCES [dbo].[sys.page] ([id])
GO
ALTER TABLE [dbo].[sys.content] CHECK CONSTRAINT [FK_sys.content_sys.page]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_sys.content_sys.xsl]') AND parent_object_id = OBJECT_ID(N'[dbo].[sys.content]'))
ALTER TABLE [dbo].[sys.content]  WITH NOCHECK ADD  CONSTRAINT [FK_sys.content_sys.xsl] FOREIGN KEY([xslid])
REFERENCES [dbo].[sys.xsl] ([id])
GO
ALTER TABLE [dbo].[sys.content] CHECK CONSTRAINT [FK_sys.content_sys.xsl]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_sys.datatype_sys.xsl]') AND parent_object_id = OBJECT_ID(N'[dbo].[sys.datatype]'))
ALTER TABLE [dbo].[sys.datatype]  WITH CHECK ADD  CONSTRAINT [FK_sys.datatype_sys.xsl] FOREIGN KEY([defaultxslid])
REFERENCES [dbo].[sys.xsl] ([id])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_sys.xsl_sys.datatype]') AND parent_object_id = OBJECT_ID(N'[dbo].[sys.xsl]'))
ALTER TABLE [dbo].[sys.xsl]  WITH CHECK ADD  CONSTRAINT [FK_sys.xsl_sys.datatype] FOREIGN KEY([datatypeid])
REFERENCES [dbo].[sys.datatype] ([id])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_sys.parameter_sys.content]') AND parent_object_id = OBJECT_ID(N'[dbo].[sys.parameter]'))
ALTER TABLE [dbo].[sys.parameter]  WITH NOCHECK ADD  CONSTRAINT [FK_sys.parameter_sys.content] FOREIGN KEY([contentid])
REFERENCES [dbo].[sys.content] ([id])
GO
ALTER TABLE [dbo].[sys.parameter] CHECK CONSTRAINT [FK_sys.parameter_sys.content]
