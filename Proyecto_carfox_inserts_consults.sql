create database carfox;
use carfox;

create table Tipo_de_documento(
Documento int (2) primary key not null,
Desc_doc varchar (30) not null
);

create table rol(
cod_rol int(2) primary key not null,
desc_rol varchar(15) not null
);

create table propietario_auto(
codigo_propietario int primary key not null,
Nomb_1 text (25) not null, 
Nomb_2 text (25),
Apellido_1 text (25) not null,
Apellido_2 text (25)
);

create table herramientas(
id_herramienta varchar(10) primary key not null,
Tipo_de_herramienta varchar (45) not null,
Nombre_herramienta varchar (45) not null ,
Cantidad decimal (5) not null
);

create table repuestos(
id_repuestos varchar(10) primary key not null,
Repuestos_nombre varchar (45) not null,
cantidad decimal (5) not null
);

create table camb_contra(
cod_pregunta bigint (20) primary key not null auto_increment,
pregunta varchar (45) not null
);

create table usuarios (
id_usuario varchar (20) not null,
pk_fk_documento int (2) not null,
nombre_1 text(25) not null,
nombre_2 text(25),
apellido_1 text(25) not null,
apellido_2 text(25),
contrasena varchar(50) not null,
fk_cod_pregunta bigint (20) not null,
primary key (id_usuario, pk_fk_documento)
);

create table usuario_rol (
pk_fk_tdoc_usuario int (2) not null,
usuario_id varchar (20) not null,
rol_id int(2) not null,
primary key (pk_fk_tdoc_usuario, usuario_id, rol_id)
);

create table vehiculo(
id_placa varchar (6) primary key not null,
Marca_vehiculo varchar (45) not null, /*apartir de aqui hasta que termine esta tabla son los campo que se van a relacionar*/
fk_codigo_propietario_auto int not null
);

create table check_in (
id_check_in int primary key not null auto_increment,
Registro_fotografico blob not null,
Descripcion_entrada varchar (100) not null,
hora_entrada time not null,
fecha_entrada date not null, /*apartir de aqui hasta que termine esta tabla son los campo que se van a relacionar*/
fk_documento int (2) not null,
fk_id_usuario varchar (20) not null,
fk_id_placa varchar (6) not null
);

create table check_up (
id_check_up int not null auto_increment,
hora_salida time not null,
fecha_salida date not null,
descripcion_de_reparacion varchar (110) not null,/*apartir de aqui hasta que termine esta tabla son los campo que se van a relacionar*/
fk_documento int (2) not null,
fk_id_usuario varchar (20) not null,
fk_insumos varchar (45)not null,
pk_fk_check_in int not null,
primary key (id_check_up, pk_fk_check_in)
);

create table insumos (
id_insumos varchar (45) not null, /*apartir de aqui hasta que termine esta tabla son los campo que se van a relacionar*/
pk_fK_herramientas varchar(10) not null,
pk_fk_repuestos varchar(10) not null,
cantidad_de_repuestos_utilizados int(5) not null,
tipo_de_herramienta_utilizada varchar (45) not null,
primary key (id_insumos)
);

create table reporte (
ID_reporte int not null auto_increment,
fk_check_in int not null,
fk_check_up int not null,
fk_codigo_propietario_auto int not null,
primary key (ID_reporte)
);



alter table usuarios
add foreign key (pk_fk_documento)
references Tipo_de_documento (Documento);

alter table usuario_rol
add foreign key (pk_fk_tdoc_usuario,usuario_id)
references  usuarios (pk_fk_documento,id_usuario);

alter table usuario_rol
add foreign key (rol_id)
references rol (cod_rol);

alter table vehiculo
add foreign key (fk_codigo_propietario_auto)
references propietario_auto (codigo_propietario);

alter table check_in
add foreign key (fk_documento, fk_id_usuario)
references usuarios (pk_fk_documento, id_usuario);

alter table check_in
add foreign key (fk_id_placa)
references vehiculo (id_placa);

alter table check_up
add foreign key (fk_documento, fk_id_usuario)
references usuarios (pk_fk_documento, id_usuario);

alter table check_up
add foreign key (pk_fk_check_in)
references check_in (id_check_in);

