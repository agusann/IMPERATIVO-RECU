program punto3;
type
	fechas= record
		dia:integer;
		mes:integer;
		anio:integer;
	end;
	alumno=record
		materia:integer;
		fecha:fechas;
		nota:real;
	end;
	lista=^nodo_lista;
	nodo_lista=record
		dato:alumno;
		sig:lista;
	end;
  
	arbol= ^nodo;
	nodo=record
		legajo:integer;
		lis:lista;
		HI:arbol;
		HD:arbol;
	end;
	
	procedure CREAR_ARBOL (var a:arbol);
		procedure AGREGAR_ADELANTE (var l:lista; r:alumno);
		var
			nue:lista;
		begin
			new (nue);
			nue^.dato:=r;
			nue^.sig:=l;
			l:=nue;
		end;
		procedure CREAR_NODO (var a:arbol; r:alumno;legajo:integer);
		begin
			if (a = nil) then begin
				new(a);
				a^.legajo:=legajo;
				a^.lis:=nil;
				AGREGAR_ADELANTE (a^.lis, r);
				a^.HI:=nil;
				a^.HD:=nil;
			end
			else 
				if (legajo < a^.legajo) then 
					CREAR_NODO (a^.HI,r,legajo)
				else
						if (legajo > a^.legajo) then 
							CREAR_NODO (a^.HD,r,legajo)
						else
							AGREGAR_ADELANTE (a^.lis, r);
		end;
	var
		r:alumno;
		leg:integer;
	begin
		a:=nil;
		leg:=RANDOM(1000);
		if (leg <> 0) then begin
			r.materia:=RANDOM (40);
			r.fecha.dia:=1 + RANDOM (31);
			r.fecha.mes:= 1 + RANDOM (12);
			r.fecha.anio:= 2000 + RANDOM (26);
			r.nota:=RANDOM (11);
		end;
		while (leg <> 0 ) do begin
			CREAR_NODO (a,r,leg);
			leg:= RANDOM(1000);
			if (leg <> 0) then begin
				r.materia:=RANDOM (40);
				r.fecha.dia:=1 + RANDOM (31);
				r.fecha.mes:= 1 + RANDOM (12);
				r.fecha.anio:= 2000 + RANDOM (26);
				r.nota:=RANDOM (11);			
			end;
		end;
	end;
	procedure IMPRIMIR (a:arbol);
	var
		l:lista;
	begin
		if (a <> nil) then begin
			l:=a^.lis;
			IMPRIMIR(a^.HI);
			writeln ('LEGAJO Nro ', a^.legajo);
			writeln ('------------------------------------------------------------------------------------------------');
			while (l <> nil) do begin
				writeln ('CODIGO DE MATERIA ', l^.dato.materia);
				writeln ('DIA ', l^.dato.fecha.dia);
				writeln ('MES ', l^.dato.fecha.mes);
				writeln ('ANIO ', l^.dato.fecha.anio);
				writeln ('NOTA ', l^.dato.nota);
				writeln ('---------------------------------------------------------------------------------------------');
				l:=l^.sig;
			end;
			writeln ('#####################################################');
			writeln ('#####################################################');
			IMPRIMIR(a^.HD);
		end;
	end;
	
	procedure INCISO_B (a:arbol; var cant_impar:integer);
		function IMPAR (num:integer): boolean;
		begin
			if (num mod 2 = 1) then
				IMPAR:= TRUE
			else
				IMPAR:= FALSE;
		end;
		procedure RECORRER_ARBOL (a:arbol; var cant_impar:integer);
		begin
			if (a <> nil) then begin
				if (IMPAR (a^.legajo) = TRUE) then
					cant_impar:=cant_impar +1;
				RECORRER_ARBOL (a^.HI,cant_impar);
				RECORRER_ARBOL (a^.HD,cant_impar);
			end;
		end;
	begin
		cant_impar:=0;
		RECORRER_ARBOL (a,cant_impar);
		writeln ('LA CANTIDAD DE ALUMNOS CON LEGAJO IMPAR ES ', cant_impar);
	end;
	
	procedure INCISO_C (a:arbol);
		procedure RECORRER_LISTA (l:lista; var cant:integer);
		begin
			while (l <> nil) do begin 
				if (l^.dato.nota > 3) then 
					cant:=cant + 1;
				l:=l^.sig;
			end;
		end;
	var
		cant:integer;
		l:lista;
	begin
		if (a <> nil) then begin
			writeln ('EL ALUMNO CON LEGAJO ', a^.legajo);
			l:=a^.lis;
			cant:=0;
			RECORRER_LISTA (l,cant);
			writeln ('LA CANTIDAD DE FINALES QUE APROBO ES DE ', cant);
			writeln ('--------------------------------------------------------------------------------');
			writeln ('--------------------------------------------------------------------------------');
			INCISO_C (a^.HI);
			INCISO_C (a^.HD);
		end;
	end;
	procedure INCISO_D (a:arbol; num:real);
		function PROMEDIO (l:lista):real;
		var
			total:real;
			cant:integer;
		begin
			total:=0;
			cant:=0;
			while (l <> nil) do begin
				total:=total + l^.dato.nota;
				cant:=cant + 1;
				l:=l^.sig;
			end;
			total:=total/cant;
			PROMEDIO := total;
		end;
	var
		l:lista;
	begin
		if (a <> nil) then begin
			l:=a^.lis;
			if (PROMEDIO(l) >=  num) then begin
				writeln ('EL ALUMNO CON EL LEGAJO ', a^.legajo);
				writeln ('CON PROMEDIO ', PROMEDIO (l));
				writeln ('------------------------------------------------------------');
				writeln ('------------------------------------------------------------');
			end;
			INCISO_D(a^.HI,num);
			INCISO_D(a^.HD,num);
			end;
		end;
 var
	a:arbol;
	cant_impar:integer;
	prom:real;
begin
	randomize;
	CREAR_ARBOL (a);
	IMPRIMIR (a);
	INCISO_B (a,cant_impar);
	INCISO_C (a);
	writeln ('INGRESE PROMEDIO A SUPERAR ');
	readln (prom);
	INCISO_D(a,prom);
end.
