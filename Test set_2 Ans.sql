use practice;
select * from employee;
-- 57. Select every row after the 10th row and select all columns.
select * from employee limit 300000 offset 9;

-- 58. Select every row up to the 10th row and select all columns.
select * from employee limit 10;

-- 59. Select rows with employee rating > 4.5.
select * from employee where Employee_Rating > 4.5;

-- 60. Select rows with employee rating > 4.5 and < 4.8.
select * from employee where Employee_Rating > 4.5 and Employee_Rating < 4.8;

-- 61. Print the name of the company with the maximum employees having rating > 4.
select Company_Name from employee where Employee_Rating > 4 group by Company_Name order by count(*) desc;

-- 62. Print the rating of the employee named 'Julie Morton'.
select Name, Employee_Rating from employee where Name like 'Julie Morton';

-- 63. Print the last 3rd entry in the column Employee_City
select Employee_City from employee limit 3 offset 299997;

-- 64. Are the number of employees in 'Scott Inc' company greater than that in 'Andrade LLC'?
select Company_Name, count(Name) from employee group by Company_Name order by count(*) desc;
SELECT
    CASE
        WHEN
            (SELECT COUNT(*) FROM practice.employee WHERE Company_Name = 'Scott Inc')
            >
            (SELECT COUNT(*) FROM practice.employee WHERE Company_Name = 'Andrade LLC')
        THEN 'Yes'
        ELSE 'No'
    END AS Result;

-- 65. Which is the most common first name in the data?
select distinct Name, count(Name) from employee group by Name order by count(Name) desc limit 1;

-- 66. Which is the least common last name in the data?
select distinct Name, count(Name) from employee group by Name order by count(Name) asc limit 1;

-- 67. What is the average name length?
select avg(length(Name)) from employee;

-- 68. What is the ratio of total full-time employees to Interns?
SELECT
    CONCAT(
        SUM(CASE WHEN Employment_Status = 'Full Time' THEN 1 ELSE 0 END),
        ' : ',
        SUM(CASE WHEN Employment_Status = 'Intern' THEN 1 ELSE 0 END)
    ) AS FullTime_to_Intern_Ratio
FROM practice.employee;

-- 69. Starting from the first record, print every third record in the Data.
SET @row_num := 0;
SELECT * FROM practice.employee
WHERE (@row_num := @row_num + 1) % 3 = 1;

-- 70. Find the average salary on company-level.
select Company_Name, Avg(Employee_Salary) as Average_Salary from employee group by Company_Name;

-- 71. Find the average rating on company-level.
select Company_Name, Avg(Employee_Rating) as Average_Rating from employee group by Company_Name;

-- 72. Find the average salary and average rating for every company in a single line.
select Company_Name, Avg(Employee_Rating) as Average_Rating, avg(Employee_Salary) as Average_Salary from employee group by Company_Name;

-- 73. Find the number of unique Employee_City corresponding to every Company_Name.
select count(distinct Employee_City) as Unique_City_Count, Company_Name from employee  group by Company_Name order by Company_Name;

-- 74. Print the number of full-time and intern employees for every company
select 
	sum(case when Employment_Status = 'Full Time' then 1 else 0 end) as Full_Time_Employees, 
	sum(case when Employment_Status = 'Intern' then 1 else 0 end) as Intern_Employees
from employee;

-- 75. Print the job title with the most employees.
select Employee_Job_Title, count(Name) as No_of_Employee from employee group by Employee_Job_Title order by No_of_Employee desc limit 1;

-- 76. Print the job title with the most employees corresponding to every company.
select Company_Name, Employee_Job_Title, count(Name) as No_of_Employee from employee group by Company_Name, Employee_Job_Title order by No_of_Employee desc limit 1;

-- 77. Find the average salary for corresponding to every value of 'Employment_Status'
select Employment_Status, avg(Employee_Salary) as Average_Salary from employee  group by Employment_Status;

