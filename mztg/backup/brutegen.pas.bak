unit brutegen;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, ComCtrls,  ShellCtrls, Buttons;

type

  { TfrmBruteGen }

  TfrmBruteGen = class(TForm)
    btnClose: TBitBtn;
    btnOk: TBitBtn;
    btnCancel: TBitBtn;
    chkGroupTypical: TCheckGroup;
    edtCurrentPos: TEdit;
    edtBruteCustom: TEdit;
    edtBruteStart: TEdit;
    edtBruteEnd: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    memoTypicalSample: TMemo;
    PanelCurrentPos: TPanel;
    pgBruteGen: TPageControl;
    Panel1: TPanel;
    SaveDialog1: TSaveDialog;
    tsTypical: TTabSheet;
    tsCustom: TTabSheet;
    procedure btnCancelClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure chkGroupTypicalItemClick(Sender: TObject; Index: integer);
    procedure edtBruteCustomChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmBruteGen: TfrmBruteGen;
  Cancel : Boolean;

implementation
uses brute;
{$R *.lfm}

{ TfrmBruteGen }

procedure TfrmBruteGen.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmBruteGen.btnCancelClick(Sender: TObject);
begin
    Cancel := True;
end;

procedure TfrmBruteGen.btnOkClick(Sender: TObject);
{
function validos(possemibrute:string):boolean;
  const val : string =      '0123456789abcdefghijklmnopqrstuvwxzyABCDEFGHIJKLMNOPQRSTUVWXYZ';
  var
   n: integer;
begin
    Result := true;
    if ( ( pos(possemibrute[2] ,val) = 0 ) and (possemibrute[2] <> '0') ) then begin
       Result := not ( ( pos(possemibrute[1] ,val) = 0 ) and (possemibrute[1] <> '0') );
       if Result then
              Result := not ( ( pos(possemibrute[3] ,val) = 0 ) and (possemibrute[3] <> '0') );
    end;
end;
 }
var
 chars, pos : string;
 outfile : TextFile;
 count : integer;
begin
  chars := edtBruteCustom.Text;
  Cancel := false;
  if SaveDialog1.Execute  then begin
     btnOk.Visible:= False;
     btnClose.Visible:= False;
     btnCancel.Visible:= True;
     AssignFile(outfile, pchar(SaveDialog1.FileName) );
     Rewrite(outfile);
     PanelCurrentPos.Visible:= True;
     pos := edtBruteStart.Text;
     Writeln(outfile, pos);
     count := 0;
     while (pos <> edtBruteEnd.Text ) do begin
       pos := BruteForce(chars,pos);
       count += 1;
       if (count > 80000) then begin
          Application.ProcessMessages;
          edtCurrentPos.Text:= pos;
          count := 0;
          if Cancel then Break;
       end;
//       if validos(pos) then
       Writeln(outfile, pos);
     end;
     PanelCurrentPos.Visible:= False;
     CloseFile(outfile);
     ShowMessage('Finished!');
     btnCancel.Visible:= False;
     btnClose.Visible:= True;
     btnOk.Visible:= True;
  end;

 end;



procedure TfrmBruteGen.chkGroupTypicalItemClick(Sender: TObject; Index: integer
  );
begin
   memoTypicalSample.clear;
   if ( chkGroupTypical.Checked[0] ) then memoTypicalSample.Text := memoTypicalSample.Text+strLower ;
   if ( chkGroupTypical.Checked[1] ) then memoTypicalSample.Text := memoTypicalSample.Text+strUpper ;
   if ( chkGroupTypical.Checked[2] ) then memoTypicalSample.Text := memoTypicalSample.Text+Numbers ;
   if ( chkGroupTypical.Checked[3] ) then memoTypicalSample.Text := memoTypicalSample.Text+' ' ;
   if ( chkGroupTypical.Checked[4] ) then memoTypicalSample.Text := memoTypicalSample.Text+symbols1 ;
   if ( chkGroupTypical.Checked[5] ) then memoTypicalSample.Text := memoTypicalSample.Text+symbols2 ;

   edtBruteCustom.Text:= memoTypicalSample.Text;


end;

procedure TfrmBruteGen.edtBruteCustomChange(Sender: TObject);
var
   n : integer;
begin
   edtBruteStart.Clear;
   edtBruteEnd.Clear;
   n := Length( edtBruteCustom.Text );
   if n  > 0 then begin

         edtBruteStart.Text := edtBruteStart.Text + edtBruteCustom.Text[1] + edtBruteCustom.Text[1] + edtBruteCustom.Text[1] ;
         edtBruteEnd.Text   := edtBruteEnd.Text + edtBruteCustom.Text[n] + edtBruteCustom.Text[n] + edtBruteCustom.Text[n] + edtBruteCustom.Text[n] ;
   end;
end;

procedure TfrmBruteGen.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
   CloseAction := caFree;
end;

procedure TfrmBruteGen.FormCreate(Sender: TObject);
var
   n: integer;
begin
     pgBruteGen.ActivePage := tsTypical;
     for n := 0 to chkGroupTypical.Items.Count-1 do
         chkGroupTypical.Checked[n] := true;

     chkGroupTypicalItemClick(Self, 0);
end;




end.
