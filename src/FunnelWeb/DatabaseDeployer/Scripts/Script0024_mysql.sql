alter table $schema$.Entry add
	Author varchar(100) null,
	RevisionAuthor varchar(100) null

alter table $schema$.Revision add
	Author varchar(100) null


update $schema$.Entry set 
	Author = (select top 1 Value from $schema$.Setting where Name = 'search-author'),
	RevisionAuthor = (select top 1 Value from $schema$.Setting where Name = 'search-author')


update $schema$.Revision set 
	Author = (select top 1 Value from $schema$.Setting where Name = 'search-author')


alter table $schema$.Entry alter column Author varchar(100) not null


alter table $schema$.Entry alter column RevisionAuthor varchar(100) not null


alter table $schema$.Revision alter column Author varchar(100) not null
