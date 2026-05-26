create table student (
StThomasEmail           varchar(50), -- survey question, 'What is your St. Thomas email?
ClassSection            varchar(10), -- survey question, 'Which class section are you in?'
DefaultOS               varchar(20), -- survey question, 'What operating system do you usually use?'
TerminalAvailable       varchar(40), -- survey question, 'Do you have access to bash terminal?'
constraint              student_pk       primary key(StThomasEmail)
);

truncate table student; -- removes the rows

select * from student;

/* Question 1A */
insert into student
select stthomasemail, classsection, defaultos, terminalavailable
from survey;
/* Question 1B
 What happened was the data inserted into the survey table was inserted into
 the student table. StThomasEmail is a primary key in the survey table, and it 
 was selected in the query that began with the insert into sattement. Moreover,
 classsection, DefaultOS, and terminalavailable are all column names that 
 contain variable character string data. In simple words, some data was 
 transferred from the survey table to the student table. It reduced redundancy 
 because there was no need for retyping repetitive insert into statements; the
 data was simply called through variable names.
 
Extended answer from AI:
 "In terms of normalization, this step identifies a functional dependency where 
 StThomasEmail determines ClassSection, DefaultOS, and TerminalAvailable. By 
 separating these attributes into their own table, we remove a partial 
 dependency from the original composite key and move the schema toward Second 
 Normal Form (2NF), reducing redundancy and improving structural organization."
*/

select 'databases', databases from survey;

create table skill (
StThomasEmail           varchar(50),
ResponseID              varchar(30),
name                    varchar(50),
value                   integer,
constraint              skill_pk       primary key(StThomasEmail, ResponseID, name)
);

/* Question 2A */
insert into skill
select StThomasEmail,
       ResponseID,
       -- Insert the text "databases" into the name column:
       'databases' as name, -- got help from AI for this line
       -- Take the number from the "databases" column in survey and put it into the "value" column.           
       databases as value -- got help from AI for this line
from survey;
/* Question 2B 
Data in the rows of three specific columns of the survey table were converted to
four columns in a new table. Data was transferred from one table to the next.
It avoids adding extra insert into statements in the program, which would take 
up more space and be redundant since the data are the same, and it creates a
one to many relationship having one response and any skills. Since "ResponseID"
is a primary key (more specifically, part of a composite primary key) in the 
survey table, that is how we know there is only one response.

Extended answer from AI:
"This moves the design toward Third Normal Form (3NF) by eliminating redundancy 
and separating multivalued attributes into their own table."
*/

insert into skill
select StThomasEmail,
       ResponseID,
       -- Insert the text "databases" into the name column:
       'databases' as name, -- got help from AI for this line
       -- Take the number from the "databases" column in survey and put it into the "value" column.           
       databases as value -- got help from AI for this line
from survey;
/* Question 2C
The second time you run one of the insert statements, it returns an error.
A duplicate key (that is, StThomasEmail, ResponseID, and name) already exists.
StThomasEmail and ResponseID are in the composite primary key, so this error 
shoud be expected because the primary keys are unique identifiers.
*/

create table operatingsystem (
StThomasEmail varchar(50),
os varchar(20),
constraint os_pk primary key (StThomasEmail, os)
);

insert into operatingsystem
select StThomasEmail, DefaultOS 
from survey;

insert into operatingsystem
select StThomasEmail, DefaultOS 
from survey
where DefaultOS is not null -- in one semester this was needed, maybe not this semester
;

select AlternateOSes from survey;
-- or even better
select distinct AlternateOSes from survey;

select StThomasEmail, 'Windows' 
from survey
where AlternateOSes like '%Windows%';

insert into operatingsystem
select StThomasEmail, 'Windows' 
from survey
where AlternateOSes like '%Windows%';

insert into operatingsystem
select StThomasEmail, 'Windows' 
from survey
where AlternateOSes like '%Windows%'
and (StThomasEmail, 'Windows') not in (select StThomasEmail, os from operatingsystem);


/* Question 3A
-- Simply copy the previous command and just replace "Windows" with "Mac" or
-- "Linux/Unix/BSD"
*/
insert into operatingsystem
select StThomasEmail, 'Mac'
from survey
where AlternateOSes like '%Mac%'
and (StThomasEmail, 'Mac') not in (select StThomasEmail, os from operatingsystem);

insert into operatingsystem
select StThomasEmail, 'Linux/Unix/BSD'
from survey
where AlternateOSes like '%Linux/Unix/BSD%'
and (StThomasEmail, 'Linux/Unix/BSD') not in (select StThomasEmail, os from operatingsystem);

/* Question 3B
-- Use aggregate function COUNT(*), which returns the total number of rows in a 
-- table or result set. The output shows 56 rows.
*/
select count(*) from operatingsystem;

/* Question 3C
-- There are no other normalization steps I would like to propose; however, I
-- am confident there are other ways to do it. I do not have any concerns. I 
-- would like to ask AI to generate another version of normalization to compare
-- the two ways and become mroe familiar with not onlty the overall concept of
-- normalization but examples of different approaches:
*/
-- Remove multivalued OS text; use lookup table
create table os (
  os_name varchar(20) primary key
);

-- Bridge table; one row per student per OS
create table student_os (
  StThomasEmail varchar(50),
  os_name varchar(20),
  constraint student_os_pk primary key (StThomasEmail, os_name),
  constraint student_os_os_fk foreign key (os_name) references os(os_name)
);