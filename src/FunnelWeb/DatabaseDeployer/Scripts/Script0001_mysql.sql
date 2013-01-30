create table $schema$.SchemaVersions (
	SchemaVersionID int AUTO_INCREMENT not null,
	VersionNumber int not null,
	SourceIdentifier nvarchar(255) not null,
	ScriptName nvarchar(255) not null,
	Applied datetime not null,
      unique (SchemaVersionID)
);

create procedure $schema$.GetCurrentVersionNumber ()
	select max(VersionNumber) from $schema$.SchemaVersions;


create procedure $schema$.RecordVersionUpgrade
(
	IN versionNumber int,
	IN sourceIdentifier nvarchar(255),
	IN scriptName nvarchar(255)
)
	insert into $schema$.SchemaVersions (VersionNumber, SourceIdentifier, ScriptName, Applied)
	values (versionNumber, sourceIdentifier, scriptName, NOW());
    
