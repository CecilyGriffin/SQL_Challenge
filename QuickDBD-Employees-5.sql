-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- Link to schema: https://app.quickdatabasediagrams.com/#/d/QLstny
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.


CREATE TABLE "departments" (
    "dept_no" VARCHAR   NOT NULL,
    "dept_name" VARCHAR   NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY (
        "dept_no"
     )
);

CREATE TABLE "dept_emp" (
    "emp_no" VARCHAR   NOT NULL,
    "dept_no" VARCHAR   NOT NULL
);

CREATE TABLE "dept_manager" (
    "dept_no" VARCHAR   NOT NULL,
    "emp_no" VARCHAR   NOT NULL
);

CREATE TABLE "titles" (
    "title_id" VARCHAR   NOT NULL,
    "title" VARCHAR   NOT NULL,
    CONSTRAINT "pk_titles" PRIMARY KEY (
        "title_id"
     )
);

CREATE TABLE "salaries" (
    "emp_no" VARCHAR   NOT NULL,
    "salary" INT   NOT NULL
);

CREATE TABLE "employees" (
    "emp_no" VARCHAR   NOT NULL,
    "emp_title_id" VARCHAR   NOT NULL,
    "birth_date" DATE   NOT NULL,
    "first_name" VARCHAR(15)   NOT NULL,
    "last_name" VARCHAR(15)   NOT NULL,
    "sex" VARCHAR(10)   NOT NULL,
    "hire_date" DATE   NOT NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY (
        "emp_no"
     )
);

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "salaries" ADD CONSTRAINT "fk_salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");


COPY departments FROM '/Users/mercygriffin/KU Assignments/SQL_Challenge/EmployeeSQL/departments.csv' CSV HEADER;

--alter table employees
--alter column last_name type character varying(30)

COPY employees FROM '/Users/mercygriffin/KU Assignments/SQL_Challenge/EmployeeSQL/employees.csv' CSV HEADER;

COPY salaries FROM '/Users/mercygriffin/KU Assignments/SQL_Challenge/EmployeeSQL/salaries.csv' CSV HEADER;

COPY titles FROM '/Users/mercygriffin/KU Assignments/SQL_Challenge/EmployeeSQL/titles.csv' CSV HEADER;

COPY dept_emp FROM '/Users/mercygriffin/KU Assignments/SQL_Challenge/EmployeeSQL/dept_emp.csv' CSV HEADER;

COPY dept_manager FROM '/Users/mercygriffin/KU Assignments/SQL_Challenge/EmployeeSQL/dept_manager.csv' CSV HEADER;

-- details of each employee: employee number, last name, first name, sex, and salary.
select  e.emp_no as "Employee Number", last_name as "Last Name", first_name as "First Name", sex as Sex, salary as Salary
from employees e
inner join salaries s
on e.emp_no = s.emp_no

-- first name, last name, and hire date for employees who were hired in 1986
select first_name, last_name, hire_date from employees where hire_date >= '01/01/1986' and hire_date <= '12/31/1986'

-- manager of each department with the following information: department number, department name, the manager's employee number, last name, first name
select dm.dept_no, d.dept_name, e.emp_no, e.last_name, e.first_name from dept_manager dm
inner join departments d
on d.dept_no = dm.dept_no
inner join employees e on dm.emp_no = e.emp_no

--department of each employee with the following information: employee number, last name, first name, and department name
select e.emp_no, e.last_name, e.first_name, d.dept_name from departments d
inner join dept_emp de
on d.dept_no = de.dept_no
inner join employees e 
on e.emp_no = de.emp_no

--first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."
select first_name, last_name, sex from employees where first_name = 'Hercules' and last_name like 'B%' 

--all employees in the Sales department, including their employee number, last name, first name, and department name
select e.emp_no, e.last_name, e.first_name, d.dept_name from employees e
inner join dept_emp de
on de.emp_no = e.emp_no 
inner join departments d
on d.dept_no = de.dept_no
WHERE dept_name = 'Sales'

--all employees in the Sales and Development departments, including their employee number, last name, first name, and department name
select e.emp_no, e.last_name, e.first_name, d.dept_name from employees e
inner join dept_emp de
on de.emp_no = e.emp_no 
inner join departments d
on d.dept_no = de.dept_no
WHERE dept_name = 'Sales' or dept_name = 'Development'

--In descending order, list the frequency count of employee last names, i.e., how many employees share each last name
select last_name, count(*) as "count" from employees
group by last_name
order by 2 desc


