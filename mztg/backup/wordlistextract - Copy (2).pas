unit wordlistextract;
{$mode objfpc}{$H+}
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ComCtrls, Spin, Buttons;

{$I invalidchars.inc}

type

  { TfrmWordListExtract }

  TfrmWordListExtract = class(TForm)
    btnStart: TBitBtn;
    btnCancel: TBitBtn;
    btnClose: TBitBtn;
    chkLower: TCheckBox;
    chkRemoveChars: TCheckBox;
    Label5: TLabel;
    Label6: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    ListBox1: TListBox;
    btnDel: TButton;
    btnAdd: TButton;
    Panel3: TPanel;
    Panel4: TPanel;
    Button3: TButton;
    Button4: TButton;
    ListBox2: TListBox;
    Label1: TLabel;
    Label3: TLabel;
    Panel5: TPanel;
    Panel6: TPanel;
    Label4: TLabel;
    LabelDir: TLabel;
    Label2: TLabel;
    LabelArq: TLabel;
    Panel8: TPanel;
    SaveDialog1: TSaveDialog;
    SelectDirectoryDialog1: TSelectDirectoryDialog;
    LabelFim: TLabel;
    Panel7: TPanel;
    Label7: TLabel;
    LabelTotal: TLabel;
    spedtMin: TSpinEdit;
    spedtMax: TSpinEdit;
    Timer1: TTimer;
    procedure btnCloseClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnDelClick(Sender: TObject);
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

{$R *.lfm}


procedure TfrmWordListExtract.Button1Click(Sender: TObject);
    procedure ListaDir(Diretorio:String);


    function StripHTMLTags(const HTML: string): string;
    var
      P: PChar;
      InTag: Boolean;
      hexapos, n, scriptpos, scriptend: Integer;
      strHTML : string;
      sBuffer : array[0..1] of Char;
    begin
      strHTML := HTML;
      Result := '';

      // remove scripts
      while Pos('</script>', strHTML ) > 0 do begin
          scriptpos := Pos('<script', strHTML);
          scriptend := Pos('</script>', strHTML);
          delete(strHTML, scriptpos, scriptend-scriptpos+9);

      end;
      P := PChar(strHTML);



      InTag := False;
      repeat
        case P^ of
          '<': InTag := True;
          '>': begin
                     InTag := False;
                     Result := Result + ' ';
               end;
          #13, #10: ; {do nothing}
          else
            if not InTag then
            begin
              if (P^ in [#9, #32]) and ((P+1)^ in [#10, #13, #32, #9, '<']) then
              else
                Result := Result + P^;
            end;
        end;
        Inc(P);
      until (P^ = #0);

      for n := 1 to 96 do begin
//        Result := StringReplace(Result, Entities[n][3], Entities[n][4],  [rfReplaceAll,rfIgnoreCase]);
        Result := StringReplace(Result, Entities[n][1], Entities[n][4],  [rfReplaceAll,rfIgnoreCase ]);
        Result := StringReplace(Result, Entities[n][2], Entities[n][4],  [rfReplaceAll,rfIgnoreCase]);
      end;
      Result := UTF8Decode(Result );


//      Result := StringReplace(Result, '&#x', '=====',  [rfReplaceAll,rfIgnoreCase ]);

{
      hexapos := Pos('&#x', Result);
      while ( hexapos > 0 ) do begin
          showmessage(Copy(Result, hexapos+3, 2));
          HexToBin( PChar(Copy(Result, hexapos+3, 2) ),sBuffer,2);
          Result[hexapos+1] := sBuffer[1];
          delete(Result,hexapos+2, 5);
          hexapos := Pos('&#x', Result);
      end;
}

//
      showmessage( copy(Result, Pos('&#x', Result), 6 ) );

      //      Result := UTF8Decode(Result );


    end;


      procedure VarreArquivo(Arquivo:String);



         function RemoveCaracter(Palavra:String):String;
           var
           Texto:String;
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


          procedure VarreLinha(Linha:String);
            procedure AdicionaPalavra(Palavra:String);
            var
             N : Integer;
             bNovo : Boolean;
             Saida: String;
            begin
              bNovo := True;
              if chkLower.Checked then
                Saida := lowercase(Palavra)
              else
                Saida := Palavra;
              if (Saida = '') then exit;

              // Apagando caracteres indesejaveis


              if (Saida = '') or (length(Saida) <= spedtMax.Value) then exit;
              for n := 0 to ArquivoSaida.Count-1 do
                if (ArquivoSaida.Strings[n] = Saida) then begin
                  bNovo := False;
                  break;
                end;
              if bNovo then begin
                 ArquivoSaida.Add(Saida);
                 contpalavra := contpalavra+1;
              end;
            end;
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

          end;
      var
       fArquivo: textfile;
       Linha: String;
       lst : TStringList;
      begin
         try
            if (Extensao = 'HTML') or (Extensao = 'HTM') then begin
                lst := TStringList.Create;
                lst.LoadFromFile(Arquivo);
                lst.Text := StripHTMLTags(lst.Text);
                VarreLinha( StripHTMLTags(lst.Text) );

                lst.Free;
            end
            else begin
              AssignFile(fArquivo, Arquivo);
              Reset(fArquivo);
              while not Eof(fArquivo) do begin
                 Readln(fArquivo, Linha);
                 Application.ProcessMessages;
                 if (Linha <> '') then VarreLinha(Linha);
              end;
              CloseFile(fArquivo);
            end;



         except
           on E : Exception  do Erros.Add(Arquivo+' '+E.Message+' '+E.ClassName);
           end;
      end;

    var
      SR: TSearchRec;
      Arquivo, sTemp: String;
      nTemp, N : Integer;

    begin
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

var
 n : integer;
begin
  if (SaveDialog1.Execute) then begin
     contpalavra := 0;
     ArquivoSaida := TStringList.Create;
     Erros := TStringList.Create;
     btnStart.Visible := False;
     btnClose.Visible := False;
     btnCancel.Visible := True;


     ContinuaLista := True;
     for n := 0 to ListBox1.Items.Count-1 do  begin
         ListaDir(ListBox1.Items.Strings[n]);
     end;
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

procedure TfrmWordListExtract.btnAddClick(Sender: TObject);
 var
  Caminho : String;
begin
  if (SelectDirectoryDialog1.Execute )   then ListBox1.Items.Add( SelectDirectoryDialog1.Filename );
end;

procedure TfrmWordListExtract.btnDelClick(Sender: TObject);
begin
  if (ListBox1.ItemIndex <> -1) then ListBox1.Items.Delete(ListBox1.ItemIndex);
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


