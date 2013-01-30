-- Settings and Statistics

create table $schema$.Redirect
(
    Id int AUTO_NUMBER not null,
	From VARCHAR(255) not null,
	To VARCHAR(255) not null,
     Unique(Id)
);


