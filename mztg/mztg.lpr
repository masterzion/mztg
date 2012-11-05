program mztg;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
    cthreads,
  {$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, main, brute, brutegen, wordlistextract, htmlutil, hybridgen, apputils,
  about, threadattack, heuristic;

{$R *.res}

begin
//  RequireDerivedFormResource := True;
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmBruteGen, frmBruteGen);
  Application.CreateForm(TfrmWordListExtract, frmWordListExtract);
  Application.CreateForm(TfrmAbout, frmAbout);
  Application.CreateForm(TfrmHeuristic, frmHeuristic);
  Application.Run;
end.
