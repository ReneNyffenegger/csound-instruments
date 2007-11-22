  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2

instr 1

if        p4 == 0 then kgoto dark

light:
  anoise    rand      10000
  a1        reson     anoise, 1760, 4
  a2        reson     anoise, 880, 40

            goto      contin

dark:
  anoise    rand      10000
  a2        reson     anoise, 55, 0.04

            goto      contin

contin:
  krimp     line      30000,p3,0
  aamp      oscil     krimp, 440, 1
  aleft     balance   a1, aamp
  aright    balance   a2, aamp
            outs      aleft,aright
endin
