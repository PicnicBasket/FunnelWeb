-- This table records the status of a long-running task
create table $schema$.TaskState
(
	Id int identity not null,
	`TaskName` VARCHAR(50) not null,
	Arguments TEXT not null,
	ProgressEstimate int,
	Status VARCHAR(30),
	OutputLog TEXT not null,
	Started datetime not null,
	Updated datetime not null,
      unique(Id)
);

