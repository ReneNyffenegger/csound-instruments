
;*********************************   FREQUENCY DIFFERENCE LIMEN   ************************************

; THE ABILITY TO DISTINGUISH BETWEEN TWO NEARLY EQUAL STIMULI IS OFTEN CHARACTERIZED BY A "DIFFERENCE
; LIMEN " OR "JUST NOTICEABLE DIFFERENCE"(JND). TWO STIMULI CANNOT BE DISTINGUISHED FROM ONE ANOTHER
; IF THEY DIFFER BY LESS THAN JND. THE JND FOR PITCH HAS BEEN FOUND TO DEPEND ON THE FREQUENCY, THE 
; SOUND LEVEL, THE DURATION OF THE TONE, AND THE SUDDENNESS OF THE FREQUENCY CHANGE. TYPICALLY, IT
; IS FOUND TO BE ABOUT 1/30 OF THE CRITICAL BANDWIDTH AT THE SAME FREQUENCY.
; IN THIS DEMONSTRATION, 10 GROUPS OF 4 TONE PAIRS ARE PRESENTED. FOR EACH PAIR, THE SECOND TONE MAY
; BE HIGHER (A) OR LOWER (B) THAN THE FIRST TONE. PAIRS ARE PRESENTED IN RANDOM ORDER WITHIN EACH
; GROUP, AND THEFREQUENCY DIFFERENCE DECREASES BY 1 HZ IN SUCCESSIVE GROUPTHE TONES, 500MS LONG ARE
; SEPARATED BY 250MS. FOLLOWING IS THE ORDER OF PAIRS WITHIN EACH GROUP, WHERE A REPRESENTS (F,F+ *F),
; B REPRESENTS (F+ *F,F) AND F EQUALS 1000HZ.


;  GROUP     *F (HZ)      KEY     
;   1         10         A,B,A,A
;   2          9         A,B,B,B
;   3          8         B,A,A,B
;   4          7         B,A,A,B
;   5          6         A,B,A,B
;   6          5         A,B,A,A
;   7          4         B,B,A,A
;   8          3         A,B,A,B
;   9          2         B,B,B,A
;  10          1         B,A,A,B

;********************************************   HEADER   *********************************************

  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2 
 
 
instr         1

  iamp      =  ampdb(p4)                          ;P4 = AMPLITUDE IN DB 
  ifreq     =  p5                                 ;P5 = FREQUENCY
 
  k1        linen     iamp,.01,p3,.01         
  a1        oscili    k1,ifreq,1             
            outs      a1,a1
endin  

