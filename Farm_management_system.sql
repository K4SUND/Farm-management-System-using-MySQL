create database Farm_management_system;

use Farm_management_system;

 create table SUPPLIER(
 Supplier_ID int not null,
 Supplier_name varchar(25) not null,
 Product_supplied varchar(25) not null,
 primary key(Supplier_ID)
 );
  
 create table SUPPLIER_CONTACT_INFO(
 Supplier_ID int,
 Contact_info varchar(25) not null,
 primary key(Supplier_ID,Contact_info),
 constraint fk1 foreign key(Supplier_ID) references SUPPLIER(Supplier_ID)
 on delete cascade
 on update cascade
 );
 
 create table HEAD_FARMER(
 Farmer_ID int,
 Farmer_name varchar(25) not null,
 Street varchar(25) not null,
 City varchar(25) not null,
 Province varchar(25) not null,
 Zip_code varchar(25) not null,
 primary key (Farmer_ID)
 );
  

 create table HEAD_FARMER_EMAIL(
 Farmer_ID int not null,
 Email varchar(50) not null,
 primary key(Farmer_ID,Email),
 constraint fk2 foreign key(Farmer_ID) references HEAD_FARMER(Farmer_ID)
 on delete cascade
 on update cascade
 ); 
 
 create table HEAD_FARMER_CONTACT(
 Farmer_ID int not null,
 Contact_info varchar(25) not null,
 primary key(Farmer_ID,Contact_info),
 constraint fk3 foreign key(Farmer_ID) references HEAD_FARMER(Farmer_ID)
 on delete cascade
 on update cascade
 );
  
 create table SUPPLIER_FARMER_ORDERING(
Supplier_ID int not null,
Farmer_ID int not null,
primary key(Supplier_ID,Farmer_ID),
 constraint fk4 foreign key(Supplier_ID) references SUPPLIER(Supplier_ID)
 on delete cascade
 on update cascade,
 constraint fk5 foreign key(Farmer_ID) references HEAD_FARMER(Farmer_ID)
 on delete cascade
 on update cascade
 );
 
 create table EQUIPMENT(
 Equipment_ID int not null,
 Modal varchar(50) not null,
 Equipment_type varchar(50) not null,
 Purchase_date date,
 Equipment_owner int,
 primary key(Equipment_ID),
 constraint fk6 foreign key(Equipment_owner) references HEAD_FARMER(Farmer_ID)
 on delete set null
 on update cascade
 );
 
 create table FIELD(
 Field_ID int not null,
 Field_name varchar(1) not null,
 Size varchar(25) not null,
 Field_owner int not null,
 primary key(Field_ID),
 constraint fk7 foreign key(Field_owner) references HEAD_FARMER(Farmer_ID)
 on delete cascade
 on update cascade
 );

create table UTILIZE(
Equipment_ID int not null,
Field_ID int not null,
primary key(Equipment_ID,Field_ID),
 constraint fk8 foreign key(Equipment_ID) references EQUIPMENT(Equipment_ID)
 on delete cascade
 on update cascade,
  constraint fk9 foreign key(Field_ID) references FIELD(Field_ID)
 on delete cascade
 on update cascade
);

create table EMPLOYEE(
Employee_ID int not null,
Employee_name varchar(50) not null,
Supervisor int,
Working_field int not null,
primary key(Employee_ID),
constraint fk10 foreign key(Supervisor) references EMPLOYEE(Employee_ID)
on delete set null
on update cascade,
constraint fk11 foreign key(Working_field) references FIELD(Field_ID)
on delete cascade
on update cascade
);

create table EMPLOYEE_EMAIL(
 Employee_ID int not null,
 Email varchar(50) not null,
 primary key(Employee_ID ,Email),
 constraint fk12 foreign key( Employee_ID) references EMPLOYEE(Employee_ID)
 on delete cascade
 on update cascade
);

