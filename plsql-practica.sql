-- Ejercicios

-- Traer e imprimir el año de estreno más alto. 

-- Traer la descripción de la película "Coco". Si es nula, reemplazarlo por "-Sin descripción-"

-- Armar e imprimir una descripción corta de cualquier película con el siguiente formato:
-- (año de estreno) - Primeros 40 caracteres de la descripción...
-- Ejemplo:

--  (2019) - Los Vengadores restantes deben encontrar...

--set serveroutput on;

select * from pelicula;

DECLARE

v_anio pelicula.año%type;

BEGIN

select max(año) into v_anio from pelicula;

dbms_output.put_line('Año mas alto '|| v_anio);

END;



DECLARE

v_titulo varchar(20);
v_descripcion pelicula.descripcion%type;
BEGIN
v_titulo:= 'Coco';
select nvl(descripcion, '-Sin descripción-') into v_descripcion from pelicula where titulo = v_titulo;

dbms_output.put_line('Descripcion de la pelicula es : '|| v_descripcion );

END;

DECLARE

v_anio pelicula.año%type;
v_descripcion pelicula.descripcion%type;
BEGIN
select descripcion, año into v_descripcion , v_anio from pelicula where idpelicula = 1;

dbms_output.put_line('( '|| v_anio||' ) '|| substr(v_descripcion,1,40)||' ...' );

END;
