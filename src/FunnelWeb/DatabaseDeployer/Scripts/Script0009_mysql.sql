alter table $schema$.Entry
    add MetaTitle VARCHAR(255) not null;
    
alter table $schema$.Entry 
    ALTER COLUMN MetaTitle SET DEFAULT '';

update $schema$.Entry set MetaTitle = Title;

