unit google;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Buttons, ComCtrls, lNetComponents, lhttp,   lhttpUtil, LCLType, htmlutil, lNet;

type

  { TfrmGoogle }

  TfrmGoogle = class(TForm)
    btnGoogle: TBitBtn;
    edtSearch: TEdit;
    Label1: TLabel;
    ProgressBar1: TProgressBar;
    SaveDialog1: TSaveDialog;
    procedure btnGoogleClick(Sender: TObject);
    procedure edtSearchKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { private declarations }
    strstream :  TStringList;
    bDownloadingGoogle : Boolean;

    procedure PrepareLinks;

    function  HTTPClientInput(ASocket: TLHTTPClientSocket; ABuffer: pchar; ASize: integer): integer;
    procedure HTTPClientDoneInput(ASocket: TLHTTPClientSocket);


    procedure HTTPClientError(const msg: string; aSocket: TLSocket);

  public
    { public declarations }
    ListOutput : TStringList;
    ThreadCount : Integer;
    procedure SanitizeOutput;
  end;

var
  frmGoogle: TfrmGoogle;

implementation
uses main, sanitizer, apputils;

{ TfrmGoogle }

procedure TfrmGoogle.btnGoogleClick(Sender: TObject);
var
  stemp, sHost, sURI: string;
  nPort: Word;
  n, ntemp : Integer;
  HTTPClient : TLHTTPClientComponent;
begin
  if (edtSearch.Text = '') then exit;
  if not SaveDialog1.Execute then exit;
  if (SaveDialog1.FileName = '') then exit;

  edtSearch.Text := trim(edtSearch.Text);
  ProgressBar1.Max:= 10;
  strstream:=  TStringList.Create();
  strstream.BeginUpdate;
  btnGoogle.Enabled := False;
  edtSearch.Enabled := False;

  frmMain.WriteLog('Searching in google...');

  bDownloadingGoogle := true;

  // lock the connection :(
  stemp := edtSearch.Text + ' -twitter -tut.fi  -multiply -zura -groups.yahoo.com -sonico ';

  stemp := 'http://www.l.google.com/search?q=' +   stringReplace(stemp, ' ','+',[rfReplaceAll])  +'&num=100&hl=en&lr=&start=0&sa=N&filter=0';
  HTTPClient := TLHTTPClientComponent.Create(self);
  DecomposeURL(stemp, sHost, sURI, nPort);
  HTTPClient.Host := sHost;
  HTTPClient.URI  := sURI;
  HTTPClient.Port := nPort;
  HTTPClient.Timeout := 5;
  HTTPClient.OnInput     :=  @HTTPClientInput;
  HTTPClient.OnDoneInput :=  @HTTPClientDoneInput;
  ThreadCount := 1;
  HTTPClient.SendRequest;

  while ThreadCount > 0 do begin
        Sleep(50);
        Application.ProcessMessages;
  end;




  PrepareLinks;

  strstream.Sort;
  RemoveDuplicated(strstream);
  frmMain.WriteLog('Downloading '+inttostr(strstream.Count)+' URLs... ');

  ntemp := 1;
  for n := 0 to ( (strstream.Count-1) div 4 ) do begin
    ntemp += 2 ;
    strstream.Move(ntemp, ntemp+( (strstream.Count-1) div 4 ) );
  end;

  for n := 0 to strstream.Count-1 do strstream.Move(n, Random(strstream.Count-1));

  ProgressBar1.Max:= 10;
  ListOutput :=  TStringList.Create();
  ListOutput.BeginUpdate;


  ProgressBar1.Max:= strstream.Count-1;
  bDownloadingGoogle := false;
  ThreadCount := 0;
  for n := 0 to strstream.Count-1 do begin
       stemp := strstream.Strings[n];
       if (stemp <> '') then begin

          while ThreadCount > 10 do begin
               sleep(500);
               Application.ProcessMessages;
          end;

          frmMain.WriteLog('('+inttostr(n)+') Downloading: '+stemp + '['+ inttostr(frmGoogle.ThreadCount)+']');
          ThreadCount +=1;
          ProgressBar1.Position := n;


          HTTPClient := TLHTTPClientComponent.Create(self);
          DecomposeURL(stemp, sHost, sURI, nPort);

          HTTPClient.Host := sHost;
          HTTPClient.URI  := sURI;
          HTTPClient.Port := nPort;
          HTTPClient.Timeout:= 5;
          HTTPClient.OnInput     :=  @HTTPClientInput;
          HTTPClient.OnDoneInput :=  @HTTPClientDoneInput;
          HTTPClient.OnError     :=  @HTTPClientError;
          HTTPClient.SendRequest;
      end;
    end;
   SanitizeOutput;
