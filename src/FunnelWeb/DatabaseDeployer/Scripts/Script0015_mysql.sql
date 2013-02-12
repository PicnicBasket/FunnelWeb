alter table $schema$.Revision
    add COLUMN `Format` VARCHAR(20) not null DEFAULT 'Markdown';

alter table $schema$.Entry
    add COLUMN HideChrome bit not null DEFAULT 0;


