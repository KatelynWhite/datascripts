;11/20/2013
pro interp

compile_opt idl2
 
; size of cartesian grid
nx=100
ny=100
nz=100

;size of graphics data
nng=81
nig=101
njg=201

;radius of inner and outer sphere
ri=10
ro=50

;read in sphereical data
a=assoc(1,dblarr(6,nng,nig,njg))
close,1 & openr,1,'emfdat005', /F77_UNFORMATTED
data=a[0]
close,1

ratio=nx/(2*ro)

cart=dblarr(6,nx,ny,nz)

for x=(-nx/2),nx/2 do begin
  for y=(-ny/2),ny/2 do begin
    for z=(-nz/2),nz/2 do begin
        r=sqrt(x^2+y^2+z^2)/ratio
        theta=acos(z/r)
        phi=atan(y/x)

        
        if (r gt ro) then begin
           cart[*,x,y,z]=0
        endif else if (r lt ri) then begin
           cart[*,x,y,z]=0
        endif else begin
           ;locate data in dat file nng, nig, njg
           ngr=r/ro*nig
           nglat=theta*nig/!pi
           nglon=(phi+!pi/4)*njg*2/!pi

           ;interpolatino points
           radl=floor(ngr)
           radh=ceil(ngr)
           latl=floor(nir)
           lath=ceil(nir)
           lonl=floor(njr)
           lonh=ceil(njr)

           ;describe point as if in cubic lattice
           radd=(ngr-radl)/(radh-radl)
           latd=(nglat-latl)/(lath-latl)
           lond=(nglon-lonl)/(lonh-lonl)

           c00=data[*,radl,latl,lonl]*(1-radd)+data[*,radh,latl,lonl]*radd
           c10=data[*,radl,lath,lonl]*(1-radd)+data[*,radh,lath,lonl]*radd
           c01=data[*,radl,latl,lonh]*(1-radd)+data[*,radh,latl,lonh]*radd
           c11=data[*,radl,lath,lonh]*(1-radd)+data[*,radh,lath,lonh]*radd

           c0=c00*(1-latd)+c10*latd
           c1=c01*(1-latd)+c11*latd

           cart[*,x,y,z] =c0*(1-lond)+cc11*lond
        endelse
    endfor
  endfor
endfor


;x=r*sin(theta)*cos(phi)
;y=r*sin(theta)*cos(phi)
;z=r*cos(theta)


end

interp
end


