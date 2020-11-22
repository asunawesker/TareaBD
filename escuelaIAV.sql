--Crear una nueva base de datos
CREATE DATABASE escuelaIAV

--Creación de la tabla estudiantes
CREATE TABLE estudiantes (
	matricula char(6) PRIMARY KEY CHECK (matricula like 'S%'),
	nombre varchar(30),
	carrera varchar(20) CHECK (carrera in ('LSCA', 'CONTA', 'ISW', 'ADMON', 'GDN')),
	semestre tinyint CHECK (semestre between 1 and 12) DEFAULT 1,
	edad tinyint CHECK (edad > 18),
)

--Creación de la tabla estudiantes
CREATE TABLE materias (
	nrc char(5) PRIMARY KEY not null,
	materia varchar(20) not null,
	creditos tinyint CHECK (creditos between 3 and 15 AND creditos % 2 <> 0) not null
)

--Creación de la tabla estudiantes
CREATE TABLE inscripcion (	
	matricula char(6) FOREIGN KEY REFERENCES estudiantes(matricula),
	nrc char(5) FOREIGN KEY REFERENCES materias(nrc),
	no_inscripcion tinyint,
	calificacion float CHECK (calificacion between 2 and 10), 
	PRIMARY KEY (matricula, nrc),
)

--CONTENIDO TABLAS BD
select * from estudiantes
select * from materias
select * from inscripcion


--INSERTANDO INFORMACIÓN TABLAS BD

--INSERTANDO INFORMACIÓN TABLA ESTUDIANTES
--Insertando información en la tabla estudiantes con la información correcta
insert into estudiantes values('S01010','Alarcón Godos Gabriel','LSCA',7,22)
insert into estudiantes values('S01020','Bonilla Vázquez Carmen','CONTA',5,21)
insert into estudiantes values('S01030','Carmona Aburto Francisco','CONTA',3,20)
insert into estudiantes values('S01040','Esquivel Hernández Lizbeth','ISW',2,19)
insert into estudiantes values('S01050','García Hernández Gabriela','ISW',3,20)
insert into estudiantes values('S01060','Ruiz Sayago Susana','LSCA',5,21)
insert into estudiantes values('S01070','Silvia Pérez Pedro','CONTA',3,20)
insert into estudiantes values('S01080','Vázquez García Alicia','LSCA',5,21)

--Insertando información en la tabla estudiantes sin la S en la matrícula
insert into estudiantes values('01010','Alarcón Godos Gabriel','LSCA',12,22)
--Insertando información en la tabla estudiantes con PE que no está en lista
insert into estudiantes values('S01011','Alarcón Godos Gabriel','QFB',12,22)
--Insertando información en la tabla estudiantes con semestre por default
insert into estudiantes (matricula, nombre, carrera, edad) values('S01090','Prueba Estudiante Default','LSCA',27)
--Insertando información en la tabla estudiantes con edad menor a 18
insert into estudiantes values('S01011','Alarcón Godos Gabriel','LSCA',12,17)


--INSERTANDO INFORMACIÓN TABLA MATERIAS
insert into materias values ('39437', 'Matemáticas', 7)
insert into materias values ('14385', 'Base de Datos', 9)
insert into materias values ('57802', 'Programación', 7)
insert into materias values ('57778', 'Estadística', 11)

--Insertando información con número de créditos par, no aceptado
insert into materias values ('35323', 'Inglés', 8)
--Insertando información con nrc vacío, no aceptado
insert into materias (materia, creditos) values ('Inglés',3)
--Insertando información con materia vacío, no aceptado
insert into materias (nrc, creditos) values ('35323', 5)
--Insertando información con créditos vacío, no aceptado
insert into materias (nrc, materia) values ('35323', 'Inglés')


--INSERTANDO INFORMACIÓN TABLA INSCRIPCIONES
insert into inscripcion values ('S01020', '39437',1,10)
insert into inscripcion values ('S01030', '57778',1,8)
insert into inscripcion values ('S01050', '57802',2,9)
insert into inscripcion values ('S01070', '39437',1,9)
insert into inscripcion values ('S01070', '14385',1,7)
insert into inscripcion values ('S01070', '57778',1,8)
insert into inscripcion values ('S01080', '39437',1,10)
insert into inscripcion values ('S01010', '39437',1,3)

--Valor no aceptado porque la nrc no está registrada
insert into inscripcion values ('S01010', '35523',2,10)
insert into inscripcion values ('S01030', '35523',1,8)
--Valor no aceptado por ser duplicado en la llave primaria
insert into inscripcion values ('S01050', '57802',1,3)
--Valor no aceptado porque calificación no esta en el rango de 2 y 10
insert into inscripcion values ('S01010', '57802',1,1)


--Eliminando un registro en la tabla inscripción donde la condición es que 
--se borren los registros con matrícula S01017.
--Para eliminar un registro empezamos indicando la instrucción DELETE FROM
--seguido del nombre de la tabla en la que queremos borrar un dato,
--posteriormente va la indicación WHERE seguido del nombre de la fila y 
--esta será igual un valor que va a fungir como condición, siendo esta condición
--una característica de él o los registros que se desean eliminar
delete from inscripcion where matricula = 'S01070';