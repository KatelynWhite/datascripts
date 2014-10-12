;last updated 8/7/2012

PRO pltadvind3
  COMPILE_OPT IDL2

; Graphic resolution:
  nn=81
  ni=101
  nj=201
  radtop=50.D
  radbot=20.D
  nlevels=1000

; Initial conditions
  r=dblarr(nn)
  colat=dblarr(ni)
  lon=dblarr(nj)

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
  advrs=dblarr(nn,ni,nj)
  indrs=dblarr(nn,ni,nj)
  totadvrs=dblarr(nn,ni)
  totindrs=dblarr(nn,ni)
  totbadvr1s=dblarr(nn,ni,nj)
  totbadvr2s=dblarr(nn,ni,nj)
  totbadvr3s=dblarr(nn,ni,nj)
  totbindr1s=dblarr(nn,ni,nj)
  totbindr2s=dblarr(nn,ni,nj)
  totbindr3s=dblarr(nn,ni,nj)
  abadvr1s=dblarr(nn,ni)
  abadvr2s=dblarr(nn,ni)
  abadvr3s=dblarr(nn,ni)
  abindr1s=dblarr(nn,ni)
  abindr2s=dblarr(nn,ni)
  abindr3s=dblarr(nn,ni)
 
  advts=dblarr(nn,ni,nj)
  indts=dblarr(nn,ni,nj)
  totadvts=dblarr(nn,ni)
  totindts=dblarr(nn,ni)
  totbadvt1s=dblarr(nn,ni,nj)
  totbadvt2s=dblarr(nn,ni,nj)
  totbadvt3s=dblarr(nn,ni,nj)
  totbindt1s=dblarr(nn,ni,nj)
  totbindt2s=dblarr(nn,ni,nj)
  totbindt3s=dblarr(nn,ni,nj)
  abadvt1s=dblarr(nn,ni)
  abadvt2s=dblarr(nn,ni)
  abadvt3s=dblarr(nn,ni)
  abindt1s=dblarr(nn,ni)
  abindt2s=dblarr(nn,ni)
  abindt3s=dblarr(nn,ni)
;;;;;;;;;;;;;;;;;
  advps=dblarr(nn,ni,nj)
  indps=dblarr(nn,ni,nj)
  totadvps=dblarr(nn,ni)
  totindps=dblarr(nn,ni)
  totbadvp1s=dblarr(nn,ni,nj)
  totbadvp2s=dblarr(nn,ni,nj)
  totbadvp3s=dblarr(nn,ni,nj)
  totbindp1s=dblarr(nn,ni,nj)
  totbindp2s=dblarr(nn,ni,nj)
  totbindp3s=dblarr(nn,ni,nj)
  abadvp1s=dblarr(nn,ni)
  abadvp2s=dblarr(nn,ni)
  abadvp3s=dblarr(nn,ni)
  abindp1s=dblarr(nn,ni)
  abindp2s=dblarr(nn,ni)
  abindp3s=dblarr(nn,ni)
;;;;;;;;;;;;;;;  

  advrt=dblarr(nn,ni,nj)
  indrt=dblarr(nn,ni,nj)
  totadvrt=dblarr(nn,ni)
  totindrt=dblarr(nn,ni)
  totbadvr1t=dblarr(nn,ni,nj)
  totbadvr2t=dblarr(nn,ni,nj)
  totbadvr3t=dblarr(nn,ni,nj)
  totbindr1t=dblarr(nn,ni,nj)
  totbindr2t=dblarr(nn,ni,nj)
  totbindr3t=dblarr(nn,ni,nj)
  abadvr1t=dblarr(nn,ni)
  abadvr2t=dblarr(nn,ni)
  abadvr3t=dblarr(nn,ni)
  abindr1t=dblarr(nn,ni)
  abindr2t=dblarr(nn,ni)
  abindr3t=dblarr(nn,ni)
 
  advtt=dblarr(nn,ni,nj)
  indtt=dblarr(nn,ni,nj)
  totadvtt=dblarr(nn,ni)
  totindtt=dblarr(nn,ni)
  totbadvt1t=dblarr(nn,ni,nj)
  totbadvt2t=dblarr(nn,ni,nj)
  totbadvt3t=dblarr(nn,ni,nj)
  totbindt1t=dblarr(nn,ni,nj)
  totbindt2t=dblarr(nn,ni,nj)
  totbindt3t=dblarr(nn,ni,nj)
  abadvt1t=dblarr(nn,ni)
  abadvt2t=dblarr(nn,ni)
  abadvt3t=dblarr(nn,ni)
  abindt1t=dblarr(nn,ni)
  abindt2t=dblarr(nn,ni)
  abindt3t=dblarr(nn,ni)
;;;;;;;;;;;;;;;;;
  advpt=dblarr(nn,ni,nj)
  indpt=dblarr(nn,ni,nj)
  totadvpt=dblarr(nn,ni)
  totindpt=dblarr(nn,ni)
  totbadvp1t=dblarr(nn,ni,nj)
  totbadvp2t=dblarr(nn,ni,nj)
  totbadvp3t=dblarr(nn,ni,nj)
  totbindp1t=dblarr(nn,ni,nj)
  totbindp2t=dblarr(nn,ni,nj)
  totbindp3t=dblarr(nn,ni,nj)
  abadvp1t=dblarr(nn,ni)
  abadvp2t=dblarr(nn,ni)
  abadvp3t=dblarr(nn,ni)
  abindp1t=dblarr(nn,ni)
  abindp2t=dblarr(nn,ni)
  abindp3t=dblarr(nn,ni)
;;;;;;;;;;;;;;;  

  maxar=0.D
  maxir=0.D
  maxat=0.D
  maxit=0.D
  maxap=0.D
  maxip=0.D
  maxar1=0.D
  maxir1=0.D
  maxar2=0.D 
  maxir2=0.D
  maxar3=0.D
  maxir3=0.D
  maxat1=0.D
  maxit1=0.D
  maxat2=0.D
  maxit2=0.D
  maxat3=0.D
  maxit3=0.D
  maxap1=0.D
  maxip1=0.D
  maxap2=0.D
  maxip2=0.D
  maxap3=0.D
  maxip3=0.D

  minar=0.D
  minir=0.D
  minat=0.D
  minit=0.D
  minap=0.D
  minip=0.D
  minar1=0.D
  minir1=0.D
  minar2=0.D
  minir2=0.D
  minar3=0.D
  minir3=0.D
  minat1=0.D
  minit1=0.D
  minat2=0.D
  minit2=0.D
  minat3=0.D
  minit3=0.D
  minap1=0.D
  minip1=0.D
  minap2=0.D
  minip2=0.D
  minap3=0.D
  minip3=0.D

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
 
  readfile1='../r10/advindm'+string(mode,FORMAT='(I2.2)')+'_3.dat'
  readfile2='../s10/advindm'+string(mode,FORMAT='(I2.2)')+'_3.dat'
  readfile3='../t10/advindm'+string(mode,FORMAT='(I2.2)')+'_3.dat'

  OPENR,1,readfile1
  READU, 1, totbadvr1, totbadvr2, totbadvr3, totbindr1, totbindr2, totbindr3
  READU, 1, totbadvt1, totbadvt2, totbadvt3, totbindt1, totbindt2, totbindt3
  READU, 1, totbadvp1, totbadvp2, totbadvp3, totbindp1, totbindp2, totbindp3    
  CLOSE,1

  OPENR,2,readfile2
  READU, 2, totbadvr1s, totbadvr2s, totbadvr3s, totbindr1s, totbindr2s, totbindr3s
  READU, 2, totbadvt1s, totbadvt2s, totbadvt3s, totbindt1s, totbindt2s, totbindt3s
  READU, 2, totbadvp1s, totbadvp2s, totbadvp3s, totbindp1s, totbindp2s, totbindp3s    
  CLOSE,2

  OPENR,3,readfile3
  READU, 3, totbadvr1t, totbadvr2t, totbadvr3t, totbindr1t, totbindr2t, totbindr3t
  READU, 3, totbadvt1t, totbadvt2t, totbadvt3t, totbindt1t, totbindt2t, totbindt3t
  READU, 3, totbadvp1t, totbadvp2t, totbadvp3t, totbindp1t, totbindp2t, totbindp3t    
  CLOSE,3

  advr=totbadvr1+totbadvr2+totbadvr3
  indr=totbindr1+totbindr2+totbindr3
  advt=totbadvt1+totbadvt2+totbadvt3 
  indt=totbindt1+totbindt2+totbindt3
  advp=totbadvp1+totbadvp2+totbadvp3 
  indp=totbindp1+totbindp2+totbindp3

  advrs=totbadvr1s+totbadvr2s+totbadvr3s
  indrs=totbindr1s+totbindr2s+totbindr3s
  advts=totbadvt1s+totbadvt2s+totbadvt3s 
  indts=totbindt1s+totbindt2s+totbindt3s
  advps=totbadvp1s+totbadvp2s+totbadvp3s
  indps=totbindp1s+totbindp2s+totbindp3s

  advrt=totbadvr1t+totbadvr2t+totbadvr3t
  indrt=totbindr1t+totbindr2t+totbindr3t
  advtt=totbadvt1t+totbadvt2t+totbadvt3t 
  indtt=totbindt1t+totbindt2t+totbindt3t
  advpt=totbadvp1t+totbadvp2t+totbadvp3t
  indpt=totbindp1t+totbindp2t+totbindp3t


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

    totadvrs=totadvrs+advrs[*,*,j]
    totindrs=totindrs+indrs[*,*,j]
    totadvts=totadvts+advts[*,*,j]
    totindts=totindts+indts[*,*,j]
    totadvps=totadvps+advps[*,*,j]
    totindps=totindps+indps[*,*,j]
    abadvr1s=abadvr1s+totbadvr1s[*,*,j]
    abadvr2s=abadvr2s+totbadvr2s[*,*,j]
    abadvr3s=abadvr3s+totbadvr3s[*,*,j]
    abindr1s=abindr1s+totbindr1s[*,*,j]
    abindr2s=abindr2s+totbindr2s[*,*,j]
    abindr3s=abindr3s+totbindr3s[*,*,j]
    abadvt1s=abadvt1s+totbadvt1s[*,*,j]
    abadvt2s=abadvt2s+totbadvt2s[*,*,j]
    abadvt3s=abadvt3s+totbadvt3s[*,*,j]
    abindt1s=abindt1s+totbindt1s[*,*,j]
    abindt2s=abindt2s+totbindt2s[*,*,j]
    abindt3s=abindt3s+totbindt3s[*,*,j]
;;;;;;;;;;;;;;
    abadvp1s=abadvp1s+totbadvp1s[*,*,j]
    abadvp2s=abadvp2s+totbadvp2s[*,*,j]
    abadvp3s=abadvp3s+totbadvp3s[*,*,j]
    abindp1s=abindp1s+totbindp1s[*,*,j]
    abindp2s=abindp2s+totbindp2s[*,*,j]
    abindp3s=abindp3s+totbindp3s[*,*,j]
;;;;;;;;;;;;;;

    totadvrt=totadvrt+advrt[*,*,j]
    totindrt=totindrt+indrt[*,*,j]
    totadvtt=totadvtt+advtt[*,*,j]
    totindtt=totindtt+indtt[*,*,j]
    totadvpt=totadvpt+advpt[*,*,j]
    totindpt=totindpt+indpt[*,*,j]
    abadvr1t=abadvr1t+totbadvr1t[*,*,j]
    abadvr2t=abadvr2t+totbadvr2t[*,*,j]
    abadvr3t=abadvr3t+totbadvr3t[*,*,j]
    abindr1t=abindr1t+totbindr1t[*,*,j]
    abindr2t=abindr2t+totbindr2t[*,*,j]
    abindr3t=abindr3t+totbindr3t[*,*,j]
    abadvt1t=abadvt1t+totbadvt1t[*,*,j]
    abadvt2t=abadvt2t+totbadvt2t[*,*,j]
    abadvt3t=abadvt3t+totbadvt3t[*,*,j]
    abindt1t=abindt1t+totbindt1t[*,*,j]
    abindt2t=abindt2t+totbindt2t[*,*,j]
    abindt3t=abindt3t+totbindt3t[*,*,j]
