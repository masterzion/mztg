unit htmlutil;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, brute, forms;
//,  DOM, XMLRead;


function StripHTMLTags(const HTML: widestring): string;

implementation
uses google;



    function StripHTMLTags(const HTML: widestring): string;
    var
      n, count, scriptpos, scriptend: Integer;
      strHTML : widestring;
      b: Boolean;
    begin
      strHTML := HTML;
      Result := '';
      scriptpos := -1;
      scriptend := 0;

      while ( Pos('</script>', strHTML ) > 0 ) and ( not ( scriptpos > scriptend) )  do begin
          scriptpos := Pos('<script', strHTML);
          scriptend := Pos('</script>', strHTML);
          delete(strHTML, scriptpos, scriptend-scriptpos+9);
          strHTML := trim(strHTML);
          Application.ProcessMessages;
      end;

      b:=true;
      count :=0;
      if Assigned(frmGoogle) then begin
           frmGoogle.ProgressBar1.Max := Length(strHTML);
           frmGoogle.ProgressBar1.Position:= 0;
      end;

      for n := 1 to Length(strHTML) do begin
          if Assigned(frmGoogle) then frmGoogle.ProgressBar1.Position := frmGoogle.ProgressBar1.Position+1;

          count+=1;
          if count > 10000 then begin
              Application.ProcessMessages;
              count := 0;
          end;
          if strHTML[n] = '<' then
             b:=false
          else
             if strHTML[n] = '>' then
                b:=true
             else
                if b then
                   if strHTML[n] = ' ' then
                      AppendStr(result, #10#13)
                   else
                      AppendStr(result, strHTML[n]);

      end;
    end;


end.

