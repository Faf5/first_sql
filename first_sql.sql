--CREATING TABLES IN MY COMPANY DATABASE

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

ALTER TABLE employee
ADD FOREIGN KEY (branch_id)
REFERENCES branch(branch_id)
ON DELETE SET NULL;

ALTER TABLE employee 
ADD FOREIGN KEY (super_id)
REFERENCES employee(emp_id)
ON DELETE SET NULL;

CREATE TABLE client(
client_id INT PRIMARY KEY,
client_name VARCHAR(40),
branch_id INT,
FOREIGN KEY(branch_id) REFERENCES branch(branch_id)
ON DELETE SET NULL);


CREATE TABLE branch_supplier(
branch_id INT,
supplier_name VARCHAR(40),
supplier_type VARCHAR(40),
PRIMARY KEY(branch_id, supplier_name),
FOREIGN KEY(branch_id) REFERENCES branch(branch_id) ON DELETE CASCADE);

SELECT * FROM works_with;
DROP TABLE works_with;

CREATE TABLE works_with(
emp_id INT,
client_id INT,
total_sales INT,
PRIMARY KEY(emp_id, client_id),
FOREIGN KEY(emp_id) REFERENCES employee(emp_id) ON DELETE CASCADE,
FOREIGN KEY(client_id) REFERENCES client(client_id) ON DELETE CASCADE);

SHOW CREATE TABLE employee;

SELECT * FROM employee;

--ME TRYING TO DROP THE CONSTRAINT IN ORDER TO DROP THE EMPLOYEE TABLE AND 
--REDO IT AFTER I REALISED THAT THE ORDER OF THE COLUMNS WERE WRONG AND I DIDNT KNOW HOW TO FIX IT

ALTER TABLE employee
DROP CONTRAINT (branch_id)
REFERENCES branch(branch_id);

DROP TABLE employee;

--I READ ON STACK OVERFLOW THAT I FIRST NEED TO DROP THE TABLE WITH THE CONSTRAINT WHICH IS BRANCH IN MY CASE AND CREATE BOTH 
--employee and branch FROM SCARTCH, OH BOY

-- LOL CANT DROP branch because then I have to drop other tables as well. there should be another way, back to Google

SELECT *
FROM sys.foreign_keys
WHERE employee(branch_id) = branch(branch_id);

--EUREKA I FOUND THE SOLUTION ON STACK OVERFLOW There is a configuration to turn off the check and turn it on.
--For example, if you are using MySQL, then to turn it off, you must write SET foreign_key_checks = 0;
--Then delete or clear the table, and re-enable the check SET foreign_key_checks = 1;


SET foreign_key_checks = 0;

DROP TABLE employee;

CREATE TABLE employee(
emp_id INT PRIMARY KEY,
first_name VARCHAR(40),
last_name VARCHAR(40),
birth_date DATE,
sex VARCHAR(1),
salary INT,
super_id INT,
branch_id INT);

SET foreign_key_checks = 1;

--INSERTING DATA INTO TABLES

--CORPORATE BRANCH ENTER INFO
INSERT INTO employee VALUES('100', 'David', 'Wallace', '1963/11/17','M', '250000', NULL, NULL);
INSERT INTO branch VALUES(1, 'Corporate', 100, '2006/02/09');

UPDATE employee
SET branch_id = 1
WHERE emp_id =100;

INSERT INTO employee VALUES(101, 'Jan', 'Levinston', '1961/05/11', 'F', '110000', 100, 1);

--SCRANTON BRANCH ENTER INFO

INSERT INTO employee VALUES(102, 'Micheal', 'Scott', '1964/03/15', 'M', '75000', 100, NULL);
INSERT INTO branch VALUES(2, 'Scranton', 100, '1992/04/06');

UPDATE branch
SET mgr_id = 102
WHERE branch_id = 2;

UPDATE employee
SET branch_id = 2
WHERE emp_id = 102;

INSERT INTO employee VALUES(103, 'Angela', 'Martin', '1971/06/25', 'M', '63000', 102, 2);
INSERT INTO employee VALUES(104, 'Kelly', 'Kapoor', '1980/02/05', 'F', '55000', 102, 2);
INSERT INTO employee VALUES(105, 'Stanley', 'Hudson', '1958/02/19', 'F', '69000', 102, 2);

--STAMFORD ENTER INFO

INSERT INTO employee VALUES(106, 'Josh', 'Porter', '1989/09/06', 'M', '78000', 100, NULL);

UPDATE employee
SET branch_id = 3
WHERE emp_id =106;

INSERT INTO employee VALUES(107, 'Andy', 'Bernard', '1973/07/22', 'M', '65000',106, 3);
INSERT INTO employee VALUES(108, 'Jen', 'Helpoot', '1978/10/01', 'M', '71000', 106, 3);
INSERT INTO branch VALUES(3, 'Stamford', 106, '1998/02/13');

--CLIENT ENTER INFO 
INSERT INTO client VALUES(400, 'Dunmore Highschool', 2);
INSERT INTO client VALUES(401, 'Lackwana Country', 2);
INSERT INTO client VALUES(402, 'FedEx', 3);
INSERT INTO client VALUES(403, 'John Daly Law, LLC', 3);
INSERT INTO client VALUES(404, 'Scranton Whitepages', 2);
INSERT INTO client VALUES(405, 'Times Newspaper', 3);
INSERT INTO client VALUES(406, 'FedEx', 2);

