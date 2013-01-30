alter table $schema$.Entry alter column Author VARCHAR(100) not null;


alter table $schema$.Entry alter column RevisionAuthor VARCHAR(100) not null;


alter table $schema$.Revision alter column Author VARCHAR(100) not null;


alter table $schema$.Entry add
	CommentCount int null;


update $schema$.Entry set CommentCount = 0;