create table EMPLOYEE_CONTACT_INFO(
 Employee_ID int not null,
 Contact_info varchar(25) not null,
 primary key(Employee_ID ,Contact_info),
 constraint fk13 foreign key( Employee_ID) references EMPLOYEE(Employee_ID)
 on delete cascade
 on update cascade
);

create table SALARY(
Employee_ID int not null,
Salary_month varchar(15) not null,
Working_hours int not null,
Payment_per_hour int not null,
Monthly_salary int generated always as (Working_hours*Payment_per_hour) stored,
primary key(Employee_ID,Salary_month),
constraint fk14 foreign key( Employee_ID) references EMPLOYEE(Employee_ID)
on delete cascade
on update cascade
);

create table CROP(
Crop_ID int not null,
Crop_name varchar(25) not null,
Variety varchar(25) not null,
Planting_date date,
Harvest_date date,
Crop_age int as (datediff(Harvest_date,Planting_date)),
primary key(Crop_ID)
);


create table CROP_PESTS(
Crop_ID int not null,
Pests varchar(25),
primary key(Crop_ID,Pests),
constraint fk15 foreign key( Crop_ID) references CROP(Crop_ID)
on delete cascade
on update cascade
);

create table CULTIVATE(
Field_ID int ,
Crop_ID int not null,
primary key(Field_ID,Crop_ID),
constraint fk16 foreign key( Field_ID) references FIELD(Field_ID)
on delete cascade
on update cascade,
constraint fk17 foreign key( Crop_ID) references CROP(Crop_ID)
on delete cascade
on update cascade
);

create table HARVEST(
Crop_ID int not null,
Harvest_month varchar(25) not null,
Quantity int,
primary key(Crop_ID,Harvest_month),
constraint fk18 foreign key( Crop_ID) references CROP(Crop_ID)
on delete cascade
on update cascade
);

INSERT INTO SUPPLIER (Supplier_ID, Supplier_name, Product_supplied) VALUES
(100, 'Saman', 'Urea'),
(101, 'Kumara', 'Urea'),
(102, 'Mahinda', 'Urea'),
(103, 'Anura', 'Potassium Nitrate'),
(104, 'Anura', 'Glyphosate'),
(105, 'Ranil', 'Glyphosate'),
(106, 'Ranil', 'Potassium Nitrate');

INSERT INTO SUPPLIER_CONTACT_INFO (Supplier_ID, Contact_info) VALUES
(100, '0714671827'),
(101, '0713341281'),
(102, '0711500145'),
(103, '0711697054'),
(104, '0717274645'),
(105, '0714962962'),
(106, '0714679584');

INSERT INTO HEAD_FARMER (Farmer_ID, Farmer_name, Street, City, Province, Zip_code) VALUES
(1, 'Dinesh', 'Main St', 'Colombo', 'Western', '00100'),
(2, 'Avishka', 'Main St', 'Gampaha', 'Western', '00100'),
(3, 'Kusal', '1st cross', 'Colombo', 'Western', '00100'),
(4, 'Pathum', '2nd cross', 'Colombo', 'Western', '00100'),
(5, 'Pathum', 'Main St', 'Kandy', 'Central', '20000'),
(6, 'Charith', 'Main St', 'Galle', 'Southern', '01100'),
(7, 'Sahan', 'Main St', 'Mathara', 'Southern', '01100');

INSERT INTO HEAD_FARMER_EMAIL (Farmer_ID, Email) VALUES
(1, 'Dinesh54@gmail.com'),
(2, 'Avishka25@gmail.com'),
(3, 'Kusal33@gmail.com'),
(4, 'Pathum25@gmail.com'),
(5, 'Pathum30@gmail.com'),
(6, 'Charith26@gmail.com'),
(7, 'Sahan27@gmail.com');


INSERT INTO HEAD_FARMER_CONTACT (Farmer_ID, Contact_info) VALUES
(1, '0706555701'),
(2, '0705528542'),
(3, '0704626573'),
(4, '0704196674'),
(5, '0709975075'),
(6, '0702851816'),
(7, '0707943187');

