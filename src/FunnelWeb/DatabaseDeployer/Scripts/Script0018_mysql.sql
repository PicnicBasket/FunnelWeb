-- Can't even remember what these columns were meant to be used for...

alter table $schema$.Entry
	drop column IsVisible;


alter table $schema$.Revision
	drop column IsVisible;


alter table $schema$.Revision
	drop column ChangeSummary;


alter table $schema$.Comment
	drop column AuthorCompany;


-- 50 was a nice size, but when we import from other blog engines they may have used large URL's
alter table $schema$.Entry 
	alter column Name VARCHAR(100);