;;;;;;;;;;;;;;
    abadvp1t=abadvp1t+totbadvp1t[*,*,j]
    abadvp2t=abadvp2t+totbadvp2t[*,*,j]
    abadvp3t=abadvp3t+totbadvp3t[*,*,j]
    abindp1t=abindp1t+totbindp1t[*,*,j]
    abindp2t=abindp2t+totbindp2t[*,*,j]
    abindp3t=abindp3t+totbindp3t[*,*,j]
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

  totadvrs=totadvrs/nj
  totindrs=totindrs/nj
  totadvts=totadvts/nj
  totindts=totindts/nj
  totadvps=totadvps/nj
  totindps=totindps/nj
  abadvr1s=abadvr1s/nj
  abadvr2s=abadvr2s/nj
  abadvr3s=abadvr3s/nj
  abindr1s=abindr1s/nj
  abindr2s=abindr2s/nj
  abindr3s=abindr3s/nj
  abadvt1s=abadvt1s/nj
  abadvt2s=abadvt2s/nj
  abadvt3s=abadvt3s/nj
  abindt1s=abindt1s/nj
  abindt2s=abindt2s/nj
  abindt3s=abindt3s/nj
;;;;;;;;;;;;;;;
  abadvp1s=abadvp1s/nj
  abadvp2s=abadvp2s/nj
  abadvp3s=abadvp3s/nj
  abindp1s=abindp1s/nj
  abindp2s=abindp2s/nj
  abindp3s=abindp3s/nj

  totadvrt=totadvrt/nj
  totindrt=totindrt/nj
  totadvtt=totadvtt/nj
  totindtt=totindtt/nj
  totadvpt=totadvpt/nj
  totindpt=totindpt/nj
  abadvr1t=abadvr1t/nj
  abadvr2t=abadvr2t/nj
  abadvr3t=abadvr3t/nj
  abindr1t=abindr1t/nj
  abindr2t=abindr2t/nj
  abindr3t=abindr3t/nj
  abadvt1t=abadvt1t/nj
  abadvt2t=abadvt2t/nj
  abadvt3t=abadvt3t/nj
  abindt1t=abindt1t/nj
  abindt2t=abindt2t/nj
  abindt3t=abindt3t/nj
;;;;;;;;;;;;;;;
  abadvp1t=abadvp1t/nj
  abadvp2t=abadvp2t/nj
  abadvp3t=abadvp3t/nj
  abindp1t=abindp1t/nj
  abindp2t=abindp2t/nj
  abindp3t=abindp3t/nj

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
  print, '22',MAX(abindp1), MIN(abindp1)
  print, '23',MAX(abindp2)
  print, '24',MAX(abindp3)
;;;;;;;;;;;;;;;
; Making the inner core white

  maxar=MAX([MAX(totadvr),MAX(totadvrs),MAX(totadvrt)])
  maxir=MAX([MAX(totindr),MAX(totindrs),MAX(totindrt)])
  maxat=MAX([MAX(totadvt),MAX(totadvts),MAX(totadvtt)])
  maxit=MAX([MAX(totindt),MAX(totindts),MAX(totindtt)])
  maxap=MAX([MAX(totadvp),MAX(totadvps),MAX(totadvpt)])
  maxip=MAX([MAX(totindp),MAX(totindps),MAX(totindpt)])
  maxar1=MAX([MAX(abadvr1),MAX(abadvr1s),MAX(abadvr1t)])
  maxir1=MAX([MAX(abindr1),MAX(abindr1s),MAX(abindr1t)])
  maxar2=MAX([MAX(abadvr2),MAX(abadvr2s),MAX(abadvr2t)])
  maxir2=MAX([MAX(abindr2),MAX(abindr2s),MAX(abindr2t)])
  maxar3=MAX([MAX(abadvr3),MAX(abadvr3s),MAX(abadvr3t)])
  maxir3=MAX([MAX(abindr3),MAX(abindr3s),MAX(abindr3t)])
  maxat1=MAX([MAX(abadvt1),MAX(abadvt1s),MAX(abadvt1t)])
  maxit1=MAX([MAX(abindt1),MAX(abindt1s),MAX(abindt1t)])
  maxat2=MAX([MAX(abadvt2),MAX(abadvt2s),MAX(abadvt2t)])
  maxit2=MAX([MAX(abindt2),MAX(abindt2s),MAX(abindt2t)])
  maxat3=MAX([MAX(abadvt3),MAX(abadvt3s),MAX(abadvt3t)])
  maxit3=MAX([MAX(abindt3),MAX(abindt3s),MAX(abindt3t)])
  maxap1=MAX([MAX(abadvp1),MAX(abadvp1s),MAX(abadvp1t)])
  maxip1=MAX([MAX(abindp1),MAX(abindp1s),MAX(abindp1t)])
  maxap2=MAX([MAX(abadvp2),MAX(abadvp2s),MAX(abadvp2t)])
  maxip2=MAX([MAX(abindp2),MAX(abindp2s),MAX(abindp2t)])
  maxap3=MAX([MAX(abadvp3),MAX(abadvp3s),MAX(abadvp3t)])
  maxip3=MAX([MAX(abindp3),MAX(abindp3s),MAX(abindp3t)])

  minar=MIN([MIN(totadvr),MIN(totadvrs),MIN(totadvrt)])
  minir=MIN([MIN(totindr),MIN(totindrs),MIN(totindrt)])
  minat=MIN([MIN(totadvt),MIN(totadvts),MIN(totadvtt)])
  minit=MIN([MIN(totindt),MIN(totindts),MIN(totindtt)])
  minap=MIN([MIN(totadvp),MIN(totadvps),MIN(totadvpt)])
  minip=MIN([MIN(totindp),MIN(totindps),MIN(totindpt)])
  minar1=MIN([MIN(abadvr1),MIN(abadvr1s),MIN(abadvr1t)])
  minir1=MIN([MIN(abindr1),MIN(abindr1s),MIN(abindr1t)])
  minar2=MIN([MIN(abadvr2),MIN(abadvr2s),MIN(abadvr2t)])
  minir2=MIN([MIN(abindr2),MIN(abindr2s),MIN(abindr2t)])
  minar3=MIN([MIN(abadvr3),MIN(abadvr3s),MIN(abadvr3t)])
  minir3=MIN([MIN(abindr3),MIN(abindr3s),MIN(abindr3t)])
  minat1=MIN([MIN(abadvt1),MIN(abadvt1s),MIN(abadvt1t)])
  minit1=MIN([MIN(abindt1),MIN(abindt1s),MIN(abindt1t)])
  minat2=MIN([MIN(abadvt2),MIN(abadvt2s),MIN(abadvt2t)])
  minit2=MIN([MIN(abindt2),MIN(abindt2s),MIN(abindt2t)])
  minat3=MIN([MIN(abadvt3),MIN(abadvt3s),MIN(abadvt3t)])
  minit3=MIN([MIN(abindt3),MIN(abindt3s),MIN(abindt3t)])
  minap1=MIN([MIN(abadvp1),MIN(abadvp1s),MIN(abadvp1t)])
  minip1=MIN([MIN(abindp1),MIN(abindp1s),MIN(abindp1t)])
  minap2=MIN([MIN(abadvp2),MIN(abadvp2s),MIN(abadvp2t)])
  minip2=MIN([MIN(abindp2),MIN(abindp2s),MIN(abindp2t)])
  minap3=MIN([MIN(abadvp3),MIN(abadvp3s),MIN(abadvp3t)])
  minip3=MIN([MIN(abindp3),MIN(abindp3s),MIN(abindp3t)])

  levar=minar+(maxar-minar)*findgen(nlevels)/(nlevels-1.)
  levir=minir+(maxir-minir)*findgen(nlevels)/(nlevels-1.)
  levat=minat+(maxat-minat)*findgen(nlevels)/(nlevels-1.)
  levit=minit+(maxit-minit)*findgen(nlevels)/(nlevels-1.)
  levap=minap+(maxap-minap)*findgen(nlevels)/(nlevels-1.)
  levip=minip+(maxip-minip)*findgen(nlevels)/(nlevels-1.)
  levar1=minar1+(maxar1-minar1)*findgen(nlevels)/(nlevels-1.)
  levir1=minir1+(maxir1-minir1)*findgen(nlevels)/(nlevels-1.)
  levar2=minar2+(maxar2-minar2)*findgen(nlevels)/(nlevels-1.)
  levir2=minir2+(maxir2-minir2)*findgen(nlevels)/(nlevels-1.)
  levar3=minar3+(maxar3-minar3)*findgen(nlevels)/(nlevels-1.)
  levir3=minir3+(maxir3-minir3)*findgen(nlevels)/(nlevels-1.)
  levat1=minat1+(maxat1-minat1)*findgen(nlevels)/(nlevels-1.)
  levit1=minit1+(maxit1-minit1)*findgen(nlevels)/(nlevels-1.)
  levat2=minat2+(maxat2-minat2)*findgen(nlevels)/(nlevels-1.)
  levit2=minit2+(maxit2-minit2)*findgen(nlevels)/(nlevels-1.)
  levat3=minat3+(maxat3-minat3)*findgen(nlevels)/(nlevels-1.)
  levit3=minit3+(maxit3-minit3)*findgen(nlevels)/(nlevels-1.)
  levap1=minap1+(maxap1-minap1)*findgen(nlevels)/(nlevels-1.)
  levip1=minip1+(maxip1-minip1)*findgen(nlevels)/(nlevels-1.)
  levap2=minap2+(maxap2-minap2)*findgen(nlevels)/(nlevels-1.)
  levip2=minip2+(maxip2-minip2)*findgen(nlevels)/(nlevels-1.)
  levap3=minap3+(maxap3-minap3)*findgen(nlevels)/(nlevels-1.)
  levip3=minip3+(maxip3-minip3)*findgen(nlevels)/(nlevels-1.)

  blankadvr=dblarr(ni,radbot)
  blankadvr[*]=maxar
  blankindr=dblarr(ni,radbot)
  blankindr[*]=maxir

  blankadvt=dblarr(ni,radbot)
  blankadvt[*]=maxat
  blankindt=dblarr(ni,radbot)
  blankindt[*]=maxit
;;;;;;;;;;;;;
  blankadvp=dblarr(ni,radbot)
  blankadvp[*]=maxap
  blankindp=dblarr(ni,radbot)
  blankindp[*]=maxip
;;;;;;;;;;;;;
  blankadvr1=dblarr(ni,radbot)
  blankadvr1[*]=maxar1
  blankindr1=dblarr(ni,radbot)
  blankindr1[*]=maxir1

  blankadvr2=dblarr(ni,radbot)
  blankadvr2[*]=maxar2
  blankindr2=dblarr(ni,radbot)
  blankindr2[*]=maxir2

  blankadvr3=dblarr(ni,radbot)
  blankadvr3[*]=maxar3
  blankindr3=dblarr(ni,radbot)
  blankindr3[*]=maxir3

  blankadvt1=dblarr(ni,radbot)
  blankadvt1[*]=maxat1
  blankindt1=dblarr(ni,radbot)
  blankindt1[*]=maxit1

  blankadvt2=dblarr(ni,radbot)
  blankadvt2[*]=maxat2
  blankindt2=dblarr(ni,radbot)
  blankindt2[*]=maxit2

  blankadvt3=dblarr(ni,radbot)
  blankadvt3[*]=maxat3
  blankindt3=dblarr(ni,radbot)
  blankindt3[*]=maxit3
