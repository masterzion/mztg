unit sanitizer;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, SynMacroRecorder, SynEdit, Forms, Controls,
  Graphics, Dialogs, StdCtrls, ExtCtrls, Buttons, Spin, ComCtrls, LCLType;

type

  { TfrmSanitizer }

  TfrmSanitizer = class(TForm)
    ImageList1: TImageList;
    Label1: TLabel;
    Label2: TLabel;
    Panel2: TPanel;
    ReplaceDialog1: TReplaceDialog;
    SaveDialog1: TSaveDialog;
    speditMax: TSpinEdit;
    speditMin: TSpinEdit;
    Memo1: TSynEdit;
    SynMacroRecorder1: TSynMacroRecorder;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton10: TToolButton;
    ToolButton11: TToolButton;
    ToolButton12: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure Memo1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ReplaceDialog1Find(Sender: TObject);
    procedure ReplaceDialog1Replace(Sender: TObject);
    procedure SynMacroRecorder1StateChange(Sender: TObject);
    procedure ToolButton11Click(Sender: TObject);
    procedure ToolButton12Click(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure ToolButton2Click(Sender: TObject);
    procedure ToolButton3Click(Sender: TObject);
    procedure ToolButton5Click(Sender: TObject);
    procedure ToolButton7Click(Sender: TObject);
    procedure ToolButton9Click(Sender: TObject);
  private
    { private declarations }

  public
    { public declarations }
  end;

var
  frmSanitizer: TfrmSanitizer;

implementation
uses apputils;
{$R *.lfm}

{ TfrmSanitizer }


procedure TfrmSanitizer.FormClose(Sender: TObject; var CloseAction: TCloseAction
  );
begin
  CloseAction:= caFree;
end;


procedure TfrmSanitizer.Memo1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = LCLType.VK_F) and (ssCtrl in Shift) then ToolButton3.Click;
  if (Key = LCLType.VK_F3) then ReplaceDialog1Find(Self);
end;



procedure TfrmSanitizer.ReplaceDialog1Find(Sender: TObject);
var
 n, nTemp : Integer;
 stemp : string;
begin
  stemp := StringReplace(StringReplace(ReplaceDialog1.FindText, '\n', #10#13, [rfReplaceAll]), '\t', #9, [rfReplaceAll]);
  if length(Memo1.Text) > 0 then begin
    nTemp :=  Length(stemp);

      n := Pos(stemp,  Memo1.Text);
      if (n > 0) then begin
         Memo1.SelStart:= n;
         Memo1.SelEnd := n+nTemp;
      end;
  end;
end;




procedure TfrmSanitizer.ReplaceDialog1Replace(Sender: TObject);
var
 sTemp  : string;
begin
  sTemp := Memo1.Lines.Text;

  ReplaceDialog1.FindText := StringReplace(StringReplace(ReplaceDialog1.FindText, '\n', #10#13, [rfReplaceAll]), '\t', #9, [rfReplaceAll]);
  ReplaceDialog1.ReplaceText := StringReplace(StringReplace(ReplaceDialog1.ReplaceText, '\n', #10#13, [rfReplaceAll]), '\t', #9, [rfReplaceAll]);

  sTemp := StringReplace(sTemp, ReplaceDialog1.FindText, ReplaceDialog1.ReplaceText, [rfReplaceAll]);
  Memo1.Lines.Text := sTemp
end;

procedure TfrmSanitizer.SynMacroRecorder1StateChange(Sender: TObject);
begin
  if SynMacroRecorder1.State = msStopped then
     ToolButton9.ImageIndex:= 5
  else
     ToolButton9.ImageIndex:= 8;


end;

procedure TfrmSanitizer.ToolButton11Click(Sender: TObject);
begin
 SynMacroRecorder1.PlaybackMacro(Memo1);
end;

procedure TfrmSanitizer.ToolButton12Click(Sender: TObject);
var
  n, Count, MaxExec :Integer;
begin
MaxExec := Memo1.Lines.Count * 3;
Count := 0;

if Memo1.Lines.Count > 0 then
   while (Memo1.Carety <> Memo1.Lines.Count ) do begin
     if ( Count > MaxExec  ) then begin
         ShowMessage('Too Sloow! Infinite loop?');
         Break;
     end
     else begin
        SynMacroRecorder1.PlaybackMacro(Memo1);
        Count +=1;
     end;


   end;
end;


procedure TfrmSanitizer.ToolButton1Click(Sender: TObject);
begin
    if (SaveDialog1.Execute) then
      if (SaveDialog1.FileName <> '') then
         Memo1.Lines.SaveToFile(SaveDialog1.FileName);
end;

procedure TfrmSanitizer.ToolButton2Click(Sender: TObject);
var
 list : TStringList;
 n : Integer;
begin
   list := TStringList.Create();
   list.Text := Memo1.Text;

   list.BeginUpdate;
   list.Sort;
   for n := 0 to list.Count do
       if list.Strings[0] = '' then
          list.Delete(0)
       else
           Break;

   list.EndUpdate;

   Memo1.Text := list.Text ;
   list.Free;
   {
     list := TStringList.Create();
     list.AddStrings( Memo1.Lines );
     list.Sort;
     Memo1.Clear;
     Memo1.Lines.AddStrings(list);
     list.Free;}

end;

procedure TfrmSanitizer.ToolButton3Click(Sender: TObject);
begin
  ReplaceDialog1.Execute;
end;

procedure TfrmSanitizer.ToolButton5Click(Sender: TObject);
var
 list : TStringList;
begin
   list := TStringList.Create();
   list.Text := Memo1.Text;
   list.CustomSort( @MyListCompare );
   Memo1.Text := list.Text ;
end;

procedure TfrmSanitizer.ToolButton7Click(Sender: TObject);
var
  List1 : TStringList;
  n, nTemp : integer;
  sTemp : string;
begin
  List1 := TStringList.create();



  List1.Text := StringReplace(Memo1.Lines.Text, '(', #10#13, [rfReplaceAll]);

  List1.Text := StringReplace(List1.Text, ')', #10#13, [rfReplaceAll]);
  List1.Text := StringReplace(List1.Text, '[', #10#13, [rfReplaceAll]);
  List1.Text := StringReplace(List1.Text, ']', #10#13, [rfReplaceAll]);
  List1.Text := StringReplace(List1.Text, '''', '', [rfReplaceAll]);
  List1.Text := StringReplace(List1.Text, ',', '', [rfReplaceAll]);
  List1.Text := StringReplace(List1.Text, #9, #10#13, [rfReplaceAll]);


  RemoveSpecialChar(List1);

  List1.Text := StringReplace(List1.Text, ' ', '', [rfReplaceAll]) + StringReplace(List1.Text, ' ', #10#13, [rfReplaceAll]);


  for n := List1.Count-1 downto 0 do begin
        sTemp := List1.Strings[n];
        nTemp := Length( sTemp );
	if (nTemp < speditMin.Value) or  (nTemp > speditMax.Value) then
           List1.delete(n)
        else
            if IsStrANumber(sTemp) then List1.delete(n);
  end;

  List1.Sort();
  RemoveDuplicated(List1);
  List1.CustomSort( @MyListCompare );

  Memo1.Lines.Text := List1.Text;
  List1.Free;
end;

procedure TfrmSanitizer.ToolButton9Click(Sender: TObject);
begin
  if ( SynMacroRecorder1.State = msStopped ) then
    SynMacroRecorder1.RecordMacro(Memo1)
  else
      SynMacroRecorder1.Stop;


end;



end.
