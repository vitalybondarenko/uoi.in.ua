-- templatepage1

declare @query varchar(1000)
set @query = 'select dbo.Entity(''menu'', ''materials'')'
exec AddContent 'templatepage1', 'Left', 'it is left menu', 'left menu', @query
GO

declare @query varchar(4000)
set @query = 'declare @uoi xml set @uoi = (select coll.value(''uoi[1]/@name'',''varchar(50)'') as [year], coll.value(''uoi[1]/@type'',''varchar(50)'') as [type], coll.value(''uoi[1]/@link'',''varchar(50)'') as [link] from EntityCol(''uoi'') order by [year] for xml raw(''uoi''), root(''alluoi'')) declare @ioi xml set @ioi = (select coll.value(''ioi[1]/@name'',''varchar(50)'') as [year], coll.value(''ioi[1]/@type'',''varchar(50)'') as [type], coll.value(''ioi[1]/@link'',''varchar(50)'') as [link] from EntityCol(''ioi'') order by [year] for xml raw(''ioi''), root(''allioi'')) declare @union xml set @union = (select coll.value(''union[1]/@name'',''varchar(50)'') as [year], coll.value(''union[1]/@link'',''varchar(50)'') as [link] from EntityCol(''union'') order by [year] for xml raw(''union''), root(''allunion'')) declare @camp xml set @camp = (select coll.value(''camp[1]/@name'',''varchar(50)'') as [year], coll.value(''camp[1]/@type'',''varchar(50)'') as [type], coll.value(''camp[1]/@link'',''varchar(50)'') as [link] from EntityCol(''camp'') order by [year] for xml raw(''camp''), root(''allcamp'')) declare @xml xml select @xml=(select @uoi, @ioi, @camp, @union for xml raw(''contests'')) select @xml'
exec AddContent 'templatepage1', 'Right', 'it is right menu', 'right menu', @query
GO

-- templatepage2

declare @query varchar(1000)
set @query = 'select dbo.Entity(''menu'', ''materials'')'
exec AddContent 'templatepage2', 'Left', 'it is left menu', 'left menu', @query
GO

declare @query varchar(4000)
set @query = 'declare @uoi xml set @uoi = (select coll.value(''uoi[1]/@name'',''varchar(50)'') as [year], coll.value(''uoi[1]/@type'',''varchar(50)'') as [type], coll.value(''uoi[1]/@link'',''varchar(50)'') as [link] from EntityCol(''uoi'') order by [year] for xml raw(''uoi''), root(''alluoi'')) declare @ioi xml set @ioi = (select coll.value(''ioi[1]/@name'',''varchar(50)'') as [year], coll.value(''ioi[1]/@type'',''varchar(50)'') as [type], coll.value(''ioi[1]/@link'',''varchar(50)'') as [link] from EntityCol(''ioi'') order by [year] for xml raw(''ioi''), root(''allioi'')) declare @union xml set @union = (select coll.value(''union[1]/@name'',''varchar(50)'') as [year], coll.value(''union[1]/@link'',''varchar(50)'') as [link] from EntityCol(''union'') order by [year] for xml raw(''union''), root(''allunion'')) declare @camp xml set @camp = (select coll.value(''camp[1]/@name'',''varchar(50)'') as [year], coll.value(''camp[1]/@type'',''varchar(50)'') as [type], coll.value(''camp[1]/@link'',''varchar(50)'') as [link] from EntityCol(''camp'') order by [year] for xml raw(''camp''), root(''allcamp'')) declare @xml xml select @xml=(select @uoi, @ioi, @camp, @union for xml raw(''contests'')) select @xml'
exec AddContent 'templatepage2', 'Right', 'it is right menu', 'right menu', @query
GO

-- templatepage3

declare @query varchar(1000)
set @query = 'select dbo.Entity(''menu'', ''materials'')'
exec AddContent 'templatepage3', 'Left', 'it is left menu', 'left menu', @query
GO

