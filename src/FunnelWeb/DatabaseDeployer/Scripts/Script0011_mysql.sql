create table $schema$.Pingback
(
    Id int AUTO_INCREMENT not null,
	EntryId int not null,
	TargetUri VARCHAR(255) not null,
	TargetTitle VARCHAR(255) not null,
	IsSpam bit not null,
     Unique(Id)
);


alter table $schema$.Pingback add constraint FK_Pingback_Entry foreign key(EntryId)
    references $schema$.Entry (Id);

