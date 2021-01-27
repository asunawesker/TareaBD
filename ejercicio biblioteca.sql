/*Proyecto Biblioteca*/

create database Biblioteca
go
use Biblioteca
go

create table autores
(
    cod_autor char(7)not null primary key check( cod_autor like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9]' ),
    nombre_autor varchar(17),
    apellido_pt varchar(17),
    apellido_mt varchar(17),
    edad tinyint not null,
    ciudad varchar(15) not null,
    pais_origen varchar(15) not null
)
go
insert into autores
values ('1234567','Leonardo','Gonzales','Trueba','3','Florencia','Italia')

insert into autores
values ('1235698','Miguel','Rodr�guez','Cruz','40','Roma','Italia')

insert into autores
values ('1237845','Gaudencio','Cabrera','Zavaleta','37','Buenos Aires','Argentina')

insert into autores
values ('1233124','Rodrigo','Alcantara','Amancio','30','Caracas','Venezuela')

insert into autores
values ('1235885','Christopher','Levy','Cha�n','43','Liverpool','Inglaterra')

insert into autores
values ('1234589','Matias','Hernan','Lucas','21','Santiago','Chile')

insert into autores
values ('1234569','Max','Well','Anz','27','DF','M�xico')

insert into autores
values ('1235589','Elisa','Torres','L�pez','53','Tegucijalpa','Honduras')

insert into autores
values ('1236977','Nancy','G�nzales','Garc�a','20','Lisboa','Portugal')

insert into autores
values ('1238765','Anah�','Jimenez','Nieto','25','Veracruz','M�xico')
go

create table libros
(
   cod_libro char(6) primary key check(cod_libro like'L[0-9][0-9][0-9][0-9][0-9]'),
   titulo varchar  (15)not null check(titulo like '"%"'),
   editorial varchar (15)not null,
   numero_paginas tinyint not null,
   genero varchar(15)not null check (genero in ('drama','suspenso','novela','accion')),
   ejem_disponibles int default 0
)
go

insert into libros
values ('L12345','"La Aduana"','Trillas','100','drama',0)

insert into libros
values ('L12346','"El Castillo"','Maxwell','120','suspenso',2)

insert into libros
values ('L12455','"El Serpe"','Trillas','100','accion',4)

insert into libros
values ('L12311','"La Divina"','Larousse','110','novela',5)

insert into libros
values ('L12598','"El Amor"','Oceano','200','drama',0)

insert into libros
values ('L12567','"La Serpiente"','Uv','130','novela',1)

insert into libros
values ('L12375','"La Canci�n"','Musik','180','drama',2)

insert into libros
values ('L11115','"Crep�sculo"','Trillas','255','accion',3)

insert into libros
values ('L12569','"La Familia"','Oceano','100','accion',4)

go


