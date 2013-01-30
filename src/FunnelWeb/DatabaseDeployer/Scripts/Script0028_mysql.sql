alter table $schema$.Pingback add
	Received datetime null;


update $schema$.Pingback set
	Received = NOW();


alter table $schema$.Pingback alter column Received datetime not null;

