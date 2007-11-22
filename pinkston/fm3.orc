;---------------------------;
; Pinkston: FM Instrument 3 ;
;---------------------------;

  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr   3       ;Phase Mod with Modulator Stack
;Common parameters:                     
  isinefn   =  1       
  irisefn   =  2                                  ;exponential rise
  iparmfn   =  p6                                 ;number of parameter f-table
  idur      =  p3      
  iamp      =  p4      
  icps      =  cpspch(p5)                         ;theoretical fundamental
  irise     table     0,iparmfn                   ;main envlp rise time
  idec      table     1,iparmfn                   ;main envlp decay time
  icarfac   table     2,iparmfn                   ;carrier ratio
  im1fac    table     3,iparmfn                   ;modulator 1 ratio
  index1    table     4,iparmfn                   ;modulator 1 index
  im1rise   table     5,iparmfn                   ;modulator 1 rise
  im1dur    table     6,iparmfn                   ;modulator 1 dur
  im1dec    table     7,iparmfn                   ;modulator 1 decay
  im2fac    table     8,iparmfn                   ;modulator 2 ratio
  index2    table     9,iparmfn                   ;modulator 2 index
  im2rise   table     10,iparmfn                  ;modulator 2 rise
  im2dur    table     11,iparmfn                  ;modulator 2 dur
  im2dec    table     12,iparmfn                  ;modulator 2 decay
  i2pi      =  6.2832                             ;used to compute pk devs
;Params for individual operators:                       
  im1hz     =  icps*im1fac                        ;compute mod 1 frequency
  im2hz     =  icps*im2fac                        ;compute mod 2 frequency
  icarhz    =  icps*icarfac                       ;compute carrier frequency
  im1dev    =  index1/i2pi                        ;convert from radians to...
  im2dev    =  index2/i2pi                        ;...normalized indices for table
;Use default of p3 for mod1 and mod2 envelope durations:                        
  im1dur    =  (im1dur == 0 ? p3 : im1dur)     
  im2dur    =  (im2dur == 0 ? p3 : im2dur)     
;Complex modulation with stacked modulators                     
  kmod1     envlpx    im1dev,im1rise,im1dur,im1dec,irisefn,1,.01,0    
  amod1     oscili    kmod1,im1hz,isinefn     
  aphs2     phasor    im2hz   
  aphs2     =  aphs2 + amod1                      ;modulate the phase of mod2
  amod2     tablei    aphs2,isinefn,1,0,1     
  kmod2     envlpx    im2dev,im2rise,im2dur,im2dec,irisefn,1,.01,0    
  amod2     =  amod2 * kmod2   
  acarphs   phasor    icarhz  
  acarphs   =  acarphs + amod2 
  acarsig   tablei    acarphs,isinefn,1,0,1   
  kenv      envlpx    iamp,irise,idur,idec,irisefn,1,.01,0    
  asig      =  acarsig * kenv  
            out       asig    
endin           