INSERT INTO SUPPLIER_FARMER_ORDERING (Supplier_ID, Farmer_ID) VALUES
(100, 1),
(100, 2),
(100, 3),
(102, 1),
(103, 2),
(104, 3),
(105, 6),
(106, 7),
(106, 1);

INSERT INTO EQUIPMENT (Equipment_ID, Modal, Equipment_type, Purchase_date, Equipment_owner) VALUES
(200, 'Kubota', 'Tractor', '2023-01-01', 1),
(201, 'Kubota', 'Tractor', '2023-01-01', 2),
(202, 'John Deere', 'Harvester', '2023-02-01', 3),
(203, 'John Deere', 'Seeder', '2023-02-01', 4),
(204, 'Agco', 'Sprayer', '2023-02-01', 5),
(205, 'Agco', 'Sprayer', '2023-03-01', 6),
(206, 'Agco', 'Harvester', '2023-03-01', 7),
(207, 'Kubota', 'Seeder', '2023-03-01', 1),
(208, 'Kubota', 'Seeder', '2023-03-01', 1),
(209, 'John Deere', 'Tractor', '2023-03-01', 2),
(210, 'John Deere', 'Seeder', null, null),
(211, 'Agco', 'Sprayer', null, null);



INSERT INTO FIELD (Field_ID, Field_name, Size, Field_owner) VALUES
(500, 'A', 'small', 1),
(501, 'A', 'large', 2),
(502, 'B', 'medium', 3),
(503, 'B', 'small', 4),
(504, 'C', 'large', 5),
(505, 'C', 'large', 6),
(506, 'C', 'medium', 7),
(507, 'D', 'large', 1),
(508, 'D', 'large', 2);


INSERT INTO UTILIZE (Equipment_ID, Field_ID) VALUES
(200, 500),
(201, 501),
(202, 502),
(203, 503),
(204, 504),
(205, 505),
(206, 506),
(207, 507),
(208, 508),
(209, 504),
(210, 501),
(211, 505),
(200, 507),
(201, 508);

INSERT INTO EMPLOYEE (Employee_ID, Employee_name, Supervisor, Working_field) VALUES
(1, 'Kasun', null, 500),
(2, 'Sameera', 1, 501),
(3, 'Nipun', null, 502),
(4, 'Ninada', 3, 503),
(5, 'Chamika', null, 504),
(6, 'Sanjana', 5, 505),
(7, 'Thurunu', 5, 506),
(8, 'Geeth', null, 507),
(9, 'Geeth', 8, 508),
(10, 'Ishini', 1, 501),
(11, 'Shamika', 5, 504),
(12, 'Ninada', 5, 505),
(13, 'Thisaru', 8, 507),
(14, 'Shamika', 8, 508);

INSERT INTO EMPLOYEE_EMAIL (Employee_ID, Email) VALUES
(1, 'Kasun1@gmail.com'),
(2, 'Sameera2@gmail.com'),
(3, 'Nipun3@gmail.com'),
(4, 'Ninada4@gmail.com'),
(5, 'Chamika5@gmail.com'),
(6, 'Sanjana6@gmail.com'),
(7, 'Thurunu7@gmail.com'),
(8, 'Geeth8@gmail.com'),
(9, 'Geeth9@gmail.com'),
(10, 'Ishini10@gmail.com'),
(11, 'Shamika11@gmail.com'),
(12, 'Ninada12@gmail.com'),
(13, 'Thisaru13@gmail.com'),
(14, 'Shamika14@gmail.com');


INSERT INTO EMPLOYEE_CONTACT_INFO (Employee_ID, Contact_info) VALUES
(1, '0771234567'),
(2, '0772345678'),
(3, '0773456789'),
(4, '0774567890'),
(5, '0775678901'),
(6, '0776789012'),
(7, '0777890123'),
(8, '0778901234'),
(9, '0779012345'),
(10, '0770123456'),
(11, '0771234567'),
(12, '0772345678'),
(13, '0773456789'),
(14, '0774567890');