--BRANCH SUPPLIER ENTER INFO
INSERT INTO branch_supplier VALUES(2, 'Hammermill', 'Paper');
INSERT INTO branch_supplier VALUES(2, 'JT Forms and Labels', 'Custom Forms');
INSERT INTO branch_supplier VALUES(2, 'Uniball', 'Writing Utensils');
INSERT INTO branch_supplier VALUES(3, 'Hammermill', 'Paper');
INSERT INTO branch_supplier VALUES(3, 'Patriot Paper', 'Paper');
INSERT INTO branch_supplier VALUES(3, 'Stamford Labels', 'Custom forms');
INSERT INTO branch_supplier VALUES(3, 'Uniball', 'Writing Utensils');

--WORKS_WITH ENTER INFO

INSERT INTO works_with VALUES(102, 401, 267000);
INSERT INTO works_with VALUES(102, 406, 15000);
INSERT INTO works_with VALUES(105, 400, 55000);
INSERT INTO works_with VALUES(105, 404, 33000);
INSERT INTO works_with VALUES(105, 406, 130000);
INSERT INTO works_with VALUES(107, 403, 5000);
INSERT INTO works_with VALUES(107, 405, 26000);
INSERT INTO works_with VALUES(108, 402, 22500);
INSERT INTO works_with VALUES(108, 403, 12000);

SELECT * FROM employee;
SELECT * FROM branch;
SELECT * FROM client;
SELECT * FROM works_with;
SELECT * FROM branch_supplier;

--BASIC SQL QUERIES

--FIND ALL EMPLOYEES
SELECT * FROM employee;
--FIND ALL CLIENTS
SELECT * FROM client;
--FIND ALL EMPLOYEES ORDERED BY SALARY
SELECT * FROM employee
ORDER BY salary DESC;
--FIND ALL EMPLOYEES ORDER BY SEX THEN NAME
SELECT * FROM employee
ORDER BY sex, first_name, last_name;
--FIND THE FIRST AND LAST NAMES OF ALL EMPLOYEES
SELECT first_name, last_name FROM employee
LIMIT 5;
--FIND THE FORENAMES AND SURNAMES OF ALL EMPLOYEES
SELECT first_name AS forename, last_name AS surname FROM employee;
--FIND OUT ALL THE DIFFERENT GENDERS
SELECT sex FROM employee
WHERE sex UNIQUE;
SELECT DISTINCT sex FROM employee;

--FUNCTIONS

--FIND THE NUMBER OF EMPLOYEES
SELECT COUNT(emp_id) FROM employee;

--FIND THE NUMBER OF SUPERVISORS
SELECT COUNT(super_id) FROM employee;

--FIND THE NUMBER OF FEMALE EMPLOYEES BORN AFTER 1970
SELECT COUNT(emp_id) FROM employee
WHERE sex = 'F'AND birth_date > '1971-01-01';

--FIND THE AVERAGE OF ALL EMPLOYEES SALARIES
SELECT AVG(salary) FROM employee;

--FIND THE AVERAGE OF ALL EMPLOYEES SALARIES where sex is male
SELECT AVG(salary) FROM employee
WHERE sex = 'M';

--FIND THE SUM OF ALL EMPLOYEES SALARIES
SELECT SUM(salary) FROM employee;

--FIND OUT HOW MANY MALES AND FEMALES THERE IS IN THE COMPANY
SELECT COUNT(sex), sex FROM employee
GROUP BY sex;

--FIND THE TOTAL SALES OF EACH SALESMAN
SELECT SUM(total_sales), emp_id FROM works_with
GROUP BY emp_id;

--WILDCARDS
--FIND ANY CLIENTS WHO ARE AN LLC
SELECT * FROM client
WHERE client_name LIKE'%LLC';

--FIND ANY BRANCH SUPPLIERS WHO ARE IN THE LABLES BUSINESS
SELECT * FROM branch_supplier
WHERE supplier_name LIKE '%labels%';

--FIND ANY EMPLOYEE BORN IN OCTOBER
SELECT * FROM employee
WHERE birth_date LIKE '____-10-__';

--FIND ANY CLIENTS THAT ARE SCHOOLS
SELECT * FROM client
WHERE client_name LIKE '%school%';

--UNION QUERIES
--FIND A LIST OF EMPLOYEE AND BRANCH NAMES
SELECT first_name
FROM employee
UNION
SELECT branch_name
FROM branch;

--JOINS
INSERT INTO branch VALUES(4, 'Buffalo', NULL, NULL);

--FIND ALL BRANCHES AND NAMES OF THEIR MANAGERS(Join or inner Join)
SELECT employee.emp_id, employee.first_name, branch.branch_name
FROM employee
JOIN branch
ON employee.emp_id = branch.mgr_id;


--LEFT JOIN
SELECT employee.emp_id, employee.first_name, branch.branch_name
FROM employee
LEFT JOIN branch
ON employee.emp_id = branch.mgr_id;

--RIGHT JOIN
SELECT employee.emp_id, employee.first_name, branch.branch_name
FROM employee
RIGHT JOIN branch
ON employee.emp_id = branch.mgr_id;

--NESTED QUERIES
--FIND NAMES OF ALL EMPLOYEES WHO HAVE SOLD OVER 30 000 TO A SINGLE CLIENT
SELECT employee.first_name, employee.last_name
FROM employee
WHERE employee.emp_id IN 
( SELECT works_with.emp_id 
		FROM works_with
		WHERE works_with.total_sales > 30000);

--FIND ALL CLIENTS THAT ARE MANAGED BY THE BRANCH THAT MICHAEL SCOTT MANAGES
--ASSUME YOU KNOW MICHAELS ID

SELECT client.client_name
FROM client
WHERE client.branch_id = (SELECT branch.branch_id 
				FROM branch
                WHERE branch.mgr_id = 102
                LIMIT 1);







