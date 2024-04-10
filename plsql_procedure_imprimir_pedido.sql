--  imprimir un pedico con un procedimineto

create or replace procedure imprimir_pedido(p_idpedido in number, p_resumen_pedido out clob) is
v_resp_pedido clob;
br varchar(1):= chr(10);
separador varchar(35) := br||'------------------------------'||br;
v_datos_cliente varchar2(140);
v_direccion_cliente varchar(140);
v_precio_final number;

cursor pedidos_articulos(id_pedido number) is
select p.cantidad, a.nombre, a.precio
from pedidos_articulos p
inner join articulos a on p.idarticulo = a.idarticulo
where p.idpedido = id_pedido;
begin
v_resp_pedido := separador;
v_resp_pedido:= v_resp_pedido || 'PEDIDO N° : '||p_idpedido;
v_resp_pedido:= v_resp_pedido || separador;

select c.nombre||' '||c.apellido||' DOC : '||c.documento, d.calle||' '||d.numero||' - PISO : '||d.piso||' '||d.departamento
into v_datos_cliente, v_direccion_cliente
from pedidos p
inner join clientes c on p.idcliente = c.idcliente
inner join direcciones d on p.iddireccion = d.iddireccion
where p.idpedido=p_idpedido;

v_precio_final:= 0;

v_resp_pedido:= v_resp_pedido||'CLIENTE : '||v_datos_cliente||br||'DIRECCION : '||v_direccion_cliente||separador;
v_resp_pedido:= v_resp_pedido|| separador||'A R T I C U L O S '||separador;

for art in pedidos_articulos(p_idpedido) loop
    v_resp_pedido:= v_resp_pedido||art.nombre||'(x '|| art.cantidad||' ) .......$ '||art.precio* art.cantidad||br;
    v_precio_final:= v_precio_final + (art.precio* art.cantidad);
end loop;
v_resp_pedido:= v_resp_pedido ||separador||'TOTAL : $ '|| v_precio_final||separador; 
p_resumen_pedido:= v_resp_pedido; 
end;




--- llamado

declare
v_idpedido number;
v_detalle clob;


begin
v_idpedido:= 3;


imprimir_pedido(v_idpedido,v_detalle);

dbms_output.put_line(v_detalle);

end;

set serveroutput on;