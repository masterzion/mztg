unit heuristic;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Spin,
  StdCtrls, Buttons, ComCtrls, apputils;

type
  { TfrmHeuristic }

  TfrmHeuristic = class(TForm)
    btnCancel: TBitBtn;
    btnClose: TBitBtn;
    btnOk: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    ProgressBar1: TProgressBar;
    spedtMinWordListSize: TSpinEdit;
    spedtMaxWordListSize: TSpinEdit;
    spedtMinWordCountList: TSpinEdit;
    spedtMaxfileSize: TSpinEdit;
    procedure btnCancelClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
  private
    { private declarations }
  public
    strPath : String;
    { public declarations }
  end;

var
  frmHeuristic: TfrmHeuristic;

implementation
uses main;

var bContinue : boolean;
{$R *.lfm}

{ TfrmHeuristic }

procedure TfrmHeuristic.FormClose(Sender: TObject; var CloseAction: TCloseAction
  );
begin
  CloseAction := caFree;
end;

procedure TfrmHeuristic.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmHeuristic.btnCancelClick(Sender: TObject);
begin
   bContinue := False;
end;

procedure TfrmHeuristic.btnOkClick(Sender: TObject);
var
  ListSearch, ListCustom : TStringList;
  FindRec: TSearchRec;
  folder :string;
  n, n2, n3, Count, nTemp : Integer;





begin
    btnOk.Visible := False;
    btnCancel.Visible := True;
    bContinue := true;
    frmMain.memoLog.Clear;

    ListSearch := TStringList.Create();
    ListCustom := TStringList.Create();

//    ListaTemp := TStringList.Create();
    ListCustom.LoadFromFile( frmMain.flWordList.Text );

    ListCustom.Text := LowerCase(ListCustom.Text);
    ListCustom.sort;
    RemoveDuplicated(ListCustom);

    frmMain.lbSelectedFiles.Items.Clear;
    for n := ListCustom.Count -1 downto 0 do begin
           nTemp := length( trim( ListCustom.Strings[n] ) );
           if ( nTemp < spedtMinWordListSize.Value ) or ( nTemp > spedtMaxWordListSize.Value ) then
              ListCustom.Delete(n);
    end;
    ListCustom.SaveToFile(frmMain.flWordList.Text+'_saida.txt');

    ProgressBar1.Max := frmMain.lstFolder.Count-1;
    ProgressBar1.Position := 0;
    Count := 0;
    for n := 0 to frmMain.lstFolder.Count -1 do begin
           folder := frmMain.lstFolder.Items[ n ];
           if  FindFirst( strPath + 'classified' + PathDelim + folder + PathDelim  +'*', faAnyFile, FindRec) = 0 then
            repeat
              if (FindRec.attr and faArchive = faArchive) then
                 if (FindRec.Name <> '.') and (FindRec.Name <> '..') and ( FindRec.Size <= (spedtMaxfileSize.Value * 1024) )  then begin
                   ListSearch.LoadFromFile(strPath + 'classified' + PathDelim  + folder + PathDelim + FindRec.Name);
                   frmMain.writelog('Checking file ...'+folder + PathDelim + FindRec.Name);
                   for n2 := ListSearch.Count -1 downto 0 do begin
                          nTemp := length( trim( ListSearch.Strings[n2] ) );
                          if ( nTemp < spedtMinWordListSize.Value ) or ( nTemp > spedtMaxWordListSize.Value ) then ListSearch.Delete(n2);
                   end;
//                   ListaTemp.Text := '';
                   ListSearch.Text := lowercase(ListSearch.Text);
                   for n2 := ListCustom.Count -1 downto 0 do begin
                          for n3 := ListSearch.Count -1 downto 0 do begin
                             if ( ListCustom.Strings[n2] = ListSearch.Strings[n3] ) then Count += 1;
//                               ListaTemp.Add(ListSearch.Strings[n3]);
                             if ( Count >= spedtMinWordCountList.Value ) then break;
                          end;
                          if ( Count >= spedtMinWordCountList.Value ) then break;
                   end;

                   if ( Count >= spedtMinWordCountList.Value ) then  begin
                     frmMain.lbSelectedFiles.Items.Add(folder + PathDelim + FindRec.Name);
//                     frmMain.writelog(folder + PathDelim + FindRec.Name +'('+Inttostr(Count)+')');
//                     if count < 20 then frmMain.writelog(ListaTemp.Text);
                   end;
//                   ListaTemp.Text := '';
                   Count := 0;
                 end;
            Until FindNext(FindRec)<>0;
            FindClose(FindRec);
            ProgressBar1.Position :=  ProgressBar1.Position + 1;
    end;
    btnOk.Visible := True;
    btnCancel.Visible := False;

end;

end.