;;;;;;;;;;;;;
  blankadvp1=dblarr(ni,radbot)
  blankadvp1[*]=maxap1
  blankindp1=dblarr(ni,radbot)
  blankindp1[*]=maxip1

  blankadvp2=dblarr(ni,radbot)
  blankadvp2[*]=maxap2
  blankindp2=dblarr(ni,radbot)
  blankindp2[*]=maxip2

  blankadvp3=dblarr(ni,radbot)
  blankadvp3[*]=maxap3
  blankindp3=dblarr(ni,radbot)
  blankindp3[*]=maxip3
;;;;;;;;;;;;;;

; Converting from cartesian to polar
  colatitude=findgen(ni)/float(ni-1)*!PI
  rad=radtop-(radtop-radbot)*findgen(nn)/float(nn-1)
  radb=radbot-float(radbot)*findgen(radbot)/(float(radbot)-1.)

;; Colored contour plot of time averaged B_r inductive averaged in longitude  
;  window, 0, XSIZE=575, YSIZE=750
;  loadct, 39
;  device, decompose=0
;  polar_contour2, transpose(totadvr), colatitude, rad,$
;       BACKGROUND=255, COLOR=0, /FILL, LEVELS=levar,$
;       TITLE= 'B_r advective', /ISOTROPIC, xstyle=1, ystyle=1,$
;       CHARSIZE=1.5, XRANGE=[0,50], YRANGE=[-50,50]
;  polar_contour2, blankadvr, colatitude, radb, $
;        /CELL_FILL, NLEVEL=1, /OVERPLOT
;  COLORBAR, COLOR=0, DIVISIONS=4, FORMAT='(e10.3)', $
;       POSITION=[0.79, 0.08, 0.83, 0.96], /VERTICAL, /RIGHT,  $
;       CHARSIZE=1.25, MAX=MAX(levar), MIN=MIN(levar)
;
;; Colored contour plot of time averaged B_r inductive averaged in longitude
;  window, 1, XSIZE=575, YSIZE=750
;  loadct, 39
;  device, decompose=0
;  polar_contour2, transpose(totindr), colatitude, rad,$
;       BACKGROUND=255, COLOR=0, /FILL, LEVELS=levir,$
;       TITLE= 'B_r inductive', xstyle=1, ystyle=1,$
;       CHARSIZE=1.5, XRANGE=[0,50], /ISOTROPIC, yrange=[-50,50]
;  polar_contour2, blankindr, colatitude, radb, $
;        /CELL_FILL, NLEVEL=1, /OVERPLOT
;  COLORBAR, COLOR=0, DIVISIONS=4, FORMAT='(e10.3)', $
;       POSITION=[0.79, 0.08, 0.83, 0.96], /VERTICAL, /RIGHT,  $
;       CHARSIZE=1.25, MAX=MAX(levir), MIN=MIN(levir)
;
;; Colored contour plot of time averaged B_theta advective averaged in longitude  
;  window, 2, XSIZE=575, YSIZE=750
;  loadct, 39
;  device, decompose=0
;  polar_contour2, transpose(totadvt), colatitude, rad,$
;       BACKGROUND=255, COLOR=0, /FILL, LEVELS=levat,$
;       TITLE= 'B_theta advective', /ISOTROPIC, xstyle=1, ystyle=1,$
;       CHARSIZE=1.5, XRANGE=[0,50], YRANGE=[-50,50]
;  polar_contour2, blankadvt, colatitude, radb, $
;        /CELL_FILL, NLEVEL=1, /OVERPLOT
;  COLORBAR, COLOR=0, DIVISIONS=4, FORMAT='(e10.3)', $
;       POSITION=[0.79, 0.08, 0.83, 0.96], /VERTICAL, /RIGHT,  $
;       CHARSIZE=1.25, MAX=MAX(levat), MIN=MIN(levat)
;
;; Colored contour plot of time averaged B_theta inductive averaged in longitude
;  window, 3, XSIZE=575, YSIZE=750
;  loadct, 39
;  device, decompose=0
;  polar_contour2, transpose(totindt), colatitude, rad,$
;       BACKGROUND=255, COLOR=0, /FILL, LEVELS=levit,$
;       TITLE= 'B_theta inductive', xstyle=1, ystyle=1,$
;       CHARSIZE=1.5, XRANGE=[0,50], /ISOTROPIC, yrange=[-50,50]
;  polar_contour2, blankindt, colatitude, radb, $
;        /CELL_FILL, NLEVEL=1, /OVERPLOT
;  COLORBAR, COLOR=0, DIVISIONS=4, FORMAT='(e10.3)', $
;       POSITION=[0.79, 0.08, 0.83, 0.96], /VERTICAL, /RIGHT,  $
;       CHARSIZE=1.25, MAX=MAX(levit), MIN=MIN(levit)
;;;;;;;;;;;;;;;;;;;;;;
;; Colored contour plot of time averaged B_phi advective averaged in longitude  
;  window, 4, XSIZE=575, YSIZE=750
;  loadct, 39
;  device, decompose=0
;  polar_contour2, transpose(totadvp), colatitude, rad,$
;       BACKGROUND=255, COLOR=0, /FILL, LEVELS=levap,$
;       TITLE= 'B_phi advective', /ISOTROPIC, xstyle=1, ystyle=1,$
;       CHARSIZE=1.5, XRANGE=[0,50], YRANGE=[-50,50]
;  polar_contour2, blankadvp, colatitude, radb, $
;        /CELL_FILL, NLEVEL=1, /OVERPLOT
;  COLORBAR, COLOR=0, DIVISIONS=4, FORMAT='(e10.3)', $
;       POSITION=[0.79, 0.08, 0.83, 0.96], /VERTICAL, /RIGHT,  $
;       CHARSIZE=1.25, MAX=MAX(levap), MIN=MIN(levap)
;
;; Colored contour plot of time averaged B_phi inductive averaged in longitude
;  window, 5, XSIZE=575, YSIZE=750
;  loadct, 39
;  device, decompose=0
;  polar_contour2, transpose(totindp), colatitude, rad,$
;       BACKGROUND=255, COLOR=0, /FILL, LEVELS=levip,$
;       TITLE= 'B_phi inductive', xstyle=1, ystyle=1,$
;       CHARSIZE=1.5, XRANGE=[0,50], /ISOTROPIC, yrange=[-50,50]
;  polar_contour2, blankindp, colatitude, radb, $
;        /CELL_FILL, NLEVEL=1, /OVERPLOT
;  COLORBAR, COLOR=0, DIVISIONS=4, FORMAT='(e10.3)', $
;       POSITION=[0.79, 0.08, 0.83, 0.96], /VERTICAL, /RIGHT,  $
;       CHARSIZE=1.25, MAX=MAX(levip), MIN=MIN(levip)
;;;;;;;;;;;;;;;;;;;;;
;; Colored contour plot of time averaged B_r1 inductive averaged in longitude  
;  window, 6, XSIZE=575, YSIZE=750
;  loadct, 39
;  device, decompose=0
;  polar_contour2, transpose(abadvr1), colatitude, rad,$
;       BACKGROUND=255, COLOR=0, /FILL, LEVELS=levar1,$
;       TITLE= 'B_r1 advective', /ISOTROPIC, xstyle=1, ystyle=1,$
;       CHARSIZE=1.5, XRANGE=[0,50], YRANGE=[-50,50]
;  polar_contour2, blankadvr1, colatitude, radb, $
;        /CELL_FILL, NLEVEL=1, /OVERPLOT
;  COLORBAR, COLOR=0, DIVISIONS=4, FORMAT='(e10.3)', $
;       POSITION=[0.79, 0.08, 0.83, 0.96], /VERTICAL, /RIGHT,  $
;       CHARSIZE=1.25, MAX=MAX(levar1), MIN=MIN(levar1)
;
;; Colored contour plot of time averaged B_r1 inductive averaged in longitude
;  window, 7, XSIZE=575, YSIZE=750
;  loadct, 39
;  device, decompose=0
;  polar_contour2, transpose(abindr1), colatitude, rad,$
;       BACKGROUND=255, COLOR=0, /FILL, LEVELS=levir1,$
;       TITLE= 'B_r1 inductive', xstyle=1, ystyle=1,$
;       CHARSIZE=1.5, XRANGE=[0,50], /ISOTROPIC, yrange=[-50,50]
;  polar_contour2, blankindr1, colatitude, radb, $
;        /CELL_FILL, NLEVEL=1, /OVERPLOT
;  COLORBAR, COLOR=0, DIVISIONS=4, FORMAT='(e10.3)', $
;       POSITION=[0.79, 0.08, 0.83, 0.96], /VERTICAL, /RIGHT,  $
;       CHARSIZE=1.25, MAX=MAX(levir1), MIN=MIN(levir1)
;
;; Colored contour plot of time averaged B_r2 advective averaged in longitude  
;  window, 8, XSIZE=575, YSIZE=750
;  loadct, 39
;  device, decompose=0
;  polar_contour2, transpose(abadvr2), colatitude, rad,$
;       BACKGROUND=255, COLOR=0, /FILL, LEVELS=levar2,$
;       TITLE= 'B_r2 advective', /ISOTROPIC, xstyle=1, ystyle=1,$
;       CHARSIZE=1.5, XRANGE=[0,50], YRANGE=[-50,50]
;  polar_contour2, blankadvr2, colatitude, radb, $
;        /CELL_FILL, NLEVEL=1, /OVERPLOT
;  COLORBAR, COLOR=0, DIVISIONS=4, FORMAT='(e10.3)', $
;       POSITION=[0.79, 0.08, 0.83, 0.96], /VERTICAL, /RIGHT,  $
;       CHARSIZE=1.25, MAX=MAX(levar2), MIN=MIN(levar2)
;
;; Colored contour plot of time averaged B_r2 inductive averaged in longitude
;  window, 9, XSIZE=575, YSIZE=750
;  loadct, 39
;  device, decompose=0
;  polar_contour2, transpose(abindr2), colatitude, rad,$
;       BACKGROUND=255, COLOR=0, /FILL, LEVELS=levir2,$
;       TITLE= 'B_r2 inductive', xstyle=1, ystyle=1,$
;       CHARSIZE=1.5, XRANGE=[0,50], /ISOTROPIC, yrange=[-50,50]
;  polar_contour2, blankindr2, colatitude, radb, $
;        /CELL_FILL, NLEVEL=1, /OVERPLOT
;  COLORBAR, COLOR=0, DIVISIONS=4, FORMAT='(e10.3)', $
;       POSITION=[0.79, 0.08, 0.83, 0.96], /VERTICAL, /RIGHT,  $
;       CHARSIZE=1.25, MAX=MAX(levir2), MIN=MIN(levir2)
;
;; Colored contour plot of time averaged B_r3 advective averaged in longitude  
;  window, 10, XSIZE=575, YSIZE=750
;  loadct, 39
;  device, decompose=0
;  polar_contour2, transpose(abadvr3), colatitude, rad,$
;       BACKGROUND=255, COLOR=0, /FILL, LEVELS=levar3,$
;       TITLE= 'B_r3 advective', /ISOTROPIC, xstyle=1, ystyle=1,$
;       CHARSIZE=1.5, XRANGE=[0,50], YRANGE=[-50,50]
;  polar_contour2, blankadvr3, colatitude, radb, $
;        /CELL_FILL, NLEVEL=1, /OVERPLOT
;  COLORBAR, COLOR=0, DIVISIONS=4, FORMAT='(e10.3)', $
;       POSITION=[0.79, 0.08, 0.83, 0.96], /VERTICAL, /RIGHT,  $
;       CHARSIZE=1.25, MAX=MAX(levar3), MIN=MIN(levar3)
;
;; Colored contour plot of time averaged B_r3 inductive averaged in longitude
;  window, 11, XSIZE=575, YSIZE=750
;  loadct, 39
;  device, decompose=0
;  polar_contour2, transpose(abindr3), colatitude, rad,$
;       BACKGROUND=255, COLOR=0, /FILL, LEVELS=levir3,$
;       TITLE= 'B_r3 inductive', xstyle=1, ystyle=1,$
;       CHARSIZE=1.5, XRANGE=[0,50], /ISOTROPIC, yrange=[-50,50]
;  polar_contour2, blankindr3, colatitude, radb, $
;        /CELL_FILL, NLEVEL=1, /OVERPLOT
;  COLORBAR, COLOR=0, DIVISIONS=4, FORMAT='(e10.3)', $
;       POSITION=[0.79, 0.08, 0.83, 0.96], /VERTICAL, /RIGHT,  $
;       CHARSIZE=1.25, MAX=MAX(levir3), MIN=MIN(levir3)
;
;; Colored contour plot of time averaged B_theta1 inductive averaged in longitude  
;  window, 12, XSIZE=575, YSIZE=750
;  loadct, 39
;  device, decompose=0
;  polar_contour2, transpose(abadvt1), colatitude, rad,$
;       BACKGROUND=255, COLOR=0, /FILL, LEVELS=levat1,$
;       TITLE= 'B_theta1 advective', /ISOTROPIC, xstyle=1, ystyle=1,$
;       CHARSIZE=1.5, XRANGE=[0,50], YRANGE=[-50,50]
;  polar_contour2, blankadvt1, colatitude, radb, $
;        /CELL_FILL, NLEVEL=1, /OVERPLOT
;  COLORBAR, COLOR=0, DIVISIONS=4, FORMAT='(e10.3)', $
;       POSITION=[0.79, 0.08, 0.83, 0.96], /VERTICAL, /RIGHT,  $
;       CHARSIZE=1.25, MAX=MAX(levat1), MIN=MIN(levat1)
;
;; Colored contour plot of time averaged B_theta1 inductive averaged in longitude
;  window, 13, XSIZE=575, YSIZE=750
;  loadct, 39
;  device, decompose=0
;  polar_contour2, transpose(abindt1), colatitude, rad,$
;       BACKGROUND=255, COLOR=0, /FILL, LEVELS=levit1,$
;       TITLE= 'B_theta1 inductive', xstyle=1, ystyle=1,$
;       CHARSIZE=1.5, XRANGE=[0,50], /ISOTROPIC, yrange=[-50,50]
;  polar_contour2, blankindt1, colatitude, radb, $
;        /CELL_FILL, NLEVEL=1, /OVERPLOT
;  COLORBAR, COLOR=0, DIVISIONS=4, FORMAT='(e10.3)', $
;       POSITION=[0.79, 0.08, 0.83, 0.96], /VERTICAL, /RIGHT,  $
;       CHARSIZE=1.25, MAX=MAX(levit1), MIN=MIN(levit1)
;
;; Colored contour plot of time averaged B_theta2 advective averaged in longitude  
;  window, 14, XSIZE=575, YSIZE=750
;  loadct, 39
;  device, decompose=0
;  polar_contour2, transpose(abadvt2), colatitude, rad,$
;       BACKGROUND=255, COLOR=0, /FILL, LEVELS=levat2,$
;       TITLE= 'B_theta2 advective', /ISOTROPIC, xstyle=1, ystyle=1,$
;       CHARSIZE=1.5, XRANGE=[0,50], YRANGE=[-50,50]
;  polar_contour2, blankadvt2, colatitude, radb, $
;        /CELL_FILL, NLEVEL=1, /OVERPLOT
;  COLORBAR, COLOR=0, DIVISIONS=4, FORMAT='(e10.3)', $
;       POSITION=[0.79, 0.08, 0.83, 0.96], /VERTICAL, /RIGHT,  $
;       CHARSIZE=1.25, MAX=MAX(levat2), MIN=MIN(levat2)
;
;; Colored contour plot of time averaged B_theta2 inductive averaged in longitude
;  window, 15, XSIZE=575, YSIZE=750
;  loadct, 39
;  device, decompose=0
;  polar_contour2, transpose(abindt2), colatitude, rad,$
;       BACKGROUND=255, COLOR=0, /FILL, LEVELS=levit2,$
;       TITLE= 'B_theta2 inductive', xstyle=1, ystyle=1,$
;       CHARSIZE=1.5, XRANGE=[0,50], /ISOTROPIC, yrange=[-50,50]
;  polar_contour2, blankindt2, colatitude, radb, $
;        /CELL_FILL, NLEVEL=1, /OVERPLOT
;  COLORBAR, COLOR=0, DIVISIONS=4, FORMAT='(e10.3)', $
;       POSITION=[0.79, 0.08, 0.83, 0.96], /VERTICAL, /RIGHT,  $
;       CHARSIZE=1.25, MAX=MAX(levit2), MIN=MIN(levit2)
;
;; Colored contour plot of time averaged B_theta3 advective averaged in longitude  
;  window, 16, XSIZE=575, YSIZE=750
;  loadct, 39
;  device, decompose=0
;  polar_contour2, transpose(abadvt3), colatitude, rad,$
;       BACKGROUND=255, COLOR=0, /FILL, LEVELS=levat3,$
;       TITLE= 'B_theta3 advective', /ISOTROPIC, xstyle=1, ystyle=1,$
;       CHARSIZE=1.5, XRANGE=[0,50], YRANGE=[-50,50]
;  polar_contour2, blankadvt3, colatitude, radb, $
;        /CELL_FILL, NLEVEL=1, /OVERPLOT
;  COLORBAR, COLOR=0, DIVISIONS=4, FORMAT='(e10.3)', $
;       POSITION=[0.79, 0.08, 0.83, 0.96], /VERTICAL, /RIGHT,  $
;       CHARSIZE=1.25, MAX=MAX(levat3), MIN=MIN(levat3)
;
;; Colored contour plot of time averaged B_theta3 inductive averaged in longitude
;  window, 17, XSIZE=575, YSIZE=750
;  loadct, 39
;  device, decompose=0
;  polar_contour2, transpose(abindt3), colatitude, rad,$
;       BACKGROUND=255, COLOR=0, /FILL, LEVELS=levit3,$
;       TITLE= 'B_theta3 inductive', xstyle=1, ystyle=1,$
;       CHARSIZE=1.5, XRANGE=[0,50], /ISOTROPIC, yrange=[-50,50]
;  polar_contour2, blankindt3, colatitude, radb, $
;        /CELL_FILL, NLEVEL=1, /OVERPLOT
;  COLORBAR, COLOR=0, DIVISIONS=4, FORMAT='(e10.3)', $
;       POSITION=[0.79, 0.08, 0.83, 0.96], /VERTICAL, /RIGHT,  $
;       CHARSIZE=1.25, MAX=MAX(levit3), MIN=MIN(levit3)
;;;;;;;;;;;;;;;;;;;;;
;; Colored contour plot of time averaged B_phi1 inductive averaged in longitude  
;  window, 18, XSIZE=575, YSIZE=750
;  loadct, 39
;  device, decompose=0
;  polar_contour2, transpose(abadvp1), colatitude, rad,$
;       BACKGROUND=255, COLOR=0, /FILL, LEVELS=levap1,$
;       TITLE= 'B_phi1 advective', /ISOTROPIC, xstyle=1, ystyle=1,$
;       CHARSIZE=1.5, XRANGE=[0,50], YRANGE=[-50,50]
;  polar_contour2, blankadvp1, colatitude, radb, $
;        /CELL_FILL, NLEVEL=1, /OVERPLOT
;  COLORBAR, COLOR=0, DIVISIONS=4, FORMAT='(e10.3)', $
;       POSITION=[0.79, 0.08, 0.83, 0.96], /VERTICAL, /RIGHT,  $
;       CHARSIZE=1.25, MAX=MAX(levap1), MIN=MIN(levap1)
;
;; Colored contour plot of time averaged B_phi1 inductive averaged in longitude
;  window, 19, XSIZE=575, YSIZE=750
;  loadct, 39
;  device, decompose=0
;  polar_contour2, transpose(abindp1), colatitude, rad,$
;       BACKGROUND=255, COLOR=0, /FILL, LEVELS=levip1,$
;       TITLE= 'B_phi1 inductive', xstyle=1, ystyle=1,$
;       CHARSIZE=1.5, XRANGE=[0,50], /ISOTROPIC, yrange=[-50,50]
;  polar_contour2, blankindp1, colatitude, radb, $
;        /CELL_FILL, NLEVEL=1, /OVERPLOT
;  COLORBAR, COLOR=0, DIVISIONS=4, FORMAT='(e10.3)', $
;       POSITION=[0.79, 0.08, 0.83, 0.96], /VERTICAL, /RIGHT,  $
;       CHARSIZE=1.25, MAX=MAX(levip1), MIN=MIN(levip1)
;
;; Colored contour plot of time averaged B_phi2 advective averaged in longitude  
;  window, 20, XSIZE=575, YSIZE=750
;  loadct, 39
;  device, decompose=0
;  polar_contour2, transpose(abadvp2), colatitude, rad,$
;       BACKGROUND=255, COLOR=0, /FILL, LEVELS=levap2,$
;       TITLE= 'B_phi2 advective', /ISOTROPIC, xstyle=1, ystyle=1,$
;       CHARSIZE=1.5, XRANGE=[0,50], YRANGE=[-50,50]
;  polar_contour2, blankadvp2, colatitude, radb, $
;        /CELL_FILL, NLEVEL=1, /OVERPLOT
;  COLORBAR, COLOR=0, DIVISIONS=4, FORMAT='(e10.3)', $
;       POSITION=[0.79, 0.08, 0.83, 0.96], /VERTICAL, /RIGHT,  $
;       CHARSIZE=1.25, MAX=MAX(levap2), MIN=MIN(levap2)
;
;; Colored contour plot of time averaged B_phi2 inductive averaged in longitude
;  window, 21, XSIZE=575, YSIZE=750
;  loadct, 39
;  device, decompose=0
;  polar_contour2, transpose(abindp2), colatitude, rad,$
;       BACKGROUND=255, COLOR=0, /FILL, LEVELS=levip2,$
;       TITLE= 'B_phi2 inductive', xstyle=1, ystyle=1,$
;       CHARSIZE=1.5, XRANGE=[0,50], /ISOTROPIC, yrange=[-50,50]
;  polar_contour2, blankindp2, colatitude, radb, $
;        /CELL_FILL, NLEVEL=1, /OVERPLOT
;  COLORBAR, COLOR=0, DIVISIONS=4, FORMAT='(e10.3)', $
;       POSITION=[0.79, 0.08, 0.83, 0.96], /VERTICAL, /RIGHT,  $
;       CHARSIZE=1.25, MAX=MAX(levip2), MIN=MIN(levip2)
;
;; Colored contour plot of time averaged B_phi3 advective averaged in longitude  
;  window, 22, XSIZE=575, YSIZE=750
;  loadct, 39
;  device, decompose=0
;  polar_contour2, transpose(abadvp3), colatitude, rad,$
;       BACKGROUND=255, COLOR=0, /FILL, LEVELS=levap3,$
;       TITLE= 'B_phi3 advective', /ISOTROPIC, xstyle=1, ystyle=1,$
;       CHARSIZE=1.5, XRANGE=[0,50], YRANGE=[-50,50]
;  polar_contour2, blankadvp3, colatitude, radb, $
;        /CELL_FILL, NLEVEL=1, /OVERPLOT
;  COLORBAR, COLOR=0, DIVISIONS=4, FORMAT='(e10.3)', $
;       POSITION=[0.79, 0.08, 0.83, 0.96], /VERTICAL, /RIGHT,  $
;       CHARSIZE=1.25, MAX=MAX(levap3), MIN=MIN(levap3)
;
;; Colored contour plot of time averaged B_phi3 inductive averaged in longitude
;  window, 23, XSIZE=575, YSIZE=750
;  loadct, 39
;  device, decompose=0
;  polar_contour2, transpose(abindp3), colatitude, rad,$
;       BACKGROUND=255, COLOR=0, /FILL, LEVELS=levip3,$
;       TITLE= 'B_phi3 inductive', xstyle=1, ystyle=1,$
;       CHARSIZE=1.5, XRANGE=[0,50], /ISOTROPIC, yrange=[-50,50]
;  polar_contour2, blankindp3, colatitude, radb, $
;        /CELL_FILL, NLEVEL=1, /OVERPLOT
;  COLORBAR, COLOR=0, DIVISIONS=4, FORMAT='(e10.3)', $
;       POSITION=[0.79, 0.08, 0.83, 0.96], /VERTICAL, /RIGHT,  $
;       CHARSIZE=1.25, MAX=MAX(levip3), MIN=MIN(levip3)
;
;; Colored contour plot of time averaged B_r inductive averaged in longitude  
;  window, 0, XSIZE=575, YSIZE=750
;  loadct, 39
;  device, decompose=0
;  polar_contour2, transpose(totadvrs), colatitude, rad,$
;       BACKGROUND=255, COLOR=0, /FILL, LEVELS=levar,$
;       TITLE= 'B_r advective non-dynamo', /ISOTROPIC, xstyle=1, ystyle=1,$
;       CHARSIZE=1.5, XRANGE=[0,50], YRANGE=[-50,50]
;  polar_contour2, blankadvr, colatitude, radb, $
;        /CELL_FILL, NLEVEL=1, /OVERPLOT
;  COLORBAR, COLOR=0, DIVISIONS=4, FORMAT='(e10.3)', $
;       POSITION=[0.79, 0.08, 0.83, 0.96], /VERTICAL, /RIGHT,  $
;       CHARSIZE=1.25, MAX=MAX(levar), MIN=MIN(levar)
;
;; Colored contour plot of time averaged B_r inductive averaged in longitude
;  window, 1, XSIZE=575, YSIZE=750
;  loadct, 39
;  device, decompose=0
;  polar_contour2, transpose(totindrs), colatitude, rad,$
;       BACKGROUND=255, COLOR=0, /FILL, LEVELS=levir,$
;       TITLE= 'B_r inductive non-dynamo', xstyle=1, ystyle=1,$
;       CHARSIZE=1.5, XRANGE=[0,50], /ISOTROPIC, yrange=[-50,50]
;  polar_contour2, blankindr, colatitude, radb, $
;        /CELL_FILL, NLEVEL=1, /OVERPLOT
;  COLORBAR, COLOR=0, DIVISIONS=4, FORMAT='(e10.3)', $
;       POSITION=[0.79, 0.08, 0.83, 0.96], /VERTICAL, /RIGHT,  $
;       CHARSIZE=1.25, MAX=MAX(levir), MIN=MIN(levir)
;
;; Colored contour plot of time averaged B_theta advective averaged in longitude  
;  window, 2, XSIZE=575, YSIZE=750
;  loadct, 39
;  device, decompose=0
;  polar_contour2, transpose(totadvts), colatitude, rad,$
;       BACKGROUND=255, COLOR=0, /FILL, LEVELS=levat,$
;       TITLE= 'B_theta advective non-dynamo', /ISOTROPIC, xstyle=1, ystyle=1,$
;       CHARSIZE=1.5, XRANGE=[0,50], YRANGE=[-50,50]
;  polar_contour2, blankadvt, colatitude, radb, $
;        /CELL_FILL, NLEVEL=1, /OVERPLOT
;  COLORBAR, COLOR=0, DIVISIONS=4, FORMAT='(e10.3)', $
;       POSITION=[0.79, 0.08, 0.83, 0.96], /VERTICAL, /RIGHT,  $
;       CHARSIZE=1.25, MAX=MAX(levat), MIN=MIN(levat)
;
;; Colored contour plot of time averaged B_theta inductive averaged in longitude
;  window, 3, XSIZE=575, YSIZE=750
;  loadct, 39
;  device, decompose=0
;  polar_contour2, transpose(totindts), colatitude, rad,$
;       BACKGROUND=255, COLOR=0, /FILL, LEVELS=levit,$
;       TITLE= 'B_theta inductive non-dynamo', xstyle=1, ystyle=1,$
;       CHARSIZE=1.5, XRANGE=[0,50], /ISOTROPIC, yrange=[-50,50]
;  polar_contour2, blankindt, colatitude, radb, $
;        /CELL_FILL, NLEVEL=1, /OVERPLOT
;  COLORBAR, COLOR=0, DIVISIONS=4, FORMAT='(e10.3)', $
;       POSITION=[0.79, 0.08, 0.83, 0.96], /VERTICAL, /RIGHT,  $
;       CHARSIZE=1.25, MAX=MAX(levit), MIN=MIN(levit)
;;;;;;;;;;;;;;;;;;;;;;
;; Colored contour plot of time averaged B_phi advective averaged in longitude  
;  window, 4, XSIZE=575, YSIZE=750
;  loadct, 39
;  device, decompose=0
;  polar_contour2, transpose(totadvps), colatitude, rad,$
;       BACKGROUND=255, COLOR=0, /FILL, LEVELS=levap,$
;       TITLE= 'B_phi advective non-dynamo', /ISOTROPIC, xstyle=1, ystyle=1,$
;       CHARSIZE=1.5, XRANGE=[0,50], YRANGE=[-50,50]
;  polar_contour2, blankadvp, colatitude, radb, $
;        /CELL_FILL, NLEVEL=1, /OVERPLOT
;  COLORBAR, COLOR=0, DIVISIONS=4, FORMAT='(e10.3)', $
;       POSITION=[0.79, 0.08, 0.83, 0.96], /VERTICAL, /RIGHT,  $
;       CHARSIZE=1.25, MAX=MAX(levap), MIN=MIN(levap)
;
;; Colored contour plot of time averaged B_phi inductive averaged in longitude
;  window, 5, XSIZE=575, YSIZE=750
;  loadct, 39
;  device, decompose=0
;  polar_contour2, transpose(totindps), colatitude, rad,$
;       BACKGROUND=255, COLOR=0, /FILL, LEVELS=levip,$
;       TITLE= 'B_phi inductive non-dynamo', xstyle=1, ystyle=1,$
;       CHARSIZE=1.5, XRANGE=[0,50], /ISOTROPIC, yrange=[-50,50]
;  polar_contour2, blankindp, colatitude, radb, $
;        /CELL_FILL, NLEVEL=1, /OVERPLOT
;  COLORBAR, COLOR=0, DIVISIONS=4, FORMAT='(e10.3)', $
;       POSITION=[0.79, 0.08, 0.83, 0.96], /VERTICAL, /RIGHT,  $
;       CHARSIZE=1.25, MAX=MAX(levip), MIN=MIN(levip)
;;;;;;;;;;;;;;;;;;;;
;; Colored contour plot of time averaged B_r1 inductive averaged in longitude  
;  window, 6, XSIZE=575, YSIZE=750
;  loadct, 39
;  device, decompose=0
;  polar_contour2, transpose(abadvr1s), colatitude, rad,$
;       BACKGROUND=255, COLOR=0, /FILL, LEVELS=levar1,$
;       TITLE= 'B_r1 advective non-dynamo', /ISOTROPIC, xstyle=1, ystyle=1,$
;       CHARSIZE=1.5, XRANGE=[0,50], YRANGE=[-50,50]
;  polar_contour2, blankadvr1, colatitude, radb, $
;        /CELL_FILL, NLEVEL=1, /OVERPLOT
;  COLORBAR, COLOR=0, DIVISIONS=4, FORMAT='(e10.3)', $
;       POSITION=[0.79, 0.08, 0.83, 0.96], /VERTICAL, /RIGHT,  $
;       CHARSIZE=1.25, MAX=MAX(levar1), MIN=MIN(levar1)
;
;; Colored contour plot of time averaged B_r1 inductive averaged in longitude
;  window, 7, XSIZE=575, YSIZE=750
;  loadct, 39
;  device, decompose=0
;  polar_contour2, transpose(abindr1s), colatitude, rad,$
;       BACKGROUND=255, COLOR=0, /FILL, LEVELS=levir1,$
;       TITLE= 'B_r1 inductive non-dynamo', xstyle=1, ystyle=1,$
;       CHARSIZE=1.5, XRANGE=[0,50], /ISOTROPIC, yrange=[-50,50]
;  polar_contour2, blankindr1, colatitude, radb, $
;        /CELL_FILL, NLEVEL=1, /OVERPLOT
;  COLORBAR, COLOR=0, DIVISIONS=4, FORMAT='(e10.3)', $
;       POSITION=[0.79, 0.08, 0.83, 0.96], /VERTICAL, /RIGHT,  $
;       CHARSIZE=1.25, MAX=MAX(levir1), MIN=MIN(levir1)
;
;; Colored contour plot of time averaged B_r2 advective averaged in longitude  
;  window, 8, XSIZE=575, YSIZE=750
;  loadct, 39
;  device, decompose=0
;  polar_contour2, transpose(abadvr2s), colatitude, rad,$
;       BACKGROUND=255, COLOR=0, /FILL, LEVELS=levar2,$
;       TITLE= 'B_r2 advective non-dynamo', /ISOTROPIC, xstyle=1, ystyle=1,$
;       CHARSIZE=1.5, XRANGE=[0,50], YRANGE=[-50,50]
;  polar_contour2, blankadvr2, colatitude, radb, $
;        /CELL_FILL, NLEVEL=1, /OVERPLOT
;  COLORBAR, COLOR=0, DIVISIONS=4, FORMAT='(e10.3)', $
;       POSITION=[0.79, 0.08, 0.83, 0.96], /VERTICAL, /RIGHT,  $
;       CHARSIZE=1.25, MAX=MAX(levar2), MIN=MIN(levar2)
;
;; Colored contour plot of time averaged B_r2 inductive averaged in longitude
;  window, 9, XSIZE=575, YSIZE=750
;  loadct, 39
;  device, decompose=0
;  polar_contour2, transpose(abindr2s), colatitude, rad,$
;       BACKGROUND=255, COLOR=0, /FILL, LEVELS=levir2,$
;       TITLE= 'B_r2 inductive non-dynamo', xstyle=1, ystyle=1,$
;       CHARSIZE=1.5, XRANGE=[0,50], /ISOTROPIC, yrange=[-50,50]
;  polar_contour2, blankindr2, colatitude, radb, $
;        /CELL_FILL, NLEVEL=1, /OVERPLOT
;  COLORBAR, COLOR=0, DIVISIONS=4, FORMAT='(e10.3)', $
;       POSITION=[0.79, 0.08, 0.83, 0.96], /VERTICAL, /RIGHT,  $
;       CHARSIZE=1.25, MAX=MAX(levir2), MIN=MIN(levir2)
;
;; Colored contour plot of time averaged B_r3 advective averaged in longitude  
;  window, 10, XSIZE=575, YSIZE=750
;  loadct, 39
;  device, decompose=0
;  polar_contour2, transpose(abadvr3s), colatitude, rad,$
;       BACKGROUND=255, COLOR=0, /FILL, LEVELS=levar3,$
;       TITLE= 'B_r3 advective non-dynamo', /ISOTROPIC, xstyle=1, ystyle=1,$
;       CHARSIZE=1.5, XRANGE=[0,50], YRANGE=[-50,50]
;  polar_contour2, blankadvr3, colatitude, radb, $
;        /CELL_FILL, NLEVEL=1, /OVERPLOT
;  COLORBAR, COLOR=0, DIVISIONS=4, FORMAT='(e10.3)', $
;       POSITION=[0.79, 0.08, 0.83, 0.96], /VERTICAL, /RIGHT,  $
;       CHARSIZE=1.25, MAX=MAX(levar3), MIN=MIN(levar3)
;
;; Colored contour plot of time averaged B_r3 inductive averaged in longitude
;  window, 11, XSIZE=575, YSIZE=750
;  loadct, 39
;  device, decompose=0
;  polar_contour2, transpose(abindr3s), colatitude, rad,$
;       BACKGROUND=255, COLOR=0, /FILL, LEVELS=levir3,$
;       TITLE= 'B_r3 inductive non-dynamo', xstyle=1, ystyle=1,$
;       CHARSIZE=1.5, XRANGE=[0,50], /ISOTROPIC, yrange=[-50,50]
;  polar_contour2, blankindr3, colatitude, radb, $
;        /CELL_FILL, NLEVEL=1, /OVERPLOT
;  COLORBAR, COLOR=0, DIVISIONS=4, FORMAT='(e10.3)', $
;       POSITION=[0.79, 0.08, 0.83, 0.96], /VERTICAL, /RIGHT,  $
;       CHARSIZE=1.25, MAX=MAX(levir3), MIN=MIN(levir3)
;
;; Colored contour plot of time averaged B_theta1 inductive averaged in longitude  
;  window, 12, XSIZE=575, YSIZE=750
;  loadct, 39
;  device, decompose=0
;  polar_contour2, transpose(abadvt1s), colatitude, rad,$
;       BACKGROUND=255, COLOR=0, /FILL, LEVELS=levat1,$
;       TITLE= 'B_theta1 advective non-dynamo', /ISOTROPIC, xstyle=1, ystyle=1,$
;       CHARSIZE=1.5, XRANGE=[0,50], YRANGE=[-50,50]
;  polar_contour2, blankadvt1, colatitude, radb, $
;        /CELL_FILL, NLEVEL=1, /OVERPLOT
;  COLORBAR, COLOR=0, DIVISIONS=4, FORMAT='(e10.3)', $
;       POSITION=[0.79, 0.08, 0.83, 0.96], /VERTICAL, /RIGHT,  $
;       CHARSIZE=1.25, MAX=MAX(levat1), MIN=MIN(levat1)
;
;; Colored contour plot of time averaged B_theta1 inductive averaged in longitude
;  window, 13, XSIZE=575, YSIZE=750
;  loadct, 39
;  device, decompose=0
;  polar_contour2, transpose(abindt1s), colatitude, rad,$
;       BACKGROUND=255, COLOR=0, /FILL, LEVELS=levit1,$
;       TITLE= 'B_theta1 inductive non-dynamo', xstyle=1, ystyle=1,$
;       CHARSIZE=1.5, XRANGE=[0,50], /ISOTROPIC, yrange=[-50,50]
;  polar_contour2, blankindt1, colatitude, radb, $
;        /CELL_FILL, NLEVEL=1, /OVERPLOT
;  COLORBAR, COLOR=0, DIVISIONS=4, FORMAT='(e10.3)', $
;       POSITION=[0.79, 0.08, 0.83, 0.96], /VERTICAL, /RIGHT,  $
;       CHARSIZE=1.25, MAX=MAX(levit1), MIN=MIN(levit1)
;
;; Colored contour plot of time averaged B_theta2 advective averaged in longitude  
;  window, 14, XSIZE=575, YSIZE=750
;  loadct, 39
;  device, decompose=0
;  polar_contour2, transpose(abadvt2s), colatitude, rad,$
;       BACKGROUND=255, COLOR=0, /FILL, LEVELS=levat2,$
;       TITLE= 'B_theta2 advective non-dynamo', /ISOTROPIC, xstyle=1, ystyle=1,$
;       CHARSIZE=1.5, XRANGE=[0,50], YRANGE=[-50,50]
;  polar_contour2, blankadvt2, colatitude, radb, $
;        /CELL_FILL, NLEVEL=1, /OVERPLOT
;  COLORBAR, COLOR=0, DIVISIONS=4, FORMAT='(e10.3)', $
;       POSITION=[0.79, 0.08, 0.83, 0.96], /VERTICAL, /RIGHT,  $
;       CHARSIZE=1.25, MAX=MAX(levat2), MIN=MIN(levat2)
;
;; Colored contour plot of time averaged B_theta2 inductive averaged in longitude
;  window, 15, XSIZE=575, YSIZE=750
;  loadct, 39
;  device, decompose=0
;  polar_contour2, transpose(abindt2s), colatitude, rad,$
;       BACKGROUND=255, COLOR=0, /FILL, LEVELS=levit2,$
;       TITLE= 'B_theta2 inductive non-dynamo', xstyle=1, ystyle=1,$
;       CHARSIZE=1.5, XRANGE=[0,50], /ISOTROPIC, yrange=[-50,50]
;  polar_contour2, blankindt2, colatitude, radb, $
;        /CELL_FILL, NLEVEL=1, /OVERPLOT
;  COLORBAR, COLOR=0, DIVISIONS=4, FORMAT='(e10.3)', $
;       POSITION=[0.79, 0.08, 0.83, 0.96], /VERTICAL, /RIGHT,  $
;       CHARSIZE=1.25, MAX=MAX(levit2), MIN=MIN(levit2)
;
;; Colored contour plot of time averaged B_theta3 advective averaged in longitude  
;  window, 16, XSIZE=575, YSIZE=750
;  loadct, 39
;  device, decompose=0
;  polar_contour2, transpose(abadvt3s), colatitude, rad,$
;       BACKGROUND=255, COLOR=0, /FILL, LEVELS=levat3,$
;       TITLE= 'B_theta3 advective non-dynamo', /ISOTROPIC, xstyle=1, ystyle=1,$
;       CHARSIZE=1.5, XRANGE=[0,50], YRANGE=[-50,50]
;  polar_contour2, blankadvt3, colatitude, radb, $
;        /CELL_FILL, NLEVEL=1, /OVERPLOT
;  COLORBAR, COLOR=0, DIVISIONS=4, FORMAT='(e10.3)', $
;       POSITION=[0.79, 0.08, 0.83, 0.96], /VERTICAL, /RIGHT,  $
;       CHARSIZE=1.25, MAX=MAX(levat3), MIN=MIN(levat3)
;
;; Colored contour plot of time averaged B_theta3 inductive averaged in longitude
;  window, 17, XSIZE=575, YSIZE=750
;  loadct, 39
;  device, decompose=0
;  polar_contour2, transpose(abindt3s), colatitude, rad,$
;       BACKGROUND=255, COLOR=0, /FILL, LEVELS=levit3,$
;       TITLE= 'B_theta3 inductive non-dynamo', xstyle=1, ystyle=1,$
;       CHARSIZE=1.5, XRANGE=[0,50], /ISOTROPIC, yrange=[-50,50]
;  polar_contour2, blankindt3, colatitude, radb, $
;        /CELL_FILL, NLEVEL=1, /OVERPLOT
;  COLORBAR, COLOR=0, DIVISIONS=4, FORMAT='(e10.3)', $
;       POSITION=[0.79, 0.08, 0.83, 0.96], /VERTICAL, /RIGHT,  $
;       CHARSIZE=1.25, MAX=MAX(levit3), MIN=MIN(levit3)
;;;;;;;;;;;;;;;;;;;
;; Colored contour plot of time averaged B_phi1 inductive averaged in longitude  
;  window, 18, XSIZE=575, YSIZE=750
;  loadct, 39
;  device, decompose=0
;  polar_contour2, transpose(abadvp1s), colatitude, rad,$
;       BACKGROUND=255, COLOR=0, /FILL, LEVELS=levap1,$
;       TITLE= 'B_phi1 advective non-dynamo', /ISOTROPIC, xstyle=1, ystyle=1,$
;       CHARSIZE=1.5, XRANGE=[0,50], YRANGE=[-50,50]
;  polar_contour2, blankadvp1, colatitude, radb, $
;        /CELL_FILL, NLEVEL=1, /OVERPLOT
;  COLORBAR, COLOR=0, DIVISIONS=4, FORMAT='(e10.3)', $
;       POSITION=[0.79, 0.08, 0.83, 0.96], /VERTICAL, /RIGHT,  $
;       CHARSIZE=1.25, MAX=MAX(levap1), MIN=MIN(levap1)
;
;; Colored contour plot of time averaged B_phi1 inductive averaged in longitude
;  window, 19, XSIZE=575, YSIZE=750
;  loadct, 39
;  device, decompose=0
;  polar_contour2, transpose(abindp1s), colatitude, rad,$
;       BACKGROUND=255, COLOR=0, /FILL, LEVELS=levip1,$
;       TITLE= 'B_phi1 inductive non-dynamo', xstyle=1, ystyle=1,$
;       CHARSIZE=1.5, XRANGE=[0,50], /ISOTROPIC, yrange=[-50,50]
;  polar_contour2, blankindp1, colatitude, radb, $
;        /CELL_FILL, NLEVEL=1, /OVERPLOT
;  COLORBAR, COLOR=0, DIVISIONS=4, FORMAT='(e10.3)', $
;       POSITION=[0.79, 0.08, 0.83, 0.96], /VERTICAL, /RIGHT,  $
;       CHARSIZE=1.25, MAX=MAX(levip1), MIN=MIN(levip1)
;
;; Colored contour plot of time averaged B_phi2 advective averaged in longitude  
;  window, 20, XSIZE=575, YSIZE=750
;  loadct, 39
;  device, decompose=0
;  polar_contour2, transpose(abadvp2s), colatitude, rad,$
;       BACKGROUND=255, COLOR=0, /FILL, LEVELS=levap2,$
;       TITLE= 'B_phi2 advective non-dynamo', /ISOTROPIC, xstyle=1, ystyle=1,$
;       CHARSIZE=1.5, XRANGE=[0,50], YRANGE=[-50,50]
;  polar_contour2, blankadvp2, colatitude, radb, $
;        /CELL_FILL, NLEVEL=1, /OVERPLOT
;  COLORBAR, COLOR=0, DIVISIONS=4, FORMAT='(e10.3)', $
;       POSITION=[0.79, 0.08, 0.83, 0.96], /VERTICAL, /RIGHT,  $
;       CHARSIZE=1.25, MAX=MAX(levap2), MIN=MIN(levap2)
;
;; Colored contour plot of time averaged B_phi2 inductive averaged in longitude
;  window, 21, XSIZE=575, YSIZE=750
;  loadct, 39
;  device, decompose=0
;  polar_contour2, transpose(abindp2s), colatitude, rad,$
;       BACKGROUND=255, COLOR=0, /FILL, LEVELS=levip2,$
;       TITLE= 'B_phi2 inductive non-dynamo', xstyle=1, ystyle=1,$
;       CHARSIZE=1.5, XRANGE=[0,50], /ISOTROPIC, yrange=[-50,50]
;  polar_contour2, blankindp2, colatitude, radb, $
;        /CELL_FILL, NLEVEL=1, /OVERPLOT
;  COLORBAR, COLOR=0, DIVISIONS=4, FORMAT='(e10.3)', $
;       POSITION=[0.79, 0.08, 0.83, 0.96], /VERTICAL, /RIGHT,  $
;       CHARSIZE=1.25, MAX=MAX(levip2), MIN=MIN(levip2)
;
;; Colored contour plot of time averaged B_phi3 advective averaged in longitude  
;  window, 22, XSIZE=575, YSIZE=750
;  loadct, 39
;  device, decompose=0
;  polar_contour2, transpose(abadvp3s), colatitude, rad,$
;       BACKGROUND=255, COLOR=0, /FILL, LEVELS=levap3,$
;       TITLE= 'B_phi3 advective non-dynamo', /ISOTROPIC, xstyle=1, ystyle=1,$
;       CHARSIZE=1.5, XRANGE=[0,50], YRANGE=[-50,50]
;  polar_contour2, blankadvp3, colatitude, radb, $
;        /CELL_FILL, NLEVEL=1, /OVERPLOT
;  COLORBAR, COLOR=0, DIVISIONS=4, FORMAT='(e10.3)', $
;       POSITION=[0.79, 0.08, 0.83, 0.96], /VERTICAL, /RIGHT,  $
;       CHARSIZE=1.25, MAX=MAX(levap3), MIN=MIN(levap3)
;
;; Colored contour plot of time averaged B_phi3 inductive averaged in longitude
;  window, 23, XSIZE=575, YSIZE=750
;  loadct, 39
;  device, decompose=0
;  polar_contour2, transpose(abindp3s), colatitude, rad,$
;       BACKGROUND=255, COLOR=0, /FILL, LEVELS=levip3,$
;       TITLE= 'B_phi3 inductive non-dynamo', xstyle=1, ystyle=1,$
;       CHARSIZE=1.5, XRANGE=[0,50], /ISOTROPIC, yrange=[-50,50]
;  polar_contour2, blankindp3, colatitude, radb, $
;        /CELL_FILL, NLEVEL=1, /OVERPLOT
;  COLORBAR, COLOR=0, DIVISIONS=4, FORMAT='(e10.3)', $
;       POSITION=[0.79, 0.08, 0.83, 0.96], /VERTICAL, /RIGHT,  $
;       CHARSIZE=1.25, MAX=MAX(levip3), MIN=MIN(levip3)


