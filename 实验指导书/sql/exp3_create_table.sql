create table S (
	SNO VARCHAR (10) NOT NULL ,
	SNAME VARCHAR(20),
	DEPT VARCHAR(20), 
	AGE INT, 
	SEX CHAR(4) 
);


create table C (
	CNO VARCHAR(10) NOT NULL,
	CNAME VARCHAR(20),
	cpno varchar(10),
	credit int
);


create table SC(
	SNO VARCHAR(10) NOT NULL,
	CNO VARCHAR(10) NOT NULL,
	SCORE DECIMAL
);