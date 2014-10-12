;10/16/2013
pro hw2

compile_opt idl2
 
z=-FINDGEN(400)/100+4
x=-z*sqrt(z*z-1)/2. + 0.5*ALOG(2*(sqrt(z*z-1)+z))

print, z
print, x
LOADCT,39
DEVICE, DECOMPOSE=0

window,1, XSIZE=700,YSIZE=500
plot,x, z,background=255, color=0, $
XRANGE=[0,2],$
YRANGE=[10,0],$
charsize=2,XSTYLE=1, YSTYLE=1,charthick=2,$ 
XTITLE='x', YTITLE='z'


end

hw2
end


