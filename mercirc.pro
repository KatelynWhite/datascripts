; last updated 4/10/2014
; This code is currently written to read in one shapshot
; 
;  Code to make:
; (1) Colored contour of the velocity circulation
; (2) Contour lines of the velocity circulation
; (3) Colored contour of the radial velocity field averaged in longitude
; (4) Colored contour of the colatitudinal velocity field averaged in longitude
; (5) Colored contour of the longitudinal velocity field averaged in longitudei
; 
; This code reads in emfdat000 and creates snapshots to the screen
;   The emfdat data is stored in the following manner:
;   u_r, u_theta, u_phi, b_r, b_theta, b_phi
;
;  This code uses the colorbar.pro code not written by me
;
;  This code uses polar_contour2.pro code which was a code slightly modified by me

PRO mercirc,nn=nni,ni=ni,nj=nj
  COMPILE_OPT IDL2

; Graphic resolution:
  nn=81
  ni=101
  nj=201
  radtop=50.D
  radbot=10.D

; Prompts user for the file to be read in
  start=0
  PRINT, 'What is the file number?'
  READ, start

; Reading in the data file
  readfile='emfdat'+string(start,FORMAT='(I3.3)')

  a=assoc(1,dblarr(6,nn,ni,nj))
  close,1 & openr,1,readfile
  data=a[0]
  close,1

; Initial Conditions
  r=dblarr(nn)
  colat=dblarr(ni)
  bar=dblarr(nn,ni)
  bat=dblarr(nn,ni)
  bap=dblarr(nn,ni)


; Setting the radius and colatitude levels
  FOR n = 0, nn-1 DO BEGIN
    r[n] = radtop - (radtop-radbot)*float(n)/float(nn-1)
  ENDFOR

  FOR k = 0, ni-1 DO BEGIN
    colat[k] = !PI * float(k)/float(ni-1)
  ENDFOR

; Finding the average of u_r, u_theta, and u_phi over longitude
  FOR n = 0, nn-1 DO BEGIN
    FOR k = 0, ni-1 DO BEGIN

      bar[n,k]=MEAN(data[0,n,k,*])
      bat[n,k]=MEAN(data[1,n,k,*])
      bap[n,k]=MEAN(data[2,n,k,*])

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

; Colored contour plot of the meridional circulation
  window, 0, XSIZE=750, YSIZE=750
  loadct, 39
  device, decompose=0
  polar_contour2, transpose(psi), colatitude, rad,$
       BACKGROUND=255, COLOR=0, /FILL, NLEVELS=100, TITLE= 'Meridional Circulation', $
        CHARSIZE=1.5, XRANGE=[0,75], /ISOTROPIC
  polar_contour2, blankp, colatitude, radb, $
        /CELL_FILL, NLEVEL=1, /OVERPLOT
  COLORBAR, COLOR=0, DIVISIONS=4, FORMAT='(I6)', $
       POSITION=[0.84, 0.17, 0.88, 0.9], /VERTICAL, /RIGHT,  $
       CHARSIZE=1.25, MAX=MAX(psi), MIN=MIN(psi) 

; Plot of the poloidal field lines
  window, 1, XSIZE=1550, YSIZE=1550
  loadct, 39
  device, decompose=0
  polar_contour2, transpose(psi), colatitude, rad,$
          BACKGROUND=255, COLOR=0, C_COLOR=0, TITLE='Meridional Circulation', $
          NLEVELS=30, C_THICK=1.5, CHARSIZE=1.5, XRANGE=[0,75], /ISOTROPIC
  polar_contour2, blankp, colatitude, radb, $
        /CELL_FILL, NLEVEL=1, /OVERPLOT

; Colored contour plot of u_r averaged in longitude
  window, 2, XSIZE=750, YSIZE=750
  loadct, 39
  device, decompose=0
  polar_contour2, transpose(bar), colatitude, rad,$
       BACKGROUND=255, COLOR=0, /FILL, NLEVELS=100, $
       TITLE= 'U_r averaged in longitude', $
       CHARSIZE=1.5, XRANGE=[0,75], /ISOTROPIC
  polar_contour2, blankr, colatitude, radb, $
        /CELL_FILL, NLEVEL=1, /OVERPLOT
  COLORBAR, COLOR=0, DIVISIONS=4, FORMAT='(I6)', $
       POSITION=[0.84, 0.17, 0.88, 0.9], /VERTICAL, /RIGHT,  $
       CHARSIZE=1.25, MAX=MAX(bar), MIN=MIN(bar)

; Colored contour plot of u_theta averaged in longitude
  window, 3, XSIZE=750, YSIZE=750
  loadct, 39
  device, decompose=0
  polar_contour2, transpose(bat), colatitude, rad,$
       BACKGROUND=255, COLOR=0, /FILL, NLEVELS=100, $
       TITLE= 'U_theta averaged in longitude', $
       CHARSIZE=1.5, XRANGE=[0,75], /ISOTROPIC
  polar_contour2, blankt, colatitude, radb, $
        /CELL_FILL, NLEVEL=1, /OVERPLOT
  COLORBAR, COLOR=0, DIVISIONS=4, FORMAT='(I6)', $
       POSITION=[0.84, 0.17, 0.88, 0.9], /VERTICAL, /RIGHT,  $
       CHARSIZE=1.25, MAX=MAX(bat), MIN=MIN(bat)

; Colored contour plot of u_phi averaged in longitude
  window, 4, XSIZE=750, YSIZE=750
  loadct, 39
  device, decompose=0
  polar_contour2, transpose(bap), colatitude, rad,$
       BACKGROUND=255, COLOR=0, /FILL, NLEVELS=100, $
       TITLE= 'U_phi averaged in longitude', $
       CHARSIZE=1.5, XRANGE=[0,75], /ISOTROPIC
  polar_contour2, blankpa, colatitude, radb, $
        /CELL_FILL, NLEVEL=1, /OVERPLOT
  COLORBAR, COLOR=0, DIVISIONS=4, FORMAT='(I6)', $
       POSITION=[0.84, 0.17, 0.88, 0.9], /VERTICAL, /RIGHT,  $
       CHARSIZE=1.25, MAX=MAX(bap), MIN=MIN(bap)

END
