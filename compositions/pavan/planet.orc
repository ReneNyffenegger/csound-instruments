;==============================================================================;
;                                                                              ;
;                        "THE IMPOSSIBLE PLANET" (SCORE)                       ;
;                                                                              ;
;                               LUCA PAVAN - 1997                              ;
;                                                                              ;
;==============================================================================;
;TOTAL DURATION: 7'57"
;HARD DISK REQUIREMENTS : 85 MB 
;COMPILATION TIME: 6 HOURS AND 5 MINUTES ON A PENTIUM 120 Mhz

sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         2

garvbsig1 init 0
garvbsig2 init 0

instr 1
   
   idur      = p3
   iamp      = p4
   iskiptime = p5
   iattack   = p6
   irelease  = p7
   ifcmin    = p8     
   ifcmax    = p9
   kband     = p10
   kpan1     = p11
   kpan2     = p12
   icircles  = p13
   itime     = p14
   ipitch    = p15
   ifunc     = p17
                                      
   kamp        linen  iamp, iattack, idur, irelease
   kpan1        oscili kpan1, (1/p3) * icircles, 6
   kpan2        oscili kpan2, (1/p3) * icircles, 5
   ktime        oscili itime, 1/p3, ifunc
   kpitch       oscili ipitch, 1/p3, ifunc
   
   asig         sndwarp 1, ktime, kpitch, 1, 0, 800, 400, 1, 9, 0
   arampsig1 =  kamp * asig
   
   if p18 = 0 goto nofilt
   asig         reson arampsig1, 1214.4, 20
   asig2        reson arampsig1, 1760, 20
   asig3        reson arampsig1, 2376, 20
   asig4        reson arampsig1, 3929.2, 20
   asig5        reson arampsig1, 5869.6, 20
   asig6        reson arampsig1, 8201.6, 20
   asig7        reson arampsig1, 14022.8, 20
   if p18 = 1 goto cont1
   nofilt: arampsig = arampsig1
   goto cont
   cont1: arampsig2 =  asig + asig2 + asig3 + asig4 + asig5 + asig6 + asig7
          arampsig     balance arampsig2, arampsig1
   cont: kcentro oscili   ifcmax, (1/p3) * icircles, 7
   autfilt1      butterbp arampsig * kpan1,ifcmin + kcentro, kband
   autfilt2      butterbp arampsig * kpan2,ifcmin + kcentro, kband
   krevhdif1     oscili  .5, (1/p3) * icircles, 8
   krevhdif2     oscili  .5, (1/p3) * icircles, 8
   arev1         reverb2  autfilt1, 3, .5+ krevhdif1
   arev2         reverb2  autfilt2, 3, .5+ krevhdif2
   aout1    =    autfilt1 + arev1 * .2
   aout2    =    autfilt2 + arev2 * .3

      outs aout1, aout2

   garvbsig1 =  garvbsig1 + aout1 * .2
   garvbsig2 =  garvbsig2 + aout2 * .3
        endin

instr 99
   asig1a       reverb   garvbsig1, 3
   asig2a       reverb   garvbsig2, 2.5
   asig1        butterhp asig1a, 65
   asig2        butterhp asig2a, 65

         outs asig1, asig2
garvbsig1 = 0
      garvbsig2 = 0
        endin
