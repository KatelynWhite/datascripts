;last updated 6/29/2012

PRO advind
  COMPILE_OPT IDL2

; Graphic resolution:
  nn=81
  ni=101
  nj=201
  radtop=50.D
  radbot=20.D

; Initial conditions
  r=dblarr(nn)
  colat=dblarr(ni)
  lon=dblarr(nj)

  badvr=dblarr(nn,ni,nj)
  bindr=dblarr(nn,ni,nj)
  badvr1=dblarr(nn,ni,nj)
  badvr2=dblarr(nn,ni,nj)
  badvr3=dblarr(nn,ni,nj)
  bindr1=dblarr(nn,ni,nj)
  bindr2=dblarr(nn,ni,nj)
  bindr3=dblarr(nn,ni,nj)
  advr=dblarr(nn,ni,nj)
  indr=dblarr(nn,ni,nj)
  totadvr=dblarr(nn,ni)
  totindr=dblarr(nn,ni)
  totbadvr1=dblarr(nn,ni,nj)
  totbadvr2=dblarr(nn,ni,nj)
  totbadvr3=dblarr(nn,ni,nj)
  totbindr1=dblarr(nn,ni,nj)
  totbindr2=dblarr(nn,ni,nj)
  totbindr3=dblarr(nn,ni,nj)
  abadvr1=dblarr(nn,ni)
  abadvr2=dblarr(nn,ni)
  abadvr3=dblarr(nn,ni)
  abindr1=dblarr(nn,ni)
  abindr2=dblarr(nn,ni)
  abindr3=dblarr(nn,ni)
 
  badvt=dblarr(nn,ni,nj)
  bindt=dblarr(nn,ni,nj)
  badvt1=dblarr(nn,ni,nj)
  badvt2=dblarr(nn,ni,nj)
  badvt3=dblarr(nn,ni,nj)
  bindt1=dblarr(nn,ni,nj)
  bindt2=dblarr(nn,ni,nj)
  bindt3=dblarr(nn,ni,nj)
  advt=dblarr(nn,ni,nj)
  indt=dblarr(nn,ni,nj)
  totadvt=dblarr(nn,ni)
  totindt=dblarr(nn,ni)
  totbadvt1=dblarr(nn,ni,nj)
  totbadvt2=dblarr(nn,ni,nj)
  totbadvt3=dblarr(nn,ni,nj)
  totbindt1=dblarr(nn,ni,nj)
  totbindt2=dblarr(nn,ni,nj)
  totbindt3=dblarr(nn,ni,nj)
  abadvt1=dblarr(nn,ni)
  abadvt2=dblarr(nn,ni)
  abadvt3=dblarr(nn,ni)
  abindt1=dblarr(nn,ni)
  abindt2=dblarr(nn,ni)
  abindt3=dblarr(nn,ni)
;;;;;;;;;;;;;;;;;
  badvp=dblarr(nn,ni,nj)
  bindp=dblarr(nn,ni,nj)
  badvp1=dblarr(nn,ni,nj)
  badvp2=dblarr(nn,ni,nj)
  badvp3=dblarr(nn,ni,nj)
  bindp1=dblarr(nn,ni,nj)
  bindp2=dblarr(nn,ni,nj)
  bindp3=dblarr(nn,ni,nj)
  advp=dblarr(nn,ni,nj)
  indp=dblarr(nn,ni,nj)
  totadvp=dblarr(nn,ni)
  totindp=dblarr(nn,ni)
  totbadvp1=dblarr(nn,ni,nj)
  totbadvp2=dblarr(nn,ni,nj)
  totbadvp3=dblarr(nn,ni,nj)
  totbindp1=dblarr(nn,ni,nj)
  totbindp2=dblarr(nn,ni,nj)
  totbindp3=dblarr(nn,ni,nj)
  abadvp1=dblarr(nn,ni)
  abadvp2=dblarr(nn,ni)
  abadvp3=dblarr(nn,ni)
  abindp1=dblarr(nn,ni)
  abindp2=dblarr(nn,ni)
  abindp3=dblarr(nn,ni)
;;;;;;;;;;;;;;;  
  mode=0
  start=0
  finish=0

; Setting the radius and colatitude levels
  FOR n = 0, nn-1 DO BEGIN
    r[n] = radtop - (radtop-radbot)*float(n)/float(nn-1)
  ENDFOR

  FOR k = 0, ni-1 DO BEGIN
    colat[k] = !PI * float(k)/float(ni-1)
  ENDFOR
  
  FOR j = 0, nj-1 DO BEGIN
    lon[j] = 2.*!PI * float(j)/float(nj-1)
  ENDFOR


  PRINT, 'What is the mode you want to compare with?'
  READ, mode
 
  PRINT, 'What is the start file?'
  READ, start
  PRINT, 'What is the end file?'
  READ, finish

  FOR count=start, finish DO BEGIN
print, count
    readfile1='m00/sphdat00'+string(count,FORMAT='(I3.3)')
    readfile2='m'+string(mode,FORMAT='(I2.2)')+'/sphdat'+string(mode,FORMAT='(I2.2)')+string(count,FORMAT='(I3.3)')

    a0=ASSOC(1,dblarr(6,nn,ni,nj))
    CLOSE,1 & OPENR,1,readfile1
    data0=a0[0]
    CLOSE,1

    a1=ASSOC(1,dblarr(6,nn,ni,nj))
    CLOSE,1 & OPENR,1,readfile2
    datam=a1[0]
    CLOSE,1

