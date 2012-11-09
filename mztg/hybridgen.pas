unit hybridgen;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, DateUtils, ExtCtrls,  Forms;


const arHybridTypes:array [0..7] of string=('brute','num','char','semibrute','word','loginpart','date', 'space');


const arAttackTypeBrute      = 0;
const arAttackTypeNum        = 1;
const arAttackTypeChar       = 2;
const arAttackTypeSemiBrute  = 3;
const arAttackTypeWord       = 4;
const arAttackTypeLoginPart  = 5;
const arAttackTypeDate       = 6;
const arAttackTypeSpace      = 7;

type
  THybrid =  Class
  public
     HybridType : Integer;
     Size: Integer;
end;

type
  THybridBrute =  Class(THybrid)
  public
     Chars : string;
     StartPos : string;
     Position : string;
     EndPos : string;
end;

type
  THybridPreIndexed =  Class(THybrid)
  public
     Index : Integer;

end;

type
  THybridLine = array of THybrid;
  THybridAttack = array of THybridLine;

  TDateFormatArray = array of string;
  THybridValidation = array[0..1] of integer;
  TLineHybridValidation = array of THybridValidation;
  THybridAttackValidation = array of TLineHybridValidation;


  function CheckTagSyntax(const tag:String  ):THybridValidation;
  function  MakeHybridArray(const AttackList: TStringList; var hybridarray: THybridAttack ; var iMaxWordSize, iMinWordSize : Integer  ): integer;

  procedure WriteAttack(const preText: String; const Line: THybridLine; const objIndex, objIndexSize:integer; postext : String   );
  procedure TextInteraction(const Text:String; var InteractionList: TStringList);
  procedure AppendFile(Text:String);
  procedure ChangeCaseText(const text: String;var  list:TStringlist; const ini, len, charpos, charcount : integer; const source, target: string );

implementation
uses main, brute, apputils, threadattack;
var
  nStatusCounter, nWordsPerSecondCounter : Integer;

procedure ChangeCaseText(const text: String;var list:TStringlist; const ini, len, charpos, charcount : integer; const source, target: string );
var
  sTemp : String;
  n, npos : Integer;
begin
  for n := ini to len do begin
     sTemp := text;
     npos := pos(sTemp[n], pchar(source));
     if npos > 0 then begin
        sTemp[n] := target[npos];
        list.add(sTemp);
        if charpos < charcount then ChangeCaseText(sTemp, list, n+1, len, charpos+1, charcount, source, target );
     end;
  end;

end;

procedure AppendFile(Text:String);
var
  p : pchar;
  n : integer;
begin
    if nStatusCounter = 0 then begin
       nStatusCounter := frmMain.tbRefresh.Position * 10000;
       frmMain.edtLastText.Text:= Text;
//       nWordsPerSecondCounter += 1;
    end
    else
       nStatusCounter -= 1 ;
    Text += #10;
    OutPutAttackFile.WriteBuffer(Text[1], length(Text));

end;

procedure TextInteraction(const Text:String; var InteractionList: TStringList);
//'A','A','B','E','I','L','O','S','T','Z'
//'@','4','8','3','1','1','0','5','7','2'
const
  arrl : string =   'abeilostz';
  arru : string =   'ABEILOSTZ';
  arr1 : string =   '483110572';
  arr2 : string =   '@83110572';
  arr3 : string =   '483110$72';
  arr4 : string =   '@83110$72';
var
//
  n, len :integer;
  sLower, sUpper : String;

begin

