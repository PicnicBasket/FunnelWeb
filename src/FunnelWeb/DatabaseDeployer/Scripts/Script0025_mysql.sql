alter table $schema$.Comment drop constraint FK_Comment_Comment


create table $schema$.Tmp_Comment
(
	Id int NOT NULL AUTO_NUMBER,
	Body VARCHAR(MAX) NOT NULL,
	AuthorName VARCHAR(100) NOT NULL,
	AuthorEmail VARCHAR(100) NOT NULL,
	AuthorUrl VARCHAR(100) NOT NULL,
	AuthorIp VARCHAR(39) NULL,
	Posted datetime NOT NULL,
	EntryId int NOT NULL,
	EntryRevisionNumber int NULL,
	Status int NOT NULL
)


set identity_insert $schema$.Tmp_Comment on

if exists(select * from $schema$.Comment)
	 exec('INSERT INTO $schema$.Tmp_Comment (Id, Body, AuthorName, AuthorEmail, AuthorUrl, Posted, EntryId, Status)
		SELECT Id, Body, AuthorName, AuthorEmail, AuthorUrl, Posted, EntryId, Status FROM $schema$.Comment WITH (HOLDLOCK TABLOCKX)')

set identity_insert $schema$.Tmp_Comment off



drop table $schema$.Comment

execute sp_rename N'$schema$.Tmp_Comment', N'Comment', 'OBJECT' 



alter table $schema$.Comment add constraint
	PK_Comment_Id primary key clustered (Id)


alter table $schema$.Comment add constraint
	FK_Comment_Comment foreign key (EntryId) references $schema$.Entry(Id) 
	on update no action 
	on delete no action 


--Default values for comment revision
update $schema$.Comment
	set EntryRevisionNumber = (select top 1 RevisionNumber from $schema$.Revision where EntryId=Comment.EntryId order by RevisionNumber desc)
where EntryRevisionNumber is null


--Fix for any Entry table that may have revisions that are not the latest
update $schema$.Entry set
	RevisionNumber = (select top 1 RevisionNumber from $schema$.Revision where EntryId=Entry.Id order by RevisionNumber desc),
	LatestRevisionId = (select top 1 Id from $schema$.Revision where EntryId=Entry.Id order by RevisionNumber desc),
	Body = (select top 1 Body from $schema$.Revision where EntryId=Entry.Id order by RevisionNumber desc),
	Author = (select top 1 Author from $schema$.Revision where EntryId=Entry.Id order by RevisionNumber desc)