;Calculating the advective terms for B_r
    FOR i = 1, nn-1 DO BEGIN
    FOR k = 1, ni-1 DO BEGIN
    FOR j = 1, nj-1 DO BEGIN
      badvr1[i,k,j]=data0[0,i,k,j]*(datam[3,i,k,j]-datam[3,i-1,k,j])/(r[i]-r[i-1])
      badvr2[i,k,j]=data0[1,i,k,j]*1/r[i]*(datam[3,i,k,j]-datam[3,i,k-1,j])/(colat[k]-colat[k-1])
      badvr3[i,k,j]=data0[2,i,k,j]*1/r[i]*1/sin(colat[k])*(datam[3,i,k,j]-datam[3,i,k,j-1])/(colat[k]-colat[k-1])
    ENDFOR
    ENDFOR
    ENDFOR

;Calculating the inductive terms for B_r
    FOR i = 1, nn-1 DO BEGIN
    FOR k = 1, ni-1 DO BEGIN
    FOR j = 1, nj-1 DO BEGIN
      bindr1[i,k,j]=data0[3,i,k,j]*[datam[0,i,k,j]-datam[0,i-1,k,j]]/(r[i]-r[i-1])
      bindr2[i,k,j]=data0[4,i,k,j]*1/r[i]*[datam[0,i,k,j]-datam[0,i,k-1,j]]/(colat[k]-colat[k-1])
      bindr3[i,k,j]=data0[5,i,k,j]*1/r[i]*1/sin(colat[k])*[datam[0,i,k,j]-datam[0,i,k,j-1]]/(colat[k]-colat[k-1])
    ENDFOR
    ENDFOR
    ENDFOR

;Calculating the advective terms for B_theta
    FOR i = 1, nn-1 DO BEGIN
    FOR k = 1, ni-1 DO BEGIN
    FOR j = 1, nj-1 DO BEGIN
      badvt1[i,k,j]=data0[0,i,k,j]*(datam[4,i,k,j]-datam[4,i-1,k,j])/(r[i]-r[i-1])
      badvt2[i,k,j]=data0[1,i,k,j]*1/r[i]*(datam[4,i,k,j]-datam[4,i,k-1,j])/(colat[k]-colat[k-1])
      badvt3[i,k,j]=data0[2,i,k,j]*1/r[i]*1/sin(colat[k])*(datam[4,i,k,j]-datam[4,i,k,j-1])/(colat[k]-colat[k-1])
    ENDFOR
    ENDFOR
    ENDFOR

;Calculating the advecting terms for B_theta
    FOR i = 1, nn-1 DO BEGIN
    FOR k = 1, ni-1 DO BEGIN
    FOR j = 1, nj-1 DO BEGIN
      bindt1[i,k,j]=data0[3,i,k,j]*[datam[1,i,k,j]-datam[1,i-1,k,j]]/(r[i]-r[i-1])
      bindt2[i,k,j]=data0[4,i,k,j]*1/r[i]*[datam[1,i,k,j]-datam[1,i,k-1,j]]/(colat[k]-colat[k-1])
      bindt3[i,k,j]=data0[5,i,k,j]*1/r[i]*1/sin(colat[k])*[datam[1,i,k,j]-datam[1,i,k,j-1]]/(colat[k]-colat[k-1])
    ENDFOR
    ENDFOR
    ENDFOR
;;;;;;;;;;;;;;;;;;
;Calculating the advective terms for B_phi
    FOR i = 1, nn-1 DO BEGIN
    FOR k = 1, ni-1 DO BEGIN
    FOR j = 1, nj-1 DO BEGIN
      badvp1[i,k,j]=data0[0,i,k,j]*(datam[5,i,k,j]-datam[5,i-1,k,j])/(r[i]-r[i-1])
      badvp2[i,k,j]=data0[1,i,k,j]*1/r[i]*(datam[5,i,k,j]-datam[5,i,k-1,j])/(colat[k]-colat[k-1])
      badvp3[i,k,j]=data0[2,i,k,j]*1/r[i]*1/sin(colat[k])*(datam[5,i,k,j]-datam[5,i,k,j-1])/(colat[k]-colat[k-1])
    ENDFOR
    ENDFOR
    ENDFOR

;Calculating the advecting terms for B_phi
    FOR i = 1, nn-1 DO BEGIN
    FOR k = 1, ni-1 DO BEGIN
    FOR j = 1, nj-1 DO BEGIN
      bindp1[i,k,j]=data0[3,i,k,j]*[datam[2,i,k,j]-datam[2,i-1,k,j]]/(r[i]-r[i-1])
      bindp2[i,k,j]=data0[4,i,k,j]*1/r[i]*[datam[2,i,k,j]-datam[2,i,k-1,j]]/(colat[k]-colat[k-1])
      bindp3[i,k,j]=data0[5,i,k,j]*1/r[i]*1/sin(colat[k])*[datam[2,i,k,j]-datam[2,i,k,j-1]]/(colat[k]-colat[k-1])
    ENDFOR
    ENDFOR
    ENDFOR
;;;;;;;;;;;;;;;;;;;;;;;
    badvr=badvr1+badvr2+badvr3
    bindr=bindr1+bindr2+bindr3
    badvt=badvt1+badvt2+badvt3 
    bindt=bindt1+bindt2+bindt3
;;;;;;;;;;;;;;;;
    badvp=badvp1+badvp2+badvp3 
    bindp=bindp1+bindp2+bindp3

;summing the advective and inductive terms through time

    advr = advr + badvr^2
    indr = indr + bindr^2
    advt = advt + badvt^2
    indt = indt + bindt^2
