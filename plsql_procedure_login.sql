-- ejercicios procedure y functions


--Ejercicio 2) Crear un procedure para el login de usuario.

--Se deben recibir 2 parámetros: p_apodo y p_password. Se debe chequear que el nombre de usuario existe y que la password sea válida.

--En caso de ser datos válidos, se deben devolver datos en 4 variables
--OUT: v_mensaje(con el mensaje "Login correcto"), v_id_usuario, v_apodo,v_email.

-- En caso de ser datos inválidos, se deben devolver las 4 mismas variables 
-- OUT: v_mensaje (con el mensaje "Usuario no existente" o "Password incorrecta", según corresponda).
--El resto de las variables deben ser "null".

create or replace procedure login(p_apodo in varchar2,p_password in  varchar2,
v_mensaje out varchar2, v_id_usuario out number, v_apodo out varchar2, v_email OUT varchar2) is

v_hash_password varchar(255);

begin 
v_mensaje:= 'vacio';
v_id_usuario:= null;
v_apodo:= null;
v_email:= null;

select u.idusuario into v_id_usuario from usuario u where u.apodo = p_apodo;



  select standard_hash(p_password, 'MD5')
    into  v_hash_password
    from dual;
    v_mensaje:= v_hash_password;
    
 select u.idusuario,u.email,u.apodo 
 into v_id_usuario,v_email,v_apodo 
 from usuario u 
 where u.idusuario = v_id_usuario and u.password = v_hash_password; 
 

v_mensaje:= 'Login correcto';

exception when no_data_found then

  v_mensaje := 'Usuario no existe';
  v_id_usuario:= null;

end;


--- llamado

declare
 
v_apodo_parametro varchar2(20);
v_password_parametro varchar2(100);
 
v_mensaje varchar2(255);
v_id_usuario number(10);
v_apodo varchar2(20);
v_email varchar2(320);
 
begin
 
    v_apodo_parametro := 'Maria789';
    v_password_parametro := 'ghi789';
 
    login(v_apodo_parametro,v_password_parametro,v_mensaje,v_id_usuario,v_apodo,v_email);
    
    dbms_output.put_line('Mensaje: '||v_mensaje);
    dbms_output.put_line('Id Usuario: '||v_id_usuario);
    dbms_output.put_line('Apodo: '||v_apodo);
    dbms_output.put_line('Email: '||v_email);
    
end;

--set serveroutput on;
