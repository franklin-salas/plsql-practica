-- ejercicios procedure y functions

--Ejercicio 1) Crear una function que reciba por par�metro un id de pel�cula.

-- Se debe retornar nombre de la pel�cula, la calificaci�n promedio num�rica y calificaci�n en texto
--(Entre 1 y 2: Mala - entre 3 y 4: Buena - Mayor a 4: Excelente) y el n�mero de calificaciones, todo en un mismo texto.

--Ejemplo: 
--"Power Rangers - Calificaci�n: Buena (3,2) - Basada en 7 puntuaci�nes".

create or replace function calificacion_pelicula(p_idpelicula number) return VARCHAR2 
is
v_titulo pelicula.titulo%type;
v_puntuacion number(10,2);
v_calificacion VARCHAR2(20);
v_cant_opiniones number;
resp VARCHAR2(255);
begin 

select p.titulo
into v_titulo
from pelicula p 
where p.idpelicula= p_idpelicula;

select count(*) , sum(o.puntuacion)
into v_cant_opiniones, v_puntuacion
from opinion o
where o.idpelicula = p_idpelicula;

v_puntuacion:= v_puntuacion / v_cant_opiniones;

case

when v_puntuacion between 1 and 2 then
    v_calificacion:= 'Mala';
when v_puntuacion between 3 and 4 then
    v_calificacion:= 'Buena';
when v_puntuacion >4 then
    v_calificacion:= 'Excelente';
else
    v_calificacion:= 'No calificada';
end case;

resp:= v_titulo ||' - Calificacion : '|| v_calificacion ||' ( '|| v_puntuacion ||' ) Basada en '|| v_cant_opiniones||' puntuaci�nes.';
return resp;


exception when NO_DATA_FOUND then
        resp := 'No existe la pelicula';
return resp;
end;

--- llamado

--Para probar el funcionamiento con una sola pel�cula:

select calificacion_pelicula(2)
from dual;
--Para probar el funcionamiento con todas las pel�culas de la tabla:

select calificacion_pelicula(p.idpelicula), p.titulo
from pelicula p;