declare @query varchar(4000)
set @query = 'declare @uoi xml set @uoi = (select coll.value(''uoi[1]/@name'',''varchar(50)'') as [year], coll.value(''uoi[1]/@type'',''varchar(50)'') as [type], coll.value(''uoi[1]/@link'',''varchar(50)'') as [link] from EntityCol(''uoi'') order by [year] for xml raw(''uoi''), root(''alluoi'')) declare @ioi xml set @ioi = (select coll.value(''ioi[1]/@name'',''varchar(50)'') as [year], coll.value(''ioi[1]/@type'',''varchar(50)'') as [type], coll.value(''ioi[1]/@link'',''varchar(50)'') as [link] from EntityCol(''ioi'') order by [year] for xml raw(''ioi''), root(''allioi'')) declare @union xml set @union = (select coll.value(''union[1]/@name'',''varchar(50)'') as [year], coll.value(''union[1]/@link'',''varchar(50)'') as [link] from EntityCol(''union'') order by [year] for xml raw(''union''), root(''allunion'')) declare @camp xml set @camp = (select coll.value(''camp[1]/@name'',''varchar(50)'') as [year], coll.value(''camp[1]/@type'',''varchar(50)'') as [type], coll.value(''camp[1]/@link'',''varchar(50)'') as [link] from EntityCol(''camp'') order by [year] for xml raw(''camp''), root(''allcamp'')) declare @xml xml select @xml=(select @uoi, @ioi, @camp, @union for xml raw(''contests'')) select @xml'
exec AddContent 'templatepage3', 'Right', 'it is right menu', 'right menu', @query
GO

-- welcome

declare @query varchar(1000)
set @query = 'select dbo.Entity(''news'', ''news'')'
exec AddContent 'welcome', 'Center', 'it is news page', 'news page', @query
GO

declare @query varchar(1000)
set @query = 'select dbo.Entity(''headerimage'', ''default'')'
exec AddContent 'welcome', 'Header', 'header', 'headerimage', @query
GO

-- uoi

declare @query varchar(1000)
set @query = 'select dbo.Entity(''uoi'', @year)'
exec AddContent 'uoi', 'Center', 'it is uoi main page', 'uoi main page', @query
GO

declare @query varchar(1000)
set @query = 'select dbo.Entity(''headerimage'', ''uoi'')'
exec AddContent 'uoi', 'Header', 'header', 'headerimage', @query
GO

-- ioi

declare @query varchar(1000)
set @query = 'select dbo.Entity(''ioi'', @year)'
exec AddContent 'ioi', 'Center', 'it is ioi main page', 'ioi main page', @query
GO

declare @query varchar(1000)
set @query = 'select dbo.Entity(''headerimage'', ''ioi'')'
exec AddContent 'ioi', 'Header', 'header', 'headerimage', @query
GO

-- union

declare @query varchar(1000)
set @query = 'select dbo.Entity(''union'', @year)'
exec AddContent 'union', 'Center', 'it is union main page', 'union main page', @query
GO

declare @query varchar(1000)
set @query = 'select dbo.Entity(''headerimage'', ''union'')'
exec AddContent 'union', 'Header', 'header', 'headerimage', @query
GO

-- camp

declare @query varchar(1000)
set @query = 'select dbo.Entity(''camp'', @year)'
exec AddContent 'camp', 'Center', 'it is camp main page', 'camp main page', @query
GO

declare @query varchar(1000)
set @query = 'select dbo.Entity(''headerimage'', ''camp'')'
exec AddContent 'camp', 'Header', 'header', 'headerimage', @query
GO

-- alluoi

declare @query varchar(1000)
set @query = 'declare @xml xml set @xml = (select xdata.value(''/uoi[1]/@name'',''int'') as [year], xdata.value(''/uoi[1]/@link'',''varchar(20)'') as [link], xdata.value(''/uoi[1]/@type'',''varchar(20)'') as [type], xdata.query(''/uoi[1]/statistics[1]/city[1]/text()'') as [city],	xdata.value(''/uoi[1]/statistics[1]/date[1]/@date'',''varchar(50)'') as [date], xdata.value(''/uoi[1]/statistics[1]/participants[1]/@participants'',''varchar(50)'') as [number] from [uoi] for xml raw(''uoi''), root(''alluoi'')) select @xml'
exec AddContent 'alluoi', 'Center', 'it is alluoi', 'alluoi', @query
GO

declare @query varchar(1000)
set @query = 'select dbo.Entity(''headerimage'', ''alluoi'')'
exec AddContent 'alluoi', 'Header', 'header', 'headerimage', @query
GO

