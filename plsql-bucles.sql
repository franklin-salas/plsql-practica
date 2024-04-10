--Ejercicios bucles

--Dada una determinada opinión, si esta fue de 1 o 2 puntos llenar una variable con el valor "Mala".
--Si fue de 3 o 4 puntos "Buena" y si fue de 5 puntos "Excelente". Luego imprimir el resultado junto al título de la película.

--Calcular la potencia de un número cualquiera e imprimir el resultado. Ejemplo: 2^4 = 16.

--set serveroutput on;

declare
v_opinion_id number;
v_puntuacion number;
v_pelicula VARCHAR(50);

begin
v_opinion_id:= 12;
select o.puntuacion ,p.titulo into  v_puntuacion, v_pelicula 
from opinion o , pelicula p  
where o.idpelicula = p.idpelicula and  o.idopinion = v_opinion_id;

case
when v_puntuacion in(1,2) then
dbms_output.put_line('Mala - '|| v_pelicula);
when v_puntuacion in(3,4) then
dbms_output.put_line('Buena - '|| v_pelicula);
when v_puntuacion = 5 then
dbms_output.put_line('Excelente - '|| v_pelicula);

end case;

end;

declare
v_base number;
v_cont number;
v_resultado number;
v_potencia number;
begin
v_base:= 2;
v_potencia:=4;
v_cont:=1;
v_resultado:=1;
while (v_cont>0)and (v_cont <= v_potencia ) loop
    v_resultado:= v_resultado * v_base;
    v_cont:= v_cont + 1;
end loop;

dbms_output.put_line('Resultado : '|| v_resultado );
end;

