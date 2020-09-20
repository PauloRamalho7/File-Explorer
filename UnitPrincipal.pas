unit UnitPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects, u99Permissions;

type
  TFrmPrincipal = class(TForm)
    Image1: TImage;
    img_open: TImage;
    procedure img_openClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    procedure TrataPermissao(Sender: TObject);
    procedure TrataPermissaoErro(Sender: TObject);
    { Private declarations }
  public
    { Public declarations }
    permissao : T99Permissions;
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

{$R *.fmx}

uses UnitExplorer;


procedure TFrmPrincipal.TrataPermissao(Sender: TObject);
begin
    FrmExplorer.ShowModal(procedure(ModalResult: TModalResult)
    begin
        if Pos('.jpg', FrmExplorer.arquivo) > 0 then
            Image1.Bitmap.LoadFromFile(FrmExplorer.arquivo);
    end);
end;

procedure TFrmPrincipal.TrataPermissaoErro(Sender: TObject);
begin
    showmessage('Você não possui permissão');
end;

procedure TFrmPrincipal.FormDestroy(Sender: TObject);
begin
    permissao.DisposeOf;
end;

procedure TFrmPrincipal.img_openClick(Sender: TObject);
begin
    permissao := T99Permissions.Create;
    permissao.ReadWriteFiles(TrataPermissao, TrataPermissaoErro);
end;

end.
