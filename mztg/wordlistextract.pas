unit wordlistextract;
{$mode objfpc}{$H+}
interface

uses
   SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls,  Spin, Buttons, EditBtn;

{$I invalidchars.inc}

type

  { TfrmWordListExtract }

  TfrmWordListExtract = class(TForm)
    btnCancel: TBitBtn;
    btnClose: TBitBtn;
    btnStart: TBitBtn;
    chkLower: TCheckBox;
    chkRemoveChars: TCheckBox;
    DirectoryEdit1: TDirectoryEdit;
    Label1: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Panel3: TPanel;
    Panel4: TPanel;
    Button3: TButton;
    Button4: TButton;
    ListBox2: TListBox;
    Label3: TLabel;
    Panel5: TPanel;
    Panel6: TPanel;
    Label4: TLabel;
    LabelDir: TLabel;
    Label2: TLabel;
    LabelArq: TLabel;
    SaveDialog1: TSaveDialog;
    LabelFim: TLabel;
    spedtMax: TSpinEdit;
    spedtMin: TSpinEdit;
    procedure btnCloseClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
  private
    ContinuaLista : Boolean;
    Erros, ArquivoSaida : TStringList;
    Extensao : String;
     { Private declarations }
  public
         { Public declarations }
  end;

var
  frmWordListExtract: TfrmWordListExtract;

implementation
uses htmlutil, apputils;
{$R *.lfm}


procedure TfrmWordListExtract.Button1Click(Sender: TObject);
    procedure ListaDir(Diretorio:String);

      procedure VarreArquivo(Arquivo:String);
      var
       lst : TStringList;
      begin
         try
              lst := TStringList.Create;
              lst.LoadFromFile(Arquivo);
              lst.BeginUpdate;
              if (Extensao = 'HTML') or (Extensao = 'HTM') then  StripHTMLTags( trim (lst.Text) );

              if chkLower.Checked then lst.Text := lowercase( lst.Text);

              if chkRemoveChars.Checked then  RemoveSpecialChar( lst );
              ArquivoSaida.AddStrings(lst);
              lst.EndUpdate;
              lst.Free;

         except
           on E : Exception  do Erros.Add(Arquivo+' '+E.Message+' '+E.ClassName);
           end;
      end;

    var
      SR: TSearchRec;
      Arquivo, sTemp: String;
      nTemp, N : Integer;

    begin
      Arquivo := '';
      FindFirst(Diretorio+'\*.*', faAnyFile, SR);

      while not (Arquivo = SR.Name) and ContinuaLista do begin
          LabelDir.Caption:= Diretorio;
          if (SR.Attr = faDirectory) or (SR.Attr = faDirectory+faHidden) or (SR.Attr = faDirectory+faSysFile) or (SR.Attr = faDirectory+faSysFile+faHidden) then begin
            if (SR.Name <> '.') and (SR.Name <> '..') and ContinuaLista then begin
            // Faz Recursividade em Diretórios

              if ((Sr.Name  <> '.') and (Sr.Name  <> '..') ) then
              try
                sTemp := concat(Diretorio,'\',Sr.Name);
                LabelDir.Caption := sTemp;
                Application.ProcessMessages;
                ListaDir(sTemp);
              except      end;
            end;
          end
          else  begin
            // Pega os Arquivos
            LabelArq.Caption:= Sr.Name;
            Application.ProcessMessages;
            sTemp := concat(Diretorio,'\',Sr.Name);
            nTemp := Length(sTemp);
            Extensao := uppercase(copy(sTemp, nTemp-2,nTemp));
            for n:= 0 to ListBox2.Items.Count -1 do
               if Extensao = ListBox2.Items.Strings[n] then begin
                 VarreArquivo(sTemp);
                 Break;
               end;

         end;
        Arquivo:=SR.Name;
        FindNext(SR);
      end;
    end;
var
   ntemp, n:integer;
   Saida : string;
begin
  if DirectoryEdit1.Text = '' then exit;
  if (SaveDialog1.Execute) then begin
     if SaveDialog1.FileName = '' then exit;
     ArquivoSaida := TStringList.Create;
     ArquivoSaida.BeginUpdate;
     Erros := TStringList.Create;
     btnStart.Visible := False;
     btnClose.Visible := False;
     btnCancel.Visible := True;


     ContinuaLista := True;
     ListaDir(DirectoryEdit1.Text);
     ArquivoSaida.text := StringReplace(ArquivoSaida.text, ' ', #10#13, [rfReplaceAll]);
     ArquivoSaida.text := StringReplace(ArquivoSaida.text, #9, #10#13, [rfReplaceAll]);
     for n := ArquivoSaida.Count-1 downto 0 do begin
        Saida := ArquivoSaida.Strings[n];
        Application.ProcessMessages;
        ntemp := length(Saida);
        if  (Saida = '') or (ntemp > spedtMax.Value) or (ntemp < spedtMin.Value) or ( IsStrANumber(Saida)  ) then ArquivoSaida.Delete(n);
     end;
     ArquivoSaida.Sort();
     ArquivoSaida.EndUpdate;
     RemoveDuplicated(ArquivoSaida);


     ArquivoSaida.SaveToFile(SaveDialog1.FileName);
     Erros.SaveToFile(SaveDialog1.FileName+'.err');
     ArquivoSaida.Destroy;
     Erros.Destroy;
     btnCancel.Visible := False;
     btnStart.Visible := True;
     btnClose.Visible := True;
     LabelFim.Caption := '';
     ShowMessage('Done!');
  end;
end;

procedure TfrmWordListExtract.btnCloseClick(Sender: TObject);
begin
  Close;
end;



procedure TfrmWordListExtract.Button2Click(Sender: TObject);
begin
  LabelFim.Caption := 'Finishing....';
  ContinuaLista := False;
end;


procedure TfrmWordListExtract.Button4Click(Sender: TObject);
 var
  Caminho : String;
begin
  Caminho := '';
  if InputQuery('Add File Extension','ex: DOC',Caminho) then begin
    Caminho := trim(Caminho);
    Caminho := StringReplace(Caminho, '.', '',[]);
    if (Length(Caminho) > 0 ) then
        ListBox2.Items.Add(Uppercase(Caminho));
  end;
end;

procedure TfrmWordListExtract.Button3Click(Sender: TObject);
begin
  if (ListBox2.ItemIndex <> -1) then ListBox2.Items.Delete(ListBox2.ItemIndex);
end;

procedure TfrmWordListExtract.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  CloseAction := caFree;
end;


end.


