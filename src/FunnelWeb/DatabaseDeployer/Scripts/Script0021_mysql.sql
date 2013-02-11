﻿--Latest Revision Id already exists, lets just extend it a little and make use of it

alter table $schema$.Entry add
	`RevisionNumber` int NULL,
	`Body` TEXT NULL


update $schema$.Entry set 
	`LatestRevisionId` = (select top 1 Id from $schema$.Revision where EntryId = Entry.Id order by Revised desc),
	`RevisionNumber` = (select top 1 RevisionNumber from $schema$.Revision where EntryId = Entry.Id order by Revised desc),
	`Body` = (select top 1 Body from $schema$.Revision where EntryId = Entry.Id order by Revised desc)


alter table $schema$.Entry alter column LatestRevisionId int not null

alter table $schema$.Entry alter column RevisionNumber int not null

alter table $schema$.Entry alter column Body TEXT not null


alter table $schema$.Revision
	drop column Tags
