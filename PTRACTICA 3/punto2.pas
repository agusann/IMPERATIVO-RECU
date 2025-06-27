program punt2;
type
	fechas=record
		dia:integer;
		mes:integer;
		anio:integer;
	end;
	
    venta=record
        cod:integer;
        fecha:fechas;
        cant:integer;
    end;

    arbol=^nodo;
    nodo=record
        dato:venta;
        HI:arbol;
        HD:arbol;
    end;

    procedure CREAR_ARBOL(var a:arbol);
        procedure CREAR_NODO (var a:arbol; v:venta);
        begin
            if (a = nil) then begin
                new (a);
                a^.dato:=v;
                a^.HI:=nil;
                a^.HD:=nil;
            end
            else
                if (v.cod < a^.dato.cod) then begin
                    CREAR_NODO (a^.HI,v);
                end
                else
                    CREAR_NODO (a^.HD,v);
        end;
    var
        v:venta;
    begin
        v.cod:= RANDOM (100);
        if (v.cod <> 0) then begin
			v.fecha.dia:= 1 + RANDOM (31);
			v.fecha.mes:= 1 + RANDOM (12);
			v.fecha.anio:= 2000 + RANDOM (26);
			v.cant:= RANDOM (400);
        end;
        while (v.cod <> 0) do begin
			CREAR_NODO(a,v);
			v.cod:= RANDOM (100);
			if (v.cod <> 0) then begin
				v.fecha.dia:= 1 + RANDOM (31);
				v.fecha.mes:= 1 + RANDOM (12);
				v.fecha.anio:= 2000 + RANDOM (26);
				v.cant:= RANDOM (400);
			end;	
        end;
    end;

