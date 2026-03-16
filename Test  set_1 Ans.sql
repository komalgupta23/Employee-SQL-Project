use practice;
select * from employee;
select * from employee limit 5;
select count(*) from employee;
select Company_Name, Employment_Status from employee limit 5;
select * from employee where Employee_Rating > 4.5 limit 5;
select count(*) from employee where Employee_Salary > 600000 and Employee_Rating > 4.5;
select * from employee where Employee_Salary > 600000 and Employee_Rating > 4.5 limit 5;
select count(distinct(Company_Name)) from employee;
select distinct(Company_Name), Employee_City from employee;
select count(distinct(Company_Name), Employee_City) from employee;
select count(*) from employee where Employment_Status = 'Full Time';
select count(*) from employee where Employee_Job_Title = 'Production engineer' or 'New Russellton';
select count(*) from employee where Employee_Job_Title = 'Production engineer' and Company_Name = 'Scott Inc';
-- 15. Print the number of employees with job title either 'Production engineer' or 'New Russellton' and company name either 'Scott Inc' or 'Baker, Allen and Edwards'.
select count(*) from employee where (Employee_Job_Title = 'Production engineer' or 'New Russellton') and (Company_Name = 'Scott Inc' or 'Baker, Allen and Edwards');
-- 16. Print the number of distinct cities with employees having job title either 'Production engineer' or 'New Russellton' and company name either 'Scott Inc' or 'Baker, Allen and Edwards'.
select count(Distinct(Employee_City)) from employee where (Employee_Job_Title = 'Production engineer' or 'New Russellton') and (Company_Name = 'Scott Inc' or 'Baker, Allen and Edwards');
select count(*) from employee where Employment_Status = 'Intern';
select count(*) from employee where Name like 'Matthew%';
select * from employee order by Employee_Salary desc limit 5;
select * from employee where (Company_Name = 'James and Sons') or (Employee_City = 'Wardfort') order by Employee_Salary desc limit 5;
-- To count/ print the total number of distinct records in the data.
select count(*) from (select distinct * from employee) as distinct_records;
-- To see all distinct/unique rows
select distinct * from employee;
-- To find duplicate entry across all columns 
select Name, Company_Name, Employee_Job_Title, Employee_City, Employee_Country, Employee_Salary, Employment_Status, Employee_Rating, count(*) from employee 
group by Name, Company_Name, Employee_Job_Title, Employee_City, Employee_Country, Employee_Salary, Employment_Status, Employee_Rating
having count(*) > 1; 

select avg(Employee_Salary) from employee;
select avg(Employee_Rating) from employee;
select max(Employee_Salary) as Highest_Salary, min(Employee_Salary) as Lowest_Salary from employee;

-- MEDIAN OF EMPLOYEE_SALARY
SELECT AVG(Employee_Salary) as Median_of_Employee_Salary
FROM (
    SELECT Employee_Salary
    FROM employee
    ORDER BY Employee_Salary
    LIMIT 2 OFFSET 149999
) middle_salaries;
SELECT Employee_Salary FROM employee ORDER BY Employee_Salary LIMIT 2 OFFSET 149999;

-- Print the distribution of the following columns: (the frequency of individual entries).
select Company_Name, count(Company_Name) as  Frequency from employee
group by Company_Name order by Frequency desc;
select Employee_Job_Title, count(Employee_Job_Title) as  Frequency from employee
group by Employee_Job_Title order by Frequency desc; 
select Employee_City, count(Employee_City) as  Frequency from employee
group by Employee_City order by Frequency desc;
select Employee_Country, count(Employee_Country) as  Frequency from employee
group by Employee_Country order by Frequency desc;
select Employment_Status, count(Employment_Status) as  Frequency from employee
group by Employment_Status order by Frequency desc; 
select Company_Name, count(Name) as  No_of_Employees from employee group by Company_Name order by No_of_Employees desc;
select Company_Name, count(Name) as  No_of_Employees from employee group by Company_Name order by No_of_Employees asc;
select Company_Name from employee group by Company_Name order by count(*) asc limit 1;
select Count(Name) from employee group by Company_Name order by count(*) asc limit 1;

-- Print the employee details with the maximum salary
select * from employee where Employee_Salary = (select max(Employee_Salary) from employee);

-- 38. Print the employee details with the maximum rating
select * from employee where Employee_Rating = (select max(Employee_Rating) from employee);