INSERT INTO SALARY (Employee_ID, Salary_month, Working_hours, Payment_per_hour) VALUES
(1, 'JANUARY', 150, 400),(2, 'JANUARY', 180, 400),(3, 'JANUARY', 210, 400),(4, 'JANUARY', 150, 400),
(5, 'JANUARY', 180, 400),(6, 'JANUARY', 210, 400),(7, 'JANUARY', 150, 400),
(8, 'JANUARY', 180, 400),(9, 'JANUARY', 210, 400),(10, 'JANUARY', 150, 400),(11, 'JANUARY', 180, 400),
(12, 'JANUARY', 210, 400),(13, 'JANUARY', 150, 400),(14, 'JANUARY', 180, 400),
(1, 'FEBRUARY', 150, 450),(2, 'FEBRUARY', 180, 450),(3, 'FEBRUARY', 210, 450),(4, 'FEBRUARY', 150, 450),
(5, 'FEBRUARY', 180, 450),(6, 'FEBRUARY', 210, 450),(7, 'FEBRUARY', 150, 450),
(8, 'FEBRUARY', 180, 450),(9, 'FEBRUARY', 210, 450),(10, 'FEBRUARY', 150, 450),(11, 'FEBRUARY', 180, 450),
(12, 'FEBRUARY', 210, 450),(13, 'FEBRUARY', 150, 450),(14, 'FEBRUARY', 180, 450);


INSERT INTO CROP (Crop_ID, Crop_name, Variety, Planting_date, Harvest_date) VALUES
(10, 'Corn', 'Dent', '2023-01-01', '2023-06-01'),
(11, 'Wheat', 'Durum', '2023-01-01', '2023-06-01'),
(12, 'Rice', 'Basmati', '2023-02-01', '2023-07-01'),
(13, 'Carrot', 'Imperator', '2023-03-01', '2023-08-01'),
(14, 'Oats', 'Rolled', '2023-04-01', '2023-09-01'),
(15, 'Apple', 'Red', '2023-05-01', '2023-10-01'),
(16, 'Peanuts', 'Spanish', '2023-06-01', '2023-11-01'),
(17, 'Orange', 'Blood', '2023-07-01', '2023-12-01'),
(18, 'Potato', 'Two-rowed', '2023-07-01', '2023-12-01'),
(19, 'Wheat', 'Red', null, null),
(20, 'Cashew', 'Roasted', null, null);


INSERT INTO CROP_PESTS (Crop_ID, Pests) VALUES
(10, 'Corn earworm'),
(10, 'Corn rootworm'),
(11, 'Wheat stem sawfly'),
(11, 'Wheat midge'),
(12, 'Rice water weevil'),
(12, 'Rice stink bug'),
(13, 'Carrot rust fly'),
(13, 'Carrot weevil'),
(14, 'Oat aphid'),
(15, 'Codling moth'),
(16, ' Peanut leaf spot'),
(17, 'Citrus whitefly'),
(18, 'Potato aphid'),
(19, 'Hessian fly'),
(20, 'Cashew nut weevil');


INSERT INTO CULTIVATE (Field_ID, Crop_ID) VALUES
(500, 10),
(501, 11),
(502,12),
(503, 13),
(504, 14),
(505, 15),
(506, 16),
(507, 17),
(508, 18),
(501, 10),
(504, 12),
(505, 13),
(507, 14),
(508, 15);


INSERT INTO HARVEST (Crop_ID, Harvest_month, Quantity) VALUES
(10, 'JANUARY', 100),(11, 'JANUARY', 100),(12, 'JANUARY', 150),
(13, 'JANUARY', 200),(14, 'JANUARY', 250),(15, 'JANUARY', 300),
(16, 'JANUARY', 350),(17, 'JANUARY', 400),(18, 'JANUARY', 400),
(19, 'JANUARY', null),(20, 'JANUARY', null),
(10, 'FEBRUARY', 200),(11, 'FEBRUARY', 200),(12, 'FEBRUARY', 250),
(13, 'FEBRUARY', 300),(14, 'FEBRUARY', 350),(15, 'FEBRUARY', 400),
(16, 'FEBRUARY', 450),(17, 'FEBRUARY', 500),(18, 'FEBRUARY', 500),
(19, 'FEBRUARY', null),(20, 'FEBRUARY', null);


