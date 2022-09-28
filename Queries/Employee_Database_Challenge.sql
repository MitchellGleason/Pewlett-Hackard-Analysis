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