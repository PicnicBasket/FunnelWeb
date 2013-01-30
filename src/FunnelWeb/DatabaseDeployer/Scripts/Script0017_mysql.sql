-- This table records the status of a long-running task
create table $schema$.TaskState
(
	Id int identity not null,
	TaskName VARCHAR(50) not null,
	Arguments VARCHAR(max) not null,
	ProgressEstimate int,
	Status VARCHAR(30),
	OutputLog VARCHAR(max) not null,
	Started datetime not null,
	Updated datetime not null,
      unique(Id)
);