;;;;;;;;;;;;;
    advp = advp + badvp^2
    indp = indp + bindp^2
  
    totbadvr1=totbadvr1+badvr1^2
    totbadvr2=totbadvr2+badvr2^2
    totbadvr3=totbadvr3+badvr3^2
    totbindr1=totbindr1+bindr1^2
    totbindr2=totbindr2+bindr2^2
    totbindr3=totbindr3+bindr3^2

    totbadvt1=totbadvt1+badvt1^2
    totbadvt2=totbadvt2+badvt2^2
    totbadvt3=totbadvt3+badvt3^2
    totbindt1=totbindt1+bindt1^2
    totbindt2=totbindt2+bindt2^2
    totbindt3=totbindt3+bindt3^2
;;;;;;;;;;;;;;
    totbadvp1=totbadvp1+badvp1^2
    totbadvp2=totbadvp2+badvp2^2
    totbadvp3=totbadvp3+badvp3^2
    totbindp1=totbindp1+bindp1^2
    totbindp2=totbindp2+bindp2^2
    totbindp3=totbindp3+bindp3^2
;;;;;;;;;;;;;;;
  ENDFOR
  
  totadvr=sqrt(totadvr)
  totindr=sqrt(totindr)
  totadvt=sqrt(totadvt)
  totindt=sqrt(totindt)
  totadvp=sqrt(totadvp)
  totindp=sqrt(totindp)
  abadvr1=sqrt(abadvr1)
  abadvr2=sqrt(abadvr2)
  abadvr3=sqrt(abadvr3)
  abindr1=sqrt(abindr1)
  abindr2=sqrt(abindr2)
  abindr3=sqrt(abindr3)
  abadvt1=sqrt(abadvt1)
  abadvt2=sqrt(abadvt2)
  abadvt3=sqrt(abadvt3)
  abindt1=sqrt(abindt1)
  abindt2=sqrt(abindt2)
  abindt3=sqrt(abindt3)
;;;;;;;;;;;;;;
  abadvp1=sqrt(abadvp1)
  abadvp2=sqrt(abadvp2)
  abadvp3=sqrt(abadvp3)
  abindp1=sqrt(abindp1)
  abindp2=sqrt(abindp2)
  abindp3=sqrt(abindp3)
;;;;;;;;;;;;;;

;averging the advective and inductive terms in time

  advr=advr/(finish-start+1)
  indr=indr/(finish-start+1)
  advt=advt/(finish-start+1)
  indt=indt/(finish-start+1)
;;;;;;;;;;;;
  advp=advp/(finish-start+1)
  indp=indp/(finish-start+1)
    
  totbadvr1=totbadvr1/(finish-start+1)
  totbadvr2=totbadvr2/(finish-start+1)
  totbadvr3=totbadvr3/(finish-start+1)
  totbindr1=totbindr1/(finish-start+1)
  totbindr2=totbindr2/(finish-start+1)
  totbindr3=totbindr3/(finish-start+1)

  totbadvt1=totbadvt1/(finish-start+1)
  totbadvt2=totbadvt2/(finish-start+1)
  totbadvt3=totbadvt3/(finish-start+1)
  totbindt1=totbindt1/(finish-start+1)
  totbindt2=totbindt2/(finish-start+1)
  totbindt3=totbindt3/(finish-start+1)
;;;;;;;;;;;;;
  totbadvp1=totbadvp1/(finish-start+1)
  totbadvp2=totbadvp2/(finish-start+1)
  totbadvp3=totbadvp3/(finish-start+1)
  totbindp1=totbindp1/(finish-start+1)
  totbindp2=totbindp2/(finish-start+1)
  totbindp3=totbindp3/(finish-start+1)
;;;;;;;;;;;;
; write terms to script
  OPENW, 1, 'advind.dat'
  WRITEU, 1, totbadvr1, totbadvr2, totbadvr3, totbindr1, totbindr2, totbindr3
  WRITEU, 1, totbadvt1, totbadvt2, totbadvt3, totbindt1, totbindt2, totbindt3
  WRITEU, 1, totbadvp1, totbadvp2, totbadvp3, totbindp1, totbindp2, totbindp3
  CLOSE, 1

; Averaging over longitude
  FOR j = 0, nj-1 DO BEGIN
    totadvr=totadvr+advr[*,*,j]
    totindr=totindr+indr[*,*,j]
    totadvt=totadvt+advt[*,*,j]
    totindt=totindt+indt[*,*,j]
    totadvp=totadvp+advp[*,*,j]
    totindp=totindp+indp[*,*,j]
    abadvr1=abadvr1+totbadvr1[*,*,j]
    abadvr2=abadvr2+totbadvr2[*,*,j]
    abadvr3=abadvr3+totbadvr3[*,*,j]
    abindr1=abindr1+totbindr1[*,*,j]
    abindr2=abindr2+totbindr2[*,*,j]
    abindr3=abindr3+totbindr3[*,*,j]
    abadvt1=abadvt1+totbadvt1[*,*,j]
    abadvt2=abadvt2+totbadvt2[*,*,j]
    abadvt3=abadvt3+totbadvt3[*,*,j]
    abindt1=abindt1+totbindt1[*,*,j]
    abindt2=abindt2+totbindt2[*,*,j]
    abindt3=abindt3+totbindt3[*,*,j]
;;;;;;;;;;;;;;
    abadvp1=abadvp1+totbadvp1[*,*,j]
    abadvp2=abadvp2+totbadvp2[*,*,j]
    abadvp3=abadvp3+totbadvp3[*,*,j]
    abindp1=abindp1+totbindp1[*,*,j]
    abindp2=abindp2+totbindp2[*,*,j]
    abindp3=abindp3+totbindp3[*,*,j]
