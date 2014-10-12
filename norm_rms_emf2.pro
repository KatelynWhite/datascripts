;  last updated 9/26/2014
;  This code is currently written to read in multiple files
; 
;  Code to make plots of the normalized rms v_r, v_theta, b_r, b_theta, 
;  v_r*b_theta, v_theta*b_r, v_r*b_theta-v_theta*b_r
; 
;  The emfdat data is stored in the following manner:
;  u_r, u_theta, u_phi, b_r, b_theta, b_phi
;
;  This code uses the colorbar.pro code not written by me
;
;  This code uses polar_contour2.pro code which was a code slightly modified by me

PRO norm_rms_emf2,nn=nni,ni=ni,nj=nj
  COMPILE_OPT IDL2

; Graphic resolution:
  nn=81
  ni=101
  nj=201

; Radius of the outter and inner core
  radtop=50.D
  radbot=10.D

; Prompts user for the file to be read in
  start=701
  finish=1160
;  PRINT, 'What is the starting number?'
;  READ, start
;  PRINT, 'What is the ending number?'
;  READ, finish

; Initial Conditions
  r=dblarr(nn)
  colat=dblarr(ni)

  rad=dblarr(nn)
  radb=dblarr(nn)
  colatitude=dblarr(nn)

  vr=dblarr(nn,ni)
  vt=dblarr(nn,ni)
  br=dblarr(nn,ni)
  bt=dblarr(nn,ni)
  vrbt=dblarr(nn,ni)
  vtbr=dblarr(nn,ni)
  emf=dblarr(nn,ni)

  normvrbt=dblarr(nn,ni)
  normvtbr=dblarr(nn,ni)
  normemf=dblarr(nn,ni)

  data=dblarr(6,nn,ni,nj)
  data0=dblarr(6,nn,ni,nj)
  data1=dblarr(6,nn,ni,nj)

; Setting the radius and colatitude levels
  FOR n = 0, nn-1 DO BEGIN
    r[n] = radtop - (radtop-radbot)*float(n)/float(nn-1)
  ENDFOR

  FOR k = 0, ni-1 DO BEGIN
    colat[k] = !PI * float(k)/float(ni-1)
  ENDFOR

; This loop is finding the mean emf (u_r*b_theta - u_theta*b_r)
  FOR m=start, finish DO BEGIN
print, m
; Reading in the data file
    readfile0='mall/emfdat'+string(m,FORMAT='(I4.4)')
    readfile1='m00/sphdat'+string(m,FORMAT='(I4.4)')

    a0=assoc(1,dblarr(6,nn,ni,nj))
    close,1 & openr,1,readfile0
    data0=a0[0]
    close,1

    a1=assoc(1,dblarr(6,nn,ni,nj))
    close,1 & openr,1,readfile1
    data1=a1[0]
    close,1

    data=data0-data1

;print, data0[0,*,30,5]
;print, data1[0,*,30,5]
;print, data[0,*,0,5]
;;;;;;;data1 and data0 are the same for v_r and b_r on [*,0,*] and [*,100,*]
array=reform(data[0,*,*,*]*data[4,*,*,*]- data[1,*,*,*]*data[3,*,*,*])^2
mx=MAX(array,I)
ind=array_indices(array,I)
print, ind, array[ind[0], ind[1], ind[2]], $
   FORMAT = '(%"Value at [%d, %d, %d] is %f")'

