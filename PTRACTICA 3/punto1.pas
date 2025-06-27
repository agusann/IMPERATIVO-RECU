program punto1;
type
	socio= record
		num:integer;
		nombre:string;
		edad:integer;
	end;
	
	arbol= ^nodo;
	nodo= record
		dato:socio;
		HI:arbol;
		HD:arbol;
	end;
	
	procedure CREAR_ARBOL(var a:arbol);
		procedure CARGAR_NODO (var a:arbol; s:socio);
		begin
			if (a=nil)then begin
				new(a);
				a^.dato:=s;
				a^.HD:=nil;
				a^.HI:=nil;
			end
			else
				if (s.num < a^.dato.num) then begin
					CARGAR_NODO (a^.HI, s);
				end
				else
					CARGAR_NODO (a^.HD,s);
		end;
		var
			s:socio;
			nombres : array [0..4] of String;
		begin
		////////////////////////////////////////////////
			nombres[0] := 'AGUSTIN';
			nombres[1] := 'PEDRO';
			nombres[2] := 'JUAN';
			nombres[3] := 'OLI';
			nombres[4] := 'VALEN';
	////////////CREO VECTOR DE NOMBRES
			a:=nil;
			s.num:=RANDOM (1000);
			if (s.num <> 0) then begin
				s.nombre:= nombres [RANDOM (5)];
				s.edad:=18 + RANDOM (65);
			end;
			while (s.num <> 0) do begin
				CARGAR_NODO (a,s);
				s.num:=RANDOM (1000);
				if (s.num <> 0) then begin
					s.nombre:= nombres [RANDOM (5)];
					s.edad:=18 + RANDOM (65);
				end;
			end;
		end;

	procedure IMPRIMIR_EN_ORDEN (a:arbol);
	begin
		if (a<>nil)then begin
			IMPRIMIR_EN_ORDEN(a^.HI);
			writeln ('NUMERO DE SOCIO= ');
			writeln(a^.dato.num);
			writeln ('/////////////////////////////////////');
			writeln ('NOMBRE= ');
			writeln(a^.dato.nombre);
			writeln ('/////////////////////////////////////');
			writeln ('EDAD= ');
			writeln(a^.dato.edad);
			writeln ('/////////////////////////////////////');
			writeln ('-------------------------------------------------');
			writeln ('-------------------------------------------------');
			IMPRIMIR_EN_ORDEN(a^.HD);
		end;
	end;
	
	procedure IMPRIMIR_EN_DECRECIENTE (a:arbol);
	begin
		if (a<>nil)then begin
			IMPRIMIR_EN_DECRECIENTE(a^.HD);
			writeln ('NUMERO DE SOCIO= ');
			writeln(a^.dato.num);
			writeln ('/////////////////////////////////////');
			writeln ('NOMBRE= ');
			writeln(a^.dato.nombre);
			writeln ('/////////////////////////////////////');
			writeln ('EDAD= ');
			writeln(a^.dato.edad);
			writeln ('/////////////////////////////////////');
			writeln ('-------------------------------------------------');
			writeln ('-------------------------------------------------');
			IMPRIMIR_EN_DECRECIENTE(a^.HI);
		end;
	end;
	
	procedure INCISO_3 (a:arbol);
		procedure BUSCAR_EDAD_MAX (a:arbol; var max:integer; var soc_max:integer);
		begin
			if (a<>nil) then begin
				if (a^.dato.edad > max) then begin
					max:=a^.dato.edad;
					soc_max:= a^.dato.num;
				end;
				BUSCAR_EDAD_MAX(a^.HI, max,soc_max);
				BUSCAR_EDAD_MAX(a^.HD, max,soc_max);
			end;
		end;
	var
		max:integer;
		soc_max:integer;
	begin
		max:=0;
		BUSCAR_EDAD_MAX(a,max,soc_max);
		writeln('EL SOCIO CON MAYOR EDAD ES EL ', soc_max);
	end;
	
	procedure INCISO_4 (a:arbol);
		procedure AUMENTAR_EDAD (a:arbol; var cant:integer);
		begin
			if (a<> nil) then begin
				if (a^.dato.edad mod 2 = 1) then begin
					a^.dato.edad:=a^.dato.edad + 1;
					cant:=cant + 1;
				end;
				AUMENTAR_EDAD(a^.HI,cant);
				AUMENTAR_EDAD(a^.HD,cant);
			end;
		end;
	var
		cant:integer;
	begin
		cant:=0;
		AUMENTAR_EDAD(a,cant);
		writeln('La cantidad de personas que se les aumento la edad es de ', cant);
	end;
	function BUSCAR_NOMBRE (a:arbol;nom:String): boolean;
	begin
		if ( a = nil) then 
			BUSCAR_NOMBRE := 	false
		else
			if (nom = a^.dato.nombre) then 
				BUSCAR_NOMBRE := true
			else
				BUSCAR_NOMBRE := BUSCAR_NOMBRE(a^.HI,nom) or BUSCAR_NOMBRE(a^.HD,nom);
	end;
	
	procedure INCISO_7 (a:arbol; var cant:int64);
	begin
		if (a<>nil) then begin
			cant:=cant + 1;
			INCISO_7(a^.HI,cant);
			INCISO_7(a^.HD,cant);
		end;
	end;
	
	function INCISO_8 (a:arbol): real;
		procedure SUMAR_EDADES (a:arbol; var total:int64);
		begin
			if (a <> nil) then begin
				total:= total + a^.dato.edad;
				SUMAR_EDADES (a^.HI, total);
				SUMAR_EDADES (a^.HD,total);
			end;
		end;
	var
		cant,total:int64;
		aux:real;
	begin
		cant:=0;
		total:=0;
		SUMAR_EDADES(a,total);
		INCISO_7(a,cant);
		writeln (total);
		writeln(cant);
		aux:=total div cant;
		writeln(aux);
		INCISO_8:= aux;
	end;
var
	a:arbol;
	nom:String;
	cant:int64;
begin
	CREAR_ARBOL(a);
	IMPRIMIR_EN_ORDEN(a);
	IMPRIMIR_EN_DECRECIENTE(a);
	INCISO_3(a);
	INCISO_4(a);
	writeln ('INGRESE NOMBRE A BUSCAR ');
	readln (nom);
	writeln(BUSCAR_NOMBRE(a,nom));
	cant:=0;
	INCISO_7(a,cant);
    INCISO_8(a);
	writeln('el promedio de edades es ', INCISO_8(a));  //revisar punto 8
end.
