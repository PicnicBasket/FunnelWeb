-- Creates the following tables:
--  * Entry
--  * Feed
--  * FeedItem
--  * Revision

create table $schema$.Entry
(
	Id int AUTO_INCREMENT not null,
	`Name` VARCHAR(50) not null,
	Title VARCHAR(200) not null,
	Summary TEXT not null,
	IsVisible bit not null,
	Published datetime not null,
	LatestRevisionId int null,
     Unique(Id)
);


create table $schema$.Feed
(
	Id int AUTO_INCREMENT not null,
	`Name` VARCHAR(100) not null,
	`Title` VARCHAR(255) not null,
     Unique(Id)
);


create table $schema$.Revision
(
	Id int AUTO_INCREMENT not null,
	EntryId int not null,
	`Body` TEXT not null,
	ChangeSummary VARCHAR(1000) not null,
	Reason VARCHAR(1000) not null,
	Revised datetime not null,
	Tags VARCHAR(1000) not null,
	`Status` int not null,
	IsVisible bit not null,
	RevisionNumber int not null,
     Unique(Id)
);


create table $schema$.FeedItem
(
	Id int AUTO_INCREMENT not null,
	FeedId int not null,
	ItemId int not null,
	SortDate datetime not null,
     Unique(Id)
);


create table $schema$.`Comment`
(
	Id int AUTO_INCREMENT not null,
	`Body` TEXT not null,
	`AuthorName` VARCHAR(100) not null,
	AuthorCompany VARCHAR(100) not null,
	AuthorEmail VARCHAR(100) not null,
	AuthorUrl VARCHAR(100) not null,
	Posted datetime not null,
	EntryId int not null,
	`Status` int not null,
     Unique(Id)
);


alter table $schema$.Revision add constraint FK_Revision_Entry foreign key(EntryId)
	references $schema$.Entry (Id);


alter table $schema$.Revision ALTER COLUMN RevisionNumber SET DEFAULT 0;


alter table $schema$.FeedItem add constraint FK_FeedItem_Entry foreign key(ItemId)
	references $schema$.Entry (Id);


alter table $schema$.FeedItem add constraint FK_FeedItem_Feed foreign key(FeedId)
	references $schema$.Feed (Id);


alter table $schema$.Comment add constraint FK_Comment_Comment foreign key(EntryId)
	references $schema$.Entry (Id);

