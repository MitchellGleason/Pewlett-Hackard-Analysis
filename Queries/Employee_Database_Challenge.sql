-- Create retirement_titles table
SELECT 
    emp.emp_no,
    emp.first_name,
    emp.last_name,
    tls.title,
    tls.from_date,
    tls.to_date
INTO retirement_titles
FROM employees AS emp
LEFT JOIN titles AS tls
ON tls.emp_no = emp.emp_no
WHERE (emp.birth_date  BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY emp.emp_no;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (rtt.emp_no) 
	rtt.emp_no, 
    rtt.first_name, 
    rtt.last_name, 
    rtt.title
INTO unique_titles
FROM retirement_titles as rtt
WHERE rtt.to_date = '9999-01-01'
ORDER BY rtt.emp_no, rtt.to_date DESC;

-- Create retiring_titles table
SELECT 
    COUNT (title),
	title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY COUNT (title) DESC;

-- Create mentorship_eligibility table
SELECT DISTINCT ON (emp.emp_no)
    emp.emp_no,
    emp.first_name,
    emp.last_name,
    emp.birth_date,
    d_emp.from_date,
    d_emp.to_date,
    tls.title
INTO mentorship_eligibility
FROM employees AS emp
LEFT JOIN dept_emp AS d_emp
    ON (emp.emp_no = d_emp.emp_no)
LEFT JOIN titles AS tls
    ON (emp.emp_no = tls.emp_no)
WHERE d_emp.to_date = '9999-01-01'
    AND (emp.birth_date  BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY emp.emp_no ASC;

-- Select retiring employees grouped by birth year
SELECT
	COUNT (EXTRACT (year FROM employees.birth_date)),
	EXTRACT (year FROM employees.birth_date)
FROM employees
LEFT JOIN dept_emp ON (employees.emp_no = dept_emp.emp_no)
WHERE (employees.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
	AND dept_emp.to_date = '9999-01-01'
GROUP BY EXTRACT (year FROM employees.birth_date)
ORDER BY EXTRACT (year FROM employees.birth_date);

-- Select retiring employees grouped by birth year and department
SELECT
	COUNT (EXTRACT (year FROM employees.birth_date)),
	dept_emp.dept_no,
	departments.dept_name,
	EXTRACT (year FROM employees.birth_date)
FROM employees
LEFT JOIN dept_emp ON (employees.emp_no = dept_emp.emp_no)
LEFT JOIN departments ON (dept_emp.dept_no = departments.dept_no)
WHERE (employees.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
	AND dept_emp.to_date = '9999-01-01'
GROUP BY EXTRACT (year FROM employees.birth_date), dept_emp.dept_no, departments.dept_name;

-- Select number of employees not retiring per department
SELECT
	COUNT (EXTRACT (year FROM employees.birth_date)),
	departments.dept_name
FROM employees
LEFT JOIN dept_emp ON (employees.emp_no = dept_emp.emp_no)
LEFT JOIN departments ON (dept_emp.dept_no = departments.dept_no)
WHERE (employees.birth_date BETWEEN '1956-01-01' AND '2022-12-31')
	AND dept_emp.to_date = '9999-01-01'
GROUP BY departments.dept_name;

-- Select number of employees retiring per department
SELECT
	COUNT (EXTRACT (year FROM employees.birth_date)),
	departments.dept_name
FROM employees
LEFT JOIN dept_emp ON (employees.emp_no = dept_emp.emp_no)
LEFT JOIN departments ON (dept_emp.dept_no = departments.dept_no)
WHERE (employees.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
	AND dept_emp.to_date = '9999-01-01'
GROUP BY departments.dept_name;

-- Line graph showing employees by birth year
SELECT
	COUNT (EXTRACT (year FROM employees.birth_date)),
	EXTRACT (year FROM employees.birth_date)
FROM employees
LEFT JOIN dept_emp ON (employees.emp_no = dept_emp.emp_no)
WHERE dept_emp.to_date = '9999-01-01'
GROUP BY EXTRACT (year FROM employees.birth_date)
ORDER BY EXTRACT (year FROM employees.birth_date);