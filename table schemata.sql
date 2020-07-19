Department
-
dept_no VARCHAR(255) PK
dept_name VARCHAR(255)

Department_Employee
-
emp_no INTEGER FK - Employees.emp_no
dept_no VARCHAR(255) FK - Department.dept_no

Department_Manager
-
dept_no VARCHAR(255) FK >- Titles.title_id
emp_no INTEGER FK - Employees.emp_no

Employees
-
emp_no INTEGER PK
emp_title_id VARCHAR(255) FK >- Titles.title_id
birth_day VARCHAR(255)
first_name VARCHAR(255)
last_name VARCHAR(255)
sex VARCHAR(255)
hire_date VARCHAR(255)

Salaries
-
emp_no INTEGER FK - Employees.emp_no
salary INTEGER

Titles
-
title_id VARCHAR(255) PK
title VARCHAR(255)
