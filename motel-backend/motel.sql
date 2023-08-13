-- To the change password
-- sudo -u postgres psql
-- \password postgres

SELECT *
FROM pg_stat_activity
WHERE datname = 'motel';

SELECT
	pg_terminate_backend (pg_stat_activity.pid)
FROM
	pg_stat_activity
WHERE
	pg_stat_activity.datname = 'motel';

drop database motel;

create database motel;

-- create table---------------------------------------------------------------------------------------------------
drop table flow;
drop TABLE room;
drop TABLE account;
drop TABLE role;
drop TABLE bill;


CREATE TABLE flow(
	flow_id INT PRIMARY KEY GENERATED BY DEFAULT AS IDENTITY,
	flow_name VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE role(
	role_id INT PRIMARY KEY GENERATED BY DEFAULT AS IDENTITY,
	role_name VARCHAR(50) NOT NULL UNIQUE,
	grant_date TIMESTAMP DEFAULT(CURRENT_TIMESTAMP(0)) NULL
);

CREATE TABLE room(
	room_id INT PRIMARY KEY GENERATED BY DEFAULT AS IDENTITY,
	flow_id INT NULL REFERENCES flow(flow_id),
	area VARCHAR(50) DEFAULT('') NOT NULL,
	status_room INT DEFAULT(-1) NOT NULL,
	room_name VARCHAR(255) NOT NULL UNIQUE,
	booking_date TIMESTAMP DEFAULT(CURRENT_TIMESTAMP(0)) NOT NULL,
	date_move_in TIMESTAMP DEFAULT(CURRENT_TIMESTAMP(0)) NOT NULL,
	date_move_out TIMESTAMP DEFAULT(CURRENT_TIMESTAMP(0)) NOT NULL,
	total_days FLOAT DEFAULT(0),
	electric_number FLOAT DEFAULT(0),
	electric_price FLOAT DEFAULT(0),
	deposits FLOAT DEFAULT(0),
	img_electric TEXT DEFAULT(''),
	img_room_rates TEXT DEFAULT(''),
	img_water TEXT DEFAULT(''),
	junk_money FLOAT DEFAULT(0),
	num_of_member INT DEFAULT(0),
	room_rates FLOAT DEFAULT(0),
	water_number FLOAT DEFAULT(0),
	water_price FLOAT DEFAULT(0)
);

CREATE TABLE account(
	account_id INT PRIMARY KEY GENERATED BY DEFAULT AS IDENTITY,
	room_id INT NULL REFERENCES room (room_id),
	user_name VARCHAR(512) UNIQUE NOT NULL,
	password VARCHAR(1024) NOT NULL,
	email VARCHAR(255) UNIQUE NOT NULL,
	created_on TIMESTAMP DEFAULT(CURRENT_TIMESTAMP(0)) NOT NULL,
    last_login TIMESTAMP DEFAULT(CURRENT_TIMESTAMP(0)) NOT NULL
);

CREATE TABLE bill(
	bill_id INT PRIMARY KEY GENERATED BY DEFAULT AS IDENTITY,
	account_id INT NULL REFERENCES account (account_id),
	room_id INT NOT NULL REFERENCES room (room_id),
	created_date TIMESTAMP DEFAULT(CURRENT_TIMESTAMP(0)) NOT NULL,
    total_payment FLOAT DEFAULT(1000000) NOT NULL,
	img_total_payment TEXT DEFAULT('') NULL,
	note TEXT DEFAULT('') NULL
);

--ALTER TABLE payment
--add note TEXT NULL;


-- SELECT TABLE ------------------------------------------------------------------------------------------------------------
SELECT * FROM room;
SELECT * FROM flow;
SELECT * FROM role;
SELECT * FROM account;
SELECT * FROM bill;


-- INSERT TABLE----------------------------------------------------------------------------------------------------------
INSERT INTO flow (flow_name) VALUES
	('flow-A'),
	('flow-B'),
	('flow-C'),
	('flow-D'),
	('flow-E'),
	('flow-F'),
	('flow-G'),
	('flow-H'),
	('flow-K'),
	('flow-KIOT');

INSERT INTO role(role_name) VALUES
	('admin'),
	('host'),
	('manager'),
	('client'),
	('user');

INSERT INTO room(
	flow_id,status_room, room_name, total_days,electric_number,electric_price,
	deposits,img_electric,img_room_rates,img_water,junk_money,
	num_of_member,room_rates,water_number,water_price) VALUES
	-- A --
	(1,0,'A1',0,0,3000,0,'','','',15000,0,900000,0,10000),
	(1,0,'A2',0,0,3000,0,'','','',15000,0,800000,0,10000),
	(1,0,'A3',0,0,3000,0,'','','',15000,0,800000,0,10000),
	(1,0,'A4',0,0,3000,0,'','','',15000,0,800000,0,10000),
	(1,0,'A5',0,0,3000,0,'','','',15000,0,800000,0,10000),
	(1,0,'A6',0,0,3000,0,'','','',15000,0,800000,0,10000),
	(1,0,'A7',0,0,3000,0,'','','',15000,0,800000,0,10000),
	(1,0,'A8',0,0,3000,0,'','','',15000,0,800000,0,10000),
	(1,0,'A9',0,0,3000,0,'','','',15000,0,800000,0,10000),
	(1,0,'A10',0,0,3000,0,'','','',15000,0,800000,0,10000),
	-- B --
	(2,0,'B1',0,0,3000,0,'','','',15000,0,800000,0,10000),
	(2,0,'B2',0,0,3000,0,'','','',15000,0,800000,0,10000),
	(2,0,'B3',0,0,3000,0,'','','',15000,0,800000,0,10000),
	(2,0,'B4',0,0,3000,0,'','','',15000,0,800000,0,10000),
	(2,0,'B5',0,0,3000,0,'','','',15000,0,800000,0,10000),
	(2,0,'B6',0,0,3000,0,'','','',15000,0,800000,0,10000),
	(2,0,'B7',0,0,3000,0,'','','',15000,0,800000,0,10000),
	(2,0,'B8',0,0,3000,0,'','','',15000,0,800000,0,10000),
	(2,0,'B9',0,0,3000,0,'','','',15000,0,800000,0,10000),
	(2,0,'B10',0,0,3000,0,'','','',15000,0,900000,0,10000),
	-- C --
	(3,0,'C1',0,0,3000,0,'','','',15000,0,800000,0,10000),
	(3,0,'C2',0,0,3000,0,'','','',15000,0,800000,0,10000),
	(3,0,'C3',0,0,3000,0,'','','',15000,0,800000,0,10000),
	(3,0,'C4',0,0,3000,0,'','','',15000,0,800000,0,10000),
	(3,0,'C5',0,0,3000,0,'','','',15000,0,800000,0,10000),
	(3,0,'C6',0,0,3000,0,'','','',15000,0,800000,0,10000),
	(3,0,'C7',0,0,3000,0,'','','',15000,0,800000,0,10000),
	(3,0,'C8',0,0,3000,0,'','','',15000,0,800000,0,10000),
	(3,0,'C9',0,0,3000,0,'','','',15000,0,800000,0,10000),
	(3,0,'C10',0,0,3000,0,'','','',15000,0,800000,0,10000),
	-- D --
	(4,0,'D0',0,0,3000,0,'','','',15000,0,900000,0,10000),
	(4,0,'D1',0,0,3000,0,'','','',15000,0,800000,0,10000),
	(4,0,'D2',0,0,3000,0,'','','',15000,0,800000,0,10000),
	(4,0,'D3',0,0,3000,0,'','','',15000,0,800000,0,10000),
	(4,0,'D4',0,0,3000,0,'','','',15000,0,800000,0,10000),
	(4,0,'D5',0,0,3000,0,'','','',15000,0,800000,0,10000),
	(4,0,'D6',0,0,3000,0,'','','',15000,0,800000,0,10000),
	(4,0,'D7',0,0,3000,0,'','','',15000,0,800000,0,10000),
	(4,0,'D8',0,0,3000,0,'','','',15000,0,800000,0,10000),
	(4,0,'D9',0,0,3000,0,'','','',15000,0,800000,0,10000),
	(4,0,'D10',0,0,3000,0,'','','',15000,0,800000,0,10000),
	-- E --
	(5,0,'E0',0,0,3000,0,'','','',15000,0,800000,0,10000),
	(5,0,'E1',0,0,3000,0,'','','',15000,0,800000,0,10000),
	(5,0,'E2',0,0,3000,0,'','','',15000,0,800000,0,10000),
	(5,0,'E3',0,0,3000,0,'','','',15000,0,800000,0,10000),
	(5,0,'E4',0,0,3000,0,'','','',15000,0,800000,0,10000),
	(5,0,'E5',0,0,3000,0,'','','',15000,0,800000,0,10000),
	(5,0,'E6',0,0,3000,0,'','','',15000,0,800000,0,10000),
	(5,0,'E7',0,0,3000,0,'','','',15000,0,800000,0,10000),
	(5,0,'E8',0,0,3000,0,'','','',15000,0,800000,0,10000),
	(5,0,'E9',0,0,3000,0,'','','',15000,0,800000,0,10000),
	(5,0,'E10',0,0,3000,0,'','','',15000,0,900000,0,10000),
	-- F --
	(6,0,'F1',0,0,3000,0,'','','',15000,0,1000000,0,10000),
	(6,0,'F2',0,0,3000,0,'','','',15000,0,800000,0,10000),
	(6,0,'F3',0,0,3000,0,'','','',15000,0,800000,0,10000),
	(6,0,'F4',0,0,3000,0,'','','',15000,0,800000,0,10000),
	(6,0,'F5',0,0,3000,0,'','','',15000,0,800000,0,10000),
	(6,0,'F6',0,0,3000,0,'','','',15000,0,800000,0,10000),
	(6,0,'F7',0,0,3000,0,'','','',15000,0,800000,0,10000),
	(6,0,'F8',0,0,3000,0,'','','',15000,0,800000,0,10000),
	(6,0,'F9',0,0,3000,0,'','','',15000,0,800000,0,10000),
	(6,0,'F10',0,0,3000,0,'','','',15000,0,1000000,0,10000),
	-- G --
	(7,0,'G1',0,0,3000,0,'','','',15000,0,800000,0,10000),
	(7,0,'G2',0,0,3000,0,'','','',15000,0,800000,0,10000),
	(7,0,'G3',0,0,3000,0,'','','',15000,0,800000,0,10000),
	(7,0,'G4',0,0,3000,0,'','','',15000,0,800000,0,10000),
	(7,0,'G5',0,0,3000,0,'','','',15000,0,800000,0,10000),
	(7,0,'G6',0,0,3000,0,'','','',15000,0,800000,0,10000),
	(7,0,'G7',0,0,3000,0,'','','',15000,0,800000,0,10000),
	(7,0,'G8',0,0,3000,0,'','','',15000,0,800000,0,10000),
	(7,0,'G9',0,0,3000,0,'','','',15000,0,800000,0,10000),
	(7,0,'G10',0,0,3000,0,'','','',15000,0,800000,0,10000),
	(7,0,'G11',0,0,3000,0,'','','',15000,0,1200000,0,10000),
	-- H --
	(8,0,'H0',0,0,3000,0,'','','',15000,0,900000,0,10000),
	(8,0,'H1',0,0,3000,0,'','','',15000,0,800000,0,10000),
	(8,0,'H2',0,0,3000,0,'','','',15000,0,800000,0,10000),
	(8,0,'H3',0,0,3000,0,'','','',15000,0,800000,0,10000),
	(8,0,'H4',0,0,3000,0,'','','',15000,0,800000,0,10000),
	(8,0,'H5',0,0,3000,0,'','','',15000,0,800000,0,10000),
	(8,0,'H6',0,0,3000,0,'','','',15000,0,800000,0,10000),
	(8,0,'H7',0,0,3000,0,'','','',15000,0,800000,0,10000),
	(8,0,'H8',0,0,3000,0,'','','',15000,0,800000,0,10000),
	(8,0,'H9',0,0,3000,0,'','','',15000,0,800000,0,10000),
	(8,0,'H10',0,0,3000,0,'','','',15000,0,800000,0,10000),
	(8,0,'H11',0,0,3000,0,'','','',15000,0,1200000,0,10000),
	-- K --
	(9,0,'K0',0,0,3000,0,'','','',15000,0,900000,0,10000),
	(9,0,'K1',0,0,3000,0,'','','',15000,0,800000,0,10000),
	(9,0,'K2',0,0,3000,0,'','','',15000,0,800000,0,10000),
	(9,0,'K3',0,0,3000,0,'','','',15000,0,800000,0,10000),
	(9,0,'K4',0,0,3000,0,'','','',15000,0,800000,0,10000),
	(9,0,'K5',0,0,3000,0,'','','',15000,0,800000,0,10000),
	(9,0,'K6',0,0,3000,0,'','','',15000,0,800000,0,10000),
	(9,0,'K7',0,0,3000,0,'','','',15000,0,800000,0,10000),
	(9,0,'K8',0,0,3000,0,'','','',15000,0,800000,0,10000),
	(9,0,'K9',0,0,3000,0,'','','',15000,0,800000,0,10000),
	(9,0,'K10',0,0,3000,0,'','','',15000,0,800000,0,10000),
	(9,0,'K11',0,0,3000,0,'','','',15000,0,800000,0,10000),
	-- KIOT --
	(10,0,'KIOT1',0,0,3000,0,'','','',15000,0,3000000,0,10000),
	(10,0,'KIOT2',0,0,3000,0,'','','',15000,0,1400000,0,10000),
	(10,0,'KIOT3',0,0,3000,0,'','','',15000,0,1600000,0,10000),
	(10,0,'KIOT4',0,0,3000,0,'','','',15000,0,2000000,0,10000),
	(10,0,'KIOT5',0,0,3000,0,'','','',15000,0,2000000,0,10000);



INSERT INTO account(
	room_id, user_name,password,email) VALUES
	(NULL,'admin','admin','admin@gmail.com'),
	(1,'A1-034982142','123456789','abc1@gmail.com'),
	(1,'A10-034982142','123456789','abc12@gmail.com'),
	(2,'B1-034982142','123456789','abc2@gmail.com'),
	(3,'C1-034982142','123456789','abc3@gmail.com'),
	(4,'D1-034982142','123456789','abc4@gmail.com'),
	(5,'E1-034982142','123456789','abc5@gmail.com'),
	(6,'F1-034982142','123456789','abc6@gmail.com'),
	(7,'G1-034982142','123456789','abc7@gmail.com'),
	(8,'H1-034982142','123456789','abc8@gmail.com'),
	(9,'K1-034982142','123456789','abc10@gmail.com'),
	(10,'KIOT1-034982142','123456789','abc13@gmail.com'),
	(10,'KIOT2-034982142','123456789','abc11@gmail.com');

INSERT INTO bill(account_id, room_id,created_date) VALUES
					(1,1,'2022-12-06 10:10:10'),
					(3,1,'2023-01-06 10:10:10'),
					(4,1,'2023-02-06 10:10:10'),
					(1,2,'2023-03-06 10:10:10'),
					(3,3,'2023-04-06 10:10:10'),
					(4,4,'2023-05-06 10:10:10'),
					(1,1,'2023-06-06 10:10:10'),
					(3,1,'2023-07-06 10:10:10'),
					(4,1,'2023-08-06 10:10:10'),
					(1,5,'2023-09-06 10:10:10'),
					(3,6,'2023-10-06 10:10:10'),
					(4,7,'2023-11-06 10:10:10'),
					(5,5,'2023-12-06 10:10:10'),
					(3,1,'2023-02-06 10:10:10'),
					(4,1,'2023-03-06 10:10:10'),
					(1,2,'2023-03-06 10:10:10'),
					(3,3,'2023-04-06 10:10:10'),
					(4,4,'2023-05-06 10:10:10'),
					(1,1,'2023-06-06 10:10:10'),
					(3,1,'2023-07-06 10:10:10'),
					(4,1,'2023-02-06 10:10:10'),
					(1,5,'2023-02-06 10:10:10'),
					(3,6,'2023-12-06 10:10:10'),
					(4,7,'2023-11-06 10:10:10');
					 
SELECT *From account;
SELECT *From bill;
SELECT *From room; 
