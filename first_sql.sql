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

--CORPORATE BRANCH
INSERT INTO employee VALUES('100', 'David', 'Wallace', '1963/11/17','M', '250000', NULL, NULL);
INSERT INTO branch VALUES(1, 'Corporate', 100, '2006/02/09');

UPDATE employee
SET branch_id = 1
WHERE emp_id =100;

INSERT INTO employee VALUES(101, 'Jan', 'Levinston', '1961/05/11', 'F', '110000', 100, 1);

--SCRANTON BRANCH

INSERT INTO employee VALUES(102, 'Micheal', 'Scott', '1964/03/15', 'M', '75000', 100, NULL);
INSERT INTO branch VALUES(2, 'Scranton', 100, '1992/04/06');

UPDATE employee
SET branch_id = 2
WHERE emp_id = 102;

INSERT INTO employee VALUES(103, 'Angela', 'Martin', '1971/06/25', 'M', '63000', 102, 2);
INSERT INTO employee VALUES(104, 'Kelly', 'Kapoor', '1980/02/05', 'F', '55000', 102, 2);
INSERT INTO employee VALUES(105, 'Stanley', 'Hudson', '1958/02/19', 'F', '69000', 102, 2);

--STAMFORD

INSERT INTO employee VALUES(106, 'Josh', 'Porter', '1989/09/06', 'M', '78000', 100, NULL);

UPDATE employee
SET branch_id = 3
WHERE emp_id =106;

INSERT INTO employee VALUES(107, 'Andy', 'Bernard', '1973/07/22', 'M', '65000',106, 3);
INSERT INTO employee VALUES(108, 'Jen', 'Helpoot', '1978/10/01', 'M', '71000', 106, 3);
INSERT INTO branch VALUES(3, 'Stamford', 106, '1998/02/13');



SELECT * FROM employee;
SELECT * FROM branch;
SELECT * FROM client;
SELECT * FROM works_with;
SELECT * FROM branch_supplier;
