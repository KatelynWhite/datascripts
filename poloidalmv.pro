; last updated 3/12/2012
; This code is currently written to read in one shapshot
; 
;  Code to make:
; (1) Colored contour of the Poloidal fields
; (2) Contour lines of the Poloidal field 
; (3) Colored contour of the radial magnetic field averaged in longitude
; (4) Colored contour of the colatitudinal magnetic field averaged in longitude
; (5) Colored contour of the longitudinal magnetic field averaged in longitudei
; 
; This code reads in emfdat000 and creates snapshots to the screen
;   The emfdat data is stored in the following manner:
;   u_r, u_theta, u_phi, b_r, b_theta, b_phi
;
;  This code uses the colorbar.pro code not written by me
;
;  This code uses polar_contour2.pro code which was a code slightly modified by me

PRO poloidalsph,nn=nni,ni=ni,nj=nj
  COMPILE_OPT IDL2

; Graphic resolution:
  nn=81
  ni=101
  nj=201
  radtop=50.D
  radbot=20.D

; Prompts user for the file to be read in
  start=0
  finish=0
  PRINT, 'What is the starting number?'
  READ, start
  PRINT, 'What is the ending number?'
  READ, finish

; Initial Conditions
  r=dblarr(nn)
  colat=dblarr(ni)
  bar=dblarr(nn,ni)
  bat=dblarr(nn,ni)
  bap=dblarr(nn,ni)

  maxpsi=0.
  minpsi=0.
  maxr=0.
  minr=0.
  maxt=0.
  mint=0.
  maxp=0.
  minp=0.

; Setting the radius and colatitude levels
  FOR n = 0, nn-1 DO BEGIN
    r[n] = radtop - (radtop-radbot)*float(n)/float(nn-1)
  ENDFOR

  FOR k = 0, ni-1 DO BEGIN
    colat[k] = !PI * float(k)/float(ni-1)
  ENDFOR


 FOR m=start, finish DO BEGIN

; Reading in the data file
    readfile='emfdat'+string(m,FORMAT='(I4.4)')

    a=assoc(1,dblarr(6,nn,ni,nj))
    close,1 & openr,1,readfile
    data=a[0]
    close,1

; Finding the average of b_r, b_theta, and b_phi over longitude
    FOR n = 0, nn-1 DO BEGIN
      FOR k = 0, ni-1 DO BEGIN

        bar[n,k]=MEAN(data[3,n,k,*])
        bat[n,k]=MEAN(data[4,n,k,*])
        bap[n,k]=MEAN(data[5,n,k,*])

      ENDFOR
    ENDFOR

; Finding the poloidal field lines
; The psi function is defined as: Bar = -1/r dpsi/dr and Bat = dpsi/dtheta
; The field lines correspond to iso-contours of psi
    psi = dblarr(nn,ni)
    n = nn-1

    FOR k = 1, ni-1 DO BEGIN
      psi[n,k] = psi[n,k-1] + 0.5*(colat[k]-colat[k-1])*$
        (bar[n,k-1]*r[n]^2*SIN(colat[k-1]) + bar[n,k]*r[n]^2*SIN(colat[k]))
    ENDFOR

    FOR k = 0, ni-1 DO BEGIN
      FOR n =  nn-2, 0, -1 DO BEGIN
        psi[n,k] = psi[n+1,k] - 0.5*(r[n+1]-r[n])*$
          (bat[n,k]*r[n]*SIN(colat[k]) + bat[n+1,k]*r[n+1]*SIN(colat[k]))
      ENDFOR
    ENDFOR

    IF (maxpsi lt max(psi)) THEN (maxpsi=max(psi))
    IF (minpsi gt min(psi)) THEN (minpsi=min(psi))
    IF (maxr lt max(bar)) THEN (maxr=max(bar))
    IF (minr gt min(bar)) THEN (minr=min(bar))
    IF (maxt lt max(bat)) THEN (maxt=max(bat))
    IF (mint gt min(bat)) THEN (mint=min(bat))
    IF (maxp lt max(bap)) THEN (maxp=max(bap))
    IF (minp gt min(bap)) THEN (minp=min(bap))

Print, m

  ENDFOR

; Making the inner core white
  blankp=dblarr(ni,radbot)
  blankp[*]=MAX(psi)
  blankr=dblarr(ni,radbot)
  blankr[*]=MAX(bar)
  blankt=dblarr(ni,radbot)
  blankt[*]=MAX(bat)
  blankpa=dblarr(ni,radbot)
  blankpa[*]=MAX(bap)

