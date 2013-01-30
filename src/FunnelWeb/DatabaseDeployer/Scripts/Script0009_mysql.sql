alter table $schema$.Entry
    add MetaTitle VARCHAR(255) not null default('');


update $schema$.Entry set MetaTitle = Title;

