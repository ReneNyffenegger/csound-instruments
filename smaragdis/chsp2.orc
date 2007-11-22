  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr 1

  ia        =  1
  isqa      =  sqrt(ia)
  ifm       =  cpspch( p4)

            goto      r1
if ifm > cpspch( 8.06)  && ifm < cpspch( 9.00) igoto r1
if ifm > cpspch( 9.00)  && ifm < cpspch( 9.06) igoto r2
if ifm > cpspch( 9.06)  && ifm < cpspch( 10.00) igoto r3
if ifm > cpspch( 10.00) && ifm < cpspch( 10.06) igoto r4
if ifm > cpspch( 10.06) && ifm < cpspch( 11.00) igoto r5
if ifm > cpspch( 11.00) && ifm < cpspch( 11.06) igoto r6
if ifm > cpspch( 11.06) && ifm < cpspch( 12.00) igoto r7

r1:
  ifmt1     =  175
  ia1       =  .400
  i1        =  0.1
  ifmt2     =  350
  ia2       =  .800
  i2        =  0.5
  ifmt3     =  2800
  ia3       =  .150
  i3        =  1.6
            igoto     numcrunch

r2:
  ifmt1     =  262
  ia1       =  .400
  i1        =  0.1
  ifmt2     =  524
  ia2       =  .800
  i2        =  0.1
  ifmt3     =  2700
  ia3       =  .150
  i3        =  1.6
            igoto     numcrunch

r3:
  ifmt1     =  392
  ia1       =  .800
  i1        =  0.1
  ifmt2     =  784
  ia2       =  .400
  i2        =  0.1
  ifmt3     =  2500
  ia3       =  .150
  i3        =  1.6
            igoto     numcrunch

r4:
  ifmt1     =  523
  ia1       =  .800
  i1        =  0.1
  ifmt2     =  950
  ia2       =  .200
  i2        =  0.1
  ifmt3     =  2450
  ia3       =  .150
  i3        =  1.6
            igoto     numcrunch

r5:
  ifmt1     =  784
  ia1       =  .800
  i1        =  0.0
  ifmt2     =  1568
  ia2       =  .100
  i2        =  0.0
  ifmt3     =  2400
  ia3       =  .150
  i3        =  1.6
            igoto     numcrunch

r6:
  ifmt1     =  1046
  ia1       =  .800
  i1        =  0.0
  ifmt2     =  2092
  ia2       =  .100
  i2        =  0.0
  ifmt3     =  2350
  ia3       =  .100
  i3        =  1.5
            igoto     numcrunch

r7:
  ifmt1     =  1568
  ia1       =  .800
  i1        =  0.0
  ifmt2     =  3136
  ia2       =  .000
  i2        =  0.0
  ifmt3     =  4500
  ia3       =  .100
  i3        =  1.0

numcrunch:

  inj       =  ifmt1 / ifm
  ifc1      =  ( inj - int(inj) > .5 ? int(inj + 1) : int( inj))

  inj       =  ifmt2 / ifm
  ifc2      =  ( inj - int(inj) > .5 ? int(inj + 1) : int( inj))

  inj       =  ifmt3 / ifm
  ifc3      =  ( inj - int(inj) > .5 ? int(inj + 1) : int( inj)) 

  itf       =  6.28
  iamp      =  25000
        
  am        oscil     1,      itf * ifm,      1

  a1        oscil     iamp * ia1,     itf * ifc1 + ifm * i1 * am,     1
  a2        oscil     iamp * ia2,     itf * ifc2 + ifm * i2 * am,     1
  a3        oscil     iamp * ia3,     itf * ifc3 + ifm * i3 * am,     1

  a1        =  a1 * isqa
  a2        =  a2 * ia * isqa
  a3        =  a3 * ia * ia
        
            out       (a1 + a2 + a3)

endin