;; Colored contour plot of time averaged B_r inductive averaged in longitude  
  window, 0, XSIZE=575, YSIZE=750
  loadct, 39
  device, decompose=0
  polar_contour2, transpose(totadvrt), colatitude, rad,$
       BACKGROUND=255, COLOR=0, /FILL, LEVELS=levar,$
       TITLE= 'B_r advective non-dynamo2', /ISOTROPIC, xstyle=1, ystyle=1,$
       CHARSIZE=1.5, XRANGE=[0,50], YRANGE=[-50,50]
  polar_contour2, blankadvr, colatitude, radb, $
        /CELL_FILL, NLEVEL=1, /OVERPLOT
  COLORBAR, COLOR=0, DIVISIONS=4, FORMAT='(e10.3)', $
       POSITION=[0.79, 0.08, 0.83, 0.96], /VERTICAL, /RIGHT,  $
       CHARSIZE=1.25, MAX=MAX(levar), MIN=MIN(levar)

; Colored contour plot of time averaged B_r inductive averaged in longitude
  window, 1, XSIZE=575, YSIZE=750
  loadct, 39
  device, decompose=0
  polar_contour2, transpose(totindrt), colatitude, rad,$
       BACKGROUND=255, COLOR=0, /FILL, LEVELS=levir,$
       TITLE= 'B_r inductive non-dynamo2', xstyle=1, ystyle=1,$
       CHARSIZE=1.5, XRANGE=[0,50], /ISOTROPIC, yrange=[-50,50]
  polar_contour2, blankindr, colatitude, radb, $
        /CELL_FILL, NLEVEL=1, /OVERPLOT
  COLORBAR, COLOR=0, DIVISIONS=4, FORMAT='(e10.3)', $
       POSITION=[0.79, 0.08, 0.83, 0.96], /VERTICAL, /RIGHT,  $
       CHARSIZE=1.25, MAX=MAX(levir), MIN=MIN(levir)

