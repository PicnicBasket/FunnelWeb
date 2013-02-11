﻿-- Settings and Statistics

create table $schema$.Setting
(
    `Id` int AUTO_INCREMENT not null,
	`Name` VARCHAR(50) not null,
	`Description` TEXT not null,
	`DisplayName` VARCHAR(200) not null,
	`Value` TEXT not null,
     Unique(`Id`)
);


insert into $schema$.Setting (Name, DisplayName, Value, Description) values ('ui-title', 'Title', 'My FunnelWeb Site', 'Text: The title shown at the top in the browser.');
                             
insert into $schema$.Setting (Name, DisplayName, Value, Description) values ('ui-introduction', 'Introduction', 'Welcome to your FunnelWeb blog. You can <a href="/admin/login">login</a> and edit this message in the administration section. The default username and password is <code>test/test</code>.', 'Markdown: The introductory text that is shown on the home page.');
                             
insert into $schema$.Setting (Name, DisplayName, Value, Description) values ('ui-links', 'Main Links', '<li><a href="/projects">Projects</a></li>', 'HTML: A list of links shown at the top of each page.');
                             
                               
insert into $schema$.Setting (Name, DisplayName, Value, Description) values ('search-author', 'Author', 'Daffy Duck', 'Text: Your name.');
                             
insert into $schema$.Setting (Name, DisplayName, Value, Description) values ('search-keywords', 'Keywords', '.net, c#, test', 'Comma-separated text: Keywords shown to search engines.');
                             
insert into $schema$.Setting (Name, DisplayName, Value, Description) values ('search-description', 'Description', 'My website.', 'Text: The description shown to search engines in the meta description tag.');
