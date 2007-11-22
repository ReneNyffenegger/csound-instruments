  sr        =  44100
  kr        =  441
  ksmps     =  100
  nchnls    =  2
     
instr     1
  icps      cpsmidi   
  ivol      midic7    7,500,10000
  iamp      ampmidi   ivol
  ifn       init      rnd(9.5)+1
  ipan      init      rnd(1.1)*.9
  iatk      init      rnd(.02)+.003
  idetune   midic7    1,0,50
  kmp       linsegr   0,iatk,iamp, 1, iamp*.2,10,iamp*.2,iatk*8, 0 ;**use relase < 7 secs
  amp       interp    kmp
  a1        oscili    amp, icps, ifn
  a2        oscili    amp,icps*(1+ .0017*idetune),ifn
  a3        oscili    amp,icps*(1+ .003 *idetune),ifn
  a4        oscili    amp,icps*(1+ .00441*idetune),ifn
  a5        =  a1 + a2 + a3 + a4
            outs      a5*ipan,a5*(1-ipan)
endin














