CREATE TABLE employee(
emp_id INT PRIMARY KEY,
first_name VARCHAR(40),
last_name VARCHAR(40),
birth_day INT,
sex VARCHAR(1),
salary INT,
super_id INT,
branch_id INT);

CREATE TABLE branch(
branch_id INT PRIMARY KEY,
branch_name VARCHAR(40),
mgr_id INT,
mgr_start_date DATE,
FOREIGN KEY(mgr_id) REFERENCES employee(emp_id) ON DELETE SET NULL);

ALTER TABLE employee
DROP COLUMN birth_day; 

ALTER TABLE employee
ADD COLUMN birth_day DATE;