-- 78. Print the row number corresponding to the maximum Employee_Salary
Select @row_num, max(Employee_Salary) from employee;

-- 79. How many unique firstnames exist in the dataset?
SELECT COUNT(DISTINCT SUBSTRING_INDEX(Name, ' ', 1)) AS unique_firstnames FROM employee;

-- 80. How many unique lastnames exist in the dataset?
SELECT COUNT(DISTINCT SUBSTRING_INDEX(Name, ' ', -1)) AS unique_lastnames FROM employee;

-- 81. How many unique firstnames exist in the dataset for every company?
SELECT Company_Name, COUNT(DISTINCT SUBSTRING_INDEX(Name, ' ', 1)) AS unique_firstnames FROM employee group by Company_Name;

-- 82. Are there any rows for the employee name 'Michael Edward'?
select case when count(Name) > 0 then 'Yes' else 'No' end as Result from employee where Name like 'Michael Edward';

-- 83. Check if the substring 'Michael Edward' appears in the Name column or not.
SELECT 
    CASE
        WHEN COUNT(*) > 0 THEN 'Yes'
        ELSE 'No'
    END AS Result
FROM employee WHERE Name LIKE '%Michael Edward%';
select count(*) from employee where Name like '%Michael Edward%';

-- 84. How many unique Job titles start with the substring 'Pr' (case-sensitive matching)
select count(distinct Employee_Job_Title) as Unique_Job_Titles from employee where Employee_Job_Title collate utf8mb4_bin like  '%Pr%' ;

-- 85. How many unique Job titles start with the substring 'Pr' (case-insensitive matching)
select count(distinct Employee_Job_Title) as Unique_Job_Titles from employee where Employee_Job_Title like '%Pr%' ;

-- 86. How many records are there whose Country end with the substring 'urt' (case-insensitive matching)
select count(*) from employee where Employee_Country like '%urt%' ;

-- 87. Print the number of records whose company name contains the substring 'LL' (case-insensitive).
select count(*) from employee where Company_Name like '%LL%';

-- 88. Select the first row corresponding to every company in the data
SELECT * FROM (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY Company_Name ORDER BY Name) AS rn
    FROM employee
) t
WHERE rn = 1;

-- 89. Select the last row corresponding to every company in the data
SELECT * FROM (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY Company_Name ORDER BY Name desc) AS rn
    FROM employee
) t
WHERE rn = 1;

-- 90. Add a new row at the bottom of the data.
-- _deepnote_execute_sql('-- add this: ["Chris Anders", "Scott Inc", "Production engineer", "Wardfort", "Anguilla", 343930, "Full Time", 3.3]\n\n', 'SQL_DEEPNOTE_DATAFRAME_SQL', audit_sql_comment='', sql_cache_mode='cache_disabled')
insert into employee
values ("Chris Anders", "Scott Inc", "Production engineer", "Wardfort", "Anguilla", 343930, "Full Time", 3.3);
     
-- 91. Print the number of rows now.
select count(*) from employee;

-- 92. Add a new column "Employee_Rating_New" which should be as follows:
-- Employee_Rating_New = max(1.5, 2*Employee_Rating - 3)
alter table employee add column Employee_Rating_New double;
select * from employee;
-- update employee set Employee_Rating_New = greatest(1.5, 2 * Employee_Rating - 3) where Name is not null ;
-- using TEMPORARY (Session-Only) METHOD bcoz above code doesn't run due to safe mode of updating all rows without where clause
SET SQL_SAFE_UPDATES = 0;
UPDATE employee
SET Employee_Rating_New = GREATEST(1.5, 2 * Employee_Rating - 3);
SET SQL_SAFE_UPDATES = 1;

-- 93. Convert the 'Name' to upper case and store it back to the same column.
SET SQL_SAFE_UPDATES = 0;
update employee
set Name = upper(Name);
SET SQL_SAFE_UPDATES = 1;

