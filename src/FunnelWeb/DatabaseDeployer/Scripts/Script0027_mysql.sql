--Adding in a few other revision fields into entry table
alter table $schema$.Entry add
	LastRevised datetime null,
	LatestRevisionFormat VARCHAR(20) null,
	TagsCommaSeparated VARCHAR(255) null


update $schema$.Entry set
	LastRevised = (select top 1 Revised from $schema$.Revision where EntryId=$schema$.Entry.Id order by RevisionNumber desc),
	LatestRevisionFormat = (select top 1 Format from $schema$.Revision where EntryId=$schema$.Entry.Id order by RevisionNumber desc),
	TagsCommaSeparated = (select Name + ',' from $schema$.TagItem ti join $schema$.Tag t on t.Id = ti.TagId where ti.EntryId = $schema$.Entry.Id for xml path(''))


update $schema$.Entry set TagsCommaSeparated = '' where TagsCommaSeparated is null


alter table $schema$.Entry alter column LastRevised datetime not null

alter table $schema$.Entry alter column LatestRevisionFormat VARCHAR(20) not null

alter table $schema$.Entry alter column TagsCommaSeparated VARCHAR(255) not null

