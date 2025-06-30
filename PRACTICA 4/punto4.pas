program punto4;
type 
//ARBOL 1
	prestamo= record
		ISBN:integer;
		num:integer;
		dia:integer;
		mes:integer;
		diasPrestados:integer;
	end;
		
	arbol=^nodo_arbol;
	nodo_arbol= record
		dato:prestamo;
		HI:arbol;
		HD:arbol;
	end;
// ARBOL 2
	prestamo_2 = record
		num:integer;
		dia:integer;
		mes:integer;
		diasPrestados:integer;
	end;
	lista=^nodo;
	nodo=record
		dato:prestamo_2;
		sig:lista;
	end;
	arbol_2=^nodo_arbol2;
	nodo_arbol2=record
		ISBN:integer;
		lis:lista;
		HI:arbol_2;
		HD:arbol_2;
	end;
	
	/////////////////////////////////////////////////////////////////
	//ARBOL 1
	procedure CREAR_ARBOL (var a:arbol);
		procedure CREAR_NODO(var a:arbol; p:prestamo);
		begin
			if (a = nil) then begin
				new (a);
				a^.dato:=p;
				a^.HI:=nil;
				a^.HD:=nil;
			end
			else
				if (p.ISBN < a^.dato.ISBN) then 
					CREAR_NODO(a^.HI, p)
				else
					CREAR_NODO(a^.HD, p);
		end;
		procedure LEER_DATOS(var p:prestamo);
		begin
			p.ISBN:= RANDOM (100);
			if (p.ISBN <> 0) then begin
				p.num:= RANDOM (1000);
				P.dia:=1 + RANDOM (31);
				p.mes:= 1 + RANDOM (12);
				p.diasPrestados:= 1 + RANDOM (7);
			end;
		end;
	var
		p:prestamo;
	begin
		a:=nil;
		LEER_DATOS(p);
		while (p.ISBN <> 0) do begin
			CREAR_NODO(a,p);
			LEER_DATOS(p);
		end;
	end;
	/////////////////////////////////////////////////////////////////
	//ARBOL 2
	procedure CREAR_ARBOL_2 (var a:arbol_2);
		procedure LEER_DATOS(var p:prestamo_2; var ISBN:integer);
		begin
			ISBN:= RANDOM (100);
			if (ISBN <> 0) then begin
				p.num:= RANDOM (1000);
				P.dia:=1 + RANDOM (31);
				p.mes:= 1 + RANDOM (12);
				p.diasPrestados:= 1 + RANDOM (7);
			end;
		end;	
		procedure CARGAR_ADELANTE (var l:lista; p:prestamo_2);
		var
			nue:lista;
		begin
			new (nue);
			nue^.dato:=p;
			nue^.sig:=l;
			l:=nue;
		end;
		procedure CREAR_NODO_2 (var a:arbol_2; p:prestamo_2; num:integer);
		begin
			if (a = nil) then begin
				new (a);
				a^.lis:=nil;
				a^.ISBN:=num;
				CARGAR_ADELANTE (a^.lis,p);
				a^.HI:=nil;
				a^.HD:=nil
			end
			else  
				if (num < a^.ISBN) then 
					CREAR_NODO_2 (a^.HI,p,num)
				else
					if (num > a^.ISBN) then 
						CREAR_NODO_2 (a^.HD,p,num)
					else
						CARGAR_ADELANTE (a^.lis,p);
		end;	
	var
		p:prestamo_2;
		ISBN:integer;
	begin
		LEER_DATOS (p,ISBN);
		while (ISBN <> 0) do begin
			CREAR_NODO_2 (a,p,ISBN);
			LEER_DATOS (p,ISBN);
		end;
	end;
var
	a:arbol;
	a2:arbol_2;
begin
	CREAR_ARBOL(a);
	CREAR_ARBOL_2 (a2);
end.