; Converting from cartesian to polar
  colatitude=findgen(ni)/float(ni-1)*!PI
  rad=radtop-(radtop-radbot)*findgen(nn)/float(nn-1)
  radb=radbot-float(radbot)*findgen(radbot)/(float(radbot)-1.)


 FOR m=start, finish DO BEGIN
print, m
; Reading in the data file
    readfile='emfdat'+string(m,FORMAT='(I4.4)')

    a=assoc(1,dblarr(6,nn,ni,nj))
    close,1 & openr,1,readfile
    data=a[0]
    close,1

; Finding the average of b_r, b_theta, and b_phi over longitude
    FOR n = 0, nn-1 DO BEGIN
      FOR k = 0, ni-1 DO BEGIN

        bar[n,k]=MEAN(data[3,n,k,*])
        bat[n,k]=MEAN(data[4,n,k,*])
        bap[n,k]=MEAN(data[5,n,k,*])

      ENDFOR
    ENDFOR

; Finding the poloidal field lines
; The psi function is defined as: Bar = -1/r dpsi/dr and Bat = dpsi/dtheta
; The field lines correspond to iso-contours of psi
    psi = dblarr(nn,ni)
    n = nn-1

    FOR k = 1, ni-1 DO BEGIN
      psi[n,k] = psi[n,k-1] + 0.5*(colat[k]-colat[k-1])*$
        (bar[n,k-1]*r[n]^2*SIN(colat[k-1]) + bar[n,k]*r[n]^2*SIN(colat[k]))
    ENDFOR

    FOR k = 0, ni-1 DO BEGIN
      FOR n =  nn-2, 0, -1 DO BEGIN
        psi[n,k] = psi[n+1,k] - 0.5*(r[n+1]-r[n])*$
          (bat[n,k]*r[n]*SIN(colat[k]) + bat[n+1,k]*r[n+1]*SIN(colat[k]))
      ENDFOR
    ENDFOR

    nlevels=500
    levpsi=minpsi+(maxpsi-minpsi)*findgen(nlevels)/(nlevels-1.)
    levr=minr+(maxr-minr)*findgen(nlevels)/(nlevels-1.)
    levt=mint+(maxt-mint)*findgen(nlevels)/(nlevels-1.)
    levp=minp+(maxp-minp)*findgen(nlevels)/(nlevels-1.)


; Colored contour plot of the poloidal field 
    set_plot, 'ps'
    myfile1="poloidal"+string(m,FORMAT='(I4.4)')
    device,filename=myfile1+".eps",$
         /encapsulated,/color,xsize=10, ysize=15,/inches
    loadct, 39
    polar_contour2, transpose(psi), colatitude, rad,$
         BACKGROUND=255, COLOR=0, /FILL, LEVELS=levpsi, $
         TITLE= 'Poloidal Field ('+string(maxpsi)+', '+string(minpsi)+')', $
         CHARSIZE=1.5, XRANGE=[0,50], YRANGE=[-50,50], /ISOTROPIC, $
         XTITLE='emfdat'+string(m,FORMAT='(I4.4)')
    polar_contour2, blankp, colatitude, radb, $
          /CELL_FILL, NLEVEL=1, /OVERPLOT
;    COLORBAR, COLOR=0, DIVISIONS=4, FORMAT='(I6)', $
;         POSITION=[0.78, 0.08, 0.83, 0.96], /VERTICAL, /RIGHT,  $
;         CHARSIZE=1.25, MAX=maxpsi, MIN=minpsi

;; Plot of the poloidal field lines
;    device,/close
;    set_plot, 'ps'
;    myfile2="poloidall"+string(m,FORMAT='(I4.4)')
;    device,filename=myfile2+".eps",$
;         /encapsulated,/color,xsize=10, ysize=15,/inches
;
;    loadct, 39
;    polar_contour2, transpose(psi), colatitude, rad,$
;         BACKGROUND=255, COLOR=0, C_COLOR=0, $
;         TITLE='Poloidal Field', $
;         NLEVELS=20, C_THICK=1.5, CHARSIZE=1.5, XRANGE=[0,50], $
;         YRANGE=[-50,50], /ISOTROPIC, $
;         XTITLE='emfdat'+string(m,FORMAT='(I4.4)')
;    polar_contour2, blankp, colatitude, radb, $
;         /CELL_FILL, NLEVEL=1, /OVERPLOT

