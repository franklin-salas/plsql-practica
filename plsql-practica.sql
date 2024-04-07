-- Ejercicios

-- Traer e imprimir el a�o de estreno m�s alto. 

-- Traer la descripci�n de la pel�cula "Coco". Si es nula, reemplazarlo por "-Sin descripci�n-"

-- Armar e imprimir una descripci�n corta de cualquier pel�cula con el siguiente formato:
-- (a�o de estreno) - Primeros 40 caracteres de la descripci�n...
-- Ejemplo:

--  (2019) - Los Vengadores restantes deben encontrar...

--set serveroutput on;

select * from pelicula;

DECLARE

v_anio pelicula.a�o%type;

BEGIN

select max(a�o) into v_anio from pelicula;

dbms_output.put_line('A�o mas alto '|| v_anio);

END;



DECLARE

v_titulo varchar(20);
v_descripcion pelicula.descripcion%type;
BEGIN
v_titulo:= 'Coco';
select nvl(descripcion, '-Sin descripci�n-') into v_descripcion from pelicula where titulo = v_titulo;

dbms_output.put_line('Descripcion de la pelicula es : '|| v_descripcion );

END;

DECLARE

v_anio pelicula.a�o%type;
v_descripcion pelicula.descripcion%type;
BEGIN
select descripcion, a�o into v_descripcion , v_anio from pelicula where idpelicula = 1;

dbms_output.put_line('( '|| v_anio||' ) '|| substr(v_descripcion,1,40)||' ...' );

END;
