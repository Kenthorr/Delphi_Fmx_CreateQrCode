unit UnitMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.Edit, FMX.ScrollBox, FMX.Memo,
  System.IOUtils, FMX.Platform, FMX.VirtualKeyboard,
  FMX.Objects, FMX.StdCtrls, System.Net.URLClient,
  System.Net.HttpClient, System.Net.HttpClientComponent, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient, IdHTTP, FMX.Layouts;

type
  TForm7 = class(TForm)
    Edit1: TEdit;
    Image1: TImage;
    NetHTTPClient1: TNetHTTPClient;
    Label1: TLabel;
    Edit2: TEdit;
    Label2: TLabel;
    Rectangle1: TRectangle;
    Layout1: TLayout;
    Layout2: TLayout;
    Rectangle2: TRectangle;
    Image2: TImage;
    Label3: TLabel;
    procedure Edit2KeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure Edit1KeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }

    FListProduit : Tstringlist ;
    FQrCodeExistant : boolean ;

  end;

var
  Form7: TForm7;

implementation

{$R *.fmx}

uses UnitLTools;


{------------------------------------------------------------------------------}
 /////////////////////////////////////////////////////////// Create QRcode ////
{------------------------------------------------------------------------------}


procedure TForm7.Edit1KeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
var
  MS: TMemoryStream;
  JPEG: TImage;
  Url: String;
  cNombreImage : integer      ;

  I: Integer;
begin
 if Key = 13 then begin

   {If you want the application to work on android, adapt the path to the folders}
   if not DirectoryExists(GetEnvironmentVariable('USERPROFILE') + '\Documents\CodeBar') then
     CreateDir(GetEnvironmentVariable('USERPROFILE') + '\Documents\CodeBar') ;

   if not DirectoryExists(GetEnvironmentVariable('USERPROFILE') + '\Documents\CodeBar') then begin
     ShowMessage('Impossible de créer' + GetEnvironmentVariable('USERPROFILE') + '\Documents\CodeBar');
     Exit ;
   end;

   LTools.FichierDansRepertoireCreate(GetEnvironmentVariable('USERPROFILE') + '\Documents\CodeBar') ;

   if FQrCodeExistant then begin
    ShowMessage('QrCode Existant !');
    Exit ;
   end;

   MS := TMemoryStream.Create;
   try

     for I := 7400 to 7500 do
     begin

       Url := 'http://chart.apis.google.com/chart?chs=180x180&choe=UTF-8&cht=qr&chl=' + Edit1.Text ;
       MS.Clear;
       try
         NetHTTPClient1.Get(Url, MS);
       except
         on E: EIdHTTPProtocolException do
           Continue;
       end;
       MS.Position := 0;
       ms.SaveToFile(GetEnvironmentVariable('USERPROFILE') + '\Documents\CodeBar\' + Edit1.Text + '.jpg');
       Image1.Bitmap.LoadFromFile(GetEnvironmentVariable('USERPROFILE') + '\Documents\CodeBar\' + Edit1.Text + '.jpg');
     end;

   finally
     MS.Free;
   end;

 end;
end;



{------------------------------------------------------------------------------}
 ///////////////////////////////////////////////////////////// Read QRcode ////
{------------------------------------------------------------------------------}


procedure TForm7.Edit2KeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = 13 then begin

    if not DirectoryExists(GetEnvironmentVariable('USERPROFILE') + '\Documents\CodeBar') then
     CreateDir(GetEnvironmentVariable('USERPROFILE') + '\Documents\CodeBar') ;

    if not DirectoryExists(GetEnvironmentVariable('USERPROFILE') + '\Documents\CodeBar') then begin
      ShowMessage('Impossible de créer' + GetEnvironmentVariable('USERPROFILE') + '\Documents\CodeBar');
      Exit ;
    end;

    LTools.FichierDansRepertoireRead(GetEnvironmentVariable('USERPROFILE') + '\Documents\CodeBar') ;

    if FQrCodeExistant then begin
     Image2.Bitmap.LoadFromFile(GetEnvironmentVariable('USERPROFILE') + '\Documents\CodeBar\' + Edit2.Text + '.jpg');
    end
    else
    begin
      ShowMessage('QrCode Introuvable ou inexistant !');
    end;
  end;
end;


end.