-- Converting the Upper case names to original case (Proper case)
set sql_safe_updates = 0;
UPDATE employee
SET Name = CONCAT(
    UPPER(LEFT(SUBSTRING_INDEX(Name, ' ', 1), 1)),
    LOWER(SUBSTRING(SUBSTRING_INDEX(Name, ' ', 1), 2)),
    ' ',
    UPPER(LEFT(SUBSTRING_INDEX(Name, ' ', -1), 1)),
    LOWER(SUBSTRING(SUBSTRING_INDEX(Name, ' ', -1), 2))
);
set sql_safe_updates = 1;

-- 94. Add a New column of 'First_name' and compute it from the 'Name' column
-- SELECT @@autocommit; (to check autocommit status
alter table employee add column First_Name varchar(50) after Name;
set sql_safe_updates = 0;
update employee set First_Name = substring_index(name, ' ', 1);

-- 95. Add a New column of 'Last_name' and compute it from the 'Name' column
alter table employee add column Last_Name varchar(50) after First_Name;
update employee set Last_Name = substring_index(name, ' ', -1);
select * from employee;

-- 96. Drop the 'Name' column from the table.
alter table employee drop column Name;

-- 97. Rename the columns: Employee_Rating -> Rating, Employee_Country -> Country, Employee_Salary -> Salary, Employee_Rating_New -> Rating_New, Employment_Status -> Employment_type, Employment_City -> City
alter table employee 
rename column Employee_Job_Title to Job_Title,
rename column Employee_City to City,
rename column Employee_Country to Country,
rename column Employee_Salary to Salary,
rename column Employee_Rating to Rating,
rename column Employee_Rating_New to Rating_New;

-- 98. Compute a new column as 'Salary_category' as follows: (1)"High" if the salary is >= 600000 (2)"Medium" if the salary is > 300000 and < 600000 (3)"Low" otherwise.
alter table employee add column Salary_Category varchar(10);
update employee set Salary_Category = case
	when Salary >= 600000 then 'High'
	when Salary > 300000 and Salary < 600000 then 'Medium'
    else 'Low' end;
set sql_safe_updates = 1;

-- 99. Print the count distribution of the 'Salary_category' column.
select Salary_Category, count(Salary_Category) from employee group by Salary_Category;
select Employment_Status, count(Employment_Status) from employee group by Employment_Status;

-- 100. Map every Company_Name to a unique integer value. Name the new column "Company_ID".
Select  distinct Company_Name, 
		dense_rank() over (order by Company_Name) as Company_ID
from employee;

-- 101. Generate one-hot lables for the 'Employment_type' column. You don't have to add this as a column to the data.
SELECT
    First_Name,
    Employment_Status,
    CASE WHEN Employment_Status = 'Full Time' THEN 1 ELSE 0 END AS Full_Time,
    CASE WHEN Employment_Status = 'Intern' THEN 1 ELSE 0 END AS Intern
FROM employee;

-- 102. Print the number of rows where 'City' belongs to the following list of cities. ["New Russellton", "Whiteside", "Kristaburgh"]
select City, count(City) from employee where City in ("New Russellton", "Whiteside", "Kristaburgh") group by city;
     
-- 103. Print the name of the person with the 10th largest salary.
select First_Name, Salary from employee order by Salary desc limit 1 offset 9;

-- 104. Print the standard deviation of the Salary column.
select std(Salary) from employee;
select stddev(Salary) as Standard_Deviation from employee;
     
-- 105. Sort the data on Employee salary column
select First_Name, Salary from employee order by Salary desc; 

-- 106. Find the average salary on company-level only for those companies where the number of employees is greater than 120.
select Company_Name, avg(Salary) from employee group by Company_Name having count(*) > 120;

-- 107. Given the data below, implement a SQL inner join on col_A:  df1 = pd.DataFrame([["A", 1], ["B", 2]], columns=["col_A", "col_B"]) and df2 = pd.DataFrame([["A", 3], ["C", 4]], columns=["col_A", "col_C"])
CREATE TABLE df1 (
    col_A VARCHAR(1),
    col_B INT
);
CREATE TABLE df2 (
    col_A VARCHAR(1),
    col_C INT
);
insert into df1 values ('A', 1), ('B', 2);
insert into df2 values ('A', 3), ('C', 4);
select df1.col_A, df1.col_B, df2.col_C from df1 inner join df2 on df1.col_A = df2.col_A;

-- 108. Perform the full outer join on the two tables.
select df1.col_A, df1.col_B, df2.col_C from df1 left join df2 on df1.col_A = df2.col_A
union
select df1.col_A, df1.col_B, df2.col_C from df1 right join df2 on df1.col_A = df2.col_A;
select df1.col_A, df1.col_B, df2.col_C from df1 full join df2 on df1.col_A = df2.col_A;

-- 109. Concatentate the two tables row-wise
SELECT col_A, col_B, NULL AS col_C FROM df1
UNION ALL
SELECT col_A, NULL AS col_B, col_C FROM df2;

-- 110. Get the mean of every column :   df = pd.DataFrame([[4, 1, 5], [5, 5, 9], [2, 9, 3], [8, 5, 8]], columns=["col_A", "col_B", "col_C"])
create table df(
col_A int,
col_B int,
col_C int);
insert into df 
values (4, 1, 5),
		(5, 5, 9),
        (2, 9, 3),
        (8, 5, 8);
select avg(col_A), avg(col_B), avg(col_C) from df;

-- 111. Sort the Data on col_A and col_B:   col_A -> Ascending col_B -> Ascending
select * from df order by col_A asc, col_B asc;

-- 112. Get the rows where (the value of "col_A" is equal to "col_B") OR (the value of "col_A" is equal to "col_C").
select * from df where (col_A = col_B) or (col_A = col_C);

-- 113. Get the rows where the value of "col_A" is equal to "col_B".
select * from df where col_A = col_B;

-- 114. Find the top 3 highest-paid employees in each company
select * from
	( select * , dense_rank() over (partition by Company_Name order by Salary desc) as rnk from employee) t
    where rnk <=3;
    
-- 115. Find companies whose average salary is above the overall average salary
select distinct Company_Name, Avg(Salary) as Avg_Salary from employee group by Company_Name having avg(Salary) > (select avg(Salary) from employee) ;

-- 116. Find the second highest salary in the entire dataset
select * from employee order by Salary desc limit 1 offset 1;

-- 117. Find employees whose salary is higher than their company’s average
SELECT e.* FROM employee e
JOIN (
    SELECT Company_Name, AVG(Salary) AS avg_sal
    FROM practice.employee
    GROUP BY Company_Name
) c
ON e.Company_Name = c.Company_Name
WHERE e.Salary > c.avg_sal;

-- 118. Find companies having more than 10 employees
select Distinct Company_Name from employee group by Company_Name having count(*) >10;

-- 119. Find employees who have the same salary as at least one other employee
select * from employee where Salary in (select Salary from employee group by Salary having count(*) > 1);

-- 120. Find the highest-paid employee in each location
select * from 
		(Select * , dense_rank() over( partition by City order by Salary desc) as rnk from employee)t
        where rnk =1;
        
-- 121. Find the total salary expense per company
Select Company_Name, sum(Salary) as Salary_Expense from employee group by Company_Name;

-- 122. Find employees whose rating is below the company average rating
select e1.* from employee e1 
join 
(select Company_Name, avg(Rating_New) as Co_Avg_Rating from employee  group by Company_Name) e2
on e1.Company_Name = e2.Company_Name
where Rating_new < Co_Avg_Rating;

-- 123. Rank all employees by salary within their location
select * , dense_rank() over(partition by City order by Salary desc) as Salary_Rank from employee;