; Colored contour plot of time averaged B_theta advective averaged in longitude  
  window, 2, XSIZE=575, YSIZE=750
  loadct, 39
  device, decompose=0
  polar_contour2, transpose(totadvtt), colatitude, rad,$
       BACKGROUND=255, COLOR=0, /FILL, LEVELS=levat,$
       TITLE= 'B_theta advective non-dynamo22', /ISOTROPIC, xstyle=1, ystyle=1,$
       CHARSIZE=1.5, XRANGE=[0,50], YRANGE=[-50,50]
  polar_contour2, blankadvt, colatitude, radb, $
        /CELL_FILL, NLEVEL=1, /OVERPLOT
  COLORBAR, COLOR=0, DIVISIONS=4, FORMAT='(e10.3)', $
       POSITION=[0.79, 0.08, 0.83, 0.96], /VERTICAL, /RIGHT,  $
       CHARSIZE=1.25, MAX=MAX(levat), MIN=MIN(levat)

; Colored contour plot of time averaged B_theta inductive averaged in longitude
  window, 3, XSIZE=575, YSIZE=750
  loadct, 39
  device, decompose=0
  polar_contour2, transpose(totindtt), colatitude, rad,$
       BACKGROUND=255, COLOR=0, /FILL, LEVELS=levit,$
       TITLE= 'B_theta inductive non-dynamo2', xstyle=1, ystyle=1,$
       CHARSIZE=1.5, XRANGE=[0,50], /ISOTROPIC, yrange=[-50,50]
  polar_contour2, blankindt, colatitude, radb, $
        /CELL_FILL, NLEVEL=1, /OVERPLOT
  COLORBAR, COLOR=0, DIVISIONS=4, FORMAT='(e10.3)', $
       POSITION=[0.79, 0.08, 0.83, 0.96], /VERTICAL, /RIGHT,  $
       CHARSIZE=1.25, MAX=MAX(levit), MIN=MIN(levit)
