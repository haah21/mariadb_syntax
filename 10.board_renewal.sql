
create table author_address(
   id int not null auto_increment primary key,
    city varchar(255) not null,
    street varchar(255) not null,
    author_id int unique not null ,
    foreign key author_address(author_id) references author(id) on delete cascade
);