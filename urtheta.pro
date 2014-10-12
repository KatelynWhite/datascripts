;last updated 6/9/2013
;  Code to make:
; (1) Colored contour of the time averaged radial velocity field
;     averaged in longitude
; (2) Colored contour of the time averaged colatitudinal velocity field 
;     averaged in longitude
; (3) Colored contour of the time averaged longitudinal velocity field
;     averaged in longitude
; and stores these values to .dat files
; 
; This code reads in emfdat000 and creates snapshots to the screen
;   The emfdat data is stored in the following manner:
;   u_r, u_theta, u_phi, b_r, b_theta, b_phi
;
;  This code uses the colorbar.pro code not written by me
;
;  This code uses polar_contour2.pro code which was a code slightly modified by me

PRO urtheta,nn=nni,ni=ni,nj=nj
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
  meanur=dblarr(nn,ni)
  meanutheta=dblarr(nn,ni)
  meanuphi=dblarr(nn,ni)

; Setting the radius and colatitude levels
  FOR n = 0, nn-1 DO BEGIN
    r[n] = radtop - (radtop-radbot)*float(n)/float(nn-1)
  ENDFOR

  FOR k = 0, ni-1 DO BEGIN
    colat[k] = !PI * float(k)/float(ni-1)
  ENDFOR

; This loop is finding the mean u_r, u_theta, u_phi
  FOR m=start, finish DO BEGIN

  print, m

    readfile='emfdat'+string(m,FORMAT='(I4.4)')

    a=assoc(1,dblarr(6,nn,ni,nj))
    close,1 & openr,1,readfile
    data=a[0]
    close,1

    tempr=dblarr(nn,ni)
    temptheta=dblarr(nn,ni)
    tempphi=dblarr(nn,ni)
    FOR g=0,nj-1 DO BEGIN
        tempr=tempr+data[0,*,*,g]
        temptheta=temptheta+data[1,*,*,g]
        tempphi=tempphi+data[2,*,*,g]
    ENDFOR
    tempr=tempr/(nj)
    temptheta=temptheta/(nj)
    tempphi=tempphi/(nj)

    meanur=meanur+tempr
    meanutheta=meanutheta+temptheta
    meanuphi=meanuphi+tempphi
  ENDFOR

  meanur=meanur/(finish-start+1)
  meanutheta=meanutheta/(finish-start+1)
  meanuphi=meanuphi/(finish-start+1)

; Writes the u_r data to the file ur.dat
  OPENW, 2, 'ur.dat'
  WRITEU, 2, meanur
  CLOSE, 2

; Writes the u_theta data to the file utheta.dat
  OPENW, 3, 'utheta.dat'
  WRITEU, 3, meanutheta
  CLOSE, 3

; Writes the u_phi data to the file uphi.dat
  OPENW, 4, 'uphi.dat'
  WRITEU, 4, meanuphi
  CLOSE, 4

; Making the inner core white
  blankr=dblarr(ni,radbot)
  blankr[*]=MAX(meanur)
  blankt=dblarr(ni,radbot)
  blankt[*]=MAX(meanutheta)
  blankp=dblarr(ni,radbot)
  blankp[*]=MAX(meanuphi)

; Converting from cartesian to polar
  colatitude=findgen(ni)/float(ni-1)*!PI
  rad=radtop-(radtop-radbot)*findgen(nn)/float(nn-1)
  radb=radbot-float(radbot)*findgen(radbot)/(float(radbot)-1.)


; Colored contour plot of time averaged u_r averaged in longitude  
  window, 0, XSIZE=750, YSIZE=750
  loadct, 39
  device, decompose=0
  polar_contour2, transpose(meanur), colatitude, rad,$
       BACKGROUND=255, COLOR=0, /FILL, NLEVELS=500, /ISOTROPIC,$
       TITLE= 'Time averaged u_r averaged over longitude', $
       CHARSIZE=1.5, XRANGE=[0,50], YRANGE=[-50,50], YSTYLE=1
  polar_contour2, blankr, colatitude, radb, $
        /CELL_FILL, NLEVEL=1, /OVERPLOT
  COLORBAR, COLOR=0, DIVISIONS=4, FORMAT='(I7)', $
       POSITION=[0.60, 0.08, 0.64, 0.96], /VERTICAL, /RIGHT,  $
       CHARSIZE=1.25, MAX=MAX(meanur), MIN=MIN(meanur) 

; Colored contour plot of time averaged u_theta averaged in longitude
  window, 2, XSIZE=750, YSIZE=750
  loadct, 39
  device, decompose=0
  polar_contour2, transpose(meanutheta), colatitude, rad,$
       BACKGROUND=255, COLOR=0, /FILL, NLEVELS=500, /ISOTROPIC,$ 
       TITLE= 'Time averaged u_theta averaged over longitude', $
       CHARSIZE=1.5, XRANGE=[0,50], YRANGE=[-50,50], YSTYLE=1
  polar_contour2, blankt, colatitude, radb, $
        /CELL_FILL, NLEVEL=1, /OVERPLOT
  COLORBAR, COLOR=0, DIVISIONS=4, FORMAT='(I7)', $
       POSITION=[0.60, 0.08, 0.64, 0.96], /VERTICAL, /RIGHT,  $
       CHARSIZE=1.25, MAX=MAX(meanutheta), MIN=MIN(meanutheta) 

; Colored contour plot of time averaged u_phi averaged in longitude
  window, 3, XSIZE=750, YSIZE=750
  loadct, 39
  device, decompose=0
  polar_contour2, transpose(meanuphi), colatitude, rad,$
       BACKGROUND=255, COLOR=0, /FILL, NLEVELS=500, /ISOTROPIC,$ 
       TITLE= 'Time averaged u_phi averaged over longitude', $
       CHARSIZE=1.5, XRANGE=[0,50], YRANGE=[-50,50], YSTYLE=1
  polar_contour2, blankp, colatitude, radb, $
        /CELL_FILL, NLEVEL=1, /OVERPLOT
  COLORBAR, COLOR=0, DIVISIONS=4, FORMAT='(I7)', $
       POSITION=[0.60, 0.08, 0.64, 0.96], /VERTICAL, /RIGHT,  $
       CHARSIZE=1.25, MAX=MAX(meanuphi), MIN=MIN(meanuphi)

END