;;;;;;;;;;;;;;;;;;;;;
; Colored contour plot of time averaged B_phi advective averaged in longitude  
  window, 4, XSIZE=575, YSIZE=750
  loadct, 39
  device, decompose=0
  polar_contour2, transpose(totadvpt), colatitude, rad,$
       BACKGROUND=255, COLOR=0, /FILL, LEVELS=levap,$
       TITLE= 'B_phi advective non-dynamo2', /ISOTROPIC, xstyle=1, ystyle=1,$
       CHARSIZE=1.5, XRANGE=[0,50], YRANGE=[-50,50]
  polar_contour2, blankadvp, colatitude, radb, $
        /CELL_FILL, NLEVEL=1, /OVERPLOT
  COLORBAR, COLOR=0, DIVISIONS=4, FORMAT='(e10.3)', $
       POSITION=[0.79, 0.08, 0.83, 0.96], /VERTICAL, /RIGHT,  $
       CHARSIZE=1.25, MAX=MAX(levap), MIN=MIN(levap)

; Colored contour plot of time averaged B_phi inductive averaged in longitude
  window, 5, XSIZE=575, YSIZE=750
  loadct, 39
  device, decompose=0
  polar_contour2, transpose(totindpt), colatitude, rad,$
       BACKGROUND=255, COLOR=0, /FILL, LEVELS=levip,$
       TITLE= 'B_phi inductive non-dynamo2', xstyle=1, ystyle=1,$
       CHARSIZE=1.5, XRANGE=[0,50], /ISOTROPIC, yrange=[-50,50]
  polar_contour2, blankindp, colatitude, radb, $
        /CELL_FILL, NLEVEL=1, /OVERPLOT
  COLORBAR, COLOR=0, DIVISIONS=4, FORMAT='(e10.3)', $
       POSITION=[0.79, 0.08, 0.83, 0.96], /VERTICAL, /RIGHT,  $
       CHARSIZE=1.25, MAX=MAX(levip), MIN=MIN(levip)
