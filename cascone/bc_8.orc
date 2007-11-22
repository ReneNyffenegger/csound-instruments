
  sr        =  44100
  kr        =  441
  ksmps     =  100
  nchnls    =  2


;======================================================
;
;    INSTR 8 -- CASCADE HARMONICS
;    [BORROWED INSTR FROM RISSET]
;
;======================================================

instr          8
  inum      notnum    
  icps      cpsmidi   

;   i1         =              p6                  ;INIT VALUES CORRESPOND TO FREQ.
;   i2         =              2*p6                ;OFFSETS FOR OSCILLATORS BASED ON ORIGINAL P6
;   i3         =              3*p6
;   i4         =              4*p6

            ctrlinit  1, 16, 64
  k1        midic7    16, .01, .06


  ampenv    linen     3000,30,80,30               ;envelope

  a1        oscili    ampenv,icps,20
  a2        oscili    ampenv,icps+k1,20           ;NINE OSCILLATORS WITH THE SAME AMPENV
  a3        oscili    ampenv,icps+(k1*2),20       ;AND WAVEFORM, BUT SLIGHTLY DIFFERENT
  a4        oscili    ampenv,icps+(k1*3),20       ;FREQUENCIES TO CREATE THE BEATING EFFECT
  a5        oscili    ampenv,icps+(k1*4),20
  a6        oscili    ampenv,icps-k1,20           ;p4 = FREQ OF FUNDAMENTAL (HZ)
  a7        oscili    ampenv,icps-(k1*2),20       ;p5 = AMP
  a8        oscili    ampenv,icps-(k1*3),20       ;p6 = INITIAL OFFSET OF FREQ - .03 HZ
  a9        oscili    ampenv,icps-(k1*4),20
      
  asnd      =  (a1+a2+a3+a4+a5+a6+a7+a8+a9)/9

  kmgate    linsegr   0, .01, 1, 1, 0
            outs      (a1+a3+a5+a7+a9)*kmgate,(a2+a4+a6+a8)*kmgate

endin

