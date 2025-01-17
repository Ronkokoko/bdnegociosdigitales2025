-- Creation of the database tienda1

-- Create the database tienda1
create database tienda1;

-- SQL LDD
-- Utilizar una base de datos
use tienda1;

-- truncate table categoria; Delete tables with data
-- drop table categoria; Delete newborn tables without data

-- Create Category
create table categoria(
categoriaid int not null,
nombre varchar(20) not null,
constraint pk_categoria -- Magic word to do restrictions (Constraint)
primary key(categoriaid),
constraint unico_nombre unique(nombre)
);

-- SQL-LMD
-- Add registers to the table "Categoria"
insert into categoria
values(1, 'Carnes Frias');

insert into categoria(categoriaid, nombre)
values(2, 'Linea Blanca');

insert into categoria(nombre, categoriaid)
values('Vinos y Licores', 3);

insert into categoria
values (4, 'Ropa'),
		(5, 'Dulces'),
		(6, 'Lacteos');

insert into categoria(nombre, categoriaid)
values ('Panaderia', 7),
	('Zapateria', 8),
	('Jugueteria', 9);

-- select * from categoria where categoriaid = 4; One specific selection

