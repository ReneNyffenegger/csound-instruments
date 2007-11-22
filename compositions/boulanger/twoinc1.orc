; ===============================================;
; ============================================== ;
; =====        Movements in C              ===== ;
; =====               by                   ===== ;
; =====        Richard Boulanger           ===== ;
; ============================================== ;
; =====        Associate Professor         ===== ;
; =====     Music Synthesis Department     ===== ;
; =====      Berklee College of Music      ===== ;
; =====         Boston, MA 02215           ===== ;
; ============================================== ;
; =====       composed in May 1981         ===== ;
; =====       in CSOUND                    ===== ;
; =====    Center for Music Experiment     ===== ;
; =====    Computer Audio Research Lab     ===== ;
; =====          CARL                      ===== ;
; =====      University of California      ===== ;
; =====        San Diego                   ===== ;
; ============================================== ;
; =====        revised March 1990          ===== ;
; =====      in PCsound                    ===== ;
; =====    for the M.T.U. Digisound 16     ===== ;
; =====       on a desktop IBM/AT          ===== ;
; =====    Krakow, Poland                  ===== ;
; ===============================================;
; ============================================== ;
; =====     Movements.orc                  ===== ;
; ============================================== ;
; ============================================== ;

  sr        =  44100     
  kr        =  4410
  ksmps     =  10
  nchnls    =  1
          
instr 1
  isine     =  1
  ivibfunc  =  2
  iampfunc  =  3
  irate     =  1/p3
  iamp      =  ampdb(p4)*.3
  icarfreq  =  p5
  imodfreq1 =  p6
  index     =  p7

  ifreq1    =  (icarfreq > 10000 ? icarfreq/2 : icarfreq)

  imodfreq2 =  imodfreq1 * 1.002
  imodfreq3 =  imodfreq1 * .998

  ifreq2    =  ifreq1 * 1.005
  ifreq3    =  ifreq1 * .995

  ifreq4    =  ifreq1 * 1.008
  ifreq5    =  ifreq2 * 1.003
  ifreq6    =  ifreq3 * 0.992

if        (p5  >  200) igoto continue

  ifreq4    =  ifreq1 * 2.005
  ifreq5    =  ifreq2 * 2.00
  ifreq6    =  ifreq3 * 1.995

continue:

  kenv      oscil     iamp, irate, iampfunc
  kvib      oscili    index, irate, ivibfunc

  avib1     oscili    kvib, imodfreq1, isine
  avib2     oscili    kvib, imodfreq2, isine
  avib3     oscili    kvib, imodfreq3, isine

  avib1     oscili    kvib, imodfreq1, isine
  avib2     oscili    kvib, imodfreq2, isine
  avib3     oscili    kvib, imodfreq3, isine

  afreq1    =  ifreq1 + avib1
  afreq2    =  ifreq2 + avib2
  afreq3    =  ifreq3 + avib3

  asig1     oscili    kenv, afreq1, isine
  asig2     oscili    kenv, afreq2, isine
  asig3     oscili    kenv, afreq3, isine

  afreq4    =  ifreq4 + avib1
  afreq5    =  ifreq5 + avib2
  afreq6    =  ifreq6 + avib3

  asig4     oscili    kenv*.8, afreq4, isine
  asig5     oscili    kenv*.8, afreq5, isine
  asig6     oscili    kenv*.8, afreq6, isine

            out       asig1 + asig2 + asig3 + asig4 + asig5 + asig6

endin