;;;;;;;;;;;;;;
  ENDFOR



  totadvr=totadvr/nj
  totindr=totindr/nj
  totadvt=totadvt/nj
  totindt=totindt/nj
  totadvp=totadvp/nj
  totindp=totindp/nj
  abadvr1=abadvr1/nj
  abadvr2=abadvr2/nj
  abadvr3=abadvr3/nj
  abindr1=abindr1/nj
  abindr2=abindr2/nj
  abindr3=abindr3/nj
  abadvt1=abadvt1/nj
  abadvt2=abadvt2/nj
  abadvt3=abadvt3/nj
  abindt1=abindt1/nj
  abindt2=abindt2/nj
  abindt3=abindt3/nj
;;;;;;;;;;;;;;;
  abadvp1=abadvp1/nj
  abadvp2=abadvp2/nj
  abadvp3=abadvp3/nj
  abindp1=abindp1/nj
  abindp2=abindp2/nj
  abindp3=abindp3/nj

  print, '1',MAX(totadvr)
  print, '2',MAX(totindr)
  print, '3',MAX(totadvt)
  print, '4',MAX(totindt)
  print, '5',MAX(totadvp)
  print, '6',MAX(totindp)
  print, '7',MAX(abadvr1)
  print, '8',MAX(abadvr2)
  print, '9',MAX(abadvr3)
  print, '10',MAX(abindr1)
  print, '11',MAX(abindr2)
  print, '12',MAX(abindr3)
  print, '13',MAX(abadvt1)
  print, '14',MAX(abadvt2)
  print, '15',MAX(abadvt3)
  print, '16',MAX(abindt1)
  print, '17',MAX(abindt2)
  print, '18',MAX(abindt3)
;;;;;;;;;;;;;;;;;
  print, '19',MAX(abadvp1)
  print, '20',MAX(abadvp2)
  print, '21',MAX(abadvp3)
  print, '22',MAX(abindp1)
  print, '23',MAX(abindp2)
  print, '24',MAX(abindp3)
;;;;;;;;;;;;;;;
; Making the inner core white

  blankadvr=dblarr(ni,radbot)
  blankadvr[*]=MAX(totadvr)
  blankindr=dblarr(ni,radbot)
  blankindr[*]=MAX(totindr)

  blankadvt=dblarr(ni,radbot)
  blankadvt[*]=MAX(totadvt)
  blankindt=dblarr(ni,radbot)
  blankindt[*]=MAX(totindt)
;;;;;;;;;;;;;
  blankadvp=dblarr(ni,radbot)
  blankadvp[*]=MAX(totadvp)
  blankindp=dblarr(ni,radbot)
  blankindp[*]=MAX(totindp)
;;;;;;;;;;;;;
  blankadvr1=dblarr(ni,radbot)
  blankadvr1[*]=MAX(abadvr1)
  blankindr1=dblarr(ni,radbot)
  blankindr1[*]=MAX(abindr1)

  blankadvr2=dblarr(ni,radbot)
  blankadvr2[*]=MAX(abadvr2)
  blankindr2=dblarr(ni,radbot)
  blankindr2[*]=MAX(abindr2)

  blankadvr3=dblarr(ni,radbot)
  blankadvr3[*]=MAX(abadvr3)
  blankindr3=dblarr(ni,radbot)
  blankindr3[*]=MAX(abindr3)

  blankadvt1=dblarr(ni,radbot)
  blankadvt1[*]=MAX(abadvt1)
  blankindt1=dblarr(ni,radbot)
  blankindt1[*]=MAX(abindt1)

  blankadvt2=dblarr(ni,radbot)
  blankadvt2[*]=MAX(abadvt2)
  blankindt2=dblarr(ni,radbot)
  blankindt2[*]=MAX(abindt2)

  blankadvt3=dblarr(ni,radbot)
  blankadvt3[*]=MAX(abadvt3)
  blankindt3=dblarr(ni,radbot)
  blankindt3[*]=MAX(abindt3)
;;;;;;;;;;;;;
  blankadvp1=dblarr(ni,radbot)
  blankadvp1[*]=MAX(abadvp1)
  blankindp1=dblarr(ni,radbot)
  blankindp1[*]=MAX(abindp1)

  blankadvp2=dblarr(ni,radbot)
  blankadvp2[*]=MAX(abadvp2)
  blankindp2=dblarr(ni,radbot)
  blankindp2[*]=MAX(abindp2)

  blankadvp3=dblarr(ni,radbot)
  blankadvp3[*]=MAX(abadvp3)
  blankindp3=dblarr(ni,radbot)
  blankindp3[*]=MAX(abindp3)
;;;;;;;;;;;;;;
; Converting from cartesian to polar
  colatitude=findgen(ni)/float(ni-1)*!PI
  rad=radtop-(radtop-radbot)*findgen(nn)/float(nn-1)
  radb=radbot-float(radbot)*findgen(radbot)/(float(radbot)-1.)

; Colored contour plot of time averaged B_r inductive averaged in longitude  
  window, 0, XSIZE=750, YSIZE=750
  loadct, 39
  device, decompose=0
  polar_contour2, transpose(totadvr), colatitude, rad,$
       BACKGROUND=255, COLOR=0, /FILL, NLEVELS=200,$
       TITLE= 'B_r advective', /ISOTROPIC, xstyle=1, ystyle=1,$
       CHARSIZE=1.5, XRANGE=[0,50], YRANGE=[-50,50]
  polar_contour2, blankadvr, colatitude, radb, $
        /CELL_FILL, NLEVEL=1, /OVERPLOT
  COLORBAR, COLOR=0, DIVISIONS=4, FORMAT='(e10.3)', $
       POSITION=[0.84, 0.17, 0.88, 0.9], /VERTICAL, /RIGHT,  $
       CHARSIZE=1.25, MAX=MAX(totadvr), MIN=MIN(totadvr)

