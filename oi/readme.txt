I have many macros, instruments and ftables, often designed 
to be used together.  These include:
---a collection of acoustical instrument simulations.
---systems for refering to the pitches of arbitrary scales, 
   modes and chords in a generalized notation.
---instruments for proclaiming the presiding tunings, modes, 
   chords and pitches of melodies for reference by other instruments
   (e.g., for the melody and harmony generators).
---instruments which generate melodies and harmonies, possibly in
   response to other, presiding melodies and harmonies and in 
   accordance with high-level (e.g., Markov) constraints defined
   by the user.
---instruments which perform notes automatically (e.g., strummers
   and n-tuple performers).
---localization/spatialization/reverberation instruments [soon].
---other, utilitarian instruments.


in this release, I've tried to break them up into separate files
to be used, as much as possible, as convienient "plug-ins," risking,
I realize, confusion, since the instruments often depend on macros,
ftables and other instruments.  I will try to document the dependancies
as clearly as possible.  A further complication in this is the 
necessity of separating macros and instruments from ftables in 
different "includes" files.  For now, I intend to have pairs of 
associated files, e.g., FILE.txt for instruments and macros and
FILESCO.txt for its associated ftables and instrument comments.
If you encounter any problems with dependancy, please let me know.
In particular, the pitch converter macros are used extensively.
I have also prepared demo scores and orchestras for some of these
instruments and macros, and will try to maintain mp3 versions of
their output on the website.


What follows is a list of my general (i.e., not sound-producing
instrument simulations, which are introduced in "simulationREADME.txt") 
macros and instruments.  In my implementation, they expect to have 
certain instrument numbers and they expect certain ftables to have 
certain fixed numbers.  Feel free to change them if you're willing to 
manage the mess; if you want to implement them as they are, simply 
keep instrument numbers 1--50 and ftable numbers 1--70 free (but note 
that ftables >100 may be assigned automatically by my instrument 
simulations)

;macro contents:
;md2sd, sd2md, getPitch, 
;doChord,
;silencer, autoShutoff, forcedShutoff
;od2z,z28,z2sd

;general instruments:
;3  zak initializer
;4  tuning proclaimer
;6  mode proclaimer
;8  chord proclaimer (via score)
;10 melody proclaimer (via score)
;12 harmony generator(/chord proc.) 
;13 " pt2---not called from score
;15 melody generator(/proc.)	[unfinished]
;17 n-tuple performer (meta-strummer)  [unfinished]
;19 pitch processor (chooses chordal degree) (depricated?)
;21 strummer
;22 subroutine: used by strummer (depricated)
;note: for harmonies generated in response to generated melodies, 
;the harmonic generator must be called (slightly) after the melody generator

