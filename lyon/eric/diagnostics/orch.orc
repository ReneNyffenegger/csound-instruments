sr=44100
kr=4410
ksmps=10
nchnls=2

;i1 0 .25 
;i1 1 .25 
;i1 2 .25 
;i1 3 .25 
;i2 4 .25 
;i2 5 .25 
;i2 6 .25 
;i2 7 .25 
instr 1
igain = 32767.
iatk=.02
idk=.1
isust=p3-(iatk+idk)
	kenv linseg 0,iatk,igain,isust,igain,idk,0
	asig randi kenv,15000,1
	outs1 asig
endin

instr 2
igain = 32767.
iatk=.05
idk=.1
isust=p3-(iatk+idk)
	kenv linseg 0,iatk,igain,isust,igain,idk,0
	asig randi kenv,15000,1
	outs2 asig
endin
