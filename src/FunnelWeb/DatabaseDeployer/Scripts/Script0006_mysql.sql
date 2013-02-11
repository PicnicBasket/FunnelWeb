-- Ability to enable/disable discussion on certain threads

alter table $schema$.Entry add IsDiscussionEnabled bit not null;
    
alter table $schema$.Entry ALTER COLUMN IsDiscussionEnabled SET DEFAULT 1;