end;


procedure TfrmGoogle.edtSearchKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    if Key = LCLType.VK_RETURN  then btnGoogle.Click;
end;



procedure TfrmGoogle.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  CloseAction := caFree;
end;

procedure TfrmGoogle.FormCreate(Sender: TObject);
begin
  //
end;



procedure TfrmGoogle.PrepareLinks;
const
     beforeurl : string = '<a href="/url?q=';
     afterurl : string  = '&amp;sa=U&amp;ei=';

var
  nPos, n: Integer;
  stemp : String;

begin
     frmMain.WriteLog('Preparing...');

     strstream.Text := StringReplace(strstream.Text, '<', LineEnding+'<' , [rfReplaceAll] );
     ProgressBar1.Max := strstream.Count;
     ProgressBar1.Position:= strstream.Count-1;

     frmMain.WriteLog('Filtering URLs...');
     for n := strstream.Count-1 downto 0 do begin
       ProgressBar1.Position:= n ;
       stemp := strstream.Strings[n];
       if (pos( beforeurl, stemp ) > 0) then begin
           stemp := StringReplace( stemp, beforeurl, '' ,[rfReplaceAll] );
           stemp := Copy(stemp,  0, pos( afterurl , stemp )-1 );
           strstream.Strings[n] := stemp;
      end
      else begin
           strstream.Delete(n);
      end;
  end;

end;



procedure TfrmGoogle.SanitizeOutput;
begin
  frmMain.WriteLog('Extracting words (Please Wait)...');

  ListOutput.Text := StripHTMLTags(ListOutput.Text);
  RemoveSpecialChar(ListOutput);

//  ListOutput.SaveToFile('C:\master\ceh\wordlist.txt');
  strstream.SaveToFile(SaveDialog1.FileName+'_urls.txt');
  strstream.Free;

//  strstream.SaveToFile('C:\master\ceh\urls.txt');
  ListOutput.SaveToFile(SaveDialog1.FileName);
  frmMain.flWordList.Text:= SaveDialog1.FileName;

  frmSanitizer := TfrmSanitizer.Create(frmMain);
  frmSanitizer.Memo1.Lines.loadFromFile(SaveDialog1.FileName);
  frmSanitizer.speditMin.Value := 6;
  frmSanitizer.speditMax.Value := 10;
  frmSanitizer.sFileName := SaveDialog1.FileName;
  frmSanitizer.ShowModal;

  ListOutput.Free;
  btnGoogle.Enabled := True;
  edtSearch.Enabled := True;

  Close;
end;


procedure TfrmGoogle.HTTPClientDoneInput(ASocket: TLHTTPClientSocket);
begin
  ThreadCount -=1 ;
  if ( bDownloadingGoogle ) then ProgressBar1.Position:= ThreadCount;
  ASocket.Disconnect();
end;

function TfrmGoogle.HTTPClientInput(ASocket: TLHTTPClientSocket;
  ABuffer: pchar; ASize: integer): integer;
begin
  if bDownloadingGoogle then
     strstream.Append(String(ABuffer))
  else
     ListOutput.Append( String(ABuffer) );

  Result := ASize;
end;

procedure TfrmGoogle.HTTPClientError(const msg: string; aSocket: TLSocket);
begin
  ThreadCount -=1 ;
end;


{$R *.lfm}

end.
