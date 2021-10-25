-- Creating tables for PH-EmployeeDB
CREATE TABLE departments (
    dept_no VARCHAR(4) NOT NULL,
	-- Creates a column named 'dept_no' that can hold up to 4 varying characters.
	-- NOT NULL means that no null fields will be allowed when importing data
    dept_name VARCHAR(40) NOT NULL,
    PRIMARY KEY (dept_no),
    UNIQUE (dept_name)
	-- Adds a unique constraint to the dept_name column
);

-- ');' signals that the 'create table' statement is done
-- Parameters within parenthesis are indented to improve readability
-- Table names are typically written in lowercase, while the rest 
	-- is written in uppercase.
-- Highlight to run a specific line of code; this helps avoid dirty data

CREATE TABLE employees (
	 emp_no INT NOT NULL,
     birth_date DATE NOT NULL,
     first_name VARCHAR NOT NULL,
     last_name VARCHAR NOT NULL,
     gender VARCHAR NOT NULL,
     hire_date DATE NOT NULL,
     PRIMARY KEY (emp_no)
);

CREATE TABLE dept_manager (
	dept_no VARCHAR(4) NOT NULL,
    emp_no INT NOT NULL,
    from_date DATE NOT NULL,
    to_date DATE NOT NULL,
FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
    PRIMARY KEY (emp_no, dept_no)
);

-- 'FOREIGN KEY (column_name)' specifies which of the current table's columns
	-- is linked to another table.
-- 'REFERENCES table_name (column_name)' tells Postgres which other 
	-- table uses that column as a primary key.

CREATE TABLE salaries (
  	emp_no INT NOT NULL,
  	salary INT NOT NULL,
  	from_date DATE NOT NULL,
  	to_date DATE NOT NULL,
  	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
  	PRIMARY KEY (emp_no)
);

CREATE TABLE dept_emp(
	emp_no INT NOT NULL,
	dept_no VARCHAR(4) NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
	PRIMARY KEY (emp_no, dept_no)
);

CREATE TABLE titles (
  	emp_no INT NOT NULL,
  	title VARCHAR NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no)
);

SELECT * FROM departments;

-- 'SELECT' tells Postgres that we're about to query the database
-- Asterisk tells Postgress that we're looking for every column in a table
-- 'FROM departments' tells pgAdmin which table to search
-- ';' signifies completion of query