-- update and delete

UPDATE SUPPLIER
SET Supplier_name = 'Supun'
WHERE Supplier_ID = 101;

UPDATE SUPPLIER
SET Product_supplied = 'Glyphosate'
WHERE Supplier_ID = 102;

DELETE FROM SUPPLIER
WHERE Supplier_ID = 104;

UPDATE SUPPLIER_CONTACT_INFO
SET Contact_info = '0714431825'
WHERE Supplier_ID = 101;

UPDATE SUPPLIER_CONTACT_INFO
SET Contact_info = '0717051699'
WHERE Supplier_ID = 103;

DELETE FROM SUPPLIER_CONTACT_INFO
WHERE Supplier_ID = 105;

UPDATE HEAD_FARMER
SET Zip_code = '00101'
WHERE Farmer_ID = 4;

UPDATE HEAD_FARMER
SET Zip_code = '01101'
WHERE Farmer_ID = 6;

DELETE FROM HEAD_FARMER
WHERE Farmer_ID = 2;

UPDATE HEAD_FARMER_EMAIL
SET Email = 'Dinesh70@gmail.com'
WHERE Farmer_ID = 1;

UPDATE HEAD_FARMER_EMAIL
SET Email = 'Pathum26@gmail.com'
WHERE Farmer_ID = 4;

DELETE FROM HEAD_FARMER_EMAIL
WHERE Farmer_ID = 6;

UPDATE HEAD_FARMER_CONTACT
SET Contact_info = '0706564704'
WHERE Farmer_ID = 1;

UPDATE HEAD_FARMER_CONTACT
SET Contact_info = '0704196666'
WHERE Farmer_ID = 4;

DELETE FROM HEAD_FARMER_CONTACT
WHERE Farmer_ID = 7;

UPDATE SUPPLIER_FARMER_ORDERING
SET Farmer_ID = 5
WHERE Supplier_ID = 105;


UPDATE SUPPLIER_FARMER_ORDERING
SET Farmer_ID = 4
WHERE Supplier_ID = 102;


DELETE FROM SUPPLIER_FARMER_ORDERING
WHERE Supplier_ID = 106;

UPDATE EQUIPMENT
SET Modal = 'Agco'
WHERE Equipment_ID = 201;

UPDATE EQUIPMENT
SET Purchase_date = '2023-03-15'
WHERE Equipment_ID = 204;

DELETE FROM EQUIPMENT
WHERE Equipment_ID = 205;

UPDATE FIELD
SET Size = 'Small'
WHERE Field_ID = 502;

UPDATE FIELD
SET Size = 'Medium'
WHERE Field_ID = 503;


DELETE FROM FIELD
WHERE Field_ID = 504;


UPDATE UTILIZE
SET Field_ID = 505
WHERE Equipment_ID = 210;

UPDATE UTILIZE
SET Equipment_ID = 200
WHERE Field_ID = 508;

DELETE FROM UTILIZE
WHERE Equipment_ID = 209;


UPDATE EMPLOYEE
SET Employee_name = 'Sandun'
WHERE Employee_ID = 2;

UPDATE EMPLOYEE
SET Working_field = 506
WHERE Employee_ID = 12;


DELETE FROM EMPLOYEE
WHERE Employee_ID = 11;



UPDATE EMPLOYEE_EMAIL
SET Email = 'Samiya2'
WHERE Employee_ID = 2;

UPDATE EMPLOYEE_EMAIL
SET Email = 'NipunDilshan3'
WHERE Employee_ID = 3;


DELETE FROM EMPLOYEE_EMAIL
WHERE Employee_ID = 7;

UPDATE EMPLOYEE_CONTACT_INFO
SET Contact_info = '0772345670'
WHERE Employee_ID = 2;

