 sr=44100
 kr=44100
 ksmps=1
 nchnls=1


  instr 1
 ga1 init 0     ; initialize global variable
 ;MARIMBA([ga1 = ga1 + a1])  ; send output to global reverberator
 
 a1	marimba	100000, 440, 0.5, 0.561, 100, 6.0, 0.05, 100, 0.1
 ga1 = ga1 + a1

 krevamount   line  p4, p3, p5   ; % signal to be reverberated
 arev = krevamount * ga1           ; signal sent to reverberator
 adirect = (1 - krevamount) * ga1  ; direct signal -- no reverberation

 krevtime     line  p6, p3, p7   ; changing reverberation time

  arev  reverb  arev, krevtime
  out arev + adirect     ; add reverberated and direct signal & send them out
  ga1 = 0                ; clear global variable
endin
