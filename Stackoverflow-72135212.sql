drop table test_table;

/*
Item 2: Table
	the range in the excel is modeled as the below test_table
Item 3: Columns
	id keeps the excel row number
	b, c, d are the corresponding b, c, d columns of the excel
*/

create table test_table
(
	id integer,
	b varchar(20),
	c varchar(20),
	d varchar(20)
);

-- Item 3: Adding the rows in the DB
insert into test_table values (3 /* same as excel row number */ , '1', '1', '1');
insert into test_table values (4 /* same as excel row number */ , '2', 'other', '2');
insert into test_table values (5 /* same as excel row number */ , 'TRUE', '3', '3');
insert into test_table values (6 /* same as excel row number */ , '4', '4', '4');


select sum(b + c + d) -- Item 5, first option: We sum row by row
	from test_table
	where id between 3 and 6; -- Item 4: We simple get all rows, because for all rows above the id are between 3 and 6, if we had another row with 7, it would be filtered out
/*
+----------------+
| sum(b + c + d) |
+----------------+
|             25 |
+----------------+
*/

select sum(b) + sum(c) + sum(d) -- Item 5, second option: We sum column by column
	from test_table
	where id between 3 and 6; -- Item 4: We simple get all rows, because for all rows above the id are between 3 and 6, if we had another row with 7, it would be filtered out
/*
+--------------------------+
| sum(b) + sum(c) + sum(d) |
+--------------------------+
|                       25 |
+--------------------------+
*/

-- Item 6: We can have group by clause to simulate a pivot table
insert into test_table values (7 /* same as excel row */ , '4', '2', '2');

select b, sum(d), min(d), max(d), avg(d)
	from test_table
	where id between 3 and 7
	group by b;
/*
+------+--------+--------+--------+--------+
| b    | sum(d) | min(d) | max(d) | avg(d) |
+------+--------+--------+--------+--------+
| 1    |      1 | 1      | 1      |      1 |
| 2    |      2 | 2      | 2      |      2 |
| TRUE |      3 | 3      | 3      |      3 |
| 4    |      6 | 2      | 4      |      3 |
+------+--------+--------+--------+--------+
*/