; Finding the average of u_r, u_theta, and u_phi over longitude
;     FOR g=0,nj-1 DO BEGIN
;        FOR k = 0, ni-1 DO BEGIN
;            tempvr=0.
;            tempvt=0.
;            tempbr=0.
;            tempbt=0.
;            tempvrbt=0.
;            tempvtbr=0.
;            tempemf=0.
;            FOR n = 0, nn-1 DO BEGIN
;                tempvr=tempvr+data[0,n,k,g]^2
;                tempvt=tempvt+data[1,n,k,g]^2
;                tempbr=tempbr+data[3,n,k,g]^2
;                tempbt=tempbt+data[4,n,k,g]^2
;                tempvrbt=tempvrbt+(data[0,n,k,g]*data[4,n,k,g])^2
;                tempvtbr=tempvtbr+(data[1,n,k,g]*data[3,n,k,g])^2
;                tempemf=tempemf+(data[0,n,k,g]*data[4,n,k,g]- $
;                        data[1,n,k,g]*data[3,n,k,g])^2
;            ENDFOR
;            vr[n,k]=sqrt(tempvr/(nj))
;            vt[n,k]=sqrt(tempvt/(nj))
;            br[n,k]=sqrt(tempbr/(nj))
;            bt[n,k]=sqrt(tempbt/(nj))
;            vrbt[n,k]=sqrt(tempvrbt/(nj))
;            vtbr[n,k]=sqrt(tempvtbr/(nj))
;            emf[n,k]=sqrt(tempemf/(nj))
;
;
;    if (vr[n,k]*bt[n,k] EQ 0) AND (vrbt[n,k] EQ 0) then normvrbt[n,k]=0 ELSE  $
;       normvrbt[n,k]=vrbt[n,k]/(vr[n,k]*bt[n,k])
;    if (vt[n,k]*br[n,k] EQ 0) AND (vtbr[n,k] EQ 0) then normvtbr[n,k]=0 ELSE  $
;       normvtbr[n,k]=vtbr[n,k]/(vt[n,k]*br[n,k])
;    if (emf[n,k] EQ 0) AND ((vr[n,k]*bt[n,k]+vt[n,k]*br[n,k]) EQ 0) then normemf[n,k]=0 ELSE  $
;;    if (emf[n,k] EQ 0) then normemf[n,k]=0 ELSE  $
;       normemf[n,k]=emf[n,k]/(vr[n,k]*bt[n,k]+vt[n,k]*br[n,k])
;        ENDFOR
;    ENDFOR

; have nan's so need to make sure I remove those. 
;    normvtbr=vtbr/(vt*br)
;print, normemf

;; Making the inner core white
;    blankvr=dblarr(ni,radbot)
;    blankvr[*]=MAX(normvrbt)
;    blankvt=dblarr(ni,radbot)
;    blankvt[*]=MAX(normvtbr)
;    blankemf=dblarr(ni,radbot)
;    blankemf[*]=MAX(normemf)

