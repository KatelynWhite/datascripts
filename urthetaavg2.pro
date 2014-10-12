;last updated 3/28/2012

PRO urthetaavg2
  COMPILE_OPT IDL2

  nn=81
  ni=101
  nj=201
  radtop=50.D
  radbot=10.D


  urall=dblarr(nn,ni)
  ur0=dblarr(nn,ni)
  ur=dblarr(nn,ni)
  uthetaall=dblarr(nn,ni)
  utheta0=dblarr(nn,ni)
  utheta=dblarr(nn,ni)

  OPENR, 1, 'urrmspltmall.dat'
  READU, 1, urall
  CLOSE, 1

  OPENR, 2, 'urrmspltm00.dat'
  READU, 2, ur0
  CLOSE, 2

  OPENR, 3, 'uthetarmspltmall.dat'
  READU, 3, uthetaall
  CLOSE, 3

  OPENR, 4, 'uthetarmspltm00.dat'
  READU, 4, utheta0
  CLOSE, 4


  ur=urall-ur0
  utheta=uthetaall-utheta0

  blank=dblarr(ni,radbot)
  blank[*]=MAX([MAX(ur),MAX(utheta)])

  colatitude=findgen(ni)/float(ni-1)*!PI
  rad=radtop-(radtop-radbot)*findgen(nn)/float(nn-1)
  radb=radbot-float(radbot)*findgen(radbot)/(float(radbot)-1.)

  colorval=0.
  colorval=MAX([MAX(ABS(ur)),MAX(ABS(utheta))])


  loadct, 39
  device, decompose=0
  window, 1, XSIZE=750, YSIZE=750
  polar_contour2, transpose(ur), colatitude, rad,$
       BACKGROUND=255, COLOR=0, /FILL, NLEVELS=250, TITLE= '|ur| for m > 0', $
;       XTITLE='radius', YTITLE='colatitude', YRANGE=[ni-1,0],
       CHARSIZE=1.5, XRANGE=[30,50], YRANGE=[-25,25], /isotropic, ystyle=1
  polar_contour2, blank, colatitude, radb, $
        /CELL_FILL, NLEVEL=1, /OVERPLOT
  COLORBAR, COLOR=0, DIVISIONS=4, FORMAT='(F7.3)', $
       POSITION=[0.54, 0.08, 0.58, 0.96], /VERTICAL, /RIGHT,  $
       CHARSIZE=1.25, MAX=colorval/50., MIN=0 

  loadct, 39
  device, decompose=0
  window, 2, XSIZE=750, YSIZE=750
  polar_contour2, transpose(utheta), colatitude, rad,$
       BACKGROUND=255, COLOR=0, /FILL, NLEVELS=250, TITLE= '|utheta| for m > 0', $
;       XTITLE='radius', YTITLE='colatitude', YRANGE=[ni-1,0],
       CHARSIZE=1.5, XRANGE=[30,50], YRANGE=[-25,25], /isotropic, ystyle=1
  polar_contour2, blank, colatitude, radb, $
        /CELL_FILL, NLEVEL=1, /OVERPLOT
  COLORBAR, COLOR=0, DIVISIONS=4, FORMAT='(F7.3)', $
       POSITION=[0.54, 0.08, 0.58, 0.96], /VERTICAL, /RIGHT,  $
       CHARSIZE=1.25, MAX=colorval/20., MIN=0


END
