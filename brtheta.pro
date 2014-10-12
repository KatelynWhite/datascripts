;last updated 3/21/2012
;  Code to make:
; (1) Colored contour of the time averaged radial magnetic field
;     averaged in longitude
; (2) Colored contour of the time averaged colatitudinal magnetic field 
;     averaged in longitude
; (3) Colored contour of the time averaged longitudinal magnetic field
;     averaged in longitude
; and to sava this data in .dat files
; 
; This code reads in emfdat000 and creates snapshots to the screen
;   The emfdat data is stored in the following manner:
;   u_r, u_theta, u_phi, b_r, b_theta, b_phi
;
;  This code uses the colorbar.pro code not written by me
;
;  This code uses polar_contour2.pro code which was a code slightly modified by me

PRO brtheta,nn=nni,ni=ni,nj=nj
  COMPILE_OPT IDL2

; Graphic resolution:
  nn=81
  ni=101
  nj=201
  radtop=50.D
  radbot=10.D

; Prompts the reader for the starting and ending file
  start=0
  finish=0
  PRINT, 'What is the starting number?'
  READ, start
  PRINT, 'What is the ending number?'
  READ, finish

; Initial conditions
  r=dblarr(nn)
  colat=dblarr(ni)
  br=dblarr(nn,ni)
  btheta=dblarr(nn,ni)
  bphi=dblarr(nn,ni)
  meanbr=dblarr(nn,ni)
  meanbtheta=dblarr(nn,ni)
  meanbphi=dblarr(nn,ni)

; Setting the radius and colatitude levels
  FOR n = 0, nn-1 DO BEGIN
    r[n] = radtop - (radtop-radbot)*float(n)/float(nn-1)
  ENDFOR

  FOR k = 0, ni-1 DO BEGIN
    colat[k] = !PI * float(k)/float(ni-1)
  ENDFOR

; This loop is finding the mean b_r, b_theta, b_phi
  FOR m=start, finish DO BEGIN

    readfile='emfdat'+string(m,FORMAT='(I4.4)')

    a=assoc(1,dblarr(6,nn,ni,nj))
    close,1 & openr,1,readfile
    data=a[0]
    close,1

    FOR n=0,nn-1 DO BEGIN
        FOR k=0,ni-1 DO BEGIN
            tempr=0.
            temptheta=0.
            tempphi=0.
            FOR g=0,nj-1 DO BEGIN
                tempr=tempr+data[3,n,k,g]
                temptheta=temptheta+data[4,n,k,g]
                tempphi=tempphi+data[5,n,k,g]
            ENDFOR
           tempr=tempr/(nj)
           temptheta=temptheta/(nj)
           tempphi=tempphi/(nj)
           br[n,k]=tempr
           btheta[n,k]=temptheta
           bphi[n,k]=tempphi
        ENDFOR
    ENDFOR
    meanbr=meanbr+br
    meanbtheta=meanbtheta+btheta
    meanbphi=meanbphi+bphi
  ENDFOR

  meanbr=meanbr/(finish-start+1)
  meanbtheta=meanbtheta/(finish-start+1)
  meanbphi=meanbphi/(finish-start+1)

; Writes the b_r data to the file br.dat
  OPENW, 2, 'br.dat'
  WRITEU, 2, meanbr
  CLOSE, 2

; Writes the b_theta data to the file btheta.dat
  OPENW, 3, 'btheta.dat'
  WRITEU, 3, meanbtheta
  CLOSE, 3

; Writes the b_phi data to the file bphi.dat
  OPENW, 4, 'bphi.dat'
  WRITEU, 4, meanbphi
  CLOSE, 4

; Making the inner core white
  blankr=dblarr(ni,radbot)
  blankr[*]=MAX(meanbr)
  blankt=dblarr(ni,radbot)
  blankt[*]=MAX(meanbtheta)
  blankp=dblarr(ni,radbot)
  blankp[*]=MAX(meanbphi)

; Converting from cartesian to polar
  colatitude=findgen(ni)/float(ni-1)*!PI
  rad=radtop-(radtop-radbot)*findgen(nn)/float(nn-1)
  radb=radbot-float(radbot)*findgen(radbot)/(float(radbot)-1.)


; Colored contour plot of time averaged b_r averaged in longitude  
  window, 1, XSIZE=750, YSIZE=750
  loadct, 39
  device, decompose=0
  polar_contour2, transpose(meanbr), colatitude, rad,$
       BACKGROUND=255, COLOR=0, /FILL, NLEVELS=500, /ISOTROPIC, $
       TITLE= 'Time averaged Br averaged over longitude', $
       CHARSIZE=1.5, XRANGE=[0,50], YRANGE=[-50,50], YSTYLE=1
  polar_contour2, blankr, colatitude, radb, $
        /CELL_FILL, NLEVEL=1, /OVERPLOT
  COLORBAR, COLOR=0, DIVISIONS=4, FORMAT='(I7)', $
       POSITION=[0.60, 0.08, 0.64, 0.96], /VERTICAL, /RIGHT,  $
       CHARSIZE=1.25, MAX=MAX(meanbr), MIN=MIN(meanbr) 

; Colored contour plot of time averaged b_theta averaged in longitude
  window, 2, XSIZE=750, YSIZE=750
  loadct, 39
  device, decompose=0
  polar_contour2, transpose(meanbtheta), colatitude, rad,$
       BACKGROUND=255, COLOR=0, /FILL, NLEVELS=500, /ISOTROPIC,$ 
       TITLE= 'Time averaged Btheta averaged over longitude', $
       CHARSIZE=1.5, XRANGE=[0,50], YRANGE=[-50,50], YSTYLE=1
  polar_contour2, blankt, colatitude, radb, $
        /CELL_FILL, NLEVEL=1, /OVERPLOT
  COLORBAR, COLOR=0, DIVISIONS=4, FORMAT='(I7)', $
       POSITION=[0.60, 0.08, 0.64, 0.96], /VERTICAL, /RIGHT,  $
       CHARSIZE=1.25, MAX=MAX(meanbtheta), MIN=MIN(meanbtheta) 

; Colored contour plot of time averaged b_phi averaged in longitude
  window, 3, XSIZE=750, YSIZE=750
  loadct, 39
  device, decompose=0
  polar_contour2, transpose(meanbphi), colatitude, rad,$
       BACKGROUND=255, COLOR=0, /FILL, NLEVELS=500, /ISOTROPIC,$ 
       TITLE= 'Time averaged Bphi averaged over longitude', $
       CHARSIZE=1.5, XRANGE=[0,50], YRANGE=[-50,50], YSTYLE=1
  polar_contour2, blankp, colatitude, radb, $
        /CELL_FILL, NLEVEL=1, /OVERPLOT
  COLORBAR, COLOR=0, DIVISIONS=4, FORMAT='(I7)', $
       POSITION=[0.60, 0.08, 0.64, 0.96], /VERTICAL, /RIGHT,  $
       CHARSIZE=1.25, MAX=MAX(meanbphi), MIN=MIN(meanbphi)

END