;;;;;;;;;;;;;;;;;;;
; Colored contour plot of time averaged B_r1 inductive averaged in longitude  
  window, 6, XSIZE=575, YSIZE=750
  loadct, 39
  device, decompose=0
  polar_contour2, transpose(abadvr1t), colatitude, rad,$
       BACKGROUND=255, COLOR=0, /FILL, LEVELS=levar1,$
       TITLE= 'B_r1 advective non-dynamo2', /ISOTROPIC, xstyle=1, ystyle=1,$
       CHARSIZE=1.5, XRANGE=[0,50], YRANGE=[-50,50]
  polar_contour2, blankadvr1, colatitude, radb, $
        /CELL_FILL, NLEVEL=1, /OVERPLOT
  COLORBAR, COLOR=0, DIVISIONS=4, FORMAT='(e10.3)', $
       POSITION=[0.79, 0.08, 0.83, 0.96], /VERTICAL, /RIGHT,  $
       CHARSIZE=1.25, MAX=MAX(levar1), MIN=MIN(levar1)

; Colored contour plot of time averaged B_r1 inductive averaged in longitude
  window, 7, XSIZE=575, YSIZE=750
  loadct, 39
  device, decompose=0
  polar_contour2, transpose(abindr1t), colatitude, rad,$
       BACKGROUND=255, COLOR=0, /FILL, LEVELS=levir1,$
       TITLE= 'B_r1 inductive non-dynamo2', xstyle=1, ystyle=1,$
       CHARSIZE=1.5, XRANGE=[0,50], /ISOTROPIC, yrange=[-50,50]
  polar_contour2, blankindr1, colatitude, radb, $
        /CELL_FILL, NLEVEL=1, /OVERPLOT
  COLORBAR, COLOR=0, DIVISIONS=4, FORMAT='(e10.3)', $
       POSITION=[0.79, 0.08, 0.83, 0.96], /VERTICAL, /RIGHT,  $
       CHARSIZE=1.25, MAX=MAX(levir1), MIN=MIN(levir1)

; Colored contour plot of time averaged B_r2 advective averaged in longitude  
  window, 8, XSIZE=575, YSIZE=750
  loadct, 39
  device, decompose=0
  polar_contour2, transpose(abadvr2t), colatitude, rad,$
       BACKGROUND=255, COLOR=0, /FILL, LEVELS=levar2,$
       TITLE= 'B_r2 advective non-dynamo2', /ISOTROPIC, xstyle=1, ystyle=1,$
       CHARSIZE=1.5, XRANGE=[0,50], YRANGE=[-50,50]
  polar_contour2, blankadvr2, colatitude, radb, $
        /CELL_FILL, NLEVEL=1, /OVERPLOT
  COLORBAR, COLOR=0, DIVISIONS=4, FORMAT='(e10.3)', $
       POSITION=[0.79, 0.08, 0.83, 0.96], /VERTICAL, /RIGHT,  $
       CHARSIZE=1.25, MAX=MAX(levar2), MIN=MIN(levar2)

; Colored contour plot of time averaged B_r2 inductive averaged in longitude
  window, 9, XSIZE=575, YSIZE=750
  loadct, 39
  device, decompose=0
  polar_contour2, transpose(abindr2t), colatitude, rad,$
       BACKGROUND=255, COLOR=0, /FILL, LEVELS=levir2,$
       TITLE= 'B_r2 inductive non-dynamo2', xstyle=1, ystyle=1,$
       CHARSIZE=1.5, XRANGE=[0,50], /ISOTROPIC, yrange=[-50,50]
  polar_contour2, blankindr2, colatitude, radb, $
        /CELL_FILL, NLEVEL=1, /OVERPLOT
  COLORBAR, COLOR=0, DIVISIONS=4, FORMAT='(e10.3)', $
       POSITION=[0.79, 0.08, 0.83, 0.96], /VERTICAL, /RIGHT,  $
       CHARSIZE=1.25, MAX=MAX(levir2), MIN=MIN(levir2)

;; Colored contour plot of time averaged B_r3 advective averaged in longitude  
  window, 10, XSIZE=575, YSIZE=750
  loadct, 39
  device, decompose=0
  polar_contour2, transpose(abadvr3t), colatitude, rad,$
       BACKGROUND=255, COLOR=0, /FILL, LEVELS=levar3,$
       TITLE= 'B_r3 advective non-dynamo2', /ISOTROPIC, xstyle=1, ystyle=1,$
       CHARSIZE=1.5, XRANGE=[0,50], YRANGE=[-50,50]
  polar_contour2, blankadvr3, colatitude, radb, $
        /CELL_FILL, NLEVEL=1, /OVERPLOT
  COLORBAR, COLOR=0, DIVISIONS=4, FORMAT='(e10.3)', $
       POSITION=[0.79, 0.08, 0.83, 0.96], /VERTICAL, /RIGHT,  $
       CHARSIZE=1.25, MAX=MAX(levar3), MIN=MIN(levar3)

; Colored contour plot of time averaged B_r3 inductive averaged in longitude
  window, 11, XSIZE=575, YSIZE=750
  loadct, 39
  device, decompose=0
  polar_contour2, transpose(abindr3t), colatitude, rad,$
       BACKGROUND=255, COLOR=0, /FILL, LEVELS=levir3,$
       TITLE= 'B_r3 inductive non-dynamo2', xstyle=1, ystyle=1,$
       CHARSIZE=1.5, XRANGE=[0,50], /ISOTROPIC, yrange=[-50,50]
  polar_contour2, blankindr3, colatitude, radb, $
        /CELL_FILL, NLEVEL=1, /OVERPLOT
  COLORBAR, COLOR=0, DIVISIONS=4, FORMAT='(e10.3)', $
       POSITION=[0.79, 0.08, 0.83, 0.96], /VERTICAL, /RIGHT,  $
       CHARSIZE=1.25, MAX=MAX(levir3), MIN=MIN(levir3)

