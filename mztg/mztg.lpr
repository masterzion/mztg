program mztg;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
    cthreads,
  {$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, main, brute, brutegen, wordlistextract, htmlutil, hybridgen, apputils,
  about, threadattack, heuristic, sanitizer, google, lnetvisual;

{$R *.res}

begin
//  RequireDerivedFormResource := True;
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