alter table check_up
add foreign key (fk_insumos)
references insumos (id_insumos);

alter table insumos
add foreign key (pk_fK_herramientas)
references herramientas (id_herramienta);

alter table insumos
add foreign key (pk_fk_repuestos)
references repuestos (id_repuestos);

alter table reporte
add foreign key (fk_check_in, fk_check_up)
references check_up (pk_fk_check_in, id_check_up);

alter table reporte
add foreign key (fk_codigo_propietario_auto)
references propietario_auto (codigo_propietario);

alter table usuarios
add foreign key (fk_cod_pregunta)
references camb_contra (cod_pregunta);


/* inserciones */

/* #1 documento */

insert into tipo_de_documento
values ("Cedula de Ciudadania"),
("Cedula de Extranjeria");

/* #2 usuarios */

insert into usuarios
values ("1067219831","Cedula de Ciudadania","Juan ","Jose","Florez","Ruiz",123);

insert into usuarios
values ("1327890191","Cedula de Extranjeria","Fernando ","null","Dias","Alvarez","345"),
("1067256745","Cedula de Ciudadania","Luisa","Fernanda","Gomez","null","567"),
("1297639521","Cedula de Ciudadania","Duban","Santiago","Mojica","null","789"),
("1902378252","Cedula de Extranjeria","Emily","anastasia","Sanchez","Beltran","101a");

/* #3 rol */

insert into rol
values (1,"Administrador"),
(2,"Mecanico");

/* #4 rol-usuario */

insert into usuario_rol
values ("Cedula de Ciudadania",1067219831,1);

insert into usuario_rol
values ("Cedula de Extranjeria",1327890191,2),
("Cedula de Ciudadania",1067256745,2),
("Cedula de Ciudadania",1297639521,2),
("Cedula de Extranjeria",1902378252,2);

/* #5 propietario_auto */

insert into propietario_auto
values (1,"Juan","David","Alandete","Florez");

insert into propietario_auto
values (2,"Edgar","null","Allan","Ruiz"),
(3,"Francisco","null","Estrada","Gomez"),
(4,"Benito","null","Encinas","Lopez"),
(5,"Aurora","null","Luque","Cortazar");

/* #6 vehiculo*/

insert into vehiculo 
values ("DTE312","Renauld",1);

insert into vehiculo
values ("CZR263","Kia",2),
("AOP567","Mazda",3),
("MSP206","Mazda",4),
("SQW954","Audi",5);

/* #7 repuestos*/

insert into repuestos
values (1,"Llantas",45);

insert into repuestos
values (2,"Farolas",34),
(3,"Cambio de pintura",96),
(4,"aceite",74),
(5,"Cambio de farolas",84);

/* #8 Herramientas */

insert into herramientas
values (1,"Manual","Destornillador",4);

insert into herramientas
values (2,"Manual","Aerosol",6),
(3,"Manual","Pinzas",4),
(4,"Mecanica","Mordazas",8),
(5,"Manual","Calibre",10);

/* #9 Insumos */

insert into insumos
values (1,1,1,1,"Mecanica");

insert into insumos
values (2,2,2,12, "Mecanica y Manual"),
(3,3,3,3, "Mecanica"),
(4,4,4,2, "Manual"),
(5,5,5,5,"Manual");

/* #10 check_in */

insert into check_in
values (20,"foto_1.jpg","Cambio de llantas","14:15","2022-09-03","Cedula de Ciudadania",1067219831,"DTE312");

insert into check_in
values (21,"foto_2.png","Cambio de frenos","15:20","2021-06-10","Cedula de Extranjeria",1327890191,"CZR263"),
(22,"foto_3.png","Cambio de bateria","17:00","2019-03-11","Cedula de Ciudadania",1067256745,"AOP567"),
(23,"foto_4.jpg","Cambio de las escobillas limpia parabrizas","17:30","2019-04-09","Cedula de Ciudadania",1297639521,"MSP206"),
(24,"foto_5.png","Cambio de farolas","16:00","2018-05-12","Cedula de Extranjeria",1902378252,"SQW954");

/* #11 check_in */