; Colored contour plot of time averaged B_theta1 inductive averaged in longitude  
  window, 12, XSIZE=575, YSIZE=750
  loadct, 39
  device, decompose=0
  polar_contour2, transpose(abadvt1t), colatitude, rad,$
       BACKGROUND=255, COLOR=0, /FILL, LEVELS=levat1,$
       TITLE= 'B_theta1 advective non-dynamo2', /ISOTROPIC, xstyle=1, ystyle=1,$
       CHARSIZE=1.5, XRANGE=[0,50], YRANGE=[-50,50]
  polar_contour2, blankadvt1, colatitude, radb, $
        /CELL_FILL, NLEVEL=1, /OVERPLOT
  COLORBAR, COLOR=0, DIVISIONS=4, FORMAT='(e10.3)', $
       POSITION=[0.79, 0.08, 0.83, 0.96], /VERTICAL, /RIGHT,  $
       CHARSIZE=1.25, MAX=MAX(levat1), MIN=MIN(levat1)

; Colored contour plot of time averaged B_theta1 inductive averaged in longitude
  window, 13, XSIZE=575, YSIZE=750
  loadct, 39
  device, decompose=0
  polar_contour2, transpose(abindt1t), colatitude, rad,$
       BACKGROUND=255, COLOR=0, /FILL, LEVELS=levit1,$
       TITLE= 'B_theta1 inductive non-dynamo2', xstyle=1, ystyle=1,$
       CHARSIZE=1.5, XRANGE=[0,50], /ISOTROPIC, yrange=[-50,50]
  polar_contour2, blankindt1, colatitude, radb, $
        /CELL_FILL, NLEVEL=1, /OVERPLOT
  COLORBAR, COLOR=0, DIVISIONS=4, FORMAT='(e10.3)', $
       POSITION=[0.79, 0.08, 0.83, 0.96], /VERTICAL, /RIGHT,  $
       CHARSIZE=1.25, MAX=MAX(levit1), MIN=MIN(levit1)

; Colored contour plot of time averaged B_theta2 advective averaged in longitude  
  window, 14, XSIZE=575, YSIZE=750
  loadct, 39
  device, decompose=0
  polar_contour2, transpose(abadvt2t), colatitude, rad,$
       BACKGROUND=255, COLOR=0, /FILL, LEVELS=levat2,$
       TITLE= 'B_theta2 advective non-dynamo2', /ISOTROPIC, xstyle=1, ystyle=1,$
       CHARSIZE=1.5, XRANGE=[0,50], YRANGE=[-50,50]
  polar_contour2, blankadvt2, colatitude, radb, $
        /CELL_FILL, NLEVEL=1, /OVERPLOT
  COLORBAR, COLOR=0, DIVISIONS=4, FORMAT='(e10.3)', $
       POSITION=[0.79, 0.08, 0.83, 0.96], /VERTICAL, /RIGHT,  $
       CHARSIZE=1.25, MAX=MAX(levat2), MIN=MIN(levat2)

; Colored contour plot of time averaged B_theta2 inductive averaged in longitude
  window, 15, XSIZE=575, YSIZE=750
  loadct, 39
  device, decompose=0
  polar_contour2, transpose(abindt2t), colatitude, rad,$
       BACKGROUND=255, COLOR=0, /FILL, LEVELS=levit2,$
       TITLE= 'B_theta2 inductive non-dynamo2', xstyle=1, ystyle=1,$
       CHARSIZE=1.5, XRANGE=[0,50], /ISOTROPIC, yrange=[-50,50]
  polar_contour2, blankindt2, colatitude, radb, $
        /CELL_FILL, NLEVEL=1, /OVERPLOT
  COLORBAR, COLOR=0, DIVISIONS=4, FORMAT='(e10.3)', $
       POSITION=[0.79, 0.08, 0.83, 0.96], /VERTICAL, /RIGHT,  $
       CHARSIZE=1.25, MAX=MAX(levit2), MIN=MIN(levit2)

;; Colored contour plot of time averaged B_theta3 advective averaged in longitude  
  window, 16, XSIZE=575, YSIZE=750
  loadct, 39
  device, decompose=0
  polar_contour2, transpose(abadvt3t), colatitude, rad,$
       BACKGROUND=255, COLOR=0, /FILL, LEVELS=levat3,$
       TITLE= 'B_theta3 advective non-dynamo2', /ISOTROPIC, xstyle=1, ystyle=1,$
       CHARSIZE=1.5, XRANGE=[0,50], YRANGE=[-50,50]
  polar_contour2, blankadvt3, colatitude, radb, $
        /CELL_FILL, NLEVEL=1, /OVERPLOT
  COLORBAR, COLOR=0, DIVISIONS=4, FORMAT='(e10.3)', $
       POSITION=[0.79, 0.08, 0.83, 0.96], /VERTICAL, /RIGHT,  $
       CHARSIZE=1.25, MAX=MAX(levat3), MIN=MIN(levat3)

; Colored contour plot of time averaged B_theta3 inductive averaged in longitude
  window, 17, XSIZE=575, YSIZE=750
  loadct, 39
  device, decompose=0
  polar_contour2, transpose(abindt3t), colatitude, rad,$
       BACKGROUND=255, COLOR=0, /FILL, LEVELS=levit3,$
       TITLE= 'B_theta3 inductive non-dynamo2', xstyle=1, ystyle=1,$
       CHARSIZE=1.5, XRANGE=[0,50], /ISOTROPIC, yrange=[-50,50]
  polar_contour2, blankindt3, colatitude, radb, $
        /CELL_FILL, NLEVEL=1, /OVERPLOT
  COLORBAR, COLOR=0, DIVISIONS=4, FORMAT='(e10.3)', $
       POSITION=[0.79, 0.08, 0.83, 0.96], /VERTICAL, /RIGHT,  $
       CHARSIZE=1.25, MAX=MAX(levit3), MIN=MIN(levit3)
;;;;;;;;;;;;;;;;;;;
; Colored contour plot of time averaged B_phi1 inductive averaged in longitude  
  window, 18, XSIZE=575, YSIZE=750
  loadct, 39
  device, decompose=0
  polar_contour2, transpose(abadvp1t), colatitude, rad,$
       BACKGROUND=255, COLOR=0, /FILL, LEVELS=levap1,$
       TITLE= 'B_phi1 advective non-dynamo2', /ISOTROPIC, xstyle=1, ystyle=1,$
       CHARSIZE=1.5, XRANGE=[0,50], YRANGE=[-50,50]
  polar_contour2, blankadvp1, colatitude, radb, $
        /CELL_FILL, NLEVEL=1, /OVERPLOT
  COLORBAR, COLOR=0, DIVISIONS=4, FORMAT='(e10.3)', $
       POSITION=[0.79, 0.08, 0.83, 0.96], /VERTICAL, /RIGHT,  $
       CHARSIZE=1.25, MAX=MAX(levap1), MIN=MIN(levap1)

; Colored contour plot of time averaged B_phi1 inductive averaged in longitude
  window, 19, XSIZE=575, YSIZE=750
  loadct, 39
  device, decompose=0
  polar_contour2, transpose(abindp1t), colatitude, rad,$
       BACKGROUND=255, COLOR=0, /FILL, LEVELS=levip1,$
       TITLE= 'B_phi1 inductive non-dynamo2', xstyle=1, ystyle=1,$
       CHARSIZE=1.5, XRANGE=[0,50], /ISOTROPIC, yrange=[-50,50]
  polar_contour2, blankindp1, colatitude, radb, $
        /CELL_FILL, NLEVEL=1, /OVERPLOT
  COLORBAR, COLOR=0, DIVISIONS=4, FORMAT='(e10.3)', $
       POSITION=[0.79, 0.08, 0.83, 0.96], /VERTICAL, /RIGHT,  $
       CHARSIZE=1.25, MAX=MAX(levip1), MIN=MIN(levip1)

; Colored contour plot of time averaged B_phi2 advective averaged in longitude  
  window, 20, XSIZE=575, YSIZE=750
  loadct, 39
  device, decompose=0
  polar_contour2, transpose(abadvp2t), colatitude, rad,$
       BACKGROUND=255, COLOR=0, /FILL, LEVELS=levap2,$
       TITLE= 'B_phi2 advective non-dynamo2', /ISOTROPIC, xstyle=1, ystyle=1,$
       CHARSIZE=1.5, XRANGE=[0,50], YRANGE=[-50,50]
  polar_contour2, blankadvp2, colatitude, radb, $
        /CELL_FILL, NLEVEL=1, /OVERPLOT
  COLORBAR, COLOR=0, DIVISIONS=4, FORMAT='(e10.3)', $
       POSITION=[0.79, 0.08, 0.83, 0.96], /VERTICAL, /RIGHT,  $
       CHARSIZE=1.25, MAX=MAX(levap2), MIN=MIN(levap2)

; Colored contour plot of time averaged B_phi2 inductive averaged in longitude
  window, 21, XSIZE=575, YSIZE=750
  loadct, 39
  device, decompose=0
  polar_contour2, transpose(abindp2t), colatitude, rad,$
       BACKGROUND=255, COLOR=0, /FILL, LEVELS=levip2,$
       TITLE= 'B_phi2 inductive non-dynamo2', xstyle=1, ystyle=1,$
       CHARSIZE=1.5, XRANGE=[0,50], /ISOTROPIC, yrange=[-50,50]
  polar_contour2, blankindp2, colatitude, radb, $
        /CELL_FILL, NLEVEL=1, /OVERPLOT
  COLORBAR, COLOR=0, DIVISIONS=4, FORMAT='(e10.3)', $
       POSITION=[0.79, 0.08, 0.83, 0.96], /VERTICAL, /RIGHT,  $
       CHARSIZE=1.25, MAX=MAX(levip2), MIN=MIN(levip2)
;
;; Colored contour plot of time averaged B_phi3 advective averaged in longitude  
  window, 22, XSIZE=575, YSIZE=750
  loadct, 39
  device, decompose=0
  polar_contour2, transpose(abadvp3t), colatitude, rad,$
       BACKGROUND=255, COLOR=0, /FILL, LEVELS=levap3,$
       TITLE= 'B_phi3 advective non-dynamo2', /ISOTROPIC, xstyle=1, ystyle=1,$
       CHARSIZE=1.5, XRANGE=[0,50], YRANGE=[-50,50]
  polar_contour2, blankadvp3, colatitude, radb, $
        /CELL_FILL, NLEVEL=1, /OVERPLOT
  COLORBAR, COLOR=0, DIVISIONS=4, FORMAT='(e10.3)', $
       POSITION=[0.79, 0.08, 0.83, 0.96], /VERTICAL, /RIGHT,  $
       CHARSIZE=1.25, MAX=MAX(levap3), MIN=MIN(levap3)

; Colored contour plot of time averaged B_phi3 inductive averaged in longitude
  window, 23, XSIZE=575, YSIZE=750
  loadct, 39
  device, decompose=0
  polar_contour2, transpose(abindp3t), colatitude, rad,$
       BACKGROUND=255, COLOR=0, /FILL, LEVELS=levip3,$
       TITLE= 'B_phi3 inductive non-dynamo2', xstyle=1, ystyle=1,$
       CHARSIZE=1.5, XRANGE=[0,50], /ISOTROPIC, yrange=[-50,50]
  polar_contour2, blankindp3, colatitude, radb, $
        /CELL_FILL, NLEVEL=1, /OVERPLOT
  COLORBAR, COLOR=0, DIVISIONS=4, FORMAT='(e10.3)', $
       POSITION=[0.79, 0.08, 0.83, 0.96], /VERTICAL, /RIGHT,  $
       CHARSIZE=1.25, MAX=MAX(levip3), MIN=MIN(levip3)


END