//  InteractionList: TStringList
//  InteractionList := TStringList.Create();
  if bPreserveCase then InteractionList.Add( Text );
  if bLowerCase    then begin
     sLower :=  LowerCase(Text);
     InteractionList.Add( sLower );
  end;
  if bUpperCase then begin
     sUpper := UpperCase(Text);
     InteractionList.Add( sUpper );
  end;
  len := Length(Text);

  if iLowerToUpperCase > 0 then ChangeCaseText(sLower, InteractionList, 1, len, 1, iLowerToUpperCase, strLower+strLowerSpecial, strUpper+strUpperSpecial );
  if iUpperToLowerCase > 0 then ChangeCaseText(sUpper, InteractionList, 1, len, 1, iUpperToLowerCase, strUpper+strUpperSpecial, strLower+strLowerSpecial );

  if bL33t then begin
     len := Length(arr2);
     for n := 1 to len do begin
       if pos(arrl[n], sLower) > 0 then begin
          InteractionList.Add(  StringReplace( sLower, arrl[n], arr1[n], [rfReplaceAll] ) );
          InteractionList.Add(  StringReplace( sLower, arrl[n], arr2[n], [rfReplaceAll] ) );
          InteractionList.Add(  StringReplace( sLower, arrl[n], arr3[n], [rfReplaceAll] ) );
          InteractionList.Add(  StringReplace( sLower, arrl[n], arr4[n], [rfReplaceAll] ) );
       end;

       if pos(arru[n], sUpper) > 0 then begin
          InteractionList.Add(  StringReplace( sUpper, arru[n], arr1[n], [rfReplaceAll] ) );
          InteractionList.Add(  StringReplace( sUpper, arru[n], arr2[n], [rfReplaceAll] ) );
          InteractionList.Add(  StringReplace( sUpper, arru[n], arr3[n], [rfReplaceAll] ) );
          InteractionList.Add(  StringReplace( sUpper, arru[n], arr4[n], [rfReplaceAll] ) );
       end;

     end;
  end;

  InteractionList.Sort;
  RemoveDuplicated(InteractionList);
//  Text:=InteractionList.Text;
//  for n := 0 to InteractionList.Count-1 do  AppendFile( InteractionList.Strings[n] );

//  InteractionList.Free;
end;

procedure WriteAttack(const preText: String; const Line: THybridLine; const objIndex, objIndexSize:integer; postext : String   );
var
  n, n2 : integer;
  brute       : THybridBrute;
  indexed     : THybridPreIndexed;
  dict        : TStringList;
  ThreadAttack : TThreadAttack;
  InteractionList: TStringList;
begin
    Application.ProcessMessages();
    if  ( Line[objIndex].HybridType > 2 ) then begin
       indexed := ( Line[objIndex] as THybridPreIndexed );
       if indexed.HybridType = arAttackTypeSpace then begin
          if ( objIndex = objIndexSize ) then begin
             AppendFile( preText+' '+postext )
          end
          else begin
             WriteAttack(preText+' ', Line, objIndex+1,objIndexSize, postext   );
          end;

       end
       else begin
           Case indexed.HybridType of
                arAttackTypeSemiBrute :  if indexed.Size = 2 then
                                            dict :=  ListSemiBrute2
                                         else
                                            dict :=  ListSemiBrute3;

                arAttackTypeWord      : begin
                                          // array split by size
                                          dict := WordListbySize[indexed.Size];
                                        end;
                arAttackTypeLoginPart : begin
                                         dict := ListLoginPart;
                                        end;

                arAttackTypeDate      : begin
                                          dict := DateTimebySize[indexed.Size];
                                        end;

           end;
           {
                                       while ( nThreadCount > appThreadCount ) do begin
                                             if CancelProcess then Break;
                                             sleep(1);
                                             Application.ProcessMessages();
                                       end;
                                       nThreadCount  += 1;
                                       ThreadAttack := TThreadAttack.create(False);
                                       ThreadAttack.SetText(preText+InteractionList.Strings[n2]+postext);
                                       ThreadAttack.Start();}
           if assigned(dict) and ( dict.Count > 0 ) then begin
              for n := 0 to dict.Count-1 do begin
                   if CancelProcess then Break;
                   Application.ProcessMessages();
                   if ( objIndex = objIndexSize ) then begin
                       if ( indexed.HybridType = arAttackTypeWord ) or  ( indexed.HybridType = arAttackTypeLoginPart ) then begin
                           InteractionList := TStringList.Create();
                           TextInteraction(dict.Strings[n], InteractionList);
                           for n2 := 0 to InteractionList.count-1 do AppendFile(preText+InteractionList.Strings[n2]+postext);
                           InteractionList.Free;
                        end
                        else
                           AppendFile( preText+dict.Strings[n]+postext)
                   end
                   else begin
                        if ( indexed.HybridType = arAttackTypeWord ) or  ( indexed.HybridType = arAttackTypeLoginPart ) then begin
                           InteractionList := TStringList.Create();
                           TextInteraction(dict.Strings[n], InteractionList);
                           for n2 := 0 to InteractionList.count-1 do WriteAttack(preText+InteractionList.Strings[n2]+postext, Line, objIndex+1,objIndexSize, postext   );
                           InteractionList.Free;
                        end
                        else
                            WriteAttack(preText+dict.Strings[n]+postext, Line, objIndex+1,objIndexSize, postext   );
                   end;
              end;
              indexed.Index += 1;
           end
           else
              exit;
       end;
    end
    else begin
        brute := ( Line[objIndex] as THybridBrute );
        brute.Position := brute.StartPos;

        while ( brute.Position <>  brute.EndPos ) do begin
          Application.ProcessMessages();
          if CancelProcess then Break;
          if ( objIndex = objIndexSize ) then begin
             AppendFile( preText+brute.Position+postext );
          end
          else begin
             WriteAttack(preText+brute.Position, Line, objIndex+1,objIndexSize, postext   );
          end;
          brute.Position := BruteForce(brute.Chars, brute.Position );
        end;

        if ( objIndex = objIndexSize ) then
           AppendFile( preText+brute.Position+postext)
        else
           WriteAttack(preText+brute.Position, Line, objIndex+1,objIndexSize, postext   );

    end;
    exit;
