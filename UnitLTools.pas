unit UnitLTools;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  System.ImageList,

  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Media,
  FMX.Controls.Presentation, FMX.Edit, FMX.Layouts, FMX.StdCtrls, FMX.ListBox,
  FMX.Objects, FMX.ImgList, FMX.DateTimeCtrls;

type
  TLTools = class(Tform)

  private
     {}

  public

    procedure FichierDansRepertoireCreate(aRepertoire : string);
    procedure FichierDansRepertoireRead(aRepertoire : string);

  end;

var
  LTools: TLTools;



implementation

uses UnitMain;


procedure TLTools.FichierDansRepertoireCreate(aRepertoire : string);
var
Info: TSearchRec;
nombre : integer ;
begin
  Form7.FQrCodeExistant := False ;
  if FindFirst(aRepertoire + '\*.*', faAnyFile - faDirectory, Info)= 0 then begin
    while FindNext(Info)= 0 do begin
    if Info.Name = Form7.Edit1.Text + '.jpg' then Form7.FQrCodeExistant := True ;
    end;
    FindClose(Info);
  end;
end;

procedure TLTools.FichierDansRepertoireRead(aRepertoire : string);
var
Info: TSearchRec;
nombre : integer ;
begin
  Form7.FQrCodeExistant := False ;
  if FindFirst(aRepertoire + '\*.*', faAnyFile - faDirectory, Info)= 0 then begin
    while FindNext(Info)= 0 do begin
    if Info.Name = Form7.Edit2.Text + '.jpg' then Form7.FQrCodeExistant := True ;
    end;
    FindClose(Info);
  end;
end;


end.
