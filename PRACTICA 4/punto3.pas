program punto3;
type
	producto= record
		cod:integer;
		cant:integer;
		montoTotal:real;
	end;
	
	venta= record
		cod_venta:integer; 
		cod_producto:integer;
		cant_unidades_vendidas:integer;
		precioUnitario:real;
	end;
	
	arbol= ^nodo_arbol;
	nodo_arbol = record
		dato: producto;
		HI:arbol;
		HD:arbol;
	end;
	
	procedure 	CREAR_ARBOL (var a:arbol);
		procedure ASIGNAR (var p:producto; v:venta);
		begin
			p.cod:=v.cod_producto;
			p.cant:=v.cant_unidades_vendidas;
			p.montoTotal:= p.cant * v.precioUnitario; 
		end;
		procedure LEER_DATOS (var v:venta);
		begin
			v.cod_venta:= RANDOM (1000);
			if (v.cod_venta <> 0) then begin
				v.cod_producto:=RANDOM (100);
				v.cant_unidades_vendidas:= 1 + RANDOM (50);
				v.precioUnitario:=RANDOM (8);
			end; 
		end;
		procedure CREAR_NODO (var a:arbol; v:venta);
		var
			p:producto;
		begin
			if (a = nil) then begin
				new (a);
				ASIGNAR (p,v);
				a^.dato:= p;
				a^.HI:=nil;
				a^.HD:=nil;
			end
			else
				if (v.cod_producto < a^.dato.cod) then 
					CREAR_NODO(a^.HI,v)
				else 
					if (v.cod_producto > a^.dato.cod) then
						CREAR_NODO(a^.HD,v)
					else  begin//es porque el codigo de produto es igual
						a^.dato.cant:=a^.dato.cant + v.cant_unidades_vendidas;
						a^.dato.montoTotal:=a^.dato.cant * v.precioUnitario;
					end;
		end;
	var
		v:venta;
	begin
		a:=nil;
		randomize;
		LEER_DATOS(v);
		while (v.cod_venta <> 0) do begin
			CREAR_NODO(a,v);
			LEER_DATOS(v);
		end;
	end;
	procedure IMPRIMIR (a:arbol);
	begin
		if (a<> nil) then begin
			IMPRIMIR(a^.HI);
			writeln ('CODIGO ', a^.dato.cod);
			writeln ('CANTIDAD ', a^.dato.cant);
			writeln ('MONTO TOTAL ', a^.dato.montoTotal:2:2);
			writeln('---------------------------------------------------------------------------------------------');
			IMPRIMIR(a^.HD);
		end;
	end;
	
	procedure INCISO_C (a:arbol; var cod:integer; var max:integer);
	begin
		if (a <> nil ) then begin
			if (a^.dato.cant > max) then begin
				cod:=a^.dato.cod;
				max:= a^.dato.cant;
			end;
			INCISO_C (a^.HI,cod,max);
			INCISO_C (a^.HD,cod,max);
		end;
	end;
	function INCISO_D (a:arbol; num:integer): integer;
	begin
		if (a = nil) then
			INCISO_D:=0
		else
			if (a^.dato.cod < num) then 
				INCISO_D:= 1 + INCISO_D(a^.HI, num) + INCISO_D(a^.HD, num)
			else 
				INCISO_D:= INCISO_D(a^.HI, num);
	end;
	function INCISO_E (a:arbol;num1,num2:integer):real;
	begin
		if (a = nil) then 
			INCISO_E:= 0
		else
			if (a^.dato.cod <= num1) then
				INCISO_E := INCISO_E(a^.HD,num1,num2)
			else
				if (a^.dato.cod >= num2) then
					INCISO_E := INCISO_E(a^.HI,num1,num2)
				else
					INCISO_E:=a^.dato.montoTotal + INCISO_E (a^.HI, num1,num2) + INCISO_E (a^.HD, num1,num2);
	end;
var
	a:arbol;
	cod_ventas, max:integer;
	num:integer;
	num1,num2:integer;
begin
	CREAR_ARBOL (a);
	IMPRIMIR(a);
	max:=-1;
	INCISO_C (a,cod_ventas,max);
	writeln ('EL CODIGO DE PRODUCTO CON MAYOR CANTIDAD DE UNIDADES VENDIDAD ES ', cod_ventas);
	writeln('INGRESE NUMERO ');
	read(num);
	writeln('LA CANTIDAD DE CODIGOS QUE SON MENORES AL NUMERO ES ', INCISO_D(a,num));
	writeln ('INGRESE PARAMETROS A BUSCAR ');
	readln(num1);
	readln(num2);
	writeln ('EL MONTO TOTAL DE LOS CODIGOS DE LOS PRODUCTOS ENTRE ESOS PARAMETROS ES ',INCISO_E(a,num1,num2):2:2);
end.
