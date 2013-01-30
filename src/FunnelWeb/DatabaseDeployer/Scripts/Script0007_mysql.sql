-- Ability to manually set the description and keywords for META tags in the final pages

alter table $schema$.Entry
    add MetaDescription VARCHAR(500) not null default('');


alter table $schema$.Entry
    add MetaKeywords VARCHAR(500) not null default('');