UPDATE EMPLOYEE_CONTACT_INFO
SET Contact_info = '0773456780'
WHERE Employee_ID = 3;

DELETE FROM EMPLOYEE_CONTACT_INFO
WHERE Employee_ID = 8;

UPDATE SALARY
SET Working_hours = 160
WHERE Employee_ID = 1 AND Salary_month = 'JANUARY';

UPDATE SALARY
SET Payment_per_hour = 500
WHERE Employee_ID = 3 AND Salary_month = 'JANUARY';

DELETE FROM SALARY
WHERE Employee_ID = 4 AND Salary_month = 'JANUARY';

UPDATE CROP
SET Planting_date = '2023-02-15'
WHERE Crop_ID = 12;

UPDATE CROP
SET Harvest_date = '2023-07-15'
WHERE Crop_ID = 13;

DELETE FROM CROP
WHERE Crop_ID = 14;

UPDATE CROP_PESTS
SET Pests = 'Corn borer'
WHERE Crop_ID = 10 AND Pests = 'Corn earworm';

UPDATE CROP_PESTS
SET Pests = 'Rice blast'
WHERE Crop_ID = 12 AND Pests = 'Rice stink bug';

DELETE FROM CROP_PESTS
WHERE Crop_ID = 15;

UPDATE CULTIVATE
SET Crop_ID = 10
WHERE Field_ID = 504 AND Crop_ID = 12;

UPDATE CULTIVATE
SET Field_ID = 500
WHERE Field_ID = 508 AND Crop_ID = 15;

DELETE FROM CULTIVATE
WHERE Field_ID = 505 AND Crop_ID = 13;

UPDATE HARVEST
SET Quantity = 250
WHERE Crop_ID = 10 AND Harvest_month = 'JANUARY';

UPDATE HARVEST
SET Quantity = 250
WHERE Crop_ID = 11 AND Harvest_month = 'FEBRUARY';

DELETE FROM HARVEST
WHERE Crop_ID = 12 ;

-- simple

-- Retrieve all records from the SUPPLIER table where Supplier_ID = 100
SELECT * FROM SUPPLIER where Supplier_ID = 100;

-- Retrieve only Supplier_ID and Supplier_name columns from the SUPPLIER table
SELECT Supplier_ID, Supplier_name FROM SUPPLIER;

-- Retrieve all columns from supplier_farmer_ordering and supplier_contact_info tables, combining every row from both tables
SELECT * FROM supplier_farmer_ordering, supplier_contact_info;


-- Create a view named userview that combines Farmer_ID and Farmer_name from HEAD_FARMER table
CREATE VIEW userview AS
SELECT Farmer_ID,Farmer_name
FROM HEAD_FARMER;
SELECT * FROM userview;


-- Retrieve Supplier_ID as ID and Supplier_name as Name from SUPPLIER table
SELECT Supplier_ID AS ID, Supplier_name AS Name FROM SUPPLIER;


-- Calculate the average Quantity from the HARVEST table
SELECT AVG(Quantity) AS AvgQuantity FROM HARVEST;



-- Retrieve Equipment_ID,Model,Equipment_type records from the EQUIPMENT table where Equipment_type contains 'er'
SELECT Equipment_ID,Modal,Equipment_type FROM equipment WHERE Equipment_type LIKE '%er%';



-- complex


 -- union
SELECT * FROM SUPPLIER where Supplier_name='Ranil'
Union
SELECT * FROM SUPPLIER where Product_supplied='Glyphosate';

 -- intersection
SELECT * FROM SUPPLIER where Supplier_name='Ranil'
Intersect
SELECT * FROM SUPPLIER where Product_supplied='Glyphosate';

 -- set difference
 
SELECT * FROM SUPPLIER where Product_supplied='Glyphosate'
except
SELECT * FROM SUPPLIER where Supplier_name='Ranil';


 -- division
 
