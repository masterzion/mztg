unit apputils;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils
  , INIFiles,typinfo, Variants, Forms, ComCtrls,  ExtCtrls, StdCtrls, Menus, Controls, brute, dialogs, StrUtils   ;
type
  TStringArray = array of string;

function IsStrANumber(const S: string): Boolean;
function SplitTag(const Str: String; blackline : Boolean = false): TStringArray;
procedure RemoveDuplicated(var WordList : TStringList);
procedure RemoveSpecialChar(var WordList : TStringList);
//Procedure MergeSort(name: string; var f: text);
procedure WriteTranslation(strPath:string; form:TForm);
procedure LoadTranslation(strPath:string; form:TForm);
implementation

procedure RemoveSpecialChar(var WordList : TStringList);
var
  n1, n2: integer;
  sTemp1, sTemp2 : string;
begin
  sTemp1 := symbols1+symbols2+'◄'+'“'+'”'+'¬';

  for n1 := 1 to Length(sTemp1) do
      WordList.Text := stringreplace(WordList.Text,sTemp1[n1], #10#13, [rfReplaceAll]);



  for n1 := WordList.Count-1  downto 0 do
     if WordList.Strings[n1] = '' then
        WordList.delete(n1);

{
  sTemp1 :=  strLowerSpecial+strUpperSpecial;
  sTemp2 :=  strLowerSpecialConvert+strUpperSpecialConvert;



  for n1 := length(sTemp2) downto 1 do begin
      WordList.Text := StringReplace(WordList.Text,sTemp1[n1], sTemp2[n1], [rfReplaceAll]);
      Application.ProcessMessages();
  end;
 }

end;

procedure RemoveDuplicated(var WordList : TStringList);
var
  stemp : string;
  n     : Integer;
begin
 stemp := '';
 for n := WordList.Count-1 downto 0 do begin
 	if stemp = WordList.Strings[n] then
 	   WordList.Delete(n)
 	else
 	   if WordList.Strings[n] = '' then
 		 WordList.Delete(n)
 	   else
 		 stemp := WordList.Strings[n];
 end;
end;

function SplitTag(const Str: String; blackline : Boolean = false): TStringArray;
var
  List: TStrings;
  n : integer;
begin
  List := TStringList.Create;
  try
    ExtractStrings([']'], [], PChar(Str), List);

    for n := List.count-1 downto 0 do
      if ( trim(List.Strings[n]) = '' ) then
         if blackline then  List.Delete(n);


    SetLength(result, List.count);
    for n := List.count-1 downto 0 do
        result[n] := List.Strings[n]+']';
  finally
    List.Free;
  end;

end;



function IsStrANumber(const S: string): Boolean;
var
  P: PChar;
begin
  P      := PChar(S);
  Result := False;
  while P^ <> #0 do
  begin
    if not (P^ in ['0'..'9']) then Exit;
    Inc(P);
  end;
  Result := True;
end;
{
  Autor????
}

{
Procedure MergeSort(name: string; var f: text);
  Var s1,s2,a1,a2,where,tmp: integer;
	  f1,f2: text;
  Begin
	 s1:=5; s2:=5;
	 Assign(f,name);
	 Assign(f1,'temp1');
	 Assign(f2,'temp1');
	 While (s1>1) and (s2>=1) do
	   begin
		 where:=1;
		 s1:=0; s2:=0;
		 Reset(f); Rewrite(f1); Rewrite(f2);
		 Read(f,a1);
		 Write(f1,a1,' ');
		 While not EOF(f) do
		   begin
			 read(f,a2);
			 If (a2<a1) then
			   begin
				 Case where of
					1: begin
						 where:=2;
						 inc(s1);
					   End;
					2: begin
						 where:=1;
						 inc(s2);
					   End;
				 End;
			   End;
			 Case where of
				1: write(f1,a2,' ');
				2: write(f2,a2,' ');
			 End;
			 a1:=a2;
		   End;
		 If where=2 then
		   inc(s2)
		 else
		   inc(s1);
		 Close(f); Close(f1); Close(f2);


		 Rewrite(f); Reset(f1); Reset(f2);
		 Read(f1,a1);
		 Read(f2,a2);
		 While (not EOF(f1)) and (not EOF(f2)) do
		   begin
			 If (a1<=a2) then
			   begin
				 Write(f,a1,' ');
				 Read(f1,a1);
			   End
			 else
			   begin
				 Write(f,a2,' ');
				 Read(f2,a2);
			   End;
		   End;
		 While not EOF(f1) do
		   begin
			 tmp:=a1;
			 Read(f1,a1);
			 If not EOF(f1) then
				Write(f,tmp,' ')
			 else
				Write(f,tmp);
		   End;
		 While not EOF(f2) do
		   begin
			 tmp:=a2;
			 Read(f2,a2);
			 If not EOF(f2) then
				Write(f,tmp,' ')
			 else
				Write(f,tmp);
		   End;
		 Close(f); Close(f1); Close(f2);
	   End;
	 Erase(f1);
	 Erase(f2);
  End;
  }
procedure WriteTranslation(strPath:string; form:TForm);
var
  INI:TINIFile;
  sTemp : String;
  n : integer;
begin
  sTemp := strPath+form.Name+'.ini';
  INI := TINIFile.Create(sTemp, true);


 for n := 0 to form.ComponentCount - 1 do
    if form.Components[n] is TMemo then begin
      sTemp := (form.Components[n] as TMemo).Lines.Text;
      sTemp := StringReplace(sTemp, #10 , '\\r', [rfReplaceAll]);
      sTemp := StringReplace(sTemp, #13 , '\\n', [rfReplaceAll]);
      INI.WriteString('Memo', (form.Components[n] as TMemo).Name, sTemp)  ;
    end
    else
    if form.Components[n] is TCheckGroup then begin
     sTemp := (form.Components[n] as TCheckGroup).Items.Text;
     sTemp := StringReplace(sTemp, #10 , '\\r', [rfReplaceAll]);
     sTemp := StringReplace(sTemp, #13 , '\\n', [rfReplaceAll]);
     INI.WriteString('CheckGroup', (form.Components[n] as TCheckGroup).Name, sTemp)  ;
    end
    else
    if form.Components[n] is TMenuItem then begin
      sTemp := VarToStr( GetPropValue( (form.Components[n] as TMenuItem) , 'Caption') );
      if trim( sTemp ) <> '' then  INI.WriteString('Caption', (form.Components[n] as TMenuItem).Name, sTemp   );
    end
    else
       if form.Components[n] is TControl then begin
          if ( IsPublishedProp(  (form.Components[n] as TControl) , 'Caption') ) then begin
            sTemp := VarToStr( GetPropValue((form.Components[n] as TControl) , 'Caption') );
            if trim( sTemp ) <> '' then  INI.WriteString('Caption', (form.Components[n] as TControl).Name, sTemp   );
          end;

          if ( IsPublishedProp(  (form.Components[n] as TControl) , 'Hint') ) then begin
            sTemp := VarToStr( GetPropValue((form.Components[n] as TControl) , 'Hint') );
            if trim( sTemp ) <> '' then  INI.WriteString('Hint', (form.Components[n] as TControl).Name, sTemp   );
          end;
       end;
  INI.Free;
end;

procedure LoadTranslation(strPath:string; form:TForm);
var
  INI:TINIFile;
  sTemp : String;
  n : integer;
begin
  sTemp := strPath+form.Name+'.ini';
  INI := TINIFile.Create(sTemp, true);


   for n := 0 to form.ComponentCount - 1 do
      if form.Components[n] is TMemo then begin
          sTemp := INI.ReadString('Memo', (form.Components[n] as TMemo).Name, '')  ;
          if (sTemp <> '') then begin
             sTemp := StringReplace(sTemp, '\\r', #10, [rfReplaceAll]);
             sTemp := StringReplace(sTemp, '\\n', #13, [rfReplaceAll]);
            (form.Components[n] as TMemo).Lines.Text := sTemp;
         end;
      end
      else
      if form.Components[n] is TCheckGroup then begin
          sTemp := INI.ReadString('CheckGroup', (form.Components[n] as TCheckGroup).Name, '')  ;
          if (sTemp <> '') then begin
             sTemp := StringReplace(sTemp, '\\r', #10, [rfReplaceAll]);
             sTemp := StringReplace(sTemp, '\\n', #13, [rfReplaceAll]);
             (form.Components[n] as TCheckGroup).Items.Text := sTemp;
          end;
      end
      else
      if form.Components[n] is TMenuItem then begin
        sTemp := INI.ReadString('Caption', (form.Components[n] as TMenuItem).Name, ''   );
        if (sTemp <> '') then  (form.Components[n] as TMenuItem).Caption := sTemp;
      end
      else
         if form.Components[n] is TControl then begin
            if ( IsPublishedProp(  (form.Components[n] as TControl) , 'Hint') ) then begin
                sTemp := INI.ReadString('Hint', (form.Components[n] as TControl).Name, ''   );
                if (sTemp <> '') then SetPropValue((form.Components[n] as TControl), 'Hint', sTemp);
            end;

             if ( IsPublishedProp(  (form.Components[n] as TControl) , 'Caption') ) then begin
                sTemp := INI.ReadString('Caption', (form.Components[n] as TControl).Name, ''   );
                if (sTemp <> '') then SetPropValue(  (form.Components[n] as TControl),  'Caption' , sTemp  );
             end;

         end;
    INI.Free;
end;


end.

