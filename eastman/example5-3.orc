   sr= 44100
   kr = 2205
   ksmps = 20
   nchnls = 1

   instr 1

  audio  soundin  p4, p6   ; read in the audio soundfile
  aenv soundin p9 , p10    ; read in the control soundfile

     ; impose control soundfile envelope on audio file
  audio  balance  audio , aenv
     ; vary output amplitude from note to note :
  p5 = ( p5 = 0 ? 1. : p5 )
  audio  =  audio * p5

  ; optional fade-in & fade-out
  itest =  p7 + p8
  if itest = 0  goto done
       kfades expseg .01, p7, 1.,p3-(p7 + p8), 1., p8,.01
       audio = audio * kfades
  done:
  out audio
  endin
