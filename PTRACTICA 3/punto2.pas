program punt2;
type
    venta=record
        cod:integer;
        fecha:fechas;
        cant:integer;
    end;

    arbol=ˆnodo;
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
                aˆ.dato:=v
                aˆ.HI:=nil;
                aˆ.HD:=nil;
            end
            else
                if (v.cod < aˆ.dato.cod) then begin
                    CREAR_NODO (Aˆ.HI,v);
                end
                else
                    CREAR_NODO (Aˆ.HD,v);
        end;
    var
        v:venta;
    begin
        
    end;
