-- Create the new tables required for tagging

create table $schema$.Tag
(
    `Id` int AUTO_INCREMENT not null constraint PK_Tag_Id primary key,
    `Name` VARCHAR(50) not null
);


create table $schema$.TagItem
(
    `Id` int AUTO_INCREMENT not null,
    `TagId` int not null constraint FK_TagItem_TagId foreign key references $schema$.Tag(Id),
    `EntryId` int not null constraint FK_TagItem_EntryId foreign key references $schema$.Entry(Id),
      unique(Id)
);


-- Add the status column. The default status is 'Public-Page', since we never had the 
-- concept of Private pages before now
alter table $schema$.Entry
	add Status VARCHAR(20) not null default('Public-Page')


-- Posts that had appeared in an RSS feed can be assumed to be blog posts
update $schema$.Entry
set Status = 'Public-Blog'
where (Id in (select fi.ItemId from $schema$.FeedItem fi))


create function $schema$.SplitTags
(
    input VARCHAR(500)
)
returns @tags table (Tag VARCHAR(500) )

    if input is null return
    
    declare @iStart int, @iPos int
    if substring( @input, 1, 1 ) = ','
        set @iStart = 2
    else set @iStart = 1
      
    while 1=1
    begin
        set @iPos = charindex( ',', @input, @iStart );
        
        if @iPos = 0 set @iPos = len(@input) + 1;
            
        if (@iPos - @iStart > 0) 
            
            insert into @tags values (replace(lower(ltrim(rtrim(substring( @input, @iStart, @iPos-@iStart )))), ' ', '-'))
            
        set @iStart = @iPos+1
        
        if @iStart > len( @input ) 
            break
    end
    return
end;



-- Discover a list of all tags from meta keywords
insert into $schema$.Tag (Name)
    select distinct(tags.Tag) as Name from $schema$.Entry e
    cross apply $schema$.SplitTags(e.MetaKeywords) as tags;

-- Associate new tags with posts
insert into $schema$.TagItem (TagId, EntryId)
    select 
        (select Id from $schema$.Tag where Name = tags.Tag) as TagId, 
		e.Id as PostId
    from $schema$.Entry e
    cross apply $schema$.SplitTags(e.MetaKeywords) as tags;

-- I normally take care to name constraints, but kept forgetting to do it for defaults, damnit!

declare @defaultConstraint`Name` VARCHAR(100);

SELECT @defaultConstraintName = `COLUMN_NAME`
    FROM `information_schema`.`KEY_COLUMN_USAGE` 
    WHERE `COLUMN_NAME` LIKE 'DF_%MetaKeywo%';

declare @str VARCHAR(200);
set @str = 'alter table $schema$.Entry drop constraint ' + @defaultConstraintName;
exec (@str);

if (1 = convert(int, SERVERPROPERTY('IsFullTextInstalled'))) 
begin
begin try
    set @str = 'alter fulltext index on $schema$.Entry disable'
	exec (@str)

    set @str = 'alter fulltext index on $schema$.Entry drop (MetaKeywords)'
	exec (@str)

    set @str = 'alter fulltext index on $schema$.Entry enable'
	exec (@str)
end try
begin catch
--Full text not installed 
PRINT 'Full text catalog not installed'
end catch
end

alter table $schema$.Entry
    drop column MetaKeywords


drop table $schema$.FeedItem


drop table $schema$.Feed


drop function $schema$.SplitTags
