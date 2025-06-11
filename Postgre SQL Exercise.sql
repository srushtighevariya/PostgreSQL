CREATE TABLE Worker (
	WORKER_ID       INT PRIMARY KEY ,
	FIRST_NAME      CHAR(25),
	LAST_NAME       CHAR(25),
	SALARY          INT,
	JOINING_DATE    DATE,
	DEPARTMENT      CHAR(25)
);

DROP TABLE Worker;

INSERT INTO Worker
	(WORKER_ID, FIRST_NAME, LAST_NAME, SALARY, JOINING_DATE, DEPARTMENT) VALUES
		(001, 'Monika', 'Arora', 100000, '14-02-20 ', 'HR'),
		(002, 'Niharika', 'Verma', 80000, '14-06-11 ', 'Admin'),
		(003, 'Vishal', 'Singhal', 300000, '14-02-20 ', 'HR'),
		(004, 'Amitabh', 'Singh', 500000, '14-02-20 ', 'Admin'),
		(005, 'Vivek', 'Bhati', 500000, '14-06-11 ', 'Admin'),
		(006, 'Vipul', 'Diwan', 200000, '14-06-11 ', 'Account'),
		(007, 'Satish', 'Kumar', 75000, '14-01-20 ', 'Account'),
		(008, 'Geetika', 'Chauhan', 90000, '14-04-11 ', 'Admin');


CREATE TABLE Bonus (
	WORKER_REF_ID   INT,
	BONUS_AMOUNT    INT,
	BONUS_DATE      DATE,
	FOREIGN KEY (WORKER_REF_ID)
		REFERENCES Worker(WORKER_ID)
        ON DELETE CASCADE
);

INSERT INTO Bonus
	(WORKER_REF_ID, BONUS_AMOUNT, BONUS_DATE) VALUES
		(001, 5000, '16-02-20'),
		(002, 3000, '16-06-11'),
		(003, 4000, '16-02-20'),
		(001, 4500, '16-02-20'),
		(002, 3500, '16-06-11');

CREATE TABLE Title (
	WORKER_REF_ID   INT,
	WORKER_TITLE    CHAR(25),
	AFFECTED_FROM   DATE,
	FOREIGN KEY (WORKER_REF_ID)
		REFERENCES Worker(WORKER_ID)
        ON DELETE CASCADE
);

INSERT INTO Title
	(WORKER_REF_ID, WORKER_TITLE, AFFECTED_FROM) VALUES
 (001, 'Manager', '2016-02-20 '),
 (002, 'Executive', '2016-06-11 '),
 (008, 'Executive', '2016-06-11 '),
 (005, 'Manager', '2016-06-11 '),
 (004, 'Asst. Manager', '2016-06-11 '),
 (007, 'Executive', '2016-06-11 '),
 (006, 'Lead', '2016-06-11 '),
 (003, 'Lead', '2016-06-11 ');


-- Q-1. fetch “FIRST_NAME” from Workers table using the alias name as <Workers_NAME>.
select FIRST_NAME as Workers_NAME from Worker;
select ARRAY_AGG(FIRST_NAME) AS Workers_NAME from Worker;
select array_to_string(array_agg(Worker.FIRST_NAME), ': ' ) as Workers_NAME from Worker;

-- Q-2. fetch “FIRST_NAME” from Workers table in upper case.
select upper(Worker.FIRST_NAME) from worker;

-- Q-3. fetch unique values of DEPARTMENT from Workers table.
select worker.department from worker;
select distinct worker.department from worker;

-- Q-4. print the first three characters of  FIRST_NAME from Workers table.
select worker.first_name from worker;
select left(worker.first_name, 3) from worker;

-- Q-5. find the position of the alphabet (‘a’) in the first name column from Workers table.
select FIRST_NAME,position('a'in first_name) from worker where FIRST_NAME like '%a%';

-- Q-6. print the FIRST_NAME from Workers table after removing white spaces from the right side.
select rtrim(Worker.FIRST_NAME) from worker;

-- Q-7. print the DEPARTMENT from Workers table after removing white spaces from the left side.
select ltrim(worker.department) from worker;

-- Q-8. Write an SQL query that fetches the unique values of DEPARTMENT from Workers table and prints its length.
select distinct length(DEPARTMENT) from worker;

-- Q-9. print the FIRST_NAME from Workers table after replacing ‘a’ with ‘A’.
select replace(worker.first_name,'a','A') from worker;

-- Q-10. print the FIRST_NAME and LAST_NAME from Workers table into a single column COMPLETE_NAME. A space char should separate them.
select concat(rtrim(FIRST_NAME),' ',ltrim(LAST_NAME)) as COMPLETE_NAME from worker;
select concat_ws(' ',rtrim(worker.first_name),ltrim(worker.last_name)) as COMPLETE_NAME from worker;

