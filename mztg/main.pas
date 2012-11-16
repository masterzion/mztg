unit main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ComCtrls,
  ExtCtrls, EditBtn, StdCtrls, Buttons, CheckLst, Spin, Menus, dateutils, INIFiles;

//const appThreadCount = 1;
const AppVersion = 'MZTG 0.04';
type
  { TfrmMain }

  TfrmMain = class(TForm)
    btnGoogle: TBitBtn;
    btnHeuristic: TBitBtn;
    btnAddCustomRule1: TButton;
    btnAddWordList: TButton;
    btnCancel: TBitBtn;
    btnDelCustomRule1: TButton;
    btnNext: TBitBtn;
    btnPrior: TBitBtn;
    btnAbout: TBitBtn;
    btnOk: TBitBtn;
    btnClose: TBitBtn;
    btnRemoveWordList: TButton;
    chkgCaseOptions: TCheckGroup;
    chkgSpecialChar: TCheckGroup;
    chklPwd10: TCheckListBox;
    chklPwd11: TCheckListBox;
    chklPwd12: TCheckListBox;
    chklPwd13: TCheckListBox;
    chklPwd14: TCheckListBox;
    chklPwd15: TCheckListBox;
    chklPwd16: TCheckListBox;
    chklPwd17: TCheckListBox;
    chklPwd18: TCheckListBox;
    chklPwd19: TCheckListBox;
    chklPwd20: TCheckListBox;
    chklPwd21: TCheckListBox;
    chklPwd22: TCheckListBox;
    chklPwd23: TCheckListBox;
    chklPwd4: TCheckListBox;
    chklPwd5: TCheckListBox;
    chklPwd6: TCheckListBox;
    chklPwd7: TCheckListBox;
    chklPwd8: TCheckListBox;
    chklPwd9: TCheckListBox;
    chklPwdCustom: TCheckListBox;
    chklPwdLoginPart: TCheckListBox;
    dteBeginDate: TDateEdit;
    dteEndDate: TDateEdit;
    dtFormat8: TEdit;
    dtFormat6: TEdit;
    dtFormat4: TEdit;
    edtLastText: TEdit;
    edtCustomRule1: TEdit;
    edtLogin1: TEdit;
    edtLogin2: TEdit;
    flWordList: TFileNameEdit;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Image5: TImage;
    Image6: TImage;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    lbItemFiles: TListBox;
    lbSelectedFiles: TListBox;
    lstFolder: TListBox;
    MainMenu1: TMainMenu;
    Memo1: TMemo;
    Memo2: TMemo;
    Memo3: TMemo;
    Memo4: TMemo;
    Memo5: TMemo;
    Memo6: TMemo;
    memoLog: TMemo;
    MenuItem1: TMenuItem;
    MenuItem10: TMenuItem;
    MenuItem11: TMenuItem;
    MenuItem12: TMenuItem;
    MenuItem13: TMenuItem;
    MenuItem14: TMenuItem;
    MenuItem15: TMenuItem;
    MenuItem16: TMenuItem;
    MenuItem17: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    Panel14: TPanel;
    Panel15: TPanel;
    Panel22: TPanel;
    Panel23: TPanel;
    Panel24: TPanel;
    Panel25: TPanel;
    Panel26: TPanel;
    Panel4: TPanel;
    PgPwdType: TPageControl;
    Panel11: TPanel;
    Panel12: TPanel;
    Panel13: TPanel;
    Panel16: TPanel;
    Panel17: TPanel;
    Panel18: TPanel;
    Panel19: TPanel;
    Panel10: TPanel;
    Panel20: TPanel;
    Panel21: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    Panel9: TPanel;
    pgMain: TPageControl;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    pgPwdSize: TPageControl;
    pgPwdWordList: TPageControl;
    PopUpCheckList: TPopupMenu;
    rgOutput: TRadioGroup;
    SaveDialog1: TSaveDialog;
    spedtLowercase: TSpinEdit;
    spedtUppercase: TSpinEdit;
    Splitter1: TSplitter;
    Splitter2: TSplitter;
    tbRefresh: TTrackBar;
    Timer1: TTimer;
    tsUserBased: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TsCustom: TTabSheet;
    tsHybrid: TTabSheet;
    tsCaseOptions: TTabSheet;
    tsPwd10: TTabSheet;
    tsPwd11: TTabSheet;
    tsPwd12: TTabSheet;
    tsPwd13: TTabSheet;
    tsPwd14: TTabSheet;
    tsPwd15: TTabSheet;
    tsPwd16: TTabSheet;
    tsPwd17: TTabSheet;
    tsPwd18: TTabSheet;
    tsPwd19: TTabSheet;
    tsPwd20: TTabSheet;
    tsPwd21: TTabSheet;
    tsPwd22: TTabSheet;
    tsPwd23: TTabSheet;
    tsPwd4: TTabSheet;
    tsPwd5: TTabSheet;
    tsPwd6: TTabSheet;
    tsPwd7: TTabSheet;
    tsPwd8: TTabSheet;
    tsPwd9: TTabSheet;
    tsPwdLoginPart: TTabSheet;
    tsWordList: TTabSheet;
    tsSpecialCharacter: TTabSheet;
    procedure btnGoogleClick(Sender: TObject);
    procedure btnHeuristicClick(Sender: TObject);
    procedure btnAboutClick(Sender: TObject);
    procedure btnAddCustomRule1Click(Sender: TObject);
    procedure btnAddWordListClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure btnDelCustomRule1Click(Sender: TObject);
    procedure btnNextClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure btnPriorClick(Sender: TObject);
    procedure btnRemoveWordListClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure lstFolderClick(Sender: TObject);
    procedure MenuItem11Click(Sender: TObject);
    procedure MenuItem17Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);
    procedure MenuItem6Click(Sender: TObject);
    procedure MenuItem7Click(Sender: TObject);
    procedure MenuItem8Click(Sender: TObject);
    procedure MenuItem9Click(Sender: TObject);
    procedure MenuItemLangClick(Sender: TObject);
    procedure pgMainChange(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
    strPath : string;
    strLang : string;

    procedure WriteLog(s:string);
  end;

var
  frmMain: TfrmMain;
  OutPutAttackFile : TFileStream;

  bPreserveCase,
  bLowerCase,
  bUpperCase,
  bL33t,
  CancelProcess : Boolean;

  iLowerToUpperCase,
  iUpperToLowerCase: Integer;

  // indexed list;
  ListSemiBrute2,
  ListSemiBrute3,
  ListLoginPart,
  LanguageMessages  : TStringList;

  WordListbySize, DateTimebySize : array of TStringList;



implementation
uses brutegen, wordlistextract, hybridgen, about, apputils, heuristic, sanitizer, google;
{$R *.lfm}

{ TfrmMain }

procedure TfrmMain.MenuItemLangClick(Sender: TObject);
var
 INI:TINIFile;
begin
 strLang := ( Sender as TMenuItem).Caption;
 INI := TINIFile.Create(strPath+'mztg.ini', true);
 INI.writeString('config', 'lang', strLang);
 LoadTranslation( strPath+'lang'+PathDelim+strLang+PathDelim , self);
end;




procedure TfrmMain.FormCreate(Sender: TObject);
//const arProperties :array [0..1] of string=('Caption', 'hint', 'Lines');
var
   FindRec: TSearchRec;
//   chkl   : TCheckListBox ;
   INI:TINIFile;
   menuitem :TMenuItem;
 begin
  Randomize();
  Caption := AppVersion;

  strPath := ExtractFilePath(Application.ExeName);
  INI := TINIFile.Create(strPath+'mztg.ini', true);
  strLang := INI.ReadString('config', 'lang', 'eng');
  LoadTranslation( strPath+'lang'+PathDelim+strLang+PathDelim , self);

//  LanguageMessages  := TStringList.Create();
//  LanguageMessages.LoadFromFile( strPath+'lang'+PathDelim+strLang+PathDelim+'messages.txt' );

 if  FindFirst( strPath +  'lang' + PathDelim  +'*', faAnyFile, FindRec) = 0 then
  repeat
    if (FindRec.attr and faDirectory = faDirectory) then
       if (FindRec.Name <> '.') and (FindRec.Name <> '..') then begin
         menuitem := TMenuItem.create(MenuItem16);
         menuitem.Caption:= FindRec.Name;
         menuitem.Bitmap.LoadFromFile(strPath +  'lang' + PathDelim+FindRec.Name+PathDelim+'flag.bmp');
         menuitem.OnClick := @MenuItemLangClick;

         MenuItem16.Add(menuitem);
       end;

  Until FindNext(FindRec)<>0;
  FindClose(FindRec);



  INI.Free;

//    Timer1.OnTimer := Timer1OnTimer(nil);

    pgMain.ActivePage := TsCustom;
    PgPwdType.ActivePage := tsUserBased;
    pgPwdSize.ActivePage := tsPwd4;
    pgPwdWordList.ActivePage := tsPwd14;


{
    for n:= 0 to frmMain.ComponentCount-1 do begin
     if ( frmMain.Components[n] is TCheckListBox ) then begin
       chkl := ( frmMain.Components[n] as TCheckListBox ) ;
       if ( chkl.Tag > -1 ) then
              for n2 := 0 to chkl.Items.Count-1 do
                  chkl.Checked[n2] := true;
     end;
    end;
    }
   chkgSpecialChar.Checked[chkgSpecialChar.Items.Count-1] := false;
   chkgCaseOptions.Checked[0] := false;
   chkgCaseOptions.Checked[1] := true;
   chkgCaseOptions.Checked[2] := true;
   chkgCaseOptions.Checked[3] := true;


   lstFolder.Items.Clear;
   lbItemFiles.Items.Clear;

   // List Word List Forders
   if  FindFirst( strPath +  'classified' + PathDelim  +'*', faAnyFile, FindRec) = 0 then
    repeat
      if (FindRec.attr and faDirectory = faDirectory) then
         if (FindRec.Name <> '.') and (FindRec.Name <> '..') then
                 lstFolder.Items.add(FindRec.Name);
    Until FindNext(FindRec)<>0;
    FindClose(FindRec);

    rgOutput.ItemIndex:= 0;


    dteBeginDate.Date:= StrToDate('01/01/1970', 'd/m/y','/');
    dteEndDate.Date:= StrToDate('01/01/2013', 'd/m/y','/');

    chkgSpecialChar.Checked[0] :=true;
    chkgSpecialChar.Checked[1] :=true;
    chkgSpecialChar.Checked[4] :=true;
    if FileExists(strPath+'custom.txt') then chklPwdCustom.Items.LoadFromFile(strPath+'custom.txt');
end;






procedure TfrmMain.btnCloseClick(Sender: TObject);
begin
     // Close App
     Application.Terminate;
end;

procedure TfrmMain.btnDelCustomRule1Click(Sender: TObject);
begin
 if (chklPwdCustom.ItemIndex > -1 )  then begin
    chklPwdCustom.Items.Delete(chklPwdCustom.ItemIndex );
    chklPwdCustom.Items.SaveTofile(strPath+'custom.txt');
 end;

end;

procedure TfrmMain.btnAddWordListClick(Sender: TObject);
var
   n : integer;
   sTemp : string;
   bExist : Boolean;
begin
  if ( lbItemFiles.ItemIndex > -1 ) and ( lstFolder.ItemIndex > -1 ) then begin
       sTemp := lstFolder.Items[lstFolder.ItemIndex] + PathDelim + lbItemFiles.Items[lbItemFiles.ItemIndex];
       bExist := false;
       for n := 0 to lbSelectedFiles.Count-1 do
          if sTemp = lbSelectedFiles.Items[n] then begin
            bExist := true;
            Break;
          end;
        if not bExist then  lbSelectedFiles.Items.Add( sTemp );
  end;
end;

procedure TfrmMain.btnAddCustomRule1Click(Sender: TObject);
var
   n, LenLine : integer;
   sTag, sResult : string;
   bExist : Boolean;
   SplitList : TStringArray;
    ItemValidation         : THybridValidation;
   LineValidation         : TLineHybridValidation;
begin
   if ( Length(edtCustomRule1.Text) = 0 ) then exit;
   edtCustomRule1.Text := Trim ( LowerCase(edtCustomRule1.Text) );
   SplitList := SplitTag(edtCustomRule1.Text );

   LenLine := length(SplitList);
   if ( LenLine > 0 ) then begin
       SetLength(LineValidation, LenLine);
       for n := 0 to LenLine-1 do begin
         sTag := SplitList[n];
         ItemValidation := CheckTagSyntax( sTag );
         if ItemValidation[0] < 0 then begin
             ShowMessage('Sintax Error!');
             exit;
         end
         else
            if ItemValidation[0] = 7 then
               sResult := sResult+'['+arHybridTypes[ItemValidation[0]]+']'
            else
               sResult := sResult+'['+arHybridTypes[ItemValidation[0]]+inttostr(ItemValidation[1])+']';
       end;
   end;

   bExist := false;
   for n := 0 to chklPwdCustom.Count-1 do
      if sResult = chklPwdCustom.Items[n] then begin
         bExist := true;
         Break;
       end;

   if not bExist then begin
      chklPwdCustom.Items.Add(sResult);
      chklPwdCustom.Checked[chklPwdCustom.Count-1] := true;
      chklPwdCustom.Items.SaveTofile(strPath+'custom.txt');
   end;
end;

procedure TfrmMain.btnAboutClick(Sender: TObject);
begin
  frmAbout :=TfrmAbout.Create(self);
  frmAbout.ShowModal;
  frmAbout.Free;

end;

procedure TfrmMain.btnHeuristicClick(Sender: TObject);
var
INI:TINIFile;
begin
   if flWordList.Text = '' then begin
      ShowMessage('No custom wordlist selected!');
      pgMain.ActivePage := TsCustom;
      flWordList.SetFocus;
   end
   else begin
     frmHeuristic := TfrmHeuristic.Create(self);
     INI := TINIFile.Create(strPath+'mztg.ini', true);
     LoadTranslation( strPath+'lang'+PathDelim+strLang+PathDelim , frmHeuristic);
//       WriteTranslation( strPath+'lang'+PathDelim+INI.ReadString('config', 'lang', 'eng')+PathDelim , frmHeuristic);
     INI.Free;
     frmHeuristic.ShowModal;

   end;


end;

procedure TfrmMain.btnGoogleClick(Sender: TObject);
begin
  frmGoogle := TfrmGoogle.Create(self);
  frmGoogle.ShowModal;
end;


procedure TfrmMain.btnCancelClick(Sender: TObject);
begin
   CancelProcess := True;
end;

procedure TfrmMain.btnRemoveWordListClick(Sender: TObject);
begin
    if (lbSelectedFiles.ItemIndex > -1 )  then lbSelectedFiles.Items.Delete(lbSelectedFiles.ItemIndex );
end;

procedure TfrmMain.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
//  LanguageMessages.Free;
end;

procedure TfrmMain.btnNextClick(Sender: TObject);
begin
     // Next tab
     if ( pgMain.TabIndex < 4 ) then pgMain.TabIndex := pgMain.TabIndex+1;
end;

procedure TfrmMain.WriteLog(s:string);
begin
   memoLog.Lines.Add(s);
//   LanguageMessages.Add(s+'='+s);
//   LanguageMessages.SaveToFile();
   Application.ProcessMessages;
end;

procedure TfrmMain.btnOkClick(Sender: TObject);
var
   HybridAttack : THybridAttack;
   attacks, WordList, WordListTemp : TStringList;
   n, n2, indexerror,
   MinDateLen, MinWordLen, MaxWordLen, MaxDateLen : integer;
   chkl : TCheckListBox ;
   HybridLine     : THybridLine;
   HybridItem     : THybrid;
   stemp, sDirectory : string;
   iMaxWordSize, ntemp, iMinWordSize : integer;
   BeginDate, EndDate : TDateTime;

   bListExists, haveDate, haveWord, haveSemiBrute, haveLoginPart  :Boolean;

begin

  memoLog.Clear;
  edtLastText.Clear;
  iMaxWordSize := 0;
  iMinWordSize := 9999999;

  attacks := TStringList.create();
  writelog('Search Checked itens  Objects...');
  for n:= 0 to frmMain.ComponentCount-1 do begin
     if ( frmMain.Components[n] is TCheckListBox ) then begin
       chkl := ( frmMain.Components[n] as TCheckListBox ) ;
              for n2 := 0 to chkl.Items.Count-1 do
                  if chkl.Checked[n2] then
                     attacks.add( LowerCase(chkl.Items[n2]) );
     end;
  end;

  if attacks.Count = 0 then begin
    ShowMessage('Select some format');
    pgMain.ActivePage := tsHybrid;
    attacks.Free;
    exit;
  end;

  if not SaveDialog1.execute then exit;
  writelog('Start '+datetimetostr(now)+' ...');
  sDirectory := ExtractFilePath(SaveDialog1.FileName);


  btnOk.Visible := False;
  btnCancel.Visible := True;
  Application.ProcessMessages;
  WordListTemp := TStringList.Create;



  for n:= 0 to chklPwdCustom.Items.Count-1  do
    if chklPwdCustom.Checked[n] then
       attacks.add( LowerCase(chklPwdCustom.Items[n]) );

  writelog('Preparing Attack Objects...');
  indexerror := MakeHybridArray(attacks, HybridAttack, iMaxWordSize,  iMinWordSize );
  if indexerror > 0 then begin
     ShowMessage('Sintax error in: '+attacks[indexerror] );
     attacks.free;
  end;
  writelog('Total Objects:' + inttostr( attacks.Count ));

  haveLoginPart := ( pos( arHybridTypes[arAttackTypeLoginPart] ,  ' ['+attacks.Text ) > 0 );
  haveDate      := ( pos( arHybridTypes[arAttackTypeDate]      ,  ' ['+attacks.Text ) > 0 );
  haveWord      := ( pos( arHybridTypes[arAttackTypeWord]      ,  ' ['+attacks.Text ) > 0 );
  haveSemiBrute := ( pos( arHybridTypes[arAttackTypeSemiBrute] ,  ' ['+attacks.Text ) > 0 );



  attacks.free;

  // create datepart
  if  haveLoginPart  then begin
     writelog('Creating LoginPart...');
     ListLoginPart  := TStringList.Create;
     for n:= 1 to Length(edtLogin1.Text) do
        ListLoginPart.add( copy(edtLogin1.Text, 0, n ) );

     for n:= 1 to Length(edtLogin2.Text) do
       ListLoginPart.add( copy(edtLogin2.Text, 0, n ) );


     for n:= 1 to Length(edtLogin1.Text+edtLogin2.Text) do begin
        ListLoginPart.add( copy(edtLogin1.Text+edtLogin2.Text, 0, n ) );
        ListLoginPart.add( copy(edtLogin2.Text+edtLogin1.Text, 0, n ) );
     end;
     Application.ProcessMessages;
  end;


  // create dates
  if haveDate then begin
  	writelog('Creating date arrays ...');
        MinDateLen := 9999;
        MaxDateLen := 0;

        BeginDate := dteBeginDate.Date;
        EndDate := dteEndDate.Date+1;

        WordListTemp.Text := '';
        ntemp := 0;
  	while  ( BeginDate <> EndDate ) do begin
               if CancelProcess then Break;

               if ntemp > 10000 then begin
                  ntemp := 0;
                  Application.ProcessMessages();
               end;
               ntemp +=1;
               if dtFormat8.Text <> '' then  WordListTemp.Add( FormatDateTime(dtFormat8.Text,BeginDate) );
               if dtFormat6.Text <> '' then  WordListTemp.Add( FormatDateTime(dtFormat6.Text,BeginDate) );
               if dtFormat4.Text <> '' then  WordListTemp.Add( FormatDateTime(dtFormat4.Text,BeginDate) );
               BeginDate := IncDay(BeginDate);
  	end;

//       writelog('Sorting dates...');
//       WordListTemp.Sort();
//  	  WordListTemp.CustomSort( @MyListCompare );
       sTemp := '';
       ntemp := 0;
       if (WordListTemp.Count > 0 ) and ( not CancelProcess ) then begin
             // Get Max and min size of
             for n :=  WordListTemp.Count-1 downto 0 do begin

                if ntemp > 10000 then begin
                   ntemp := 0;
                   Application.ProcessMessages();
                end;
                ntemp +=1;
                WordListTemp.Strings[n] := trim(WordListTemp.Strings[n]);
                nTemp := Length(WordListTemp.Strings[n]);
                if nTemp = 0 then begin
                  WordListTemp.Delete(n);
                end
                else begin
                  if sTemp = WordListTemp.Strings[n] then
                      WordListTemp.Delete(n)
                  else begin
                     sTemp := WordListTemp.Strings[n];
                     if nTemp < MinDateLen  then MinDateLen := nTemp;
                     if nTemp > MaxDateLen  then MaxDateLen := nTemp;
                  end;
                end;
             end;

  	     writelog('Removing duplicated dates...');
             WordListTemp.Sort();
             RemoveDuplicated(WordListTemp);
   	     WordListTemp.savetofile(sDirectory+'date.txt');

  	     SetLength(DateTimebySize, MaxDateLen+1 );
  	     for n := 0 to MaxDateLen do DateTimebySize[n] := TStringList.Create();

  	     for n := 0 to WordListTemp.Count-1 do begin
                  if CancelProcess then Break;
  		  stemp := WordListTemp.Strings[n];
  		  ntemp := Length( stemp );
  		  DateTimebySize[  ntemp  ].Add( stemp );
  	     end;
       end;
  end;
  if haveSemiBrute and ( not CancelProcess ) then begin
    writelog('Loading Semibrute2 ...');
    ListSemiBrute2 := TStringList.Create;
    ListSemiBrute2.LoadFromFile(strPath + 'preindexed'+ PathDelim  + 'semibrute2.txt');

    writelog('Loading Semibrute3 ...');
    ListSemiBrute3 := TStringList.Create;
    ListSemiBrute3.LoadFromFile(strPath + 'preindexed'+ PathDelim  + 'semibrute3.txt');
  end;

  //  sort by size
  if haveWord and ( not CancelProcess )  then begin

    	  WordList := TStringList.Create;

    	  // load default WordList
    	  if Length(flWordList.Text) > 0 then begin
    		 if FileExists(flWordList.Text) then
    			WordList.LoadFromFile(flWordList.Text);
          end
          else
              WordList.Text := '';

    	  // load selected WordList
    	  for n:= 0 to lbSelectedFiles.Items.Count-1 do begin
                 writelog('Loading ' +lbSelectedFiles.items[n] + ' ...');
    		 WordListTemp.LoadFromFile( strPath+  'classified' + PathDelim  +lbSelectedFiles.items[n] );
    		 WordList.AddStrings(WordListTemp);
                 writelog( IntToStr( WordListTemp.Count ) + ' words added.' );
    	  end;

    	  writelog('Total: ' +IntToStr( WordList.Count ) + ' Words ...');

    	  writelog('Word Sizes used : ' + IntToStr( iMinWordSize ) + ' - ' +IntToStr( iMaxWordSize ) + ' Words ...');

          MinWordLen := 99999;
          MaxWordLen := 0;
    	  //create wordlist array by size
    	  if WordList.Count > 0 then begin
         	 // Get Max and min size of
                WordList.BeginUpdate;

                writelog('Sorting words ...');
                WordList.BeginUpdate;
         	WordList.Sort;
                WordList.EndUpdate;

                Application.ProcessMessages;
         	writelog('Removing duplicated lines ...');
                RemoveDuplicated(WordList);

         	writelog('Total now: ' +IntToStr( WordList.Count ) + ' Words ...');
         	WordList.savetofile(sDirectory+'wordlist.txt');
         	writelog('Temp Wordlist Saved...');

                writelog('Populating...');
     	        ntemp := 0;
                SetLength(WordListbySize, iMaxWordSize+1);

         	for n := iMinWordSize to iMaxWordSize do begin
                    WordListbySize[ n  ] := TStringList.Create();
                    WordListbySize[ n  ].BeginUpdate;
                end;


                for n :=  WordList.Count-1 downto 0 do begin
                  WordList.Strings[n] := trim(WordList.Strings[n]);
                  stemp := WordList.Strings[n];
                  nTemp := Length(stemp);
                  if ntemp > 10000 then begin
                       ntemp := 0;
                       Application.ProcessMessages();
                  end;

                  if ( nTemp > iMaxWordSize ) or (nTemp < iMinWordSize) then begin
                    WordList.Delete(n);
                  end
                  else begin
                    if nTemp < MinWordLen  then  MinWordLen := nTemp;
                    if nTemp > MaxWordLen  then MaxWordLen := nTemp;
                    WordListbySize[  nTemp  ].Add(stemp);
                  end;
                end;
                WordList.EndUpdate;



         	for n := iMinWordSize to iMaxWordSize do  WordListbySize[ n ].EndUpdate;



                {
                if WordList.Count > 0 then begin
                  stemp :=  WordList.Strings[0];
         	  MinWordLen := Length( stemp);
         	  MaxWordLen := Length( WordList.Strings[WordList.Count-1] )+1;


                  ntemp := iMaxWordSize;
                  if MaxWordLen > ntemp then ntemp := MaxWordLen;

                  SetLength(WordListbySize, ntemp+1 );

           	  for n := 1 to ntemp do begin
                           writelog('Creating Arrays ['+inttostr(n)+'] ...' );
                           WordListbySize[n] := TStringList.Create();
                  end;

                end;}
    	  end;
          Application.ProcessMessages();
    	  WordListTemp.Free;
  end;
//  if nThreadCount > 0  then sleep(1000);
  Application.ProcessMessages();
  writelog('Creating file ...');
  OutPutAttackFile:= TFileStream.Create( SaveDialog1.FileName,  fmCreate or fmOpenWrite or fmShareDenyWrite);
  Application.ProcessMessages();
  CancelProcess := False;



  bPreserveCase := chkgCaseOptions.Checked[0];
  bLowerCase    := chkgCaseOptions.Checked[1];
  bUpperCase    := chkgCaseOptions.Checked[2];
  bL33t         := False;
  bL33t         := chkgCaseOptions.Checked[3];

  iLowerToUpperCase :=  spedtUppercase.Value;
  iUpperToLowerCase :=  spedtLowercase.Value;


  n := 1;
  for HybridLine in  HybridAttack do begin
    ntemp := 0;
    stemp := '';
    bListExists :=True;
    if CancelProcess then Break;
    //  SizeOf( HybridLine ) have bug
    for HybridItem in  HybridLine do begin
       ntemp += 1;
       stemp += '['+arHybridTypes[HybridItem.HybridType]+inttostr(HybridItem.Size)+ ']';

       if HybridItem.HybridType = arAttackTypeDate then
             if ( HybridItem.Size < MinDateLen ) or  ( HybridItem.Size > MaxDateLen ) then bListExists :=False;

       if (HybridItem.HybridType <> 7 ) and  (HybridItem.Size = 0)  then bListExists :=False;

       if bListExists and ( HybridItem.HybridType = arAttackTypeWord )  then begin
          if ( HybridItem.Size < MinWordLen ) or  ( HybridItem.Size > MaxWordLen ) then bListExists :=False;


          if WordList.Count = 0 then
             bListExists :=False
          else
             if SizeOf(WordListbySize) = 0 then
               bListExists :=False
             else
                if HybridItem.Size  > MaxWordLen then
                    bListExists :=False
                else
                    if WordListbySize[  HybridItem.Size  ].Count = 0  then
                       bListExists :=False;
       end;

       if bListExists = false then Break;
    end;



    if bListExists then begin
        writelog('Generating attack '+stemp+' ...');
        WriteAttack('', HybridLine, 0 , ntemp-1, '' );
    end
    else begin
      writelog('No Word/Date  for '+stemp+' ...');
    end;

    Application.ProcessMessages();
    n +=1;
  end;

  writelog('Closing file ...');
  OutPutAttackFile.Free;
  WordList.Free;

  writelog('Closing Hybrid Arrays ...');
  for HybridLine in  HybridAttack do
    for HybridItem in  HybridLine do
       HybridItem.Free;


  if haveLoginPart then begin
     writelog('Closing LoginPart ...');
     ListLoginPart.Free;
  end;

  if haveSemiBrute then begin
     writelog('Closing SemiBrute2 ...');
     ListSemiBrute2.Free;

     writelog('Closing SemiBrute3 ...');
     ListSemiBrute3.Free;
  end;



  if haveDate then begin
     writelog('Closing Date Arrays ...');
     for WordListTemp in  DateTimebySize do WordListTemp.Free;
  end;

  if haveWord then begin
     writelog('Closing Wordlist Arrays ...');
     for WordListTemp in  WordListbySize do WordListTemp.Free;
  end;
  writelog('End '+datetimetostr(now)+' ...');
  writelog('Done! :)');
  writelog('');
  writelog('');
  btnOk.Visible := True;
  btnCancel.Visible := False;

end;


procedure TfrmMain.btnPriorClick(Sender: TObject);
begin
     // Prior Tab
     if ( pgMain.TabIndex > 0 ) then pgMain.TabIndex := pgMain.TabIndex-1;
end;





procedure TfrmMain.lstFolderClick(Sender: TObject);
var
   FindRec: TSearchRec;
   folder :string;
begin
     // List files on folder click
     if ( lstFolder.ItemIndex > -1 ) then begin
        lbItemFiles.Clear;
        folder := lstFolder.Items[ lstFolder.ItemIndex ];
       if  FindFirst( strPath +  'classified' + PathDelim + folder + PathDelim  +'*', faAnyFile, FindRec) = 0 then
        repeat
          if (FindRec.attr and faArchive = faArchive) then
             if (FindRec.Name <> '.') and (FindRec.Name <> '..') then lbItemFiles.Items.add(FindRec.Name);
        Until FindNext(FindRec)<>0;
        FindClose(FindRec);
     end;
end;



procedure TfrmMain.MenuItem11Click(Sender: TObject);
begin
  frmAbout := TfrmAbout.Create(self);
  frmAbout.ShowModal;
end;

procedure TfrmMain.MenuItem17Click(Sender: TObject);
begin
  frmSanitizer := TfrmSanitizer.Create(self);
  frmSanitizer.ShowModal();

end;





procedure TfrmMain.MenuItem2Click(Sender: TObject);
begin
  if (btnClose.Enabled) then btnClose.Click;
end;

procedure TfrmMain.MenuItem4Click(Sender: TObject);
begin
  btnGoogle.Click;
end;


procedure TfrmMain.MenuItem5Click(Sender: TObject);
var
INI:TINIFile;
begin
  frmWordListExtract := TfrmWordListExtract.Create(self);
  INI := TINIFile.Create(strPath+'mztg.ini', true);
  LoadTranslation( strPath+'lang'+PathDelim+strLang+PathDelim , frmWordListExtract);
  INI.Free;
//  LanguageMessages.LoadFromFile( strPath+'lang'+PathDelim+strLang+PathDelim+'messages.txt' );
  frmWordListExtract.ShowModal;
end;

procedure TfrmMain.MenuItem6Click(Sender: TObject);
var
INI:TINIFile;
begin
  frmBruteGen := TfrmBruteGen.Create(self);
  INI := TINIFile.Create(strPath+'mztg.ini', true);
  LoadTranslation( strPath+'lang'+PathDelim+strLang+PathDelim , frmBruteGen);
  //WriteTranslation( strPath+'lang'+PathDelim+INI.ReadString('config', 'lang', 'eng')+PathDelim , frmBruteGen);
  INI.Free;

  frmBruteGen.ShowModal;
end;

procedure TfrmMain.MenuItem7Click(Sender: TObject);
var
  chkl : TCheckListBox ;
  n : integer;
begin
  if ( Sender is TCheckListBox ) then begin
     chkl := ( Sender as TCheckListBox ) ;
     for n := 0 to chkl.Items.Count-1 do chkl.Checked[n] := true;
  end;
end;

procedure TfrmMain.MenuItem8Click(Sender: TObject);
var
  chkl : TCheckListBox ;
  n : integer;
begin
  //ShowMessage( Sender.name   );
  if ( Sender is TCheckListBox ) then begin
     chkl := ( Sender as TCheckListBox ) ;
     for n := 0 to chkl.Items.Count-1 do chkl.Checked[n] := False;
  end;
end;

procedure TfrmMain.MenuItem9Click(Sender: TObject);
var
  chkl : TCheckListBox ;
  n : integer;
begin
  if ( Sender is TCheckListBox ) then begin
     chkl := ( Sender as TCheckListBox ) ;
     for n := 0 to chkl.Items.Count-1 do chkl.Checked[n] := not chkl.Checked[n];
  end;
end;

procedure TfrmMain.pgMainChange(Sender: TObject);
begin
    //Enable Ok Button in last tab
     btnOk.Enabled:= ( pgMain.TabIndex = 4 );
end;



end.

