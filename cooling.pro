;5/10/2012
pro cooling

compile_opt idl2
 
x1=FINDGEN(360)
y1=68. + 60.*exp(-0.02*x1)
y2=68. + 60.*exp(-0.03*x1)
y3=68. + 60.*exp(-0.04*x1)
y4=68. + 60.*exp(-0.05*x1)
y5=68. + 60.*exp(-0.08*x1)


LOADCT,39
DEVICE, DECOMPOSE=0

window,1, XSIZE=700,YSIZE=500
plot,x1, y1,background=255, color=0, $
XRANGE=[0,200],$
YRANGE=[50,150],$
charsize=2,XSTYLE=1, YSTYLE=1,charthick=2,$ 
XTITLE='Time (minutes)', YTITLE='Temperature (F)'
oplot,x1,y1,color=250,THICK=3
oplot,x1,y2,color=210,THICK=3
oplot,x1,y3,color=180,THICK=3
oplot,x1,y4,color=95,THICK=3
oplot,x1,y5,color=50,THICK=2

end

cooling
end


