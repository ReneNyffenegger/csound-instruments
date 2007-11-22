  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr 1                            ; VARY PITCH P4=PITCH MULTIPLIER
  iharm     =  int(44100/(262*p4)/2)-1            ;Chz MAX HARM W/O ALIAS
  kenv      linseg    0,0.01,1,1,1                ;GET STARTED RIGHT
  kmovit    linseg    0,p3,1.0029                 ;1.0029 IS DURATION OF ORIGINAL FILE
  krmsr,krmso,kerr,kcps lpread                    kmovit, "marimba.lpc"
  axit      buzz      1,kcps*p4,iharm,1,-1
  araw      lpreson   axit
  afinal    gain      araw, krmso*kenv,20
            out       afinal
endin


instr 2                                 ; PLAY BACKWARDS & VARY PITCH P4=PITCH MULTIPLIER
  iharm     =  int(44100/(262*p4)/2)-1            ;CHZ MAX HARM W/O ALIAS
  kenv      linseg    1,p3-0.01,1,0.01,0,1,0      ;GET ENDED RIGHT
  kmovit    linseg    1.0029, p3, 100/44100,1,100/44100
;1.0029 IS DURATION OF ORIGINAL FILE, 100/44100 IS TO PREVENT READING PAST 0
  krmsr,krmso,kerr,kcps lpread                    kmovit, "marimba.lpc"
  axit      buzz      1,kcps*p4,iharm,1,-1
  araw      lpreson   axit
  afinal    gain      araw, krmso*kenv,20
            out       afinal
endin

instr 3                            ; HOLD PITCH, SHIFT FORMANTS P4=FORMANT MULTIPLIER
  iharm     =  int(44100/(262)/2)-1               ;CHZ MAX HARM W/O ALIAS
  kenv      linseg    0,0.01,1,1,1                ;GET STARTED RIGHT
  kmovit    linseg    0,p3,1.0029                 ;1.0029 IS DURATION OF ORIGINAL FILE
  krmsr,krmso,kerr,kcps lpread                    kmovit, "marimba.lpc"
  axit      buzz      1,kcps,iharm,1,-1
  araw      lpfreson  axit,p4
  afinal    gain      araw, krmso*kenv,20
            out       afinal
endin