; Colored contour plot of time averaged B_r inductive averaged in longitude
  window, 1, XSIZE=750, YSIZE=750
  loadct, 39
  device, decompose=0
  polar_contour2, transpose(totindr), colatitude, rad,$
       BACKGROUND=255, COLOR=0, /FILL, NLEVELS=200,$
       TITLE= 'B_r inductive', xstyle=1, ystyle=1,$
       CHARSIZE=1.5, XRANGE=[0,50], /ISOTROPIC, yrange=[-50,50]
  polar_contour2, blankindr, colatitude, radb, $
        /CELL_FILL, NLEVEL=1, /OVERPLOT
  COLORBAR, COLOR=0, DIVISIONS=4, FORMAT='(e10.3)', $
       POSITION=[0.84, 0.17, 0.88, 0.9], /VERTICAL, /RIGHT,  $
       CHARSIZE=1.25, MAX=MAX(totindr), MIN=MIN(totindr)

; Colored contour plot of time averaged B_theta advective averaged in longitude  
  window, 2, XSIZE=750, YSIZE=750
  loadct, 39
  device, decompose=0
  polar_contour2, transpose(totadvt), colatitude, rad,$
       BACKGROUND=255, COLOR=0, /FILL, NLEVELS=200,$
       TITLE= 'B_theta advective', /ISOTROPIC, xstyle=1, ystyle=1,$
       CHARSIZE=1.5, XRANGE=[0,50], YRANGE=[-50,50]
  polar_contour2, blankadvt, colatitude, radb, $
        /CELL_FILL, NLEVEL=1, /OVERPLOT
  COLORBAR, COLOR=0, DIVISIONS=4, FORMAT='(e10.3)', $
       POSITION=[0.84, 0.17, 0.88, 0.9], /VERTICAL, /RIGHT,  $
       CHARSIZE=1.25, MAX=MAX(totadvt), MIN=MIN(totadvt)

; Colored contour plot of time averaged B_theta inductive averaged in longitude
  window, 3, XSIZE=750, YSIZE=750
  loadct, 39
  device, decompose=0
  polar_contour2, transpose(totindt), colatitude, rad,$
       BACKGROUND=255, COLOR=0, /FILL, NLEVELS=200,$
       TITLE= 'B_theta inductive', xstyle=1, ystyle=1,$
       CHARSIZE=1.5, XRANGE=[0,50], /ISOTROPIC, yrange=[-50,50]
  polar_contour2, blankindt, colatitude, radb, $
        /CELL_FILL, NLEVEL=1, /OVERPLOT
  COLORBAR, COLOR=0, DIVISIONS=4, FORMAT='(e10.3)', $
       POSITION=[0.84, 0.17, 0.88, 0.9], /VERTICAL, /RIGHT,  $
       CHARSIZE=1.25, MAX=MAX(totindt), MIN=MIN(totindt)
;;;;;;;;;;;;;;;;;;;;;
; Colored contour plot of time averaged B_phi advective averaged in longitude  
  window, 4, XSIZE=750, YSIZE=750
  loadct, 39
  device, decompose=0
  polar_contour2, transpose(totadvp), colatitude, rad,$
       BACKGROUND=255, COLOR=0, /FILL, NLEVELS=200,$
       TITLE= 'B_phi advective', /ISOTROPIC, xstyle=1, ystyle=1,$
       CHARSIZE=1.5, XRANGE=[0,50], YRANGE=[-50,50]
  polar_contour2, blankadvp, colatitude, radb, $
        /CELL_FILL, NLEVEL=1, /OVERPLOT
  COLORBAR, COLOR=0, DIVISIONS=4, FORMAT='(e10.3)', $
       POSITION=[0.84, 0.17, 0.88, 0.9], /VERTICAL, /RIGHT,  $
       CHARSIZE=1.25, MAX=MAX(totadvp), MIN=MIN(totadvp)

; Colored contour plot of time averaged B_phi inductive averaged in longitude
  window, 5, XSIZE=750, YSIZE=750
  loadct, 39
  device, decompose=0
  polar_contour2, transpose(totindp), colatitude, rad,$
       BACKGROUND=255, COLOR=0, /FILL, NLEVELS=200,$
       TITLE= 'B_phi inductive', xstyle=1, ystyle=1,$
       CHARSIZE=1.5, XRANGE=[0,50], /ISOTROPIC, yrange=[-50,50]
  polar_contour2, blankindp, colatitude, radb, $
        /CELL_FILL, NLEVEL=1, /OVERPLOT
  COLORBAR, COLOR=0, DIVISIONS=4, FORMAT='(e10.3)', $
       POSITION=[0.84, 0.17, 0.88, 0.9], /VERTICAL, /RIGHT,  $
       CHARSIZE=1.25, MAX=MAX(totindp), MIN=MIN(totindp)
;;;;;;;;;;;;;;;;;;;;
; Colored contour plot of time averaged B_r1 inductive averaged in longitude  
  window, 6, XSIZE=750, YSIZE=750
  loadct, 39
  device, decompose=0
  polar_contour2, transpose(abadvr1), colatitude, rad,$
       BACKGROUND=255, COLOR=0, /FILL, NLEVELS=200,$
       TITLE= 'B_r1 advective', /ISOTROPIC, xstyle=1, ystyle=1,$
       CHARSIZE=1.5, XRANGE=[0,50], YRANGE=[-50,50]
  polar_contour2, blankadvr1, colatitude, radb, $
        /CELL_FILL, NLEVEL=1, /OVERPLOT
  COLORBAR, COLOR=0, DIVISIONS=4, FORMAT='(e10.3)', $
       POSITION=[0.84, 0.17, 0.88, 0.9], /VERTICAL, /RIGHT,  $
       CHARSIZE=1.25, MAX=MAX(abadvr1), MIN=MIN(abadvr1)

