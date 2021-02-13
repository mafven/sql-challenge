--Data Engineering
--create tables to hold the data
x
create table departments
(dept_no varchar,dept_name varchar);
alter table departments
add primary key(dept_no);
select * from departments


create table dept_emp_numbers
(emp_no int, dept_no varchar);
alter table dept_emp_numbers
add primary key(dept_no,emp_no);
select * from dept_emp_numbers

create table managers
(dept_no varchar,emp_no int);
alter table managers
add primary key(dept_no,emp_no);
select * from managers


create table salaries
(emp_no int, salary int);
alter table salaries
add primary key(emp_no);
select * from salaries


create table titles
(title_id varchar, title varchar);
 alter table titles
 add primary key(title_id);
select * from titles

create table employees
(emp_no int, 
 emp_title_id varchar,
 birth_date varchar,
 first_name varchar,
 last_name varchar,
 sex varchar,
 hire_date varchar);
 alter table employees
 add primary key(emp_no);
 alter table employees
   add CONSTRAINT fk_title_id
      FOREIGN KEY(emp_title_id) 
	  REFERENCES titles(title_id);

ALTER TABLE employees
ALTER COLUMN birth_date type date
USING to_date(birth_date, 'MM:DD:YYYY'); 

ALTER TABLE employees
ALTER COLUMN hire_date type date
USING to_date(hire_date, 'MM:DD:YYYY');
select * from employees


--DATA ANALYSIS
--1)List the following details of each employee: 
--employee number, last name, first name, sex, and salary.

--Check tables
Select * from salaries
Select * from employees

--join columns and filter the data
create view vw_emp_salary as 
Select e.emp_no,e.last_name,e.first_name,e.sex,s.salary
from employees as e
INNER JOIN  salaries as s
on e.emp_no = s.emp_no;

--2)List first name, last name, and hire date for employees who were hired in 1986.
--Check table
Select * from employees

--filter the data ....
create view vw_emp_hired_1986 as 
select first_name,last_name,hire_date 
from employees 
where hire_date between '1986-01-01' and '1986-12-31';

--3)List the manager of each department with the following information: 
--department number, department name, the manager's employee number, last name, first name.

--Check table
Select * from managers
Select * from departments
Select * from employees

--join columns and filter the data
create view vw_dept_managers as
Select m.dept_no,d.dept_name,m.emp_no,e.last_name,e.first_name
from managers as m
JOIN  departments as d 
on m.dept_no = d.dept_no
JOIN employees as e
on m.emp_no = e.emp_no;


--4)List the department of each employee with the following information: 
--employee number, last name, first name, and department name.
--Check table
Select * from departments
Select * from employees
select * from dept_emp_numbers

CREATE VIEW departament_view as
Select e.emp_no,e.last_name,e.first_name,d.dept_name
from employees as e
JOIN  dept_emp_numbers as de
on e.emp_no = de.emp_no
JOIN departments as d
on d.dept_no = de.dept_no;

--5)List first name, last name, and sex for employees 
--whose first name is "Hercules" and last names begin with "B."
--Check table
Select * from employees

create view vw_emp_hercules_b as
Select first_name,last_name,sex 
from employees
where first_name='Hercules' and last_name like 'B%';


--6) List all employees in the Sales department, 
--including their employee number, last name, first name, and department name.
--Check table
Select * from employees
Select * from departments
Select * from dept_emp_numbers

create view vw_emp_sales_dept as
select e.emp_no,e.last_name,e.first_name,d.dept_name
from employees as e
JOIN  dept_emp_numbers as de
on e.emp_no=de.emp_no
JOIN  departments as d
on d.dept_no=de.dept_no
where dept_name='Sales';

--7) List all employees in the Sales and Development departments, 
--including their employee number, last name, first name, and department name.
Select * from employees
Select * from departments
Select * from dept_emp_numbers

create view vw_emp_sales_dev_dept as
select e.emp_no,e.last_name,e.first_name,d.dept_name
from employees as e
JOIN  dept_emp_numbers as de
on e.emp_no=de.emp_no
JOIN  departments as d
on d.dept_no=de.dept_no
where dept_name = 'Sales' or dept_name = 'Development';

--8) In descending order, list the frequency count of employee last names, 
--i.e., how many employees share each last name.
--Check table
Select * from employees

create view vw_emp_last_name_freq as
Select last_name,count(emp_no) 
from employees
Group by last_name
order by count desc;

-- Bonus (Optional)