SELECT Equipment_owner
FROM equipment AS e1
GROUP BY Equipment_owner
HAVING NOT EXISTS (
    SELECT * FROM (
        SELECT Equipment_ID FROM equipment
        WHERE Equipment_ID IN (200, 207, 208)
    ) As e2
    WHERE NOT EXISTS (
        SELECT * FROM equipment AS e3
        WHERE e3.Equipment_owner = e1.Equipment_owner
        AND e3.Equipment_ID = e2.Equipment_ID
    )
);




 -- inner join

CREATE VIEW  userview1 AS SELECT Field_ID,Field_owner from FIELD;
CREATE VIEW userview2 AS SELECT Modal as Equipment_model,Equipment_owner as Head_farmer from EQUIPMENT;
SELECT userview2.Head_farmer, userview1.Field_ID,userview2.Equipment_model
FROM 
userview1 
INNER JOIN userview2 
ON userview2.Head_farmer = userview1.Field_owner;



 -- natural join
 
CREATE VIEW userview3 AS SELECT Field_ID,Field_Name,Size FROM FIELD;
CREATE VIEW userview4 AS SELECT * FROM CULTIVATE;
CREATE VIEW UV AS SELECT * FROM CULTIVATE where Crop_ID>14;

SELECT * FROM
userview3 
NATURAL JOIN userview4;

SELECT * FROM
userview3 
NATURAL JOIN UV;

SELECT * FROM
UV
NATURAL JOIN userview3;

 -- left outer join

CREATE VIEW userview5 AS
SELECT * FROM supplier_farmer_ordering;
CREATE VIEW userview6 AS
SELECT * FROM head_farmer;
select * from
userview5 left outer join userview6
ON userview5.Farmer_ID = userview6.Farmer_ID;



 -- Right outer join

CREATE VIEW userview7 AS
SELECT * FROM cultivate;
CREATE VIEW userview8 AS
SELECT * FROM crop;
select * from
userview7 right outer join userview8
ON userview7.Crop_ID = userview8.Crop_ID;


 -- full outer join
 
CREATE VIEW userview9 AS
SELECT * FROM employee;
CREATE VIEW userview10 AS
SELECT * FROM salary;

(select * from
userview9 left outer join userview10
ON userview9.Employee_ID = userview10.Employee_ID)
union
(select * from
userview9 right outer join userview10
ON userview9.Employee_ID = userview10.Employee_ID);



-- Outer union
Create view userview11 AS
SELECT COALESCE(ee.Employee_ID, ec.Employee_ID) AS Employee_ID,
       ee.Email,
       ec.Contact_info
FROM employee_email AS ee
LEFT JOIN employee_contact_info AS ec ON ee.Employee_ID = ec.Employee_ID;
Create view userview12 AS
SELECT COALESCE(ee.Employee_ID, ec.Employee_ID) AS Employee_ID,
       ee.Email,
       ec.Contact_info
FROM employee_email AS ee
RIGHT JOIN employee_contact_info AS ec ON ee.Employee_ID = ec.Employee_ID;
select * from userview11
UNION
select * from userview12;






 -- nested 1
SELECT Employee_ID, Employee_name
FROM EMPLOYEE
WHERE Employee_ID IN (
    SELECT Employee_ID
    FROM SALARY
    WHERE Monthly_salary < 90000
)
INTERSECT
SELECT Employee_ID, Employee_name
FROM EMPLOYEE
WHERE Working_field = 500;


-- nested 2
Select H.Farmer_ID from head_farmer as H where H.Farmer_name = 'Pathum'
AND H.Farmer_ID IN
(Select F.Field_owner from field as F where F.Size= 'Medium');


-- nested 3
select Employee_ID,Salary_month,Monthly_salary from salary where 
Payment_per_hour > all(select Payment_per_hour from salary where Employee_ID IN (6,7));


-- tunning

-- 1,2

EXPLAIN(SELECT * FROM SUPPLIER where Supplier_name='Ranil'
Union
SELECT * FROM SUPPLIER where Product_supplied='Glyphosate');

