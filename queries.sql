-- Determine retirement eligibility
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31';

-- Determine employees born in 1952
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1952-12-31';

-- Determine employees born in 1953
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1953-01-01' AND '1953-12-31';

-- Determine employees born in 1954
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1954-01-01' AND '1954-12-31';

-- Determine employees born in 1955
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1955-01-01' AND '1955-12-31';

-- Narrow the Search for Retirement Eligibility
SELECT first_name, last_name
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31') 
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Determine the number of employees retiring
SELECT count(first_name)
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Save data into a new table "retirement info"
-- select first_name, last_name
-- into retirement_info
-- from employees
-- where (birth_date between '1952-01-01' and '1955-12-31')
-- and (hire_date between '1985-01-01' and '1988-12-31');
-- Check the table
-- select * from retirement_info;

-- Create a new table for retiring employees
SELECT emp_no, first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');
-- Check the table
SELECT * FROM retirement_info;

-- Join the "retirement_info" and "dept_emp" tables
SELECT retirement_info.emp_no,
	retirement_info.first_name,
	retirement_info.last_name,
	dept_emp.to_date
FROM retirement_info
LEFT JOIN dept_emp
ON retirement_info.emp_no = dept_emp.emp_no;

-- Use aliases in the code above^ to make code cleaner
SELECT ri.emp_no,
	ri.first_name,
	ri.last_name,
	de.to_date
FROM retirement_info AS ri --this is where the alias 'ri' gets defined
LEFT JOIN dept_emp AS de --this is where the alias 'de' gets defined
ON ri.emp_no = de.emp_no;
-- NOTE: these aliases only exist within this query; they aren't committed to that database

-- Join the "departments" and "managers" tables
SELECT dpt.dept_name,
	mgr.emp_no,
	mgr.from_date,
	mgr.to_date
FROM departments AS dpt
INNER JOIN managers AS mgr
ON dpt.dept_no = mgr.dept_no;

-- Join the "retirement_info" and "dept_emp" tables to make sure they're still employed
SELECT ri.emp_no,
	ri.first_name,
	ri.last_name,
	de.to_date
INTO current_emp
FROM retirement_info AS ri
LEFT JOIN dept_emp AS de
ON ri.emp_no = de.emp_no
WHERE de.to_date = ('9999-01-01');
-- Check the table
SELECT * FROM current_emp;

-- Determine the employee count by department number
SELECT count(ce.emp_no), de.dept_no
INTO emp_count_by_dept_no
FROM current_emp AS ce
LEFT JOIN dept_emp AS de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;

-- Create the 1st List: Employee Information
-- Here, we are using a modified version of the "retirement_info" table to include salaries 
-- and renaming the table to "emp_info"
SELECT e.emp_no, 
	e.first_name, 
	e.last_name,
	e.gender,
	s.salary,
	de.to_date
INTO emp_info
FROM employees AS e
	INNER JOIN salaries AS s
		ON (e.emp_no = s.emp_no)
	INNER JOIN dept_emp AS de
		ON (e.emp_no = de.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
	AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
	AND (de.to_date = '9999-01-01');

-- Create the 2nd List: Management
SELECT mgr.dept_no,
	dpt.dept_name,
	mgr.emp_no,
	ce.last_name,
	ce.first_name,
	mgr.from_date,
	mgr.to_date
INTO manager_info
FROM managers AS mgr
	INNER JOIN departments AS dpt
		ON (mgr.dept_no = dpt.dept_no)
	INNER JOIN current_emp AS ce
		ON (mgr.emp_no = ce.emp_no);
		
-- Create the 3rd List: Department Retirees
SELECT ce.emp_no,
	ce.first_name,
	ce.last_name,
	dpt.dept_name
INTO dept_info
FROM current_emp AS ce
	INNER JOIN dept_emp AS de
		ON (ce.emp_no = de.emp_no)
	INNER JOIN departments AS dpt
		ON (de.dept_no = dpt.dept_no);
        
-- Skill Drill 7.3.6: Create a query that returns the info relevant to the Sales Team
-- Requested list includes: employee numbers, first name, last name, department name
SELECT ce.emp_no,
	ce.first_name,
	ce.last_name,
	de.dept_no,
	dpt.dept_name
FROM current_emp AS ce
	INNER JOIN dept_emp AS de
		ON (ce.emp_no = de.emp_no)
	INNER JOIN departments AS dpt
		ON (de.dept_no = dpt.dept_no)
WHERE dept_name = 'Sales';

-- Skill Drill 7.3.6: Create a query that returns the following info for the Sales & Development Teams
-- Requested list includes: employee numbers, first name, last, department name
SELECT ce.emp_no,
	ce.first_name,
	ce.last_name,
	de.dept_no,
	dpt.dept_name
FROM current_emp AS ce
	INNER JOIN dept_emp AS de
		ON (ce.emp_no = de.emp_no)
	INNER JOIN departments AS dpt
		ON (de.dept_no = dpt.dept_no)
WHERE dept_name IN ('Sales', 'Development');     