; Colored contour plot of time averaged B_r1 inductive averaged in longitude
  window, 7, XSIZE=750, YSIZE=750
  loadct, 39
  device, decompose=0
  polar_contour2, transpose(abindr1), colatitude, rad,$
       BACKGROUND=255, COLOR=0, /FILL, NLEVELS=200,$
       TITLE= 'B_r1 inductive', xstyle=1, ystyle=1,$
       CHARSIZE=1.5, XRANGE=[0,50], /ISOTROPIC, yrange=[-50,50]
  polar_contour2, blankindr1, colatitude, radb, $
        /CELL_FILL, NLEVEL=1, /OVERPLOT
  COLORBAR, COLOR=0, DIVISIONS=4, FORMAT='(e10.3)', $
       POSITION=[0.84, 0.17, 0.88, 0.9], /VERTICAL, /RIGHT,  $
       CHARSIZE=1.25, MAX=MAX(abindr1), MIN=MIN(abindr1)

; Colored contour plot of time averaged B_r2 advective averaged in longitude  
  window, 8, XSIZE=750, YSIZE=750
  loadct, 39
  device, decompose=0
  polar_contour2, transpose(abadvr2), colatitude, rad,$
       BACKGROUND=255, COLOR=0, /FILL, NLEVELS=200,$
       TITLE= 'B_r2 advective', /ISOTROPIC, xstyle=1, ystyle=1,$
       CHARSIZE=1.5, XRANGE=[0,50], YRANGE=[-50,50]
  polar_contour2, blankadvr2, colatitude, radb, $
        /CELL_FILL, NLEVEL=1, /OVERPLOT
  COLORBAR, COLOR=0, DIVISIONS=4, FORMAT='(e10.3)', $
       POSITION=[0.84, 0.17, 0.88, 0.9], /VERTICAL, /RIGHT,  $
       CHARSIZE=1.25, MAX=MAX(abadvr2), MIN=MIN(abadvr2)

; Colored contour plot of time averaged B_r2 inductive averaged in longitude
  window, 9, XSIZE=750, YSIZE=750
  loadct, 39
  device, decompose=0
  polar_contour2, transpose(abindr2), colatitude, rad,$
       BACKGROUND=255, COLOR=0, /FILL, NLEVELS=200,$
       TITLE= 'B_r2 inductive', xstyle=1, ystyle=1,$
       CHARSIZE=1.5, XRANGE=[0,50], /ISOTROPIC, yrange=[-50,50]
  polar_contour2, blankindr2, colatitude, radb, $
        /CELL_FILL, NLEVEL=1, /OVERPLOT
  COLORBAR, COLOR=0, DIVISIONS=4, FORMAT='(e10.3)', $
       POSITION=[0.84, 0.17, 0.88, 0.9], /VERTICAL, /RIGHT,  $
       CHARSIZE=1.25, MAX=MAX(abindr2), MIN=MIN(abindr2)

; Colored contour plot of time averaged B_r3 advective averaged in longitude  
  window, 10, XSIZE=750, YSIZE=750
  loadct, 39
  device, decompose=0
  polar_contour2, transpose(abadvr3), colatitude, rad,$
       BACKGROUND=255, COLOR=0, /FILL, NLEVELS=200,$
       TITLE= 'B_r3 advective', /ISOTROPIC, xstyle=1, ystyle=1,$
       CHARSIZE=1.5, XRANGE=[0,50], YRANGE=[-50,50]
  polar_contour2, blankadvr3, colatitude, radb, $
        /CELL_FILL, NLEVEL=1, /OVERPLOT
  COLORBAR, COLOR=0, DIVISIONS=4, FORMAT='(e10.3)', $
       POSITION=[0.84, 0.17, 0.88, 0.9], /VERTICAL, /RIGHT,  $
       CHARSIZE=1.25, MAX=MAX(abadvr3), MIN=MIN(abadvr3)

; Colored contour plot of time averaged B_r3 inductive averaged in longitude
  window, 11, XSIZE=750, YSIZE=750
  loadct, 39
  device, decompose=0
  polar_contour2, transpose(abindr3), colatitude, rad,$
       BACKGROUND=255, COLOR=0, /FILL, NLEVELS=200,$
       TITLE= 'B_r3 inductive', xstyle=1, ystyle=1,$
       CHARSIZE=1.5, XRANGE=[0,50], /ISOTROPIC, yrange=[-50,50]
  polar_contour2, blankindr3, colatitude, radb, $
        /CELL_FILL, NLEVEL=1, /OVERPLOT
  COLORBAR, COLOR=0, DIVISIONS=4, FORMAT='(e10.3)', $
       POSITION=[0.84, 0.17, 0.88, 0.9], /VERTICAL, /RIGHT,  $
       CHARSIZE=1.25, MAX=MAX(abindr3), MIN=MIN(abindr3)

