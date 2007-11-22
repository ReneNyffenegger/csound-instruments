; jmdbrady@club-internet.fr wrote:
; Hi,
;>
;> I can't find any precise information about making ties between two notes.
;> The manual only says:" p1 instrument number[...] An optional fractional part
;> can provide an additional tag for specifying ties between particular notes." 
;> I've tried unsuccessfully.
;>
;> How can I make it?
;>
;> Thanks for any help.
;>
;> Jean-Michel DARRÉMONT

; It just so happens that I have been exploring exactly this question myself,
; and I think I've got it pretty well figured out.  Included below is a simple
;example orchestra and score that illustrates how to do portamento between
; notes that are tied, but to just play the note strictly with its given pitch
; if it's not tied.  The score also uses the fractional instrument number
; feature to show polyphonic portamento.

;               David Kirsh


  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1


; Demonstration of portamento between tied notes
; This technique could be applied to other parameters and to
; non-tied notes with straightforward changes.
instr   5           
  inote     =  cpspch(p4)                         ; THIS NOTE'S PITCH

    ; If this is not a tied note, then there's no previous
    ; pitch to glide from, so set beginning pitch of
    ; portamento to this note's pitch.  Then save this same
    ; pitch in 'iprevpitch' so we can remember what pitch we
    ; are coming from when we have a tied note.  We have to
    ; save it both here and in the tied note case because if
    ; we do it in a common place below, Csound complains about
    ; iprevpitch being used before set.
            tigoto    tieinit

    ; At this point we know we're not in a tied note.
    ; Set beginning and previous pitches to the same thing.
  ibegpitch =  inote
  iprevpitch   =      inote
            goto      cont

tieinit:
    ; We're in a tied note.
    ; Set up beginning pitch for portamento to new pitch.
    ; Beginning pitch is pitch of previous note that this one is
    ; tied onto the end of.  Save current pitch in case another
    ; note ties onto this one; then we'll be able to portamento
    ; again to that new pitch.
  ibegpitch =  iprevpitch
  iprevpitch   =      inote

cont:
    ; Now set up a pitch envelope that moves from the beginning
    ; pitch (as determined above) to this note's nominal pitch.
  kpitchenv linseg    ibegpitch, .9, inote, abs(p3), inote

    ; Generate a sound using the pitch envelope.  Notice the
    ; last 'buzz' argument (-1), which causes phase
    ; initialization to be skipped.  This is important to avoid
    ; clicks on tied notes.  (This simple example clicks on
    ; untied notes, though, because there's no amplitude
    ; envelope.)
  a1        buzz      10000, kpitchenv, 6, 1, -1
            out       a1
endin
