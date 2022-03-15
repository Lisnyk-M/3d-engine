unit TECHNICAL;

interface
uses  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls,opengl;
procedure PrepareImage(p:string);
procedure V_CALCNORMALS(x1,y1,z1,x2,y2,z2,x3,y3,z3:GLfloat;var nx,ny,nz:GLfloat);
implementation
procedure PrepareImage(p:string);

type
  PPixelArray = ^TPixelArray;
  TPixelArray = array [0..0] of Byte;

var
  Bitmap : TBitmap;
  Data : PPixelArray;
  BMInfo : TBitmapInfo;
  I, ImageSize : Integer;
  Temp : Byte;
  MemDC : HDC;
begin
  Bitmap := TBitmap.Create;
  Bitmap.LoadFromFile (p+'.bmp');
  with BMinfo.bmiHeader do begin
    FillChar (BMInfo, SizeOf(BMInfo), 0);
    biSize := sizeof (TBitmapInfoHeader);
    biBitCount := 24;
    biWidth := Bitmap.Width;
    biHeight := Bitmap.Height;
    ImageSize := biWidth * biHeight;
    biPlanes := 1;
    biCompression := BI_RGB;

    MemDC := CreateCompatibleDC (0);
    GetMem (Data, ImageSize * 3);
    try
      GetDIBits (MemDC, Bitmap.Handle, 0, biHeight, Data, BMInfo, DIB_RGB_COLORS);
      For I := 0 to ImageSize - 1 do begin
          Temp := Data [I * 3];
          Data [I * 3] := Data [I * 3 + 2];
          Data [I * 3 + 2] := Temp;
      end;
{  //------------------кирпич------------------//
     for k_om:=0 to 8-1 do
       for l_om:=0 to 3-1 do
        for i_om:=0 to biWidth-1 do
        begin
          Data[(i_om+((k_om*biHeight div 8+l_om)*biWidth))*3]:=50;
          Data[(i_om+((k_om*biHeight div 8+l_om)*biWidth))*3+1]:=50;
          Data[(i_om+((k_om*biHeight div 8+l_om)*biWidth))*3+2]:=50;
        end;
  //------------вертикальные полоски------------//
     for n_om:=0 to 1 do
      for m_om:=0 to 4-1 do
       for l_om:=0 to 4-1 do
        for k_om:=0 to 3-1 do
         for i_om:=0 to biHeight div 8-3-1 do
         begin
           Data[(k_om+l_om*biWidth div 4+biWidth div 8*n_om+((i_om+3+m_om*biHeight div 4+n_om*biHeight div 8)*biwidth))*3]:=50;
           Data[(k_om+l_om*biWidth div 4+biWidth div 8*n_om+((i_om+3+m_om*biHeight div 4+n_om*biHeight div 8)*biwidth))*3+1]:=50;
           Data[(k_om+l_om*biWidth div 4+biWidth div 8*n_om+((i_om+3+m_om*biHeight div 4+n_om*biHeight div 8)*biwidth))*3+2]:=50;
         end;
  //------------------конец------------------//}
      glTexImage2d(GL_TEXTURE_2D, 0, 3, biWidth,
                   biHeight, 0, GL_RGB, GL_UNSIGNED_BYTE, Data);

      glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);
      glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);

     finally
      FreeMem (Data);
      DeleteDC (MemDC);
      Bitmap.Free;
   end;
  end;
{  glenable(GL_TEXTURE_GEN_S);
  gltexgeni(GL_S,GL_TEXTURE_GEN_MODE,GL_OBJECT_LINEAR);}
 // gltexenvf(GL_TEXTURE_ENV,GL_TEXTURE_ENV_MODE,GL_DECAL);
end;
procedure V_CALCNORMALS(x1,y1,z1,x2,y2,z2,x3,y3,z3:GLfloat;var nx,ny,nz:GLfloat);
var vx1,vy1,vz1,vx2,vy2,vz2,nx1,ny1,nz1,wrki:GLfloat;
begin
  vx1:=x1-x2;
  vy1:=y1-y2;
  vz1:=z1-z2;
    vx2:=x2-x3;
    vy2:=y2-y3;
    vz2:=z2-z3;
  nx1:=vy1*vz2-vz1*vy2;
  ny1:=vz1*vx2-vx1*vz2;
  nz1:=vx1*vy2-vy1*vx2;
  wrki:=sqrt(nx1*nx1+ny1*ny1+nz1*nz1);
  if wrki=0 then wrki:=1;
  nx:=nx1/wrki;
  ny:=ny1/wrki;
  nz:=nz1/wrki;
end;

end.