end;


function CheckTagSyntax( const tag:String  ):THybridValidation;
var
  LenHybrid, taglim1, taglim2, n: integer;
  tagtext, num : string;
begin
    Result[0] := -1;
    if Length(tag) = 0 then exit;
    LenHybrid := SizeOf(arHybridTypes);


    taglim1 := 0;
    taglim2 := 0;

    // check if all tags is closed
    for n:= 1 to Length(tag) do begin
  	if tag[n] = '[' then taglim1 +=1;
  	if tag[n] = ']' then taglim2 +=1;
    end;

    if (taglim1 <> taglim2) then exit;

    taglim2 :=  Pos(']', tag);
    taglim1  := Pos('[', tag);

    if  ( taglim1 >= taglim2 ) then begin
        Result[0] := -1;
        exit;
    end;

    tagtext := Copy(tag, taglim1+1, taglim2-taglim1-1 );

    for n := 0 to 7 do begin
        if Pos(arHybridTypes[n], ' '+tagtext) > 0 then begin
           num := StringReplace(tagtext, arHybridTypes[n], '', []);

           if (n = 5) then begin
              Result[0] := n;
              Result[1] := 0;
              Break;
           end
           else begin
               if (n = 7)  then begin
                  if ( Length(num) = 0 ) then begin
                     Result[1] := 0;
                     Result[0] := n;
                     Break;
                  end;
               end
               else
                  if Length(num)  > 0 then
                     if IsStrANumber(num) then begin
                        Result[1] := StrToInt(num);
                        Result[0] := n;
                        Break;
                     end;
           end;
        end;
    end;
end;

function MakeHybridArray(const AttackList: TStringList; var hybridarray: THybridAttack; var iMaxWordSize, iMinWordSize : Integer  ): integer;
var
  LenAttack, LineCount, LenLine, n1, n2, n3, lenbrute : integer;
  SplitList              : TStringArray;
  // validation of
  ItemValidation         : THybridValidation; // each item
  LineValidation         : TLineHybridValidation; // each line
  HybridAttackValidation : THybridAttackValidation;  // all attack

  HybridLine     : THybridLine;
  HybridAttack   : THybridAttack;

  ret     : THybrid;
  tag, linetags     : string;

  // create attack objects
  HybridItemBrute     : THybridBrute;
  HybridItemIndexed   : THybridPreIndexed;

