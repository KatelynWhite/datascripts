; last updated 3/6/2013
; 
;  Code to read in data in tangent cylinders of the data:
; (1) Colored contour of the Poloidal fields
; (2) Colored contour of the radial magnetic field averaged in longitude
; (3) Colored contour of the colatitudinal magnetic field averaged in longitude
; (4) Colored contour of the longitudinal magnetic field averaged in longitudei
; 
; This code reads in emfdat000 and creates snapshots to the screen
;   The emfdat data is stored in the following manner:
;   u_r, u_theta, u_phi, b_r, b_theta, b_phi
;
;  This code uses the colorbar.pro code not written by me
;
;  This code uses polar_contour2.pro code which was a code slightly modified by me
; This code outputs cyldata which contains an array size (6, time), with the first line being the time. 
; 0 - B_r of north
; 1 - B_t of north
; 2 - psi of north
; 3 - B_r of south
; 4 - B_t of south
; 5 - psi of south


PRO tangcyl,nn=nni,ni=ni,nj=nj
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

   bs=dblarr(nn,ni)
;  maxpsi=0.
;  minpsi=0.
;  maxr=0.
;  minr=0.
;  maxt=0.
;  mint=0.
;  maxp=0.
;  minp=0.

; Setting the radius and colatitude levels
  FOR n = 0, nn-1 DO BEGIN
    r[n] = radtop - (radtop-radbot)*float(n)/float(nn-1)
  ENDFOR

  FOR k = 0, ni-1 DO BEGIN
    colat[k] = !PI * float(k)/float(ni-1)
  ENDFOR

; Converting from cartesian to polar
  colatitude=findgen(ni)/float(ni-1)*!PI
  rad=radtop-(radtop-radbot)*findgen(nn)/float(nn-1)
  radb=radbot-float(radbot)*findgen(radbot)/(float(radbot)-1.)

  compb=dblarr(6,finish-start+1)

  openw, 11, 'cyldata'

printf, 11, finish-start+1

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
 
    vert1=0.
    vert2=0.35

    brn=0.
    brs=0.
    btn=0.
    bts=0.
    psin=0.
    psis=0.
    
    FOR i= 0, ni-1 DO BEGIN
    FOR k= 0, nn-1 DO BEGIN
        cylwidth=(1-k*(1-radbot/radtop)/(nn-1))*sin(!pi*i/(ni-1))

        IF (cylwidth ge vert1) and (cylwidth le vert2) THEN BEGIN 
           bs[k,i]=1.
           bar[k,i] = bar[k,i]
           bat[k,i] = bat[k,i]
           psi[k,i] = psi[k,i]
        ENDIF ELSE BEGIN
           bar[k,i] = 0.
           bat[k,i] = 0.
           psi[k,i] = 0.
        ENDELSE

       IF (i le 50)  THEN BEGIN
           brn = brn + bar[k,i]
           btn = btn + bat[k,i]
           psin = psin + psi[k,i]
       ENDIF ELSE BEGIN
           brs = brs + bar[k,i]
           bts = bts + bat[k,i]
           psis = psis + psi[k,i]
       ENDELSE

    ENDFOR
    ENDFOR

compb[0, m-1] = brn
compb[1, m-1] = btn
compb[2, m-1] = psin
compb[3, m-1] = brs
compb[4, m-1] = bts
compb[5, m-1] = psis

printf, 11, compb[*,m-1]

  ENDFOR

; Making the inner core white
  blankp=dblarr(ni,radbot)
  blankp[*]=max(bs)
; Colored contour plot of the poloidal field 
    window, 0, xsize=500, ysize=700
    device, decomposed = 0
    loadct, 39
    polar_contour2, transpose(bs), colatitude, rad,$
         BACKGROUND=255, COLOR=0, /FILL, LEVELS=levpsi, $
         CHARSIZE=1.5, XRANGE=[0,50], YRANGE=[-50,50], /ISOTROPIC, $
         XTITLE='emfdat'+string(m,FORMAT='(I4.4)'), ystyle=1, xstyle=1
    polar_contour2, blankp, colatitude, radb, $
          /CELL_FILL, NLEVEL=1, /OVERPLOT


    close, 11

    window, 1
    device, decomposed = 0
    loadct, 39
    plot, compb[0,*]/compb[3,*], $
          TITLE='ratio of br north to south in tang cyl r=.35'

    window, 2
    device, decomposed = 0
    loadct, 39
    plot, compb[1,*]/compb[4,*], $
          TITLE='ratio of btheta north to south in tang cyl r=.35'

    window, 3
    device, decomposed = 0
    loadct, 39
    plot, compb[3,*]/compb[5,*], $
         TITLE='ratio of psi north to south in tang cyl r=.35'





END
