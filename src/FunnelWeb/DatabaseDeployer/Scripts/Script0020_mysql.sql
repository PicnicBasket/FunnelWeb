drop procedure $schema$.GetCurrentVersionNumber;


create procedure $schema$.GetCurrentVersionNumber
	@sourceIdentifier VARCHAR(255)
	select max(VersionNumber) from $schema$.SchemaVersions where SourceIdentifier = @sourceIdentifier;
end;

