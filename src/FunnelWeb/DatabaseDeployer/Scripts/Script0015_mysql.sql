alter table $schema$.Revision
    add `Format` VARCHAR(20) not null default('Markdown');


alter table $schema$.Entry
    add HideChrome bit not null default(0);