insert into check_up
values (2,"15:15","2022-03-09","Automovil color blanco se encuentra con una llanta dañada, necesitando un cambio de llanta.","Cedula de Ciudadania",1067219831,1,20);

insert into check_up
values (4, "15:50", "2021-06-11", "Se le realizo el respectivo cambio de llantas con los repuestos que se ingresaron y con herramientas utilizadas", "Cedula de Extranjeria",1327890191,2,21),

(6, "19:50", "2019-03-12", "Al automovil se le realizo un cambio de bateria con herramientas mecanica", "Cedula de Ciudadania",1067256745,3,22),

(8, "18:14", "2019-04-09", "Se le implementaron nuevas escobillas al parabrizas con herramientsa manuales","Cedula de Ciudadania",1297639521,4,23),

(10, "16:50", "2018-05-13", "Se retiraron las farolas antiguas y se implementaron nuevas  con herramientas manuales", "Cedula de Extranjeria",1902378252,5,24);

/* #12 reporte */

insert into reporte
values (1,20,2,1);

insert into reporte
values (2,21,4,2),
(3,22,6,3),
(4,23,8,4),
(5,24,10,5);

/*consultas -like-logica-todo */

select pk_fk_tdoc_usuario, usuario_id, cod_rol, desc_rol from usuario_rol inner join rol on rol_id=cod_rol;


select pk_fk_documento, id_usuario, nombre_1, apellido_1, rol_id from usuarios inner join usuario_rol on id_usuario=usuario_id where rol_id=2;


select  id_usuario, nombre_1, apellido_1, id_check_in, hora_entrada, fecha_entrada from usuarios inner join check_in on id_usuario=fk_id_usuario where nombre_1 like "%E%";


/* consulta usuario_rol y rol*/

select pk_fk_tdoc_usuario, usuario_id, cod_rol, desc_rol from usuario_rol inner join rol on rol_id=cod_rol;

/* consulta usuarios y usuario_rol */

select pk_fk_documento, id_usuario, nombre_1, apellido_1, rol_id from usuarios inner join usuario_rol on id_usuario=usuario_id;

/* consulta usuarios y check_in */

select id_usuario, id_usuario, nombre_1, apellido_1, Registro_fotografico, Descripcion_entrada, hora_entrada, fecha_entrada from usuarios inner join check_in on id_usuario=fk_id_usuario;


/* consulta usuarios y check_up */

select id_usuario, id_usuario, nombre_1, apellido_1,pk_fk_check_in,  Descripcion_de_reparacion, hora_salida, fecha_salida, fk_insumos from usuarios inner join check_up on id_usuario=fk_id_usuario;

/* consulta vehiculo y check_in  */

select id_placa, Marca_vehiculo, fk_codigo_propietario_auto, Registro_fotografico, Descripcion_entrada, hora_entrada, fecha_entrada from vehiculo inner join check_in on id_placa=fk_id_placa;


/* consulta propietario y vehiculo   */

select fk_codigo_propietario_auto, id_placa, Marca_vehiculo, nomb_1, nomb_2, Apellido_1, Apellido_2 from propietario_auto inner join vehiculo on codigo_propietario=fk_codigo_propietario_auto;


/* consulta propietario_auto y reporte   */

select ID_reporte,codigo_propietario, nomb_1, nomb_2, Apellido_1, Apellido_2, fk_check_in, fk_check_up from propietario_auto inner join reporte on codigo_propietario=fk_codigo_propietario_auto;

/* consulta check_up y reporte */

select ID_reporte,fk_documento,fk_id_usuario,fk_check_in,  Descripcion_de_reparacion, hora_salida, fecha_salida, fk_insumos from check_up inner join reporte on id_check_up=fk_check_up;

/*  consulta repuestos e insumos */

select id_insumos, id_repuestos, Repuestos_nombre, cantidad from insumos inner join repuestos on pk_fk_repuestos=id_repuestos;


/*  consulta insumo y herramientas */

select id_insumos, id_herramienta, Tipo_de_herramienta, Nombre_herramienta, Cantidad from insumos inner join herramientas on pk_fk_herramientas=id_herramienta;


/* consulta actualizacion */

update repuestos set cantidad = 81 where Repuestos_nombre="Cambio de pintura";

