unit GL_TOR;

interface
procedure SP;
var
   V_xt,V_YT,V_zt,V_rotat,V_ugol,V_rmm,V_fx,V_FY,V_FZ:single;
   V_bmm,V_amm,V_Aten,V_Bten:integer;
   V_g:boolean;
V_pointcoord1:array[0..31,0..24]of record
                                    xmm,ymm,zmm:single;
                                  end;
implementation
uses opengl,TECHNICAL;
const V_APLE=1;                          `
procedure SP;
begin
 // glusphere(glunewquadric,1,10,10);
  //---------------€блуко-----------------//

 // glnewlist(V_APLE,GL_COMPILE);
   prepareimage('4');
   glpushmatrix();
   gltranslatef(0,0.6,0);
   glrotatef(90,0,0,1);
  glcolor3f(0.6,0.3,0.8);
  glpointsize(2);
  V_yt:=0;
  v_rotat:=20*pi/180;
  V_ugol:=0;
      V_rmm:=1;
      v_g:=true;
  for V_bmm:=0 to 23 do
  begin
//    if rmm<0 then rmm:=0;
//    rmm:=0.5*(sin(rotat))+0.45;
{    if bmm<=4 then} begin V_rmm:=0.5*(2*sin(V_rotat/2)-0.33);
                         V_yt:=0.5*cos(V_rotat+pi/2);
                   end;
  {  if bmm>4 then begin  rmm:=0.5*(4*sin(rotat/2)-0.33);
                         yt:=2*cos(rotat+pi/2);
                  end;}
    for V_amm:=0 to 23 do
    begin
      V_xt:= 0 +V_rmm*sin(V_ugol);
      V_zt:= 0 +V_rmm*cos(V_ugol);
      V_pointcoord1[V_bmm,V_amm].xmm:=V_xt;
      V_pointcoord1[V_bmm,V_amm].ymm:=V_yt;
      V_pointcoord1[V_bmm,V_amm].zmm:=V_zt;
      V_ugol:=V_ugol+15*pi/180;
    end;
//              yt:=0.4*sin(rotat);
              V_rotat:=V_rotat+20*pi/180;
  end;
  glenable(GL_LIGHTING);
  glenable( GL_TEXTURE_2D);
  for V_bmm:=0 to 11 do
  begin
    for V_amm:=0 to 23 do
    begin
      V_Bten:=0;
      glbegin(GL_QUADS);
        V_Aten:=V_amm+1;
        if V_Aten=24 then V_Aten:=0;
        V_Bten:=V_bmm+1;
        if V_Bten=24 then V_Bten:=0;
        V_calcnormals(V_pointcoord1[V_bmm,V_amm].xmm,V_pointcoord1[V_bmm,V_amm].ymm,
         V_pointcoord1[V_bmm,V_amm].zmm,
        V_pointcoord1[V_bmm,V_Aten].xmm,V_pointcoord1[V_bmm,V_Aten].ymm,
         V_pointcoord1[V_bmm,V_Aten].zmm,
        V_pointcoord1[V_Bten,V_Aten].xmm,V_pointcoord1[V_Bten,V_Aten].ymm,
         V_pointcoord1[V_Bten,V_Aten].zmm,
                   V_fx,V_fy,V_fz);
//---------------1----------------------//
//      if bmm=0 then  glnormal3f(-fx,-fy,-fz)
  {             else   }glnormal3f(v_fx,v_fy,V_fz);
    gltexcoord2f(V_bmm/24,V_amm/6);
        glvertex3f(V_pointcoord1[V_bmm,V_amm].xmm,V_pointcoord1[V_bmm,V_amm].ymm,
         V_pointcoord1[V_bmm,V_amm].zmm);
//---------------2----------------------//
    gltexcoord2f(V_bmm/24,V_Aten/6);
        glvertex3f(V_pointcoord1[V_bmm,V_Aten].xmm,V_pointcoord1[V_bmm,V_Aten].ymm,
         V_pointcoord1[V_bmm,V_Aten].zmm);
//---------------3----------------------//
    gltexcoord2f(V_Bten/24,V_Aten/6);
        glvertex3f(V_pointcoord1[V_Bten,V_Aten].xmm,V_pointcoord1[V_Bten,V_Aten].ymm,
         V_pointcoord1[V_Bten,V_Aten].zmm);
//---------------4----------------------//
    gltexcoord2f(V_Bten/24,V_amm/6);
        glvertex3f(V_pointcoord1[V_Bten,V_amm].xmm,V_pointcoord1[V_Bten,V_amm].ymm,
         V_pointcoord1[V_Bten,V_amm].zmm);
      glend;
    end;
  end;
  glDisable(GL_TEXTURE_2D);
  glpopmatrix();
 // glendlist;

end;

end.