explain
(SELECT * FROM SUPPLIER where Supplier_name='Ranil'
Intersect
SELECT * FROM SUPPLIER where Product_supplied='Glyphosate'); 

CREATE INDEX idx_supplier_name ON SUPPLIER (Supplier_name);
CREATE INDEX idx_product_supplied ON SUPPLIER (Product_supplied);

EXPLAIN(SELECT * FROM SUPPLIER where Supplier_name='Ranil'
Union
SELECT * FROM SUPPLIER where Product_supplied='Glyphosate');


explain
(SELECT * FROM SUPPLIER where Supplier_name='Ranil'
Intersect
SELECT * FROM SUPPLIER where Product_supplied='Glyphosate'); 



-- 3

select * from userview1;
select * from userview2;

select * from userview1 inner join userview2 
on userview1.Field_owner = userview2.Head_farmer;

Explain(
SELECT userview2.Head_farmer, userview1.Field_ID,userview2.Equipment_model
FROM 
userview1 
INNER JOIN userview2 
ON userview2.Head_farmer = userview1.Field_owner);


CREATE INDEX idx_field_owner ON FIELD (Field_owner);

Explain(
SELECT userview2.Head_farmer, userview1.Field_ID,userview2.Equipment_model
FROM 
userview1 
INNER JOIN userview2 
ON userview2.Head_farmer = userview1.Field_owner);


-- 4

CREATE INDEX idx_monthly_salary_salary ON salary(Monthly_salary);
CREATE INDEX idx_working_field_employee ON employee(Working_field);

explain(
SELECT Employee_ID, Employee_name
FROM EMPLOYEE
WHERE Employee_ID IN (
    SELECT Employee_ID
    FROM SALARY
    WHERE Monthly_salary < 90000
)
INTERSECT
SELECT Employee_ID, Employee_name
FROM EMPLOYEE
WHERE Working_field = 500);




-- 5
CREATE INDEX idx_farmer_name_head_farmer ON head_farmer(Farmer_name);
CREATE INDEX idx_size_field ON field(size);

explain(
Select H.Farmer_ID from head_farmer as H where H.Farmer_name = 'Pathum'
AND H.Farmer_ID IN
(Select F.Field_owner from field as F where F.Size= 'Medium'));



-- 6

explain( 
SELECT * FROM
userview3 
NATURAL JOIN userview4);

-- 7
explain(
select * from
userview5 left outer join userview6
ON 
userview5.Farmer_ID = userview6.Farmer_ID
);




-- 8

explain(
SELECT Equipment_owner
FROM equipment AS e1
GROUP BY Equipment_owner
HAVING NOT EXISTS (
    SELECT * FROM (
        SELECT Equipment_ID FROM equipment
        WHERE Equipment_ID IN (200, 207, 208)
    ) As e2
    WHERE NOT EXISTS (
        SELECT * FROM equipment AS e3
        WHERE e3.Equipment_owner = e1.Equipment_owner
        AND e3.Equipment_ID = e2.Equipment_ID
    )
));




-- 9

explain(SELECT * FROM SUPPLIER where Product_supplied='Glyphosate'
except
SELECT * FROM SUPPLIER where Supplier_name='Ranil');


explain(
SELECT *
FROM SUPPLIER s1
WHERE Product_supplied = 'Glyphosate'
AND NOT EXISTS (
    SELECT 1
    FROM SUPPLIER s2
    WHERE s2.Supplier_name = 'Ranil'
    AND s1.Supplier_ID = s2.Supplier_ID
));


-- 10

explain(select Employee_ID,Salary_month,Monthly_salary from salary where 
Payment_per_hour > all(select Payment_per_hour from salary where Employee_ID IN (6,7)));

explain(
SELECT s1.Employee_ID, s1.Salary_month, s1.Monthly_salary 
FROM salary s1
JOIN (
    SELECT MAX(Payment_per_hour) AS max_payment
    FROM salary
    WHERE Employee_ID IN (6, 7)
) s2 ON s1.Payment_per_hour > s2.max_payment);


use farm_management_system;

























