unit brute;

{$mode objfpc}{$H+}
 {
Brute 2.0  by Master_Zion
}

interface


uses
  Classes, SysUtils;

const
// characters  ´` ¨ have bug in fpc?
Numbers:  String = '0123456789';
strLower: String = 'abcdefghijklmnopqrstuvwxyz';
strUpper: String = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
symbols1: String = '!@#$%&*()_+.,-';
symbols2: String = '<>;:?[]{}~^''"\/=';

strLowerSpecial          : String = 'áéíóúâêîôûäëïöüãõàèùòç';
strUpperSpecial          : String = 'ÁÉÍÓÚÂÊÎÔÛÄËÏÖÜÃÕÀÈÙÒÇ';

strLowerSpecialConvert   : String = 'aeiouaeiouaeiouaoaeuoc';
strUpperSpecialConvert   : String = 'AEIOUAEIOUAEIOUAOAEUOC';


function BruteForce(Chars, strLastPos:String):String;

implementation




function BruteForce(Chars, strLastPos:String):String;
var
 n, LenLastPos: Integer;
 LastPos, FirstChar:String;
 thischar : char;
begin
  LastPos := strLastPos;
  LenLastPos := Length(LastPos);

  // for each chars in current text
  for n := 1 to LenLastPos do begin
    // is the last char?
	thischar := LastPos[n];
    if ( thischar = Chars[ Length(Chars) ] ) then begin
        FirstChar := Chars[1];
        if ( n = LenLastPos ) then begin
            // is the last position and last char?
            //        copy  start           +  reset this char     + plus 1 lenght
            result := Copy(LastPos, 0 , n-1) +       FirstChar      + FirstChar ;
            // exit
            Break;
        end
        else begin
            // is only the last char? ok reset it, but continue to next char...
            //          copy start            +  reset the char + copy the end
            LastPos := Copy(LastPos, 0 , n-1) + FirstChar       + copy(LastPos, N+1,Length(Chars) ) ;
        end;
    end
    else begin
      // only get next character and exit
      //         copy start            +     get next char                 + copy the end
      result := Copy(LastPos, 0 , n-1) + Chars[ pos(thischar, Chars)+1 ] + copy(LastPos, N+1,Length(Chars) ) ;
      Break;
    end;
  end;
end;

end.