-- allioi

declare @query varchar(1000)
set @query = 'declare @xml xml set @xml = (select xdata.value(''/ioi[1]/@name'',''int'') as [year], xdata.value(''/ioi[1]/@link'',''varchar(20)'') as [link], xdata.value(''/ioi[1]/@type'',''varchar(20)'') as [type], xdata.query(''/ioi[1]/statistics[1]/country[1]/text()'') as [country], xdata.value(''/ioi[1]/statistics[1]/date[1]/@date'',''varchar(50)'') as [date], xdata.query(''/ioi[1]/statistics[1]/city[1]/text()'') as [city], xdata.query(''/ioi[1]/statistics[1]/commands[1]/text()'') as [commands], xdata.value(''/ioi[1]/statistics[1]/participants[1]/@participants'',''varchar(50)'') as [number] from [ioi] for xml raw(''ioi''), root(''allioi'')) select @xml'
exec AddContent 'allioi', 'Center', 'it is allioi', 'allioi', @query
GO

declare @query varchar(1000)
set @query = 'select dbo.Entity(''headerimage'', ''allioi'')'
exec AddContent 'allioi', 'Header', 'header', 'headerimage', @query
GO

-- allunion

declare @query varchar(1000)
set @query = 'declare @xml xml set @xml = (select xdata.value(''union[1]/@name'',''int'') as [year], xdata.value(''union[1]/@link'',''varchar(20)'') as [link], xdata.value(''/union[1]/@type'',''varchar(20)'') as [type], xdata.query(''/union[1]/statistics[1]/country[1]/text()'') as [country], xdata.query(''/union[1]/statistics[1]/city[1]/text()'') as [city], xdata.query(''/union[1]/statistics[1]/date[1]/text()'') as [date] from [union] for xml raw(''union''), root(''allunion'')) select @xml'
exec AddContent 'allunion', 'Center', 'it is allunion', 'allunion', @query
GO

declare @query varchar(1000)
set @query = 'select dbo.Entity(''headerimage'', ''allunion'')'
exec AddContent 'allunion', 'Header', 'header', 'headerimage', @query
GO

-- problem

declare @query varchar(1000)
set @query = 'declare @xml xml set @xml = (select  dbo.Entity(@ContestType, @year).query(''//problems/day[@id = sql:variable("@dayid")]/task[@id = sql:variable("@taskid")]'')) select @xml'
exec AddContent 'problem', 'Center', 'it is task visualization', 'task visualization', @query
GO

declare @query varchar(1000)
set @query = 'select dbo.Entity(''headerimage'', ''problem'')'
exec AddContent 'problem', 'Header', 'header', 'headerimage', @query
GO

-- links

declare @query varchar(1000)
set @query = 'select dbo.Entity(''links'', ''links'')'
exec AddContent 'links', 'Center', 'it is links', 'links', @query
GO

declare @query varchar(1000)
set @query = 'select dbo.Entity(''headerimage'', ''links'')'
exec AddContent 'links', 'Header', 'header', 'headerimage', @query
GO

-- uoirating

declare @query varchar(1000)
set @query = 'declare @xml xml set @xml = dbo.Entity(''uoi'', @year).query(''/uoi/results/teams'') declare @title nvarchar(50) set @title = (select dbo.Entity(''uoi'', @year).value(''/uoi[1]/@title'', ''nvarchar(50)'') ) set @xml.modify(''insert attribute title {sql:variable("@title") } into (/teams)[1] '') select @xml'
exec AddContent 'uoirating', 'Center', 'it is uoi rating page', 'uoi rating page', @query
GO

declare @query varchar(1000)
set @query = 'select dbo.Entity(''headerimage'', ''uoirating'')'
exec AddContent 'uoirating', 'Header', 'header', 'headerimage', @query
GO

-- uoiresults

declare @query varchar(1000)
set @query = 'declare @xml xml set @xml = dbo.Entity(''uoi'', @year).query(''/uoi/results/contestants'') declare @title nvarchar(50) set @title = (select dbo.Entity(''uoi'', @year).value(''/uoi[1]/@title'', ''nvarchar(50)'') ) set @xml.modify(''insert attribute title {sql:variable("@title") } into (/contestants)[1] '') select @xml'
exec AddContent 'uoiresults', 'Center', 'it is uoi results page', 'uoi results page', @query
GO

