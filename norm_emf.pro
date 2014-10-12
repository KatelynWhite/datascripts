; last updated 9/29/2014
; This code is currently written to read in multiple files,
; find the norm of the emf terms and interpolate them
;   sph: 0 - vr
;         1 - vt
;         2 - br
;         3 - bt
;         4 - vr*bt
;         5 - vt*br
;         6 - vr*bt-vt*br

PRO norm_emf,nn=nni,ni=ni,nj=nj
  COMPILE_OPT IDL2

; radius of cartesian grid
  nx=50
  ny=50
  nz=50

  cart=dblarr(7,2*nx+1,2*ny+1,2*nz+1)     ;is is forced to be odd

; Graphic resolution:
  nng=81
  nig=101
  njg=201

  sph=dblarr(7,nng,nig,njg)

;radius of inner and outer sphere
  ri=10.
  ro=50.

; Prompts user for the file to be read in
  start=0
  finish=0
  PRINT, 'What is the starting number?'
  READ, start
  PRINT, 'What is the ending number?'
  READ, finish

; Initial Conditions
  vr=dblarr(nng,nig,njg)
  vt=dblarr(nng,nig,njg)
  br=dblarr(nng,nig,njg)
  bt=dblarr(nng,nig,njg)

  vradius=dblarr(nng,nig,njg)
  vtheta=dblarr(nng,nig,njg)
  bradius=dblarr(nng,nig,njg)
  btheta=dblarr(nng,nig,njg)
  vrbt=dblarr(nng,nig,njg)
  vtbr=dblarr(nng,nig,njg)
  emf=dblarr(nng,nig,njg)

  data=dblarr(6,nng,nig,njg)
  data0=dblarr(6,nng,nig,njg)
  data1=dblarr(6,nng,nig,njg)

; This loop is finding the mean emf (u_r*b_theta - u_theta*b_r)
  FOR m=start, finish DO BEGIN
  print, m

; Reading in the data file
    readfile0='mall/emfdat'+string(m,FORMAT='(I4.4)')
    readfile1='m00/sphdat'+string(m,FORMAT='(I4.4)')

    a0=assoc(1,dblarr(6,nng,nig,njg))
    close,1 & openr,1,readfile0
    data0=a0[0]
    close,1

    a1=assoc(1,dblarr(6,nng,nig,njg))
    close,1 & openr,1,readfile1
    data1=a1[0]
    close,1

    data=data0-data1

    vr=reform(data[0,*,*,*])
    vt=reform(data[1,*,*,*])
    br=reform(data[3,*,*,*])
    bt=reform(data[4,*,*,*])

; Finding the average of u_r, u_theta, and u_phi over longitude
    sph[0,*,*,*]=vr/MAX(ABS(vr))
    sph[1,*,*,*]=vt/MAX(ABS(vt))
    sph[2,*,*,*]=br/MAX(ABS(br))
    sph[3,*,*,*]=bt/MAX(ABS(bt))
    sph[4,*,*,*]=vr*bt/MAX(ABS(vr*bt))
    sph[5,*,*,*]=vt*br/MAX(ABS(vt*br))
    sph[6,*,*,*]=(vr*bt-vt*br)/MAX(ABS(vr*bt-vt*br))

;  print, min(sph[0,*,*,*]), max(sph[0,*,*,*])
;  print, min(sph[1,*,*,*]), max(sph[1,*,*,*])
;  print, min(sph[2,*,*,*]), max(sph[2,*,*,*])
;  print, min(sph[3,*,*,*]), max(sph[3,*,*,*])
;  print, min(sph[4,*,*,*]), max(sph[4,*,*,*])
;  print, min(sph[5,*,*,*]), max(sph[5,*,*,*])
;  print, min(sph[6,*,*,*]), max(sph[6,*,*,*])

