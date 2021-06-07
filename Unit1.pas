unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ComCtrls;

type

    TVector = record
      x,y,z:Integer;
    end;

  TForm1 = class(TForm)
    tmr1: TTimer;
    lbl1: TLabel;
    Timer1: TTimer;
    procedure Timer1Timer(Sender: TObject);
    procedure tmr1Timer(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ResetCanv();
    procedure Triangle(x1,y1,x2,y2,x3,y3:Integer; col:TColor);
    procedure Triangle3D(x1,y1,z1,x2,y2,z2,x3,y3,z3,x4,y4,z4:Integer; col:TColor);
    function  RotateX(x0,y0,x1,y1:integer;fi:Real):integer;
    function  RotateY(x0,y0,x1,y1:integer;fi:Real):integer;
    procedure draw1();
    procedure Line3D(v1,v2:TVector; col:TColor);
    function  Rotate3D(v1:TVector;fi:Real;asix:string):TVector;
    procedure Cube3d(v1,v2,v3,v4,v5,v6,v7,v8:TVector;col:TColor);
    function interp(val1,val2,i:Real):Real;
    function vInterp(v1,v2:TVector;i:Real):TVector;
  private
    { Private declarations }
    Rect: TRect;
    DefaultCol:TColor;
    points: Array [1..3] of TPoint;
    b:Boolean;
    fi,f,totalTime:Real;




  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  Rect.Left:=0;
  Rect.Top:=0;
  Rect.Right:=Form1.Width;
  Rect.Bottom:=Form1.Height;
  DefaultCol:=RGB(240,240,240);
   points[1].X:=10; points[1].Y:=10;
   points[2].X:=30; points[2].Y:=70;
   points[3].X:=80; points[3].Y:=40;
end;



procedure TForm1.FormPaint(Sender: TObject);
begin
  with Form1.Canvas do
  begin
    Pen.Color:=clRed;
    Triangle(10,10,30,70,80,40,clBlack);
    Triangle(Round(10*Sin(90)-(10*Cos(90))),10,30,70,80,40,clBlue);
  end;
  //ResetCanv;
end;

procedure TForm1.ResetCanv();
begin
  Form1.Canvas.Brush.Color:=DefaultCol;
  Canvas.FillRect(Rect);
end;

procedure TForm1.tmr1Timer(Sender: TObject);
var
 x0,y0,z0:integer;
 x1,x2,x3,x4,y1,y2,y3,y4:integer;
 v1,v2,v3,v4,v5,v6,v7,v8:TVector;
begin
  x0:=190;
  y0:=140;
  z0:=120;
  ResetCanv;
  x1:=130; y1:=130;
  x2:=150; y2:=180;
  x3:=190; y3:=140;
  x4:=170; y4:=150;

  // Вращение вокруг оси по координатам X0,Y0
  // X = x0 + (x - x0) * cos(fi) - (y - y0) * sin(fi);
  // Y = y0 + (y - y0) * cos(fi) + (x - x0) * sin(fi);

  v1.x:=x1; v1.y:=y1; v1.z:=0;
  v2.x:=x2; v2.y:=y2; v2.z:=5;
  v1:=Rotate3D(v1,fi,'x');
  v2:=Rotate3D(v2,fi,'x');
  //Line3D(v1,v2,clGreen);


  v1.x:=100; v1.y:=100; v1.z:=0;
  v2.x:=100; v2.y:=200; v2.z:=0;
  v3.x:=200; v3.y:=200; v3.z:=0;
  v4.x:=200; v4.y:=100; v4.z:=0;
  v5.x:=140; v5.y:=140; v5.z:=40;
  v6.x:=140; v6.y:=240; v6.z:=40;
  v7.x:=240; v7.y:=240; v7.z:=40;
  v8.x:=240; v8.y:=140; v8.z:=40;
  {v1:=Rotate3D(v1,fi,'y');
  v2:=Rotate3D(v2,fi,'y');
  v3:=Rotate3D(v3,fi,'y');
  v4:=Rotate3D(v4,fi,'y');
  v5:=Rotate3D(v5,fi,'y');
  v6:=Rotate3D(v6,fi,'y');
  v7:=Rotate3D(v7,fi,'y');
  v8:=Rotate3D(v8,fi,'y');
  v1:=Rotate3D(v1,fi,'x');
  v2:=Rotate3D(v2,fi,'x');
  v3:=Rotate3D(v3,fi,'x');
  v4:=Rotate3D(v4,fi,'x');
  v5:=Rotate3D(v5,fi,'x');
  v6:=Rotate3D(v6,fi,'x');
  v7:=Rotate3D(v7,fi,'x');
  v8:=Rotate3D(v8,fi,'x');
  v1:=Rotate3D(v1,fi,'z');
  v2:=Rotate3D(v2,fi,'z');
  v3:=Rotate3D(v3,fi,'z');
  v4:=Rotate3D(v4,fi,'z');
  v5:=Rotate3D(v5,fi,'z');
  v6:=Rotate3D(v6,fi,'z');
  v7:=Rotate3D(v7,fi,'z');
  v8:=Rotate3D(v8,fi,'z');   }

  if b then
    f:=f-0.03
  else
    f:=f+0.03;

  if (f>1) or (f<0) then
  b:=not b;



  Cube3d(v1,v2,v3,v4,v5,v6,v7,v8,
  RGB(Round(interp(0,254,f)),
      Round(interp(0,222,f)),
      Round(interp(0,44,f))));

  //Triangle(v1.x,v1.y,v2.x,v2.y,x3,y3,clTeal);
  fi:=fi+pi/360+0.01;
   //lbl1.Caption:=FloatToStr(fi);
   lbl1.Caption:=FloatToStr(f);
end;

procedure TForm1.triangle(x1,y1,x2,y2,x3,y3:Integer; col:TColor);
var
  colTemp:TColor;
begin
  with Form1.Canvas do
  begin
    colTemp:=Pen.Color;
    Pen.Color:=col;
    MoveTo(x1,y1);
    LineTo(x2,y2);
    LineTo(x3,y3);
    LineTo(x1,y1);
    Pen.Color:=colTemp;
  end;
end;

procedure TForm1.triangle3D(x1,y1,z1,x2,y2,z2,x3,y3,z3,x4,y4,z4:Integer; col:TColor);
var
  colTemp:TColor;
begin
  with Form1.Canvas do
  begin
    colTemp:=Pen.Color;
    Pen.Color:=col;
    MoveTo(x1,y1);
    LineTo(x2,y2);
    LineTo(x3,y3);
    LineTo(x1,y1);
    LineTo(x4,y4);
    LineTo(x2,y2);
    MoveTo(x4,y4);
    LineTo(x3,y3);
    Pen.Color:=colTemp;
  end;
end;

function TForm1.rotateX(x0,y0,x1,y1:integer;fi:Real):integer;
begin
  Result:=Round(x0+(x1-x0)*Cos(fi)-(y1-y0)*Sin(fi));

end;

function TForm1.rotateY(x0,y0,x1,y1:integer;fi:Real):integer;
begin
  Result:=Round(y0+(y1-y0)*Cos(fi)+(x1-x0)*Sin(fi));
end;

 procedure TForm1.Timer1Timer(Sender: TObject);
 var
 v1,v2,v3,v4,v5,v6,v7,v8,temp:TVector;
begin
  ResetCanv;
  v1.x:=100; v1.y:=100; v1.z:=0;
  v2.x:=100; v2.y:=200; v2.z:=0;
  v3.x:=200; v3.y:=200; v3.z:=0;
  v4.x:=200; v4.y:=100; v4.z:=0;
  v5.x:=140; v5.y:=140; v5.z:=40;
  v6.x:=140; v6.y:=240; v6.z:=40;
  v7.x:=240; v7.y:=240; v7.z:=40;
  v8.x:=240; v8.y:=140; v8.z:=40;
  if totalTime<=1 then
  begin
    with Form1.Canvas do
    begin
      MoveTo(v1.x,v1.y);
      temp:=vInterp(v1,v2,totalTime);
      LineTo(temp.x,temp.y);
      MoveTo(v1.x,v1.y);
      temp:=vInterp(v1,v4,totalTime);
      LineTo(temp.x,temp.y);
      MoveTo(v1.x,v1.y);
      temp:=vInterp(v1,v5,totalTime);
      LineTo(temp.x,temp.y);
    end;
  end;
  if (totalTime>1) and (totalTime<=2)  then
  begin
    with Form1.Canvas do
    begin
      MoveTo(v1.x,v1.y);
      LineTo(v2.x,v2.y);
      MoveTo(v1.x,v1.y);
      LineTo(v4.x,v4.y);
      MoveTo(v1.x,v1.y);
      LineTo(v5.x,v5.y);
      //----------------
      MoveTo(v2.x,v2.y);
      temp:=vInterp(v2,v3,totalTime);
      LineTo(temp.x,temp.y);
      MoveTo(v2.x,v2.y);
      temp:=vInterp(v2,v6,totalTime);
      LineTo(temp.x,temp.y);
      MoveTo(v4.x,v4.y);
      temp:=vInterp(v4,v3,totalTime);
      LineTo(temp.x,temp.y);
      MoveTo(v4.x,v4.y);
      temp:=vInterp(v4,v8,totalTime);
      LineTo(temp.x,temp.y);
      MoveTo(v5.x,v5.y);
      temp:=vInterp(v5,v6,totalTime);
      LineTo(temp.x,temp.y);
      MoveTo(v5.x,v5.y);
      temp:=vInterp(v5,v8,totalTime);
      LineTo(temp.x,temp.y);
    end;
  end;
  if (totalTime>2) and (totalTime<=3)  then
  begin
    with Form1.Canvas do
    begin
      MoveTo(v1.x,v1.y);
      LineTo(v2.x,v2.y);
      MoveTo(v1.x,v1.y);
      LineTo(v4.x,v4.y);
      MoveTo(v1.x,v1.y);
      LineTo(v5.x,v5.y);
      //----------------
      MoveTo(v2.x,v2.y);
      LineTo(v3.x,v3.y);
      MoveTo(v2.x,v2.y);
      LineTo(v6.x,v6.y);
      MoveTo(v4.x,v4.y);
      LineTo(v3.x,v3.y);
      MoveTo(v4.x,v4.y);
      LineTo(v8.x,v8.y);
      MoveTo(v5.x,v5.y);
      LineTo(v6.x,v6.y);
      MoveTo(v5.x,v5.y);
      LineTo(v8.x,v8.y);
      //----------------
      MoveTo(v3.x,v3.y);
      temp:=vInterp(v3,v7,totalTime);
      LineTo(temp.x,temp.y);
      MoveTo(v6.x,v6.y);
      temp:=vInterp(v6,v7,totalTime);
      LineTo(temp.x,temp.y);
      MoveTo(v8.x,v8.y);
      temp:=vInterp(v8,v7,totalTime);
      LineTo(temp.x,temp.y);
    end;
  end;
  if (totalTime>3) and (totalTime<=4)  then
  begin
    Cube3d(v1,v2,v3,v4,v5,v6,v7,v8,clTeal);
  end;
  if (totalTime>4) and (totalTime<=10)  then
  begin
    v1:=Rotate3D(v1,fi,'y');
    v2:=Rotate3D(v2,fi,'y');
    v3:=Rotate3D(v3,fi,'y');
    v4:=Rotate3D(v4,fi,'y');
    v5:=Rotate3D(v5,fi,'y');
    v6:=Rotate3D(v6,fi,'y');
    v7:=Rotate3D(v7,fi,'y');
    v8:=Rotate3D(v8,fi,'y');
    Cube3d(v1,v2,v3,v4,v5,v6,v7,v8,clTeal);
    fi:=fi+pi/20;
  end;
  if (totalTime>10) and (totalTime<=11)  then
  begin
    v1:=vInterp(Rotate3D(v1,fi,'y'),v1,totalTime);
    v2:=vInterp(Rotate3D(v2,fi,'y'),v2,totalTime);
    v3:=vInterp(Rotate3D(v3,fi,'y'),v3,totalTime);
    v4:=vInterp(Rotate3D(v4,fi,'y'),v4,totalTime);
    v5:=vInterp(Rotate3D(v5,fi,'y'),v5,totalTime);
    v6:=vInterp(Rotate3D(v6,fi,'y'),v6,totalTime);
    v7:=vInterp(Rotate3D(v7,fi,'y'),v7,totalTime);
    v8:=vInterp(Rotate3D(v8,fi,'y'),v8,totalTime);
    Cube3d(v1,v2,v3,v4,v5,v6,v7,v8,clTeal);
  end;
  if (totalTime>11) and (totalTime<=12) then
  begin
   v1:=vInterp(v1,v1,totalTime);
   v2:=vInterp(v2,v1,totalTime);
   v3:=vInterp(v3,v1,totalTime);
   v4:=vInterp(v4,v1,totalTime);
   v5:=vInterp(v5,v1,totalTime);
   v6:=vInterp(v6,v1,totalTime);
   v7:=vInterp(v7,v1,totalTime);
   v8:=vInterp(v8,v1,totalTime);
   Cube3d(v1,v2,v3,v4,v5,v6,v7,v8,clTeal);
  end;
  


  if totalTime>12 then
  begin
    totalTime:=0;
    fi:=0;
  end;


  totalTime:=totalTime+0.033;
end;

procedure TForm1.draw1();
 var
  x0,y0,z0:integer;
  x1,x2,x3,x4,y1,y2,y3,y4:integer;
 begin
  x0:=190;
  y0:=140;
  z0:=120;
  //ResetCanv;
  x1:=130; y1:=130;
  x2:=150; y2:=180;
  x3:=190; y3:=140;
  x4:=170; y4:=150;
  if (fi>(pi*2)) or (fi<0) then
    b:= not b;
  if b=True then
  begin
    fi:=fi+(Pi/20);
    triangle3D(rotateX(x0,y0,x1,y1,fi), RotateY(x0,y0,x1,y1,fi),0,
             rotateX(x0,y0,x2,y2,fi),RotateY(x0,y0,x2,y2,fi),0,
             rotateX(x0,y0,x3,y3,fi),RotateY(x0,y0,x3,y3,fi),0,
             rotateX(x0,y0,x4,y4,fi),RotateY(x0,y0,x4,y4,fi),0,
             clPurple);
  end
  else
  begin
    fi:=fi-(Pi/20);
    triangle3D(rotateX(x0,y0,x1,y1,fi), RotateY(x0,y0,x1,y1,fi),0,
             rotateX(x0,y0,x2,y2,fi),RotateY(x0,y0,x2,y2,fi),0,
             rotateX(x0,y0,x3,y3,fi),RotateY(x0,y0,x3,y3,fi),0,
             rotateX(x0,y0,x4,y4,fi),RotateY(x0,y0,x4,y4,fi),0,
             defaultCol);
  end;
 end;

 procedure TForm1.Line3D(v1,v2:TVector; col:TColor);
 var
  colTemp:TColor;
 begin
 with Form1.Canvas do
  begin
    colTemp:=Pen.Color;
    Pen.Color:=col;
    MoveTo(v1.x,v1.y);
    LineTo(v2.x,v2.y);

    Pen.Color:=colTemp;
  end;
 end;

 function TForm1.Rotate3D(v1:TVector;fi:Real;asix:string):TVector;
 var
  ret:TVector;
 const x0=130;
 const y0=130;
 const z0=50;
 begin
 // X = x0 + (x - x0) * cos(fi) - (y - y0) * sin(fi);

   if asix='x' then
   begin
     ret.x:=v1.x;
     ret.y:=Round(y0+(v1.y-y0)*Cos(fi)-(v1.z-z0)*sin(fi));
     ret.z:=Round(z0+(v1.y-y0)*Sin(fi)+(v1.z-z0)*cos(fi));
   end;
   if asix='y' then
   begin
     ret.x:=Round(x0+(v1.x-x0)*Cos(fi)+(v1.z-z0)*Sin(fi));
     ret.y:=v1.y;
     ret.z:=Round(z0-(v1.x-x0)*Sin(fi)+(v1.z-z0)*Cos(fi));
   end;
   if asix='z' then
   begin
     ret.x:=Round(x0-(v1.x-x0)*Cos(fi)-(v1.y-y0)*Sin(fi));
     ret.y:=Round(y0-(v1.x-x0)*Sin(fi)+(v1.y-y0)*Cos(fi));
     ret.z:=v1.z;
   end;
   result:=ret;
 end;

procedure TForm1.Cube3d(v1,v2,v3,v4,v5,v6,v7,v8:TVector;col:TColor);
var
  colTemp:TColor;
  begin
  with Form1.Canvas do
  begin
    colTemp:=Pen.Color;
    Pen.Color:=col;
    MoveTo(v1.x,v1.y);
    LineTo(v2.x,v2.y);
    LineTo(v3.x,v3.y);
    LineTo(v4.x,v4.y);
    LineTo(v1.x,v1.y);
    Pen.Color:=clRed;
    MoveTo(v5.x,v5.y);
    LineTo(v6.x,v6.y);
    LineTo(v7.x,v7.y);
    LineTo(v8.x,v8.y);
    LineTo(v5.x,v5.y);
    Pen.Color:=clBlue;
    MoveTo(v1.x,v1.y);
    LineTo(v5.x,v5.y);
    MoveTo(v2.x,v2.y);
    LineTo(v6.x,v6.y);
    MoveTo(v3.x,v3.y);
    LineTo(v7.x,v7.y);
    MoveTo(v4.x,v4.y);
    LineTo(v8.x,v8.y);
    Pen.Color:=colTemp;
  end;
  end;

  function TForm1.interp(val1,val2,i:Real):Real;
  var
    vMin,vMax,vInterp:Real;
  begin
    if (i>1) or (i<0) then
    begin
      vInterp:=Abs(Frac(i));
    end
    else
      vInterp:=i;
   if val1<val2 then
      Result:=val1+((val2-val1)*vInterp);
   if val1>val2 then
    Result:=val1-((val1-val2)*vInterp);
   if val1=val2 then
    Result:=val1;
  end;

  function TForm1.vInterp(v1,v2:TVector;i:Real):TVector;
  var
    vRes:TVector;
  begin
     //123
     vRes.x:=Round(interp(v1.x,v2.x,i));
     vRes.y:=Round(interp(v1.y,v2.y,i));
     vRes.z:=Round(interp(v1.z,v2.z,i));
     Result:=vRes;
  end;


end.
