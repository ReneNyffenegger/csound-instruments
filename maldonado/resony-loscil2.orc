  sr        =  44100
  kr        =  441
  ksmps     =  100
  nchnls    =  1

  gk1       init      500                         ;1 center frequency
  gk2       init      30                          ;2 bandwidth in hz
  gk3       init      2                           ;3 number of filters
  gk4       init      0                           ;4 separation in octaves
  gk5       init      1                           ;5 main volume

instr   1

  icps      cpsmidi   
  kamp      linsegr   1,1,1,.05,0
  icps      =  icps/261
;*****          xamp, kcps, ifn[, ibas] [,imod1,ibeg1,iend1] 
  a1        loscil2   1,    icps,    1,    1,      1,    0,    90000 ;49687
;*****          asig, *kcf,       *kbw, *ord, *sep, iflag, *iscl, *istor;
  a2        resony    a1,   gk1 *icps  , gk2 ,i(gk3),gk4 ,0, 2        
            out       a2*gk5*kamp                 ;, a3*p4
endin


;***************************************************
instr   100
;***************************************************

  i1min     init      100                         ;1 center frequency of the lowest filter
  i1max     init      5000    
  i2min     init      .2                          ;2 bandwidth in Hz referring to the lowest filter
  i2max     init      40      
  i3min     init      1                           ;3 number of filters
  i3max     init      50      
  i4min     init      0                           ;4 separation in octaves
  i4max     init      8       
  i5min     init      .00001                      ;5 main volume
  i5max     init      1       

;******  ivalue = (initial_value - min) / (max - min)
            initc7    1,1,(i(gk1)-i1min)/(i1max-i1min)         
            initc7    1,2,(i(gk2)-i2min)/(i2max-i2min)        
            initc7    1,3,(i(gk3)-i3min)/(i3max-i3min)        
            initc7    1,4,(i(gk4)-i4min)/(i4max-i4min)        
            initc7    1,5,(i(gk5)-i5min)/(i5max-i5min)        

  gk1       ctrl7     1,1,i1min,i1max,3       
  gk2       ctrl7     1,2,i2min,i2max,3       
  gk3       ctrl7     1,3,i3min,i3max 
  gk4       ctrl7     1,4,i4min,i4max 
  gk5       ctrl7     1,5,i5min,i5max 
  gk1       tonek     gk1,5
  gk4       tonek     gk4,5
endin