; Colored contour plot of b_r averaged in longitude
    device,/close
    set_plot, 'ps'
    myfile3="br"+string(m,FORMAT='(I4.4)')
    device,filename=myfile3+".eps",$
         /encapsulated,/color,xsize=10, ysize=15,/inches

    loadct, 39
    polar_contour2, transpose(bar), colatitude, rad,$
         BACKGROUND=255, COLOR=0, /FILL, LEVELS=levr, $
         TITLE= 'B_r ('+string(maxr)+', '+string(minr)+')', $
         CHARSIZE=1.5, XRANGE=[0,50], YRANGE=[-50,50], /ISOTROPIC, $
         XTITLE='emfdat'+string(m,FORMAT='(I4.4)')
    polar_contour2, blankr, colatitude, radb, $
          /CELL_FILL, NLEVEL=1, /OVERPLOT
;    COLORBAR, COLOR=0, DIVISIONS=4, FORMAT='(I6)', $
;         POSITION=[0.78, 0.08, 0.83, 0.96], /VERTICAL, /RIGHT,  $
;         CHARSIZE=1.25, MAX=maxr, MIN=minr

; Colored contour plot of b_theta averaged in longitude
    device,/close
    set_plot, 'ps'
    myfile4="btheta"+string(m,FORMAT='(I4.4)')
    device,filename=myfile4+".eps",$
         /encapsulated,/color,xsize=10, ysize=15,/inches

    loadct, 39
    polar_contour2, transpose(bat), colatitude, rad,$
         BACKGROUND=255, COLOR=0, /FILL, LEVELS=levt, $
         TITLE= 'B_theta ('+string(maxt)+', '+string(mint)+')', $
         CHARSIZE=1.5, XRANGE=[0,50], YRANGE=[-50,50], /ISOTROPIC, $
         XTITLE='emfdat'+string(m,FORMAT='(I4.4)')
    polar_contour2, blankt, colatitude, radb, $
          /CELL_FILL, NLEVEL=1, /OVERPLOT
;    COLORBAR, COLOR=0, DIVISIONS=4, FORMAT='(I6)', $
;         POSITION=[0.78, 0.08, 0.83, 0.96], /VERTICAL, /RIGHT,  $
;         CHARSIZE=1.25, MAX=maxt, MIN=mint

;; Colored contour plot of b_phi averaged in longitude
;    device,/close
;    set_plot, 'ps'
;    myfile5="bphi"+string(m,FORMAT='(I4.4)')
;    device,filename=myfile5+".eps",$
;         /encapsulated,/color,xsize=10, ysize=15,/inches
;
;    loadct, 39
;    polar_contour2, transpose(bap), colatitude, rad,$
;         BACKGROUND=255, COLOR=0, /FILL, LEVELS=levp, $
;         TITLE= 'B_phi ('+string(maxp)+', '+string(minp)+')', $
;         CHARSIZE=1.5, XRANGE=[0,50], YRANGE=[-50,50], /ISOTROPIC, $
;         XTITLE='emfdat'+string(m,FORMAT='(I4.4)')
;    polar_contour2, blankpa, colatitude, radb, $
;          /CELL_FILL, NLEVEL=1, /OVERPLOT
;;    COLORBAR, COLOR=0, DIVISIONS=4, FORMAT='(I6)', $
;;         POSITION=[0.78, 0.08, 0.83, 0.96], /VERTICAL, /RIGHT,  $
;;         CHARSIZE=1.25, MAX=maxp, MIN=minp
;
    device,/close
    cmd1 = 'convert '+myfile1+'.eps '+myfile1+'.ppm'
;    cmd2 = 'convert '+myfile2+'.eps '+myfile2+'.ppm'
    cmd3 = 'convert '+myfile3+'.eps '+myfile3+'.ppm'
    cmd4 = 'convert '+myfile4+'.eps '+myfile4+'.ppm'
;    cmd5 = 'convert '+myfile5+'.eps '+myfile5+'.ppm'
    spawn, cmd1
;    spawn, cmd2
    spawn, cmd3
    spawn, cmd4
;    spawn, cmd5
    spawn, 'rm *.eps'
    set_plot,'x'

  ENDFOR
END