;; Converting from cartesian to polar
;    colatitude=findgen(ni)/float(ni-1)*!PI
;    rad=radtop-(radtop-radbot)*findgen(nn)/float(nn-1)
;    radb=radbot-float(radbot)*findgen(radbot)/(float(radbot)-1.)
;
;; Creates the colored contour for the normalized v_r*b_theta
;  window, 0, XSIZE=700, YSIZE=750
;  ctload, 3, /reverse
;  device, decompose=0
;  Polar_Contour2, transpose(normvrbt), colatitude, $
;        rad, /FILL, NLEVELS=100,$
;        TITLE= '||V_r*B_t||', BACKGROUND=0, COLOR=255, CHARSIZE=1.5,$
;        XRANGE=[0,50], YRANGE=[-50,50], /ISOTROPIC, YSTYLE=1, XSTYLE=1
;;       XTITLE='radius', YTITLE='colatitude', YRANGE=[ni-1,0]
;  polar_contour2, blankvr, colatitude, radb, $
;        /CELL_FILL, NLEVEL=1, /OVERPLOT, color=0
;;  COLORBAR, COLOR=0, DIVISIONS=4, FORMAT='(I6)', $
;;       POSITION=[0.84, 0.17, 0.88, 0.9], /VERTICAL, /RIGHT,  $
;;       CHARSIZE=1.25, MAX=MAX(normvrbt), MIN=MIN(normvrbt)
;
;; Creates the colored contour for the normalized v_theta*b_r
;  window, 1, XSIZE=500, YSIZE=750
;  ctload, 3, /reverse
;  device, decompose=0
;  Polar_Contour2, transpose(normvtbr), colatitude, $
;        rad, /FILL, NLEVELS=500,$
;        TITLE= '||V_theta*B_r||', BACKGROUND=0, COLOR=255, CHARSIZE=1.5,$
;        XRANGE=[0,50], YRANGE=[-50,50], /ISOTROPIC, YSTYLE=1, XSTYLE=1
;;       XTITLE='radius', YTITLE='colatitude', YRANGE=[ni-1,0]
;  polar_contour2, blankvt, colatitude, radb, $
;        /CELL_FILL, NLEVEL=1, /OVERPLOT, color=0
;;  COLORBAR, COLOR=0, DIVISIONS=4, FORMAT='(I6)', $
;;       POSITION=[0.84, 0.17, 0.88, 0.9], /VERTICAL, /RIGHT,  $
;;       CHARSIZE=1.25, MAX=MAX(normvtbr), MIN=MIN(normvtbr)
;
;; Creates the colored contour for the normalized emf
;  window, 2, XSIZE=500, YSIZE=750
;  ctload, 3, /reverse
;  device, decompose=0
;  Polar_Contour2, transpose(normemf), colatitude, $
;        rad, /FILL, NLEVELS=100,$
;        TITLE= '||emf||', BACKGROUND=0, COLOR=255, CHARSIZE=1.5,$
;        XRANGE=[0,50], YRANGE=[-50,50], /ISOTROPIC, YSTYLE=1, XSTYLE=1
;;       XTITLE='radius', YTITLE='colatitude', YRANGE=[ni-1,0]
;  polar_contour2, blankemf, colatitude, radb, $
;        /CELL_FILL, NLEVEL=1, /OVERPLOT, color=0
;;  COLORBAR, COLOR=0, DIVISIONS=4, FORMAT='(I6)', $
;;       POSITION=[0.84, 0.17, 0.88, 0.9], /VERTICAL, /RIGHT,  $
;;       CHARSIZE=1.25, MAX=MAX(normemf), MIN=MIN(normemf)
;
;  urbtfile='norm_urbt'+string(m,FORMAT='(I4.4)')
;  utbrfile='norm_utbr'+string(m,FORMAT='(I4.4)')
;  emffile='norm_emf'+string(m,FORMAT='(I4.4)')
;
;  set_plot, 'ps'
;  device,filename=urbtfile+'.eps',$
;        /encapsulated,/color,xsize=10, ysize=15,/inches
;  ctload, 3, /reverse
;  polar_contour2, transpose(normvrbt), colatitude, rad, $
;         BACKGROUND=0, COLOR=255, /FILL, NLEVELS=500, $
;         TITLE= '||V_r*B_theta||', $
;         CHARSIZE=1.5, XRANGE=[0,50], YRANGE=[-50,50], /ISOTROPIC, $
;         XTITLE=string(m,FORMAT='(I4.4)'), YSTYLE=1
;  polar_contour2, blankvr, colatitude, radb, $
;         /CELL_FILL, NLEVEL=1, /OVERPLOT, color=0
;
;  set_plot, 'ps'
;  device,filename=utbrfile+".eps",$
;        /encapsulated,/color,xsize=10, ysize=15,/inches
;  ctload, 3, /reverse
;  polar_contour2, transpose(normvtbr), colatitude, rad,$
;         BACKGROUND=0, COLOR=255, /FILL, NLEVELS=500, $
;         TITLE= '||V_theta*B_r||', $
;         CHARSIZE=1.5, XRANGE=[0,50], YRANGE=[-50,50], /ISOTROPIC, $
;         XTITLE=string(m,FORMAT='(I4.4)'), YSTYLE=1
;  polar_contour2, blankvt, colatitude, radb, $
;         /CELL_FILL, NLEVEL=1, /OVERPLOT, color=0
;
;  set_plot, 'ps'
;  device,filename=emffile+".eps",$
;        /encapsulated,/color,xsize=10, ysize=15,/inches
;  ctload, 3, /reverse
;  polar_contour2, transpose(normemf), colatitude, rad,$
;         BACKGROUND=0, COLOR=255, /FILL, NLEVELS=500, $
;         TITLE= '||emf||', $
;         CHARSIZE=1.5, XRANGE=[0,50], YRANGE=[-50,50], /ISOTROPIC, $
;         XTITLE=string(m,FORMAT='(I4.4)'), YSTYLE=1
;  polar_contour2, blankemf, colatitude, radb, $
;         /CELL_FILL, NLEVEL=1, /OVERPLOT, color=0
;
;    device,/close
;    cmd1 = 'convert '+urbtfile+'.eps '+urbtfile+'.ppm'
;    cmd3 = 'convert '+utbrfile+'.eps '+utbrfile+'.ppm'
;    cmd4 = 'convert '+emffile+'.eps '+emffile+'.ppm'
;    spawn, cmd1
;    spawn, cmd3
;    spawn, cmd4
;;;    spawn, 'rm *.eps'
;    set_plot,'x'

  ENDFOR

END

norm_rms_emf2
end