create table usuarios
(
    ID char(9)not null primary key check (ID like 'ID[0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
    nombre varchar(15) not null,
    direccion varchar(15) not null,
    ciudad varchar (15) not null,
    edad tinyint not null,
    tel varchar(10)check (tel like '[0-9][0-9][0-9]-[0-9][0-9][0-9][0-9][0-9]') 
)

go

insert into usuarios
values('ID1234567','Ana','Prolongaci�n 6','Orizaba',11,'272-12369')

insert into usuarios
values('ID1234568','Cecilia','Avenida Juarez','Orizaba',12,'272-72369')

insert into usuarios
values('ID1235567','Roberto','Av. Michoacan','C�rdoba',19,'272-72369')

insert into usuarios
values('ID1234777','Luis','Parque 15','R�o Blanco',18,'272-82369')

insert into usuarios
values('ID1233369','Eduardo','Prolongaci�n 6','Orizaba',25,'272-12369')

insert into usuarios
values('ID1222267','Teresa','Av. 10','Mendoza',14,'272-98369')

insert into usuarios
values('ID1236897','Miguel','Ojo de agua','Orizaba',17,'272-50721')

insert into usuarios
values('ID1698765','Alma','Sumidero','Atzacan',14,'272-69869')

insert into usuarios
values('ID1236987','Noem�','Prolongaci�n 2','Orizaba',25,'272-12367')

insert into usuarios
values('ID1236986','Anah�','Avenida melo','Orizaba',32,'272-69369')

insert into usuarios
values('ID1237417','Marco','Av.La Joya6','Nogales',14,'272-12369')
go

create table ejemplares
(
    folio char (5)not null primary key check(folio like 'F[0-9][0-9][0-9]'), 
    Nstand tinyint not null,
    piso tinyint not null,
    cod_libro char(6) references libros(cod_libro)
)
go


insert into ejemplares
values ('F120','1','2','L11115')

insert into ejemplares
values ('F100','3','2','L12598')

insert into ejemplares
values ('F110','4','2','L12567')

insert into ejemplares
values ('F130','10','2','L12455')

insert into ejemplares
values ('F140','5','1','L12569')

insert into ejemplares
values ('F150','1','1','L11115')

insert into ejemplares
values ('F160','15','2','L12375')

insert into ejemplares
values ('F170','6','2','L12311')

insert into ejemplares
values ('F180','10','1','L12346')

insert into ejemplares
values ('F190','9','2','L12598')


insert into ejemplares
values ('F200','11','1','L12567')

go

create table consultas
(
  fecha_prestamo datetime not null,
  fecha_dev datetime not null,
  ID char (9)references usuarios(ID),
  folio char (5)references ejemplares(folio)
)

go
insert into consultas
values ('27/12/2008','30/12/2008','ID1222267','F100')


insert into consultas
values ('17/01/2009','20/01/2009','ID1222267','F110')


insert into consultas
values ('27/01/2009','30/01/2009','ID1234568','F120')


insert into consultas
values ('07/02/2009','30/06/2009','ID1234777','F130')


insert into consultas
values ('01/03/2009','10/03/2009','ID1235567','F140')


insert into consultas
values ('09/04/2009','03/07/2009','ID1236897','F160')


insert into consultas
values ('27/12/2008','30/12/2008','ID1236986','F170')


insert into consultas
values ('02/12/2008','30/12/2008','ID1236987','F180')


insert into consultas
values ('06/11/2009','12/11/2009','ID1698765','F190')


insert into consultas
values ('07/07/2007','08/08/2007','ID1698765','F200')

go
create table escribe
(
   cod_autor char(7) references autores(cod_autor),
   cod_libro char(6) references libros(cod_libro)
)

go

insert into escribe
values ('1233124','L11115')

insert into escribe
values ('1234567','L12311')

insert into escribe
values ('1234569','L12345')

insert into escribe
values ('1234589','L12346')

insert into escribe
values ('1235589','L12598')

insert into escribe
values ('1235698','L12598') ---

insert into escribe
values ('1235885','L12455')

insert into escribe
values ('1235885','L12567')

insert into escribe
values ('1237845','L12569')

insert into escribe
values ('1238765','L12598')

--Mostar los autores mayores de 30 a�os que son extranjeros.
SELECT * FROM autores WHERE (edad > 30) AND (pais_origen <> 'M�xico') 

--Autores mayores de 30 a�os que son extranjeros y cuyo nombre tenga x o y.
SELECT * FROM autores WHERE (edad > 30) AND (pais_origen <> 'M�xico') AND (nombre_autor LIKE '%[x-y]%')

--T�tulo y editorial de los libros que no sean de suspenso y que en el titulo tengan los art�culos El o LA.
SELECT * FROM libros WHERE (genero != 'suspenso') AND ((titulo LIKE '%El %') OR (titulo LIKE '%La %')) 

--N�meros de folio de todos los libros de la editorial trillas.
SELECT folio from libros inner join ejemplares on  ejemplares.cod_libro = libros.cod_libro
WHERE(editorial = 'trillas')

--Nombre del usuario y t�tulos de los libros que ha consultado.
SELECT nombre, titulo 
FROM libros inner join ejemplares on ejemplares.cod_libro = libros.cod_libro
			inner join consultas on consultas.folio = ejemplares.folio
			inner join usuarios on usuarios.id = consultas.ID

--Nombre del usuario, t�tulo y nombre del autor de los libros que ha consultado.
SELECT nombre, titulo, nombre_autor 
FROM libros inner join ejemplares on ejemplares.cod_libro = libros.cod_libro
			inner join consultas on consultas.folio = ejemplares.folio
			inner join usuarios on usuarios.id = consultas.ID
			inner join escribe on escribe.cod_libro = libros.cod_libro
			inner join autores on autores.cod_autor = escribe.cod_autor

--Nombre del usuario, t�tulo y nombre del autor de los libros que ha consultado ordenados por apellido del usuario y por fecha de consulta.
SELECT nombre, titulo, nombre_autor  
FROM libros inner join ejemplares on ejemplares.cod_libro = libros.cod_libro
			inner join consultas on consultas.folio = ejemplares.folio
			inner join usuarios on usuarios.id = consultas.ID
			inner join escribe on escribe.cod_libro = libros.cod_libro
			inner join autores on autores.cod_autor = escribe.cod_autor
ORDER BY apellido_pt, fecha_prestamo

--Agrupando por número de libros escritos de cada autor
SELECT nombre_autor as 'Nombre del autor', NoLibros
FROM 
    (SELECT cod_autor, count(*) AS NoLibros
    FROM escribe 
    GROUP BY cod_autor) as ConteoLibros 
INNER JOIN autores on autores.cod_autor = ConteoLibros.cod_autor

--Cuantas veces se ha prestado un ejemplar
SELECT libros.cod_libro, ejemplares.folio,libros.titulo, XX.NoPrestamos
FROM libros 
INNER JOIN ejemplares on libros.cod_libro=ejemplares.cod_libro
INNER JOIN (select folio, count(*) as NoPrestamos from consultas group by folio) as XX 
	on XX.folio = ejemplares.folio

--Veces en que se ha prestado un libro
SELECT libros.cod_libro, libros.titulo, t1.NoPrestamos
FROM libros inner join 
	(SELECT cod_libro,count(*)as NoPrestamos 
	FROM ejemplares INNER JOIN consultas on ejemplares.folio=consultas.folio
	GROUP BY cod_libro) AS t1 ON libros.cod_libro=t1.cod_libro

CREATE TRIGGER TR_INSERTA_CONSULTAON CONSULTASFOR INSERTAs	UPDATE LIBROS SET ejem_disponibles=ejem_disponibles-1	WHERE COD_LIBRO IN 	(SELECT COD_LIBRO FROM inserted INNER JOIN EJEMPLARES ON EJEMPLARES.FOLIO=inserted.folio)

--ESTA CONSULTA DISPARA EL SP
insert into consultasvalues ('20082712','20083012','ID1222267','F190')
