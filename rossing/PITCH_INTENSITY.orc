 
;*************************************   PITCH AND INTENSITY   ***********************************

; SINE WAVES WILL BE PRESENTED AT 6 DIFFERENT FREQUENCIES TO THE LISTENER(S) IN ORDER TO ILLUSTRATE
; THE AFFECT OF INTENSITY ON THE LISTENER(S) PERCEPTION OF PITCH. THE FREQUENCIES ARE AS FOLLOWS:
; 200HZ, 500HZ, 1000HZ, 3000HZ, 4000HZ, 8000HZ. THE ENVELOPE FOR EACH TONE BURST WILL BE A SIMPLE
; GATE WITH A 5MS. DELAY AND RELEASE. EACH TONE WILL HAVE A DURATION OF 500MS. THE SIX PAIR OF TONES
; ARE PRESENTED AT EACH FREQUENCY SUCH THAT THE SECOND TONE WILL BE 40DB HIGHER THAN THE FIRST. A
; NOTICABLE PITCH CHANGE SHOULD BE AUDIBLE.  
 
 
;******************************************   HEADER   *******************************************  
 
  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1 
 
 
instr         1
 
  iamp      =  ampdb(p4)                          ;P4 = AMPLITUDE IN DB                                    
  iamp      =  ampdb(p4)                
 
 
  k1        linen     iamp,.05,p3,.05         
  a1        oscili    k1,p5,1             
            out       a1
endin  
