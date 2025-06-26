program punto1;
type
	sub_r=1..15;
	venta=record
		dia:integer;
		cod:sub_r;
		cant:integer;
	end;
	vector=array [0..49] of venta;
	
	//TIPO DE DATOS
	procedure CARGAR_DATOS (var v:vector; var diml:integer);
		procedure LEER_DATOS (var r:venta);
		begin
			r.dia:= RANDOM (31);
			if (r.dia <> 0) then begin
				r.cod:= 1 + RANDOM (15);
				r.cant:= RANDOM (100);
			end;
		end;
	var
		r:venta;
	begin
		diml:=0;
		LEER_DATOS(r);
		while (r.dia <> 0) and (diml < 49) do begin
			v[diml]:= r;
			diml:=diml+1;
			LEER_DATOS(r);
		end;
	end;
	
	procedure INCISO_B (v:vector; diml:integer);
	var
		i:integer;
	begin
		for  i := 0 to diml do begin
			writeln ('POSICION ', i+1);
			writeln ('Dia= ', v[i].dia);
			writeln ('Codigo= ', v[i].cod);
			writeln ('Cantidad= ', v[i].cant);
			writeln ('//////////////////////////////////////////////////////////////////');
		end;
	end;
	
	procedure ORDENAR_VECTOR (var v:vector;diml:integer);
	var
		i,j:integer;
		aux:venta;
	begin
		for i:= 0 to diml do begin
			for j:= i+1 to diml do begin
				if (v[j].cod < v[i].cod) then begin
					aux:=v[i];
					v[i]:=v[j];
					v[j]:=aux;
				end;
			end;
		end;
	end;
	
	
	procedure INCISO_E (var v:vector);
	var
		num:integer;
		i:integer;
	begin
		i:=0;
		writeln ('INGRESE UN NUMERO');
		while (v[i].cod <> and ()
	end;
	
	
	
	
	
	
var
	v:vector;
	diml:integer;
begin
	CARGAR_DATOS (v,diml);
	INCISO_B (v,diml);
	ORDENAR_VECTOR (v,diml);
	writeln ('VECTOR YA ORDENADO');
	writeln ('___________________________________________');
	writeln ('___________________________________________');
	INCISO_B (v,diml);
end.