;Interpolation
  ratio=(nx-5)/(ro)


  for x=-1*nx,nx do begin
    for y=-1*ny,ny do begin
      for z=-1*nz,nz do begin

        ;grid sphereical
        grid_r=sqrt(x^2+y^2+z^2)

        ;real spherical
        theta=acos(z/grid_r)  ;check
        phi=atan(abs(y)*1./abs(x))
        if (x lt 0) then begin
           phi= !pi - phi
        endif
        if (y lt 0) then begin
           phi=2*!pi - phi
        endif
        if (~finite(phi)) then phi=0
        r = grid_r/ratio

;       print, r,theta,phi

        ;bounds on data
        if (r gt ro) then begin
           cart[*,x,y,z]=0
        endif else if (r lt ri) then begin
           cart[*,x,y,z]=0
        endif else begin
          ;locate data in dat file nng, nig, njg
;print, 'x=',x, 'r=', r
           ngr=(r-ro)/(ri-ro)*(nng-1)
           nglat=theta*(nig-1)/!pi
           nglon=phi*(njg-1)/(2*!pi)

;print, ngr, nglat, nglon

           ;interpolatino points
           radl=floor(ngr)
           radh=ceil(ngr)
           latl=floor(nglat)
           lath=ceil(nglat)
           lonl=floor(nglon)
           lonh=ceil(nglon)
;print, 'radh =', radh

           if (radl ne radh) AND (latl ne lath) AND (lonl ne lonh) then begin
;print, '1'
              ;describe point as if in cubic lattice
              radd=(ngr-radl)/(radh-radl)
              latd=(nglat-latl)/(lath-latl)
              lond=(nglon-lonl)/(lonh-lonl)
;print, radl, radh, latl, lath, lonl, lonh
              c00=sph[*,radl-1,latl-1,lonl-1]*(1-radd)+sph[*,radh-1,latl-1,lonl-1]*radd
              c10=sph[*,radl-1,lath-1,lonl-1]*(1-radd)+sph[*,radh-1,lath-1,lonl-1]*radd
              c01=sph[*,radl-1,latl-1,lonh-1]*(1-radd)+sph[*,radh-1,latl-1,lonh-1]*radd
              c11=sph[*,radl-1,lath-1,lonh-1]*(1-radd)+sph[*,radh-1,lath-1,lonh-1]*radd
;print, '2'
;print, c00[0], sph[0,radl-1,latl-1,lonl-1], sph[0,radh-1,latl-1,lonl-1]
              c0=c00*(1-latd)+c10*latd
              c1=c01*(1-latd)+c11*latd
;print,'3' 
              cart[*,x,y,z] =c0*(1-lond)+c1*lond
;print,'4'
           endif else if (radl eq radh) AND (latl ne lath) AND (lonl ne lonh) then begin
;print, '2', lath-latl, lonh-lonl
              latd=(nglat-latl)/(lath-latl)
              lond=(nglon-lonl)/(lonh-lonl)

              q00=sph[*,radl-1,latl-1,lonl-1]
              q10=sph[*,radl-1,lath-1,lonl-1]
              q01=sph[*,radl-1,latl-1,lonh-1]
              q11=sph[*,radl-1,lath-1,lonh-1]

              c0=q00*(1-latd)+q10*latd
              c1=q01*(1-latd)+q11*latd

              cart[*,x,y,z] =c0*(1-lond)+c1*lond
;print, '2end'
           endif else if (radl ne radh) AND (latl eq lath) AND (lonl ne lonh) then begin
;print, '3'
              radd=(ngr-radl)/(radh-radl)
              lond=(nglon-lonl)/(lonh-lonl)

              q00=sph[*,radl-1,latl-1,lonl-1]
              q10=sph[*,radh-1,latl-1,lonl-1]
              q01=sph[*,radl-1,latl-1,lonh-1]
              q11=sph[*,radh-1,latl-1,lonh-1]

              c0=q00*(1-radd)+q10*radd
              c1=q01*(1-radd)+q11*radd

              cart[*,x,y,z] =c0*(1-lond)+c1*lond

           endif else if (radl ne radh) AND (latl eq lath) AND (lonl ne lonh) then begin
