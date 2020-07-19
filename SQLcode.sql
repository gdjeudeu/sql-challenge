-- Data Engineering

--Use the information you have to create a table schema for each of the six CSV files.
--Remember to specify data types, primary keys, foreign keys, and other constraints.

CREATE TABLE Department (
    dept_no VARCHAR   NOT NULL,
    dept_name VARCHAR   NOT NULL,
    CONSTRAINT "pk_Department" PRIMARY KEY (
        dept_no
     )
);
CREATE TABLE Department_Employee (
    emp_no INTEGER   NOT NULL,
    dept_no VARCHAR   NOT NULL
);
CREATE TABLE Department_Manager (
    dept_no VARCHAR   NOT NULL,
    emp_no INTEGER   NOT NULL
);
CREATE TABLE Employees (
    emp_no INTEGER   NOT NULL,
    emp_title_id VARCHAR   NOT NULL,
    birth_day VARCHAR   NOT NULL,
    first_name VARCHAR   NOT NULL,
    last_name VARCHAR   NOT NULL,
    sex VARCHAR   NOT NULL,
    hire_date VARCHAR   NOT NULL,
    CONSTRAINT "pk_Employees" PRIMARY KEY (
        emp_no
     )
);
CREATE TABLE Salaries (
    emp_no INTEGER   NOT NULL,
    salary INTEGER   NOT NULL
);
CREATE TABLE Titles (
    title_id VARCHAR   NOT NULL,
    title VARCHAR   NOT NULL,
    CONSTRAINT pk_Titles PRIMARY KEY (
        title_id
     )
);
ALTER TABLE Department_Employee ADD CONSTRAINT fk_Department_Employee_emp_no FOREIGN KEY(emp_no)
REFERENCES Employees (emp_no);
ALTER TABLE Department_Employee ADD CONSTRAINT fk_Department_Employee_dept_no FOREIGN KEY(dept_no)
REFERENCES Department (dept_no);
ALTER TABLE Department_Manager ADD CONSTRAINT fk_Department_Manager_dept_no FOREIGN KEY(dept_no)
REFERENCES Department (dept_no);
ALTER TABLE Department_Manager ADD CONSTRAINT fk_Department_Manager_emp_no FOREIGN KEY(emp_no)
REFERENCES Employees (emp_no);
ALTER TABLE Employees ADD CONSTRAINT fk_Employees_emp_title_id FOREIGN KEY(emp_title_id)
REFERENCES Titles (title_id);
ALTER TABLE Salaries ADD CONSTRAINT fk_Salaries_emp_no FOREIGN KEY(emp_no)
REFERENCES Employees (emp_no);


-- Data Analysis

-- 1. List the following details of each employee: employee number, last name, first name, sex, and salary.
SELECT employees.emp_no, employees.first_name, employees.last_name, employees.sex, salaries.salary
FROM employees
INNER JOIN salaries ON employees.emp_no = salaries.emp_no;

--2. List first name, last name, and hire date for employees who were hired in 1986.
SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date LIKE '%/1986'

--3. List the manager of each department with the following information: department number, 
--   department name, the manager's employee number, last name, first name.
CREATE VIEW Q3 AS
SELECT
    Employees.emp_no, Employees.first_name, Employees.last_name, Department_Manager.dept_no
FROM Employees
INNER JOIN
    Department_Manager
ON
    Employees.emp_no = Department_Manager.emp_no;
	
SELECT *
FROM Q3
INNER JOIN
	Department
ON
	Department.dept_no = Q3.dept_no;
	
-- 4. List the department of each employee with the following information: 
--    employee number, last name, first name, and department name. 
SELECT
    Employees.emp_no, Employees.first_name, Employees.last_name, Department.dept_name
FROM Employees
INNER JOIN
    Department_Employee
ON
    Employees.emp_no = Department_Employee.emp_no
INNER JOIN
	Department
ON
	Department_Employee.dept_no = Department.dept_no


-- 5. List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."
SELECT first_name, last_name, sex
FROM Employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';


-- 6. List all employees in the Sales department, including their employee number, last name, first name, and department name.
SELECT
    Employees.emp_no, Employees.first_name, Employees.last_name, Department.dept_name
FROM Employees
INNER JOIN
    Department_Employee
ON
    Employees.emp_no = Department_Employee.emp_no
INNER JOIN
	Department
ON
	Department_Employee.dept_no = Department.dept_no
WHERE dept_name = 'Sales'


-- 7. List all employees in the Sales and Development departments, including their employee number,
--    last name, first name, and department name.
SELECT
    Employees.emp_no, Employees.first_name, Employees.last_name, Department.dept_name
FROM Employees
INNER JOIN
    Department_Employee
ON
    Employees.emp_no = Department_Employee.emp_no
INNER JOIN
	Department
ON
	Department_Employee.dept_no = Department.dept_no
WHERE dept_name = 'Sales' OR dept_name = 'Development';


-- 8. In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
SELECT last_name, count(last_name)
FROM Employees
GROUP BY last_name
ORDER BY count(last_name) DESC;