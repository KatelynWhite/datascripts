;10/16/2013
pro hw

compile_opt idl2
 
x=FINDGEN(360)/100
t=0.0
y1=sin(3*!pi*x)*cos(3*!pi*t)
t=0.1
y2=sin(3*!pi*x)*cos(3*!pi*t)
t=0.2
y3=sin(3*!pi*x)*cos(3*!pi*t)
t=0.3
y4=sin(3*!pi*x)*cos(3*!pi*t)
t=0.4
y5=sin(3*!pi*x)*cos(3*!pi*t)

LOADCT,39
DEVICE, DECOMPOSE=0

window,1, XSIZE=700,YSIZE=500
plot,x, y1,background=255, color=0, $
XRANGE=[0,1],$
YRANGE=[-1,1],$
charsize=2,XSTYLE=1, YSTYLE=1,charthick=2,$ 
XTITLE='x', YTITLE='Pressure'
oplot,x,y1,color=250,THICK=3
oplot,x,y2,color=210,THICK=3
oplot,x,y3,color=180,THICK=3
oplot,x,y4,color=95,THICK=3
oplot,x,y5,color=50,THICK=2


;-------------------------------
esp=0.01
t=0.0
x=FINDGEN(720)/700
y6=0
y7=0
y8=0
y9=0
y10=0
for n=1,100 do begin
y6=y6+(1./n*!pi)*(cos(n*!pi*(.5+esp))-cos(n*!pi*(.5-esp)))*sin(n*!pi*x)*cos(n*!pi*t)
endfor
t=0.2
for n=1,100 do begin
y7=y7+(1./n*!pi)*(cos(n*!pi*(.5+esp))-cos(n*!pi*(.5-esp)))*sin(n*!pi*x)*cos(n*!pi*t)
endfor
t=0.4
for n=1,100 do begin
y8=y8+(1./n*!pi)*(cos(n*!pi*(.5+esp))-cos(n*!pi*(.5-esp)))*sin(n*!pi*x)*cos(n*!pi*t)
endfor
t=0.5
for n=1,100 do begin
y9=y9+(1./n*!pi)*(cos(n*!pi*(.5+esp))-cos(n*!pi*(.5-esp)))*sin(n*!pi*x)*cos(n*!pi*t)
endfor
t=0.6
for n=1,100 do begin
y10=y10+(1./n*!pi)*(cos(n*!pi*(.5+esp))-cos(n*!pi*(.5-esp)))*sin(n*!pi*x)*cos(n*!pi*t)
endfor

LOADCT,39
DEVICE, DECOMPOSE=0

window,2, XSIZE=700,YSIZE=500
plot,x, y6,background=255, color=0, $
XRANGE=[0,1],$
YRANGE=[-1,1],$
charsize=2,XSTYLE=1, YSTYLE=1,charthick=2,$ 
XTITLE='x', YTITLE='Pressure'
oplot,x,y6,color=250,THICK=3
oplot,x,y7,color=210,THICK=3
oplot,x,y8,color=180,THICK=3
oplot,x,y9,color=95,THICK=3
oplot,x,y10,color=50,THICK=2


end

hw
end