;print, '4'
              radd=(ngr-radl)/(radh-radl)
              latd=(nglat-latl)/(lath-latl)

              q00=sph[*,radl-1,latl-1,lonl-1]
              q10=sph[*,radh-1,latl-1,lonl-1]
              q01=sph[*,radl-1,lath-1,lonl-1]
              q11=sph[*,radh-1,lath-1,lonl-1]

              c0=q00*(1-radd)+q10*radd
              c1=q01*(1-radd)+q11*radd

              cart[*,x,y,z] =c0*(1-latd)+c1*latd

           endif else if (radl eq radh) AND (latl eq lath) AND (lonl ne lonh) then begin
;print, '5'
              lond=(nglon-lonl)/(lonh-lonl)

              q0=sph[*,radl-1,latl-1,lonl-1]
              q1=sph[*,radl-1,latl-1,lonh-1]

              c0=q0*(1-lond)+q1*lond

              cart[*,x,y,z]=c0

           endif else if (radl eq radh) AND (latl ne lath) AND (lonl eq lonh) then begin
;print, '6'
              latd=(nglat-latl)/(lath-latl)

              q0=sph[*,radl-1,latl-1,lonl-1]
              q1=sph[*,radl-1,lath-1,lonl-1]

              c0=q0*(1-latd)+q1*latd

              cart[*,x,y,z]=c0

           endif else if (radl ne radh) AND (latl eq lath) AND (lonl eq lonh) then begin
;print, '7'
              radd=(ngr-radl)/(radh-radl)

              q0=sph[*,radl-1,latl-1,lonl-1]
              q1=sph[*,radh-1,latl-1,lonl-1]

              c0=q0*(1-radd)+q1*radd

              cart[*,x,y,z]=c0

           endif else if (radl eq radh) AND (latl eq lath) AND (lonl eq lonh) then begin

              cart[*,x,y,z]=sph[*,radl-1,latl-1,lonl-1]

           endif
        endelse
      endfor
    endfor
  endfor


  vradius=shift(reform(cart[0,*,*,*]),nx,ny,nz)
  vtheta=shift(reform(cart[1,*,*,*]),nx,ny,nz)
  bradius=shift(reform(cart[2,*,*,*]),nx,ny,nz)
  btheta=shift(reform(cart[3,*,*,*]),nx,ny,nz)
  vrbt=shift(reform(cart[4,*,*,*]),nx,ny,nz)
  vtbr=shift(reform(cart[5,*,*,*]),nx,ny,nz)
  emf=shift(reform(cart[6,*,*,*]),nx,ny,nz)

;  print, min(vradius), max(vradius)
;  print, min(vtheta), max(vtheta)
;  print, min(bradius), max(bradius)
;  print, min(btheta), max(btheta)
;  print, min(vrbt), max(vrbt)
;  print, min(vtbr), max(vtbr)
;  print, min(emf), max(emf)

  vrfile='nvr_cart_'+string(m,FORMAT='(I4.4)')+'.dat'
  vtfile='nvt_cart_'+string(m,FORMAT='(I4.4)')+'.dat'
  brfile='nbr_cart_'+string(m,FORMAT='(I4.4)')+'.dat'
  btfile='nbt_cart_'+string(m,FORMAT='(I4.4)')+'.dat'
  vrbtfile='nvrbt_cart_'+string(m,FORMAT='(I4.4)')+'.dat'
  vtbrfile='nvtbr_cart_'+string(m,FORMAT='(I4.4)')+'.dat'
  emffile='nemf_cart_'+string(m,FORMAT='(I4.4)')+'.dat'



  OPENW, 1, vrfile
  WRITEU, 1, vradius
  CLOSE, 1

  OPENW, 2, vtfile
  WRITEU, 2, vtheta
  CLOSE, 2

  OPENW, 3, brfile
  WRITEU, 3, bradius
  CLOSE, 3

  OPENW, 4, btfile
  WRITEU, 4, btheta
  CLOSE, 4

  OPENW, 5, vrbtfile
  WRITEU, 5, vrbt
  CLOSE, 5

  OPENW, 6, vtbrfile
  WRITEU, 6, vtbr
  CLOSE, 6

  OPENW, 7, emffile
  WRITEU, 7, emf
  CLOSE, 7



  ENDFOR

END

norm_emf
end