possible future instruments:
;melodic performer, chorder, arpeggiator?
;melody and chord followers (listen to channels and generate 
;events with phrasing?
; a rhythm/event generator?

An annotated list of the same:

macros:
Of the macros, getPitch is the one most likely to be reused.
It allows pitches to be refered to by reference to user-defined
scales, modes and chords.  In order to make these definitions,
see the ftables associated with the tuning, mode and chord
proclaimers below.  An exellent source of tuning and modal data
is Manuel Op de Coul's Scale Archive at  
http://www.xs4all.nl/~huygensf/scala/downloads.html
and his List of Musical Modes at
http://www.xs4all.nl/~huygensf/doc/modename.html.

The generalized pitch codes to be used with getPitch are as follows:
E.g., if we say $getPitch(p4),

SCALAR---if p4 is -ve:
	-8ve.DD, where DD is the two-digit modal degree (0,...,99).
	(note that scalar degree 00 is inaccesible in 8ve 0.)
MODAL---if p4 is 0 or +ve:
	8ve.DCC, where D is the one-digit modal degree (0,...,9)
	and CC is the two-digit mode channel (00,...,39).
CHORDAL---if p4 is +ve and large, ~>=100:
	Coo.c or CooOO.c where C=chord channel number {1, 2, 3}, 
	oo=dictated 8ve number, 
	ooOO= an acceptable range of 8ve numbers (inclusive) 	
	(one will be chosen at random), and 
	c=chord component number (1...6).
	If c=0 or >6, one will be chosen at random. (I find this 
	useful for pitched percussion, for example.)
The macro then decodes p4 and assigns the appropriate values to
i8ve, isd, ioct and icps---the octave number, scalar degree, 
oct value, and Hz value.  The macro can be used any number of 
times within the same instrument as long as it is called with 
a different argument each time.

;3  zak initializer---allocates and intializes zak space; assumes use
;				by other instruments
	;zakinits
	;p4--max scale size
	;p5--sum of number of chord types
	;p6--number of control channels needed
	;p7--number of audio channels needed

;4  tuning proclaimer---proclaims the presiding tuning, as directed 
;			 	 by the score, onto git.
	;p4=tuning table number

;6  mode proclaimer---proclaims the presiding modes, as directed 
;			 	by the score, onto "mode channels" in ftable 2.
	;p4=mode code: mtn.mit, where mtn=mode definition table number (20--29)
	;   	and mit=mode-in-table number (two digits, .00,...,.99)
	;p5=Markov table number, either melodic or harmmonic (30--49)
	;p6=modulatory scalar degree offset, i.e., MD0=p6 in scalar degrees
	;p7=mode channel (0--39) on which to proclaim
	;p8=mode channel---if >p7, proclaims on (p7,p8) inclusive

;8  chord proclaimer---proclaims the presiding chords, as directed 
;			 	by the score, onto "chord channels" in ftable 4.
	;p4=chord code, p5=chord channel 1--3, p6=mode channel
	;chord code:
	;0 or +ve=natural (selection from mode) modal root.type (.0) (types 0..n)
	;-ve= selection from scale: scalar root.type (.00)(types 1..n)
	;trailing digit=chord definition table number-10(modal) or -15(scalar)
	;so, the trailing digits may be (.00--.04)if modal and (.000--.004)if scalar

;10 melody proclaimer---proclaims melodies' current notes 
;				(for use by the melody and harmony 
;				generators) as directed by the score, 
;				on 120 "channels" in ftable 3---
	; these correspond to the 40 modal channels 
	;as mc0=>0,40,80, etc.
	;p1=10.NNMM... where NN.MM... is the destination instrument which will be
	;sent the note (or none if the NN==0).
	;p4=the pitch of the note to be proclaimed, in general pitch notation
	;p5=the channel (0,...,119) on which to proclaim it.
	;p6=if >p5, proclaim on the range (p5,p6) inclusive, otherwise on p5 only
	;p7=decode using mode number p7, if -ve, the mode of the concerned melody
	;channel is used.  (i.e., if p4 is scalar, it is interpreted as being a
	;degree of mode p7; if p4 is modal, it is converted from the mode of p7
	;to the mode of melody channel p5.
	;if the destination is >0, an event is scheduled with p-fields:
	;i [destination],p2,p8,[proclaimed pitch],p9,p10...etc

;12 harmony generator(/chord proc.)---generates and proclaims a chord,
;						possibly influenced by several 
;					things: the previous chord and Markov chains
;				defined by the harmonic mode; up to three pitches
;			from currently-sounding melodies; other, simultaneously-
;		sounding chords; demanded chord type; etc., etc., etc.
	;p4=C.DDdd where C=chord channel on which to proclaim generated chord {1,2,3}
	; and where DD and dd=prefered number of SD steps to separate tones. 
	; if DDdd=0 (i.e., the default), 3 and 4 steps are prefered.
	;p5=R.E where R=the reference chord channel---the new chord will be chosen
	; in reference to that on chord channel R. if R is not {1,2,3} or if R=C,
	; then no chord is used as a referece (i.e., a chord will be chosen freely).
	; and where E=the suitability on [0,1) of tones D steps outside 
	; the bounding chord tones.
	; (e.g., of a melodic 7th above a chord, or another chord rooted there).
	;p6=a demanded chord type.  if 0.T, the modal type T; if N.TT, the scalar
	; type TT; if -ve, the type is uncertain, and will be chosen by the algorithm.
	;p7---p9=M.F where M refers to melody channels which to harmonize 
	; (ignored if -ve) where F [0,1) the importance of that channel.
	;p10=modal chord definition table number (default =10)
	;p11=scalar chord definition table number (default =15)
;13 harmony generator pt2---must be called from the score with the same
;	arguments as instrument 12 (and at the same time).  Why break it 
;	up into two?  Because my little computer crashes if I don't.
;	Why not have the first trigger the second?  Because I can't get
;	the scheduling opcodes to work as expected.

;15 melody generator(/proc.)---analogous to the harmony generator; 
					as yet unfinished.

;17 n-tuple performer (meta-strummer)---unfinished

;21 strummer---performs a strum (a series of overlapping, sustained notes)
			on any other instrument given a chord channel, an
			accordatura and other performance parameters.
	;p1=21.xxyyy..., where xx.yyy... is the destination instrument.
	;p3=sounding duration (of each note)
	;p4=dB
	;p5=chord channel number {1,2,3}
	;p6=accordatura table number
	;  +ve if strumming up, -ve is strumming down.
	;p7=seconds in which to traverse fretboard
	;p8=capo position (may be -ve)
	;p9=tilt of plectrum effective on [-1,1],
	;  -1=very bass-heavy, 1=very treble-heavy
	;p10...-->p6... of destination instrument 
	;  (the destination's p5's become assigned pitches)


-------------------------------------Dr. Michael Saunders
                                     MichaelSaunders7@hotmail.com
http://members.fortunecity.com/odradek5/pp/csound/index.html