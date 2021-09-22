
-- Create Database 

use master;
go
drop database if exists PRSDb;
go
create database PRSDb
go
use PRSDb;
go

-- Create Users Table

CREATE table Users(
	Id int primary key identity(1,1),
	Username varchar(30) not null unique,
	Password varchar(30) not null,
	Firstname varchar(30) not null,
	Lastname varchar(30) not null,
	Phone varchar(12) null,
	Email varchar(255) null,
	isReviewer bit not null default 0,
	isAdmin bit not null default 0,
);
go

-- Create Vendors Table

CREATE table Vendors(
	Id int primary key identity(1,1),
	Code varchar(30) not null unique,
	Name varchar(30) not null,
	Address varchar(30) not null,
	City varchar(30) not null,
	State varchar(2) not null,
	Zip varchar(5) not null,
	Phone varchar(12) null,
	Email varchar(255) null,
);
go

--Create Products Table

CREATE table Products(
	Id int primary key identity(1,1),
	PartNbr varchar(30) not null unique,
	Name varchar(30) not null,
	Price decimal(9,2) not null default 0,
	Unit varchar(30) not null default 'Each',
	PhotoPath varchar(255) null,
	VendorId int not null foreign key references Vendors(Id),
);
go

-- Create Requests Table

CREATE table Requests(
	Id int primary key identity(1,1),
	Description varchar(80) not null,
	Justification varchar(80) not null,
	RejectionReason varchar(80) null,
	DeliveryMode varchar(20) not null,
	Status varchar(10) not null default 'New',
	Total decimal(11,2) not null default 0,
	UserId int not null foreign key references Users(Id),
);
go

-- Create Requestlines Table

CREATE table Requestlines(
	Id int primary key identity(1,1),
	RequestId int not null foreign key references Requests(Id),
	ProductId int not null foreign key references Products(Id),
	Quantity int not null default 1 check (Quantity > 0)
);
go

-- Insert Users

INSERT into Users
	(Username, Password, Firstname, Lastname, Phone, Email,isReviewer,isAdmin)
	values
	('selaborde','marxwusright','Silas','La Borde',Null,'slaborde@gmail.com', 0, 1),
	('besenseman','bassyblakey', 'Blake','Senseman', '5133029875','bsenseman@gmail.com',1,0),
	('atkidd','monarchy>all','Alexander', 'Kidd','5134108796','atkidd@gmail.com',1,1);
go

-- Insert Vendors

INSERT into Vendors
	(Code,Name,Address,City,State,Zip,Phone,Email)
	values
	('KRGR', 'Kroger', '1014 Vine St.', 'Cincinnati', 'OH', '45404', '8005764377', 'sales@kroger.com'),
	('HBFR', 'Harbor Freight', '26677 Agoura Rd.', 'Calabasas', 'CA', '91302', '8188365000','sales@harborfreight.com'),
	('MXTT', 'MAX Technical Training', '4900 Parkway Dr. #160', 'Mason','OH','45040','5133228888','train@maxtrain.com');
go

-- Insert Products

INSERT into Products
	(PartNbr,Name,Price,Unit,VendorId)
	values
	('MGF56829','Milk',4.99,'Each',(select id from vendors where code like '%KRGR%')),
	('AUT3920', 'Floor Jack - 3 Ton', 129.99,'Each',(select id from vendors where code = 'HBFR')),
	('BTCP1980','Maximum Bootcamp',15500.00, 'Each',(select id from vendors where code = 'MXTT'));
go

-- Insert Requests

insert into Requests
	(Description,Justification,DeliveryMode,Status,Total,UserId)
	values
	('Request 1','Not Needed','on-site','approved',250,1),
	('Request 2','Not Needed','on-site','reviewing',200,2);
go

-- Insert Requestlines

insert into Requestlines
	(RequestId,ProductId,Quantity)
	values
	(1,1,1),
	(1,2,2),
	(2,3,3);
go