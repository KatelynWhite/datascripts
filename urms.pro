;last updated 6/9/2013
;  This code is to create a polar image for the absolute value of 
;    ur and utheta for m>0 averaged  over several files
;    and also writes the rms information to the files 
;    urrmsplt.dat, uthetarmsplt.dat, uphirmsplt.dat
;
;  This code uses the colorbar.pro code not written by me
;
;  This code uses polar_contour2.pro code which was a code slightly modified by me
;

PRO urms,nn=nni,ni=ni,nj=nj
  COMPILE_OPT IDL2

;Graphic resolution:
  nn=81
  ni=101
  nj=201

; Radius of the outter and inner core
  radtop=50.D
  radbot=10.D

; Prompts user for the starting and ending files
  start=0
  finish=0
  PRINT, 'What is the starting number?'
  READ, start
  PRINT, 'What is the ending number?'
  READ, finish

; Initial Conditions
  r=dblarr(nn)
  colat=dblarr(ni)
  ur=dblarr(nn,ni)
  utheta=dblarr(nn,ni)
  uphi=dblarr(nn,ni)
  meanur=dblarr(nn,ni)
  meanutheta=dblarr(nn,ni)
  meanuphi=dblarr(nn,ni)

  data=dblarr(6,nn,ni,nj)
  data1=dblarr(6,nn,ni,nj)
  data2=dblarr(6,nn,ni,nj)

; Setting the radius and colatitude levels
  FOR n = 0, nn-1 DO BEGIN
    r[n] = radtop - (radtop-radbot)*float(n)/float(nn-1)
  ENDFOR

  FOR k = 0, ni-1 DO BEGIN
    colat[k] = !PI * float(k)/float(ni-1)
  ENDFOR

; This loop is finding the rms for u_r, u_theta and u_phi
  FOR m=start, finish DO BEGIN
  print, m

    readfile1='mall/emfdat'+string(m,FORMAT='(I4.4)')
    readfile2='m00/sphdat00'+string(m,FORMAT='(I4.4)')

    a=assoc(1,dblarr(6,nn,ni,nj))
    close,1 & openr,1,readfile1
    data1=a[0]
    close,1

    a=assoc(1,dblarr(6,nn,ni,nj))
    close,1 & openr,1,readfile2
    data2=a[0]
    close,1

    data=data1-data2

    tempr=0.
    temptheta=0.
    tempphi=0.
    FOR g=0,nj-1 DO BEGIN
        tempr=tempr+data[0,*,*,g]^2
        temptheta=temptheta+data[1,*,*,g]^2
        tempphi=tempphi+data[2,*,*,g]^2
    ENDFOR
    tempr=SQRT(tempr/(nj))
    temptheta=SQRT(temptheta/(nj))
    tempphi=SQRT(tempphi/(nj))
;    tempr=tempr/(nj)
;    temptheta=temptheta/(nj)
;    tempphi=tempphi/(nj)

    meanur=meanur+tempr
    meanutheta=meanutheta+temptheta
    meanuphi=meanuphi+tempphi
  ENDFOR

  meanur=meanur/(finish-start+1)
  meanutheta=meanutheta/(finish-start+1)
  meanuphi=meanuphi/(finish-start+1)
;  meanur=SQRT(meanur/(finish-start+1))
;  meanutheta=SQRT(meanutheta/(finish-start+1))
;  meanuphi=SQRT(meanuphi/(finish-start+1))

; Writes the u_r rms data to the file urrmsplt.dat
  OPENW, 2, 'urrmsplt.dat'
  WRITEU, 2, meanur
  CLOSE, 2  

; Writes the u_theta rms data to the file uthetarmsplt.dat
  OPENW, 3, 'uthetarmsplt.dat'
  WRITEU, 3, meanutheta
  CLOSE, 3

; Writes the u_phi rms data to the file uphirmsplt.dat
  OPENW, 4, 'uphirmsplt.dat'
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

; Creates the colored contour for the mean emf
  window, 0, XSIZE=750, YSIZE=750
  loadct, 39
  device, decompose=0
  Polar_Contour2, transpose(meanur), colatitude, $
        rad, /FILL, NLEVELS=500, /ISOTROPIC,$
        TITLE= 'rms ur', BACKGROUND=255, COLOR=0, CHARSIZE=1.5,$
        XRANGE=[0,50], YRANGE=[-50,50], YSTYLE=1
;       XTITLE='radius', YTITLE='colatitude', YRANGE=[ni-1,0]
  polar_contour2, blankr, colatitude, radb, $
        /CELL_FILL, NLEVEL=1, /OVERPLOT
  COLORBAR, COLOR=0, DIVISIONS=4, FORMAT='(I6)', $
       POSITION=[0.60, 0.08, 0.64, 0.96], /VERTICAL, /RIGHT,  $
       CHARSIZE=1.25, MAX=MAX(meanur), MIN=MIN(meanur)

  window, 1, XSIZE=750, YSIZE=750
  loadct, 39
  device, decompose=0
  Polar_Contour2, transpose(meanutheta), colatitude, $
        rad, /FILL, NLEVELS=500,/ISOTROPIC,$
        TITLE= 'rms utheta', BACKGROUND=255, COLOR=0, CHARSIZE=1.5,$
        XRANGE=[0,50], YRANGE=[-50,50], YSTYLE=1
;       XTITLE='radius', YTITLE='colatitude', YRANGE=[ni-1,0]
  polar_contour2, blankt, colatitude, radb, $
        /CELL_FILL, NLEVEL=1, /OVERPLOT
  COLORBAR, COLOR=0, DIVISIONS=4, FORMAT='(I6)', $
       POSITION=[0.60, 0.08, 0.64, 0.96], /VERTICAL, /RIGHT,  $
       CHARSIZE=1.25, MAX=MAX(meanutheta), MIN=MIN(meanutheta)   

  window, 2, XSIZE=750, YSIZE=750
  loadct, 39
  device, decompose=0
  Polar_Contour2, transpose(meanuphi), colatitude, $
        rad, /FILL, NLEVELS=500, /ISOTROPIC,$
        TITLE= 'rms uphi', BACKGROUND=255, COLOR=0, CHARSIZE=1.5,$
        XRANGE=[0,50], YRANGE=[-50,50], YSTYLE=1
;        XTITLE='radius', YTITLE='colatitude', YRANGE=[ni-1,0]
  polar_contour2, blankp, colatitude, radb, $
        /CELL_FILL, NLEVEL=1, /OVERPLOT
  COLORBAR, COLOR=0, DIVISIONS=4, FORMAT='(I6)', $
       POSITION=[0.60, 0.08, 0.64, 0.96], /VERTICAL, /RIGHT,  $
       CHARSIZE=1.25, MAX=MAX(meanuphi), MIN=MIN(meanuphi)    
END