--  39. Print the Company_Name with most number of employees in 'Wardfort' city.
select Company_Name, count(Name) as No_of_Employees from employee where Employee_City = 'Wardfort' group by Company_Name order by No_of_Employees desc;

-- 40. Print 'Employee_Salary' column as string.
select format(Employee_Salary, 0) as Employee_Salary from employee;

-- 41. Print the Employee_City with the most number of 'Production engineer'.
select Employee_City, count(Employee_Job_Title) as Production_Engineers from employee where Employee_Job_Title = 'Production Engineer' group by Employee_City order by count(*) desc;

-- 42. Print the Company_Name with the most number of Full-time Employees.
select Company_Name, count(Employment_Status) as Full_Time_Employees from employee where Employment_Status = 'Full Time' group by Company_Name order by count(*) desc;

-- 43. Print the Company_Name with the highest average 'Employee_Rating'.
select Company_Name, avg(Employee_Rating) as Highest_AVG_Employee_Rating from employee group by Company_Name order by Highest_AVG_Employee_Rating desc limit 1 ;

-- 44. Print the number of employees working in 'Ricardomouth' and 'Kristaburgh' location combined.
select count(name) from employee where Employee_City in ('Ricardomouth', 'Kristaburgh') ;

-- 45. Print the distinct Company_Name corresponding to the 5 highest paid employees in the dataset.
SELECT DISTINCT Company_Name
FROM (
    SELECT Company_Name
    FROM employee
    ORDER BY Employee_Salary DESC
    LIMIT 5
) t;

-- 46. Check if any of the columns has NULL values.
 SELECT
    SUM(CASE WHEN Name IS NULL THEN 1 ELSE 0 END) AS Name_NULLS,
    SUM(CASE WHEN Company_Name IS NULL THEN 1 ELSE 0 END) AS Company_Name_NULLS,
    SUM(CASE WHEN Employee_Job_Title IS NULL THEN 1 ELSE 0 END) AS Job_Title_NULLS,
    SUM(CASE WHEN Employee_City IS NULL THEN 1 ELSE 0 END) AS City_NULLS,
    SUM(CASE WHEN Employee_Country IS NULL THEN 1 ELSE 0 END) AS Country_NULLS,
    SUM(CASE WHEN Employee_Salary IS NULL THEN 1 ELSE 0 END) AS Employee_Salary_NULLS,
    SUM(CASE WHEN Employment_Status IS NULL THEN 1 ELSE 0 END) AS Status_NULLS,
    SUM(CASE WHEN Employee_Rating IS NULL THEN 1 ELSE 0 END) AS Rating_NULLS
FROM employee;
select Name, Company_Name, Employee_Job_Title, Employee_City, Employee_Country, Employee_Salary, Employment_Status, Employee_Rating from employee 
where Name is null or Company_Name is null or Employee_Job_Title is null or Employee_City is null or Employee_Country is null or Employee_Salary is null or Employment_Status is null or Employee_Rating is null;
 
-- 47. Print the data type of every column in the data.
describe employee;
show columns from employee;
SELECT
    COLUMN_NAME,
    DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'practice'
  AND TABLE_NAME = 'employee';

-- Print the number of employees with Employee_Rating greater than the average Employee_Rating
 select count(*) as High_rated_Employees from employee where Employee_Rating > (select avg(Employee_Rating) from employee);
 
-- 49. Find the employee which has the maximum salary among the ones with the minimum Employee_Rating
select * from employee where Employee_Rating = (select min(Employee_Rating) from employee) order by Employee_Salary desc limit 1;

-- 50. Sort the table in ascending order of Employee_Salary
select * from  employee order by Employee_Salary asc; 
 
-- 51. Sort the table in descending order of Employee_Rating
select * from  employee order by Employee_Rating desc; 
 
-- 52. Print the name of 100th employee after sorting on Name column
select * from  employee order by Name asc limit 1 offset 99; 
 
-- 53. Print the first 5 rows of the first 5 columns.
select Name, Company_Name, Employee_Job_Title, Employee_City, Employee_Country from  employee limit 5;

-- 54. Print the number of employees whose first name starts with the letter 'V'.
select count(*)  from employee where Name like 'V%';

-- 55. Print the number of employees whose last name starts with the letter 'R'.
select count(*)  from employee where Name like '%R';
 
-- 56. Select the rows 2 to 7 and the columns 3 to 7 (both included)
select Employee_Job_Title, Employee_City, Employee_Country, Employee_Salary, Employment_Status from employee limit 6 offset 1;