declare @query varchar(1000)
set @query = 'select dbo.Entity(''headerimage'', ''uoiresults'')'
exec AddContent 'uoiresults', 'Header', 'header', 'headerimage', @query
GO

-- about

declare @query varchar(1000)
set @query = 'select dbo.Entity(''about'', ''about'')'
exec AddContent 'about', 'Center', 'it is about page', 'about page', @query
GO

declare @query varchar(1000)
set @query = 'select dbo.Entity(''headerimage'', ''about'')'
exec AddContent 'about', 'Header', 'header for about page', 'headerimage', @query
GO

-- literatures

declare @query varchar(1000)
set @query = 'select dbo.Entity(''topic'', ''topics'')'
exec AddContent 'literatures', 'Center', 'it is literature preview', 'topic list', @query
GO

declare @query varchar(1000)
set @query = 'select dbo.Entity(''headerimage'', ''literature'')'
exec AddContent 'literatures', 'Header', 'header', 'headerimage', @query
GO

-- literature

declare @query varchar(1000)
set @query = 'declare @Name nvarchar(50) set @name = cast( (select dbo.Entity(''topic'', ''topics'').query(''//topic[@name = sql:variable("@Type")]/title/text()'') ) as nvarchar(50) ) declare @xml xml set @xml = (select xdata.query(''/'') from literature where xdata.exist(''//topicname[text() = sql:variable("@Type")]'')=1 for xml raw(''single''), root(''literatures'')) set @xml.modify(''insert attribute title {sql:variable("@Name")} into (/literatures[1])'') declare @title nvarchar(500) set @title = cast (dbo.Entity(''topic'',''topics'').query(''//topic[@name = sql:variable("@Type")]/description/text()'') as nvarchar(500)) set @xml.modify(''insert attribute description {sql:variable("@title")} into (/literatures[1])'') select @xml'
exec AddContent 'literature', 'Center', 'it is literature list', 'literature list', @query
GO

declare @query varchar(1000)
set @query = 'select dbo.Entity(''headerimage'', ''literature'')'
exec AddContent 'literature', 'Header', 'header', 'headerimage', @query
GO

-- articles

declare @query varchar(1000)
set @query = 'select dbo.Entity(''article'', ''articles'')'
exec AddContent 'articles', 'Center', 'it is articles', 'articles', @query
GO

declare @query varchar(1000)
set @query = 'select dbo.Entity(''headerimage'', ''articles'')'
exec AddContent 'articles', 'Header', 'header', 'headerimage', @query
GO

-- deliveries

declare @query varchar(1000)
set @query = 'select dbo.Entity(''deliveries'',''deliveries'')'
exec AddContent 'deliveries', 'Center', 'it is deliveries', 'deliveries', @query
GO

declare @query varchar(1000)
set @query = 'select dbo.Entity(''headerimage'', ''deliveries'')'
exec AddContent 'deliveries', 'Header', 'header', 'headerimage', @query
GO

-- interviews

declare @query varchar(1000)
set @query = 'declare @xml xml set @xml = (select xdata.value(''/interview[1]/@name'', ''varchar(50)'') as [link], xdata.query(''/interview/header/person/name/text()'') as [name], xdata.query(''interview/header/interviewname/text()'') as [interviewname], xdata.query(''/interview/header/date/text()'') as [date] from [interview] where (xdata.exist(''/interview[@type="usual"]'')=1) for xml raw(''interview''), root(''interviews'')) select @xml'
exec AddContent 'interviews', 'Center', 'it is interviews', 'interviews', @query
GO

declare @query varchar(1000)
set @query = 'select dbo.Entity(''headerimage'', ''interview'')'
exec AddContent 'interviews', 'Header', 'header', 'headerimage', @query
GO

-- interview

declare @query varchar(1000)
set @query = 'select dbo.Entity(''interview'', @name)'
exec AddContent 'interview', 'Center', 'it is interview', 'interview', @query
GO

declare @query varchar(1000)
set @query = 'select dbo.Entity(''headerimage'', ''interview'')'
exec AddContent 'interview', 'Header', 'header', 'headerimage', @query
GO