; Colored contour plot of time averaged B_theta1 inductive averaged in longitude  
  window, 12, XSIZE=750, YSIZE=750
  loadct, 39
  device, decompose=0
  polar_contour2, transpose(abadvt1), colatitude, rad,$
       BACKGROUND=255, COLOR=0, /FILL, NLEVELS=200,$
       TITLE= 'B_theta1 advective', /ISOTROPIC, xstyle=1, ystyle=1,$
       CHARSIZE=1.5, XRANGE=[0,50], YRANGE=[-50,50]
  polar_contour2, blankadvt1, colatitude, radb, $
        /CELL_FILL, NLEVEL=1, /OVERPLOT
  COLORBAR, COLOR=0, DIVISIONS=4, FORMAT='(e10.3)', $
       POSITION=[0.84, 0.17, 0.88, 0.9], /VERTICAL, /RIGHT,  $
       CHARSIZE=1.25, MAX=MAX(abadvt1), MIN=MIN(abadvt1)

; Colored contour plot of time averaged B_theta1 inductive averaged in longitude
  window, 13, XSIZE=750, YSIZE=750
  loadct, 39
  device, decompose=0
  polar_contour2, transpose(abindt1), colatitude, rad,$
       BACKGROUND=255, COLOR=0, /FILL, NLEVELS=200,$
       TITLE= 'B_theta1 inductive', xstyle=1, ystyle=1,$
       CHARSIZE=1.5, XRANGE=[0,50], /ISOTROPIC, yrange=[-50,50]
  polar_contour2, blankindt1, colatitude, radb, $
        /CELL_FILL, NLEVEL=1, /OVERPLOT
  COLORBAR, COLOR=0, DIVISIONS=4, FORMAT='(e10.3)', $
       POSITION=[0.84, 0.17, 0.88, 0.9], /VERTICAL, /RIGHT,  $
       CHARSIZE=1.25, MAX=MAX(abindt1), MIN=MIN(abindt1)

; Colored contour plot of time averaged B_theta2 advective averaged in longitude  
  window, 14, XSIZE=750, YSIZE=750
  loadct, 39
  device, decompose=0
  polar_contour2, transpose(abadvt2), colatitude, rad,$
       BACKGROUND=255, COLOR=0, /FILL, NLEVELS=200,$
       TITLE= 'B_theta2 advective', /ISOTROPIC, xstyle=1, ystyle=1,$
       CHARSIZE=1.5, XRANGE=[0,50], YRANGE=[-50,50]
  polar_contour2, blankadvt2, colatitude, radb, $
        /CELL_FILL, NLEVEL=1, /OVERPLOT
  COLORBAR, COLOR=0, DIVISIONS=4, FORMAT='(e10.3)', $
       POSITION=[0.84, 0.17, 0.88, 0.9], /VERTICAL, /RIGHT,  $
       CHARSIZE=1.25, MAX=MAX(abadvt2), MIN=MIN(abadvt2)

; Colored contour plot of time averaged B_theta2 inductive averaged in longitude
  window, 15, XSIZE=750, YSIZE=750
  loadct, 39
  device, decompose=0
  polar_contour2, transpose(abindt2), colatitude, rad,$
       BACKGROUND=255, COLOR=0, /FILL, NLEVELS=200,$
       TITLE= 'B_theta2 inductive', xstyle=1, ystyle=1,$
       CHARSIZE=1.5, XRANGE=[0,50], /ISOTROPIC, yrange=[-50,50]
  polar_contour2, blankindt2, colatitude, radb, $
        /CELL_FILL, NLEVEL=1, /OVERPLOT
  COLORBAR, COLOR=0, DIVISIONS=4, FORMAT='(e10.3)', $
       POSITION=[0.84, 0.17, 0.88, 0.9], /VERTICAL, /RIGHT,  $
       CHARSIZE=1.25, MAX=MAX(abindt2), MIN=MIN(abindt2)

; Colored contour plot of time averaged B_theta3 advective averaged in longitude  
  window, 16, XSIZE=750, YSIZE=750
  loadct, 39
  device, decompose=0
  polar_contour2, transpose(abadvt3), colatitude, rad,$
       BACKGROUND=255, COLOR=0, /FILL, NLEVELS=200,$
       TITLE= 'B_theta3 advective', /ISOTROPIC, xstyle=1, ystyle=1,$
       CHARSIZE=1.5, XRANGE=[0,50], YRANGE=[-50,50]
  polar_contour2, blankadvt3, colatitude, radb, $
        /CELL_FILL, NLEVEL=1, /OVERPLOT
  COLORBAR, COLOR=0, DIVISIONS=4, FORMAT='(e10.3)', $
       POSITION=[0.84, 0.17, 0.88, 0.9], /VERTICAL, /RIGHT,  $
       CHARSIZE=1.25, MAX=MAX(abadvt3), MIN=MIN(abadvt3)

; Colored contour plot of time averaged B_theta3 inductive averaged in longitude
  window, 17, XSIZE=750, YSIZE=750
  loadct, 39
  device, decompose=0
  polar_contour2, transpose(abindt3), colatitude, rad,$
       BACKGROUND=255, COLOR=0, /FILL, NLEVELS=200,$
       TITLE= 'B_theta3 inductive', xstyle=1, ystyle=1,$
       CHARSIZE=1.5, XRANGE=[0,50], /ISOTROPIC, yrange=[-50,50]
  polar_contour2, blankindt3, colatitude, radb, $
        /CELL_FILL, NLEVEL=1, /OVERPLOT
  COLORBAR, COLOR=0, DIVISIONS=4, FORMAT='(e10.3)', $
       POSITION=[0.84, 0.17, 0.88, 0.9], /VERTICAL, /RIGHT,  $
       CHARSIZE=1.25, MAX=MAX(abindt3), MIN=MIN(abindt3)
