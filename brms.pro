;last updated 6/10/2013
;  This code is to create a polar image for the absolute value of 
;    ur and utheta for m>0 averaged  over several files
;    and also writes the rms information to the files 
;    urrmsplt.dat, uthetarmsplt.dat, uphirmsplt.dat
;
;  This code uses the colorbar.pro code not written by me
;
;  This code uses polar_contour2.pro code which was a code slightly modified by me
;

PRO brms,nn=nni,ni=ni,nj=nj
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
  br=dblarr(nn,ni)
  btheta=dblarr(nn,ni)
  bphi=dblarr(nn,ni)
  meanbr=dblarr(nn,ni)
  meanbtheta=dblarr(nn,ni)
  meanbphi=dblarr(nn,ni)

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
        tempr=tempr+data[3,*,*,g]^2
        temptheta=temptheta+data[4,*,*,g]^2
        tempphi=tempphi+data[5,*,*,g]^2
    ENDFOR
    tempr=SQRT(tempr/(nj))
    temptheta=SQRT(temptheta/(nj))
    tempphi=SQRT(tempphi/(nj))

    meanbr=meanbr+tempr
    meanbtheta=meanbtheta+temptheta
    meanbphi=meanbphi+tempphi
  ENDFOR

  meanbr=meanbr/(finish-start+1)
  meanbtheta=meanbtheta/(finish-start+1)
  meanbphi=meanbphi/(finish-start+1)

; Writes the b_r rms data to the file urrmsplt.dat
  OPENW, 2, 'brrmsplt.dat'
  WRITEU, 2, meanbr
  CLOSE, 2  

; Writes the b_theta rms data to the file uthetarmsplt.dat
  OPENW, 3, 'bthetarmsplt.dat'
  WRITEU, 3, meanbtheta
  CLOSE, 3

; Writes the b_phi rms data to the file uphirmsplt.dat
  OPENW, 4, 'bphirmsplt.dat'
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

; Creates the colored contour for the mean emf
  window, 0, XSIZE=750, YSIZE=750
  loadct, 39
  device, decompose=0
  Polar_Contour2, transpose(meanbr), colatitude, $
        rad, /FILL, NLEVELS=500, /ISOTROPIC,$
        TITLE= 'rms br', BACKGROUND=255, COLOR=0, CHARSIZE=1.5,$
        XRANGE=[0,50], YRANGE=[-50,50], YSTYLE=1
;       XTITLE='radius', YTITLE='colatitude', YRANGE=[ni-1,0]
  polar_contour2, blankr, colatitude, radb, $
        /CELL_FILL, NLEVEL=1, /OVERPLOT
  COLORBAR, COLOR=0, DIVISIONS=4, FORMAT='(I6)', $
       POSITION=[0.60, 0.08, 0.64, 0.96], /VERTICAL, /RIGHT,  $
       CHARSIZE=1.25, MAX=MAX(meanbr), MIN=MIN(meanbr)

  window, 1, XSIZE=750, YSIZE=750
  loadct, 39
  device, decompose=0
  Polar_Contour2, transpose(meanbtheta), colatitude, $
        rad, /FILL, NLEVELS=500,/ISOTROPIC,$
        TITLE= 'rms btheta', BACKGROUND=255, COLOR=0, CHARSIZE=1.5,$
        XRANGE=[0,50], YRANGE=[-50,50], YSTYLE=1
;       XTITLE='radius', YTITLE='colatitude', YRANGE=[ni-1,0]
  polar_contour2, blankt, colatitude, radb, $
        /CELL_FILL, NLEVEL=1, /OVERPLOT
  COLORBAR, COLOR=0, DIVISIONS=4, FORMAT='(I6)', $
       POSITION=[0.60, 0.08, 0.64, 0.96], /VERTICAL, /RIGHT,  $
       CHARSIZE=1.25, MAX=MAX(meanbtheta), MIN=MIN(meanbtheta)   

  window, 2, XSIZE=750, YSIZE=750
  loadct, 39
  device, decompose=0
  Polar_Contour2, transpose(meanbphi), colatitude, $
        rad, /FILL, NLEVELS=500, /ISOTROPIC,$
        TITLE= 'rms bphi', BACKGROUND=255, COLOR=0, CHARSIZE=1.5,$
        XRANGE=[0,50], YRANGE=[-50,50], YSTYLE=1
;        XTITLE='radius', YTITLE='colatitude', YRANGE=[ni-1,0]
  polar_contour2, blankp, colatitude, radb, $
        /CELL_FILL, NLEVEL=1, /OVERPLOT
  COLORBAR, COLOR=0, DIVISIONS=4, FORMAT='(I6)', $
       POSITION=[0.60, 0.08, 0.64, 0.96], /VERTICAL, /RIGHT,  $
       CHARSIZE=1.25, MAX=MAX(meanbphi), MIN=MIN(meanbphi)    
END
