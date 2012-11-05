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
    Panel7: TPanel;
    Label7: TLabel;
    LabelTotal: TLabel;
    spedtMax: TSpinEdit;
    spedtMin: TSpinEdit;
    Timer1: TTimer;
    procedure btnCloseClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure Timer1Timer(Sender: TObject);
  private
    ContinuaLista : Boolean;
    contpalavra : Integer;
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
         function RemoveCaracter(Palavra:widestring):widestring;
           var
           Texto:widestring;
           Caracter:char;
           n : integer;
          begin
             Texto := Palavra;
             for n := 0 to length(Caracteres)-1 do begin
                caracter := Caracteres[n];
                Texto := StringReplace(Texto, Caracteres[n+1],  ' ',  [rfReplaceAll]);
             end;
            Result := Texto;
          end;

{
          procedure VarreLinha(Linha:widestring);
          var
            Palavra, sTemp : String;
            nTemp : Integer;
          begin
            sTemp := Linha;
            while (sTemp <> '') do begin
              if Extensao = 'INI' then begin
                nTemp := pos('=',sTemp);
                if (nTemp = 0) then begin
                  Application.ProcessMessages;
                  palavra := sTemp;
                  sTemp := '';
                end
                else begin
                  Palavra := trim(copy(sTemp, 0, nTemp-1));
                  delete(sTemp,1,nTemp);
                end;
              end
              else begin
                nTemp := pos(' ',sTemp);
                if (nTemp = 0) then begin
                  Application.ProcessMessages;
                  palavra := sTemp;
                  sTemp := '';
                end
                else begin
                  Palavra := trim(copy(sTemp, 0, nTemp));
                  delete(sTemp,1,nTemp);
                end;
              end;
              if chkRemoveChars.Checked then Palavra := trim(RemoveCaracter(Palavra));
              if (length(Palavra) >= spedtMin.Value) then
                 AdicionaPalavra(Palavra);
            end;

          end;}

        procedure AdicionaPalavra(Palavra:TStringList);
        var
         n1, n2, ntemp  : Integer;
         bNovo : Boolean;
         Saida: widestring;
        begin


          for n1 := 0 to Palavra.Count-1 do begin
             Saida := Palavra.Strings[n1];
             Application.ProcessMessages;
             ntemp := length(Saida);
             if  (Saida <> '') and (ntemp <= spedtMax.Value)and (ntemp >= spedtMin.Value) and ( not( IsStrANumber(Saida) ) ) then begin
               bNovo := True;
               for n2 := 0 to ArquivoSaida.Count-1 do
                 if (ArquivoSaida.Strings[n2] = Saida) then begin
                   bNovo := False;
                   break;
                 end;
               if bNovo then begin
                  ArquivoSaida.Add(Saida);
                  contpalavra := contpalavra+1;
               end;
             end;
          end;

        end;
      var
       fArquivo: textfile;
       lastword, stemp,  Linha: widestring;
       lst : TStringList;
       ntemp, n : integer;




      begin
         try
              lst := TStringList.Create;
              lst.LoadFromFile(Arquivo);
              if (Extensao = 'HTML') or (Extensao = 'HTM') then  StripHTMLTags( trim (lst.Text) );

              lst.Text := UTF8Decode( stringreplace(lst.Text, ' ' , #10#13, [rfReplaceAll]) );
              if chkLower.Checked then lst.Text := lowercase( lst.Text);

              if chkRemoveChars.Checked then  RemoveSpecialChar( lst );
              AdicionaPalavra( lst );

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
          if (SR.Attr = faDirectory) or (SR.Attr = faDirectory+faHidden) or (SR.Attr = faDirectory+faSysFile) or (SR.Attr = faDirectory+faSysFile+faHidden) then begin
            if (SR.Name <> '.') and (SR.Name <> '..') and ContinuaLista then begin
            // Faz Recursividade em Diretórios

              if ((Sr.Name  <> '.') and (Sr.Name  <> '..') ) then
              try
                sTemp := concat(Diretorio,'\',Sr.Name);
                LabelDir.Caption := sTemp;
                ListaDir(sTemp);
              except      end;
              Application.ProcessMessages;
            end;
          end
          else  begin
            // Pega os Arquivos
            sTemp := concat(Diretorio,'\',Sr.Name);
            LabelArq.Caption := sTemp;
            LabelDir.Caption := Diretorio;
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

begin
  if DirectoryEdit1.Text = '' then exit;
  if (SaveDialog1.Execute) then begin
     contpalavra := 0;
     ArquivoSaida := TStringList.Create;
     Erros := TStringList.Create;
     btnStart.Visible := False;
     btnClose.Visible := False;
     btnCancel.Visible := True;


     ContinuaLista := True;
     ListaDir(DirectoryEdit1.Text);
     ArquivoSaida.Sort();
     RemoveDuplicated(ArquivoSaida);

     ArquivoSaida.SaveToFile(SaveDialog1.FileName);
     Erros.SaveToFile(SaveDialog1.FileName+'.err');
     ArquivoSaida.Destroy;
     Erros.Destroy;
     btnCancel.Visible := False;
     btnStart.Visible := True;
     btnClose.Visible := True;
     LabelFim.Caption := '';
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

procedure TfrmWordListExtract.Timer1Timer(Sender: TObject);
begin
   LabelTotal.Caption := inttostr(contpalavra);
end;

end.


