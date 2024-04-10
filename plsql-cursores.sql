-- Ejercicios cursores

-- Obtener e imprimir todas las opiniones para la película con ID 5.

-- Obtener e imprimir todas las opiniones de un usuario (enviar id de usuario por parámetro al cursor),
-- imprimiendo primero el nombre de la película en mayúsculas y luego la opinión.

-- Cambiar todos los textos de opiniones para la película con ID 4.
-- Modificar concatenando el nombre del usuario delante del texto.
-- Ej: "Juan: Aquí iría la opinión del usuario". Imprimir cuantas filas fueron afectadas utilizando cursor implícito.

declare
 
cursor cur_opiniones is
select o.*
from opinion o
inner join pelicula p on o.idpelicula = p.idpelicula
where o.idpelicula = 5;
 
begin
 
    for op in cur_opiniones loop
    
        dbms_output.put_line(op.opinion);
    
    end loop;
 
end;


declare
 
cursor cur_opiniones(p_id_usuario number) is
select o.opinion, p.titulo
from opinion o
inner join pelicula p on o.idpelicula = p.idpelicula
where o.idusuario = p_id_usuario;
 
begin
 
    for op in cur_opiniones(1) loop
        
        dbms_output.put_line(upper(op.titulo));
        dbms_output.put_line(op.opinion);
    
    end loop;
 
end;


declare
 
cursor cur_opiniones(p_id_pelicula number) is
select o.*, u.apodo
from opinion o
inner join usuario u on o.idusuario = u.idusuario
where o.idpelicula = p_id_pelicula;
 
v_afectadas number;
v_nueva_opinion varchar(140);
 
begin
 
    for op in cur_opiniones(4) loop
        
      v_nueva_opinion:= op.apodo||': '||op.opinion;
      
      update opinion set opinion = v_nueva_opinion
      where idopinion = op.idopinion;
      
      v_afectadas:= sql%rowcount;
      
      dbms_output.put_line('Afectadas: '||v_Afectadas);
    
    end loop;
 
end;


declare
 
cursor cur_opiniones(p_id_pelicula number) is
select o.*, u.apodo
from opinion o
inner join usuario u on o.idusuario = u.idusuario
where o.idpelicula = p_id_pelicula
for update;
 
v_afectadas number;
v_nueva_opinion varchar(140);
 
begin
 
    for op in cur_opiniones(3) loop
        
      v_nueva_opinion:= op.apodo||': '||op.opinion;
      
      update opinion set opinion = v_nueva_opinion
      where current of cur_opiniones;
      
      v_afectadas:= sql%rowcount;
      
      dbms_output.put_line('Afectadas: '||v_Afectadas);
    
    end loop;
 
end;

SELECT * FROM  opinion o where o.idpelicula=3;