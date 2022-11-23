unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls,
  sqldb, IBConnection, mysql56conn;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
  private
    function CreateConnection: TMySQL56Connection;
  public

  end;

var
  Form1: TForm1;
var
  AConnection : TMySQL56Connection;
  ATransaction : TSQLTransaction;
  Query        : TSQLQuery;
  sci_name : string;
  comm_name: string;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Edit1Change(Sender: TObject);
begin
 sci_name:=Edit1.Text;
end;

procedure TForm1.Edit2Change(Sender: TObject);
begin
 comm_name:=Edit2.Text;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  if Aconnection.Connected then
  begin
   Query.SQL.Text := 'INSERT INTO birds (scientific_name, common_name) VALUES ("' + sci_name + '","' + comm_name + '")';
   Query.Database := AConnection;
   Query.ExecSQL;
   ATransaction.Commit;
   Label5.Caption:= format('Sikeres feltöltés: %s',[sci_name]);
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  AConnection := CreateConnection;
  AConnection.Open;
  ATransaction := TSQLTransaction.Create(AConnection);
  AConnection.Transaction := ATransaction;


  if Aconnection.Connected then
    begin
    Label4.Caption:= 'Kapcsolódva!';
    Label4.Color:= clLime;
    end
  else
    Label4.Caption:='Sikertelen!';

  Query := TSQLQuery.Create(nil);
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  if Aconnection.Connected then
    begin
      Query.Close;
      AConnection.Close;
      Query.Free;
      ATransaction.Free;
      AConnection.Free;
      Label4.Caption:='Nincs kapcsolódva';
      Label4.Color:= clRed;
    end;
end;

function TForm1.CreateConnection: TMySQL56Connection;
begin
  result := TMySQL56Connection.Create(nil);
  result.Hostname := 'localhost';
  result.DatabaseName := 'rookery';
  result.UserName := 'yourusername';
  result.Password := 'yourpassword';
end;

end.
