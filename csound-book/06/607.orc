sr      =      	44100
kr    	=     	4410
ksmps  	=     	10
nchnls	=		1

        instr    607        
iampi   =       p4                  ; AMPLITUDE INDEX (0-96)
iocti   =       octpch(p5)*10       ; OCTAVE INDEX (0-120)
iampa   table   iampi, 90           ; f90 = Fn FOR AMP ATK
iampd   table   iampi, 91           ; f91 = Fn FOR AMP DECAY
iocta   table   iocti, 92           ; f92 = Fn FOR OCTAVE ATTACK
ioctd   table   iocti, 93           ; f93 = Fn FOR OCTAVE DECAY
iattack =       iampa*iocta*p7      ; p7 = ATTACK LENGTH
idecay  =       iampd*ioctd*p8      ; p8 = DECAY LENGTH
; SET TOTAL DURATION TO LENGTH OF NOTE + DECAY VALUE
; IF ATTACK IS LONGER THAN p3, THEN SET TOTAL DURATION TO ATTACK + DECAY 
idur    =       (iattack>p3 ? iattack+idecay : p3+idecay)
p3      =       idur    
imodf   table   p4, 94              ; f94 IS Fn FOR MOD SCALER
imodind =       imodf*p9            ; p9 IS MODULATION INDEX
kenv    linen   ampdb(p4), iattack, idur, idecay
kmodenv linen   imodind, iattack, idur, idecay
asig    foscil  kenv, cpspch(p5), 1, 1, kmodenv, p6
        out     asig    
        endin       