;;;;;;;;;;;;;;;;;;;;
; Colored contour plot of time averaged B_phi1 inductive averaged in longitude  
  window, 18, XSIZE=750, YSIZE=750
  loadct, 39
  device, decompose=0
  polar_contour2, transpose(abadvp1), colatitude, rad,$
       BACKGROUND=255, COLOR=0, /FILL, NLEVELS=200,$
       TITLE= 'B_phi1 advective', /ISOTROPIC, xstyle=1, ystyle=1,$
       CHARSIZE=1.5, XRANGE=[0,50], YRANGE=[-50,50]
  polar_contour2, blankadvp1, colatitude, radb, $
        /CELL_FILL, NLEVEL=1, /OVERPLOT
  COLORBAR, COLOR=0, DIVISIONS=4, FORMAT='(e10.3)', $
       POSITION=[0.84, 0.17, 0.88, 0.9], /VERTICAL, /RIGHT,  $
       CHARSIZE=1.25, MAX=MAX(abadvp1), MIN=MIN(abadvp1)

; Colored contour plot of time averaged B_phi1 inductive averaged in longitude
  window, 19, XSIZE=750, YSIZE=750
  loadct, 39
  device, decompose=0
  polar_contour2, transpose(abindp1), colatitude, rad,$
       BACKGROUND=255, COLOR=0, /FILL, NLEVELS=200,$
       TITLE= 'B_phi1 inductive', xstyle=1, ystyle=1,$
       CHARSIZE=1.5, XRANGE=[0,50], /ISOTROPIC, yrange=[-50,50]
  polar_contour2, blankindp1, colatitude, radb, $
        /CELL_FILL, NLEVEL=1, /OVERPLOT
  COLORBAR, COLOR=0, DIVISIONS=4, FORMAT='(e10.3)', $
       POSITION=[0.84, 0.17, 0.88, 0.9], /VERTICAL, /RIGHT,  $
       CHARSIZE=1.25, MAX=MAX(abindp1), MIN=MIN(abindp1)

; Colored contour plot of time averaged B_phi2 advective averaged in longitude  
  window, 20, XSIZE=750, YSIZE=750
  loadct, 39
  device, decompose=0
  polar_contour2, transpose(abadvp2), colatitude, rad,$
       BACKGROUND=255, COLOR=0, /FILL, NLEVELS=200,$
       TITLE= 'B_phi2 advective', /ISOTROPIC, xstyle=1, ystyle=1,$
       CHARSIZE=1.5, XRANGE=[0,50], YRANGE=[-50,50]
  polar_contour2, blankadvp2, colatitude, radb, $
        /CELL_FILL, NLEVEL=1, /OVERPLOT
  COLORBAR, COLOR=0, DIVISIONS=4, FORMAT='(e10.3)', $
       POSITION=[0.84, 0.17, 0.88, 0.9], /VERTICAL, /RIGHT,  $
       CHARSIZE=1.25, MAX=MAX(abadvp2), MIN=MIN(abadvp2)

; Colored contour plot of time averaged B_phi2 inductive averaged in longitude
  window, 21, XSIZE=750, YSIZE=750
  loadct, 39
  device, decompose=0
  polar_contour2, transpose(abindp2), colatitude, rad,$
       BACKGROUND=255, COLOR=0, /FILL, NLEVELS=200,$
       TITLE= 'B_phi2 inductive', xstyle=1, ystyle=1,$
       CHARSIZE=1.5, XRANGE=[0,50], /ISOTROPIC, yrange=[-50,50]
  polar_contour2, blankindp2, colatitude, radb, $
        /CELL_FILL, NLEVEL=1, /OVERPLOT
  COLORBAR, COLOR=0, DIVISIONS=4, FORMAT='(e10.3)', $
       POSITION=[0.84, 0.17, 0.88, 0.9], /VERTICAL, /RIGHT,  $
       CHARSIZE=1.25, MAX=MAX(abindp2), MIN=MIN(abindp2)

; Colored contour plot of time averaged B_phi3 advective averaged in longitude  
  window, 22, XSIZE=750, YSIZE=750
  loadct, 39
  device, decompose=0
  polar_contour2, transpose(abadvp3), colatitude, rad,$
       BACKGROUND=255, COLOR=0, /FILL, NLEVELS=200,$
       TITLE= 'B_phi3 advective', /ISOTROPIC, xstyle=1, ystyle=1,$
       CHARSIZE=1.5, XRANGE=[0,50], YRANGE=[-50,50]
  polar_contour2, blankadvp3, colatitude, radb, $
        /CELL_FILL, NLEVEL=1, /OVERPLOT
  COLORBAR, COLOR=0, DIVISIONS=4, FORMAT='(e10.3)', $
       POSITION=[0.84, 0.17, 0.88, 0.9], /VERTICAL, /RIGHT,  $
       CHARSIZE=1.25, MAX=MAX(abadvp3), MIN=MIN(abadvp3)

; Colored contour plot of time averaged B_phi3 inductive averaged in longitude
  window, 23, XSIZE=750, YSIZE=750
  loadct, 39
  device, decompose=0
  polar_contour2, transpose(abindp3), colatitude, rad,$
       BACKGROUND=255, COLOR=0, /FILL, NLEVELS=200,$
       TITLE= 'B_phi3 inductive', xstyle=1, ystyle=1,$
       CHARSIZE=1.5, XRANGE=[0,50], /ISOTROPIC, yrange=[-50,50]
  polar_contour2, blankindp3, colatitude, radb, $
        /CELL_FILL, NLEVEL=1, /OVERPLOT
  COLORBAR, COLOR=0, DIVISIONS=4, FORMAT='(e10.3)', $
       POSITION=[0.84, 0.17, 0.88, 0.9], /VERTICAL, /RIGHT,  $
       CHARSIZE=1.25, MAX=MAX(abindp3), MIN=MIN(abindp3)


END