-- Q-11. print all Workers details from the Workers table order by FIRST_NAME Ascending.
select * from worker order by FIRST_NAME;

-- Q-12. print all Workers details from the Workers table order by FIRST_NAME Ascending and DEPARTMENT Descending.
select * from worker order by FIRST_NAME asc , DEPARTMENT desc ;

-- Q-13. print details for Workers with the first name as “Vipul” and “Satish” from Workers table.
select * from worker where FIRST_NAME = 'Vipul' or FIRST_NAME = 'Satish';
select * from worker where FIRST_NAME in ('Vipul','Satish');

-- Q-14. print details of Workers excluding first names, “Vipul” and “Satish” from Workers table.
select * from worker where FIRST_NAME not in ('Vipul','Satish');

-- Q-15. print details of Workers with DEPARTMENT name as “Admin”.
select * from worker where DEPARTMENT = 'Admin';

-- Q-16. print details of the Workers whose FIRST_NAME contains ‘a’.
select * from worker where FIRST_NAME like '%a%';

-- Q-17. print details of the Workers whose FIRST_NAME ends with ‘a’.
-- select * from worker where FIRST_NAME like '%a';

-- Q-18. print details of the Workers whose FIRST_NAME ends with ‘h’ and contains six alphabets.
-- select * from worker where FIRST_NAME like '_____h';

-- Q-19. print details of the Workers whose SALARY lies between 50000 and 70000.
-- select * from worker where SALARY between 50000 and 70000;

-- Q-20. print details of the Workers who have joined in Feb’2014.
-- select * from worker where extract(month from JOINING_DATE) = 2 and extract(year from JOINING_DATE) = 2014 ;


-- Q-21. fetch the count of Workers working in the department ‘Admin’.
select count(worker.worker_id) as Admin from worker where DEPARTMENT = 'Admin';

-- Q-22. fetch the no. of Workers for each department in the descending order.
select worker.department, count(*) AS grp from worker group by DEPARTMENT order by grp desc ;
select DEPARTMENT,count(worker.worker_id) as count_dept from worker group by DEPARTMENT order by count_dept desc ;

-- Q-23. print details of the Workers who are also Managers.
select worker.worker_id, worker.first_name, worker.department, Title.WORKER_TITLE
    from worker left join title
        on worker.WORKER_ID = title.WORKER_REF_ID
            where Title.WORKER_TITLE = 'Manager';

-- Q-24. clone a new table from another table.
create table clon_table as (select * from worker);
drop table clon_table;
select * from clon_table;

-- Q-25. show records from one table that another table does not have.
select * from bonus right join Worker W on W.WORKER_ID = bonus.WORKER_REF_ID where WORKER_REF_ID is null;

-- Q-26. show the current date and time.
set timezone = 'Asia/Kolkata';
select current_date , current_time;

-- Q-27. show the top 10 records of a table.
select * from worker limit 5;

-- Q-28. fetch the list of Workers with the same Bonus.


-- Q-29. show the second highest salary from a table.
select max(worker.salary) from worker;
select worker.first_name,worker.salary from worker order by SALARY desc ;
select worker.first_name, worker.salary from  worker where SALARY not in (select max(worker.salary) from worker) order by SALARY desc limit 1;

-- Q-30. fetch the first 50% records from a table.
select * from worker limit (select count(*) / 2 from worker);

-- Q-31. fetch the departments that have less than five people in it.
select worker.department from worker group by DEPARTMENT having count(*) < 5 ;

-- Q-32. show all departments along with the number of people in there.
select worker.department, count(worker.worker_id) from worker group by DEPARTMENT;

-- Q-33. show the last record from a table.
select * from worker order by WORKER_ID desc limit 1;

-- Q-34. fetch the first row of a table.
select * from worker limit 1;

-- Q-35. fetch the last five records from a table.
select * from worker order by WORKER_ID desc limit 5;

-- Q-36. print the name of Workers having the highest salary in each department.
-- select DEPARTMENT,max(SALARY) from worker group by DEPARTMENT ;

-- Q-37. fetch three max salaries from a table.
select * from worker order by SALARY desc limit 3;

-- Q-38. fetch three min salaries from a table.
select worker.salary from worker order by SALARY limit 3;

-- Q-39. fetch departments along with the total salaries paid for each of them.
select worker.department , sum(worker.salary) from worker group by DEPARTMENT;

-- Q-40. fetch the names of Workers who earn the highest salary.
select worker.first_name,worker.salary from worker where SALARY in (select max(worker.salary)from worker);