begin
  LenAttack := 0;
  Result := -1;
  SetLength(hybridarray, AttackList.Count);

  // first check all syntax and create validation arrays
   for n1 := 0 to AttackList.Count-1 do begin
      LenLine := 0;
      linetags :=  trim( AttackList.Strings[n1] );
      SplitList := SplitTag(linetags );
      SetLength(HybridAttackValidation, LenAttack+1);
      LenLine := length(SplitList);
       if ( LenLine > 0 ) then begin
          SetLength(LineValidation, LenLine);
          for n2 := 0 to LenLine-1 do begin
              tag := SplitList[n2];
              ItemValidation := CheckTagSyntax( tag );
              if ItemValidation[0] < 0 then begin
                  result := n1;
                  exit;
               end
               else
                  LineValidation[n2] := ItemValidation;
          end;
    end
    else begin
        result := n1;
        exit;
    end;
    LenAttack += 1;
    HybridAttackValidation[LenAttack-1] :=  LineValidation;
  end;

  // generate Attack objects
  SetLength( HybridAttack, LenAttack );
  LenLine := 0;
  LineCount := 0;

  for LineValidation in HybridAttackValidation do begin
      LenLine := 0;
      LineCount += 1;

      //       SizeOf( LineValidation ) have bug
      for ItemValidation in LineValidation do begin
          LenLine +=1;
          SetLength(HybridLine, LenLine);

          if  ( ItemValidation[0] = arAttackTypeSpace ) then begin
              ret := THybrid.Create();
              ret.HybridType := arAttackTypeSpace;
              HybridLine[n2] := ret;
          end
          else
              if  ( ItemValidation[0] > 2 ) then begin
                  HybridItemIndexed := THybridPreIndexed.create;
                  HybridItemIndexed.Index:= 0;
                  HybridItemIndexed.HybridType := ItemValidation[0];
                  HybridItemIndexed.Size := ItemValidation[1];
                  HybridLine[LenLine-1] := HybridItemIndexed;
                  if HybridItemIndexed.HybridType = arAttackTypeWord then begin
                     if ( HybridItemIndexed.Size  > iMaxWordSize ) then  iMaxWordSize := HybridItemIndexed.Size;
                     if ( HybridItemIndexed.Size  < iMinWordSize ) then  iMinWordSize := HybridItemIndexed.Size;
                  end;
              end
              else begin
                  HybridItemBrute := THybridBrute.create;
                  HybridItemBrute.HybridType := ItemValidation[0];


                  Case HybridItemBrute.HybridType of
                       arAttackTypeBrute : begin
                                                HybridItemBrute.Chars :=  numbers;
                                                if frmMain.chkgSpecialChar.Checked[0] then begin
                                                    HybridItemBrute.Chars := HybridItemBrute.Chars + ' ';
                                                    if frmMain.chkgSpecialChar.Checked[3] then HybridItemBrute.Chars := HybridItemBrute.Chars+strLowerSpecial;
                                                end;
                                                HybridItemBrute.Chars := HybridItemBrute.Chars + strlower;
                                                if frmMain.chkgSpecialChar.Checked[1] then HybridItemBrute.Chars := HybridItemBrute.Chars + symbols1;
                                                if frmMain.chkgSpecialChar.Checked[2] then HybridItemBrute.Chars := HybridItemBrute.Chars + symbols2;

                                                if frmMain.chkgSpecialChar.Checked[4] then begin
                                                    HybridItemBrute.Chars := HybridItemBrute.Chars + strUpper;
                                                    if frmMain.chkgSpecialChar.Checked[3] then HybridItemBrute.Chars := HybridItemBrute.Chars+strUpperSpecial;
                                                end;


                                                HybridItemBrute.Size := ItemValidation[1];
                                           end;
                       arAttackTypeNum   : begin
                                                HybridItemBrute.Chars :=  numbers;
                                                HybridItemBrute.Size := ItemValidation[1];
                                           end;
                       arAttackTypeChar  : begin
                                                HybridItemBrute.Chars :=  strLower;
                                                HybridItemBrute.Size := 1;
                                           end;
                  end;

                  HybridItemBrute.StartPos := '';
                  HybridItemBrute.EndPos := '';

                  lenbrute := Length( HybridItemBrute.Chars );

                  for n3 := 0 to ItemValidation[1]-1 do begin
                     HybridItemBrute.StartPos :=  HybridItemBrute.StartPos+HybridItemBrute.Chars[1];
                     HybridItemBrute.EndPos   :=  HybridItemBrute.EndPos  +HybridItemBrute.Chars[lenbrute];
                  end;
                  HybridItemBrute.Position := HybridItemBrute.StartPos;

                  HybridLine[LenLine-1] := HybridItemBrute;
              end;
      end;

      hybridarray[LineCount-1] := HybridLine;
  end;

end;

end.

