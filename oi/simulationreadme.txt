I am attempting to make available a series of instrument 
simulations, each actual instrument being simulated by a 
number of different methods, as appropriate.  The purpose 
of using more than one method is to make available the 
unique expressive contols made possible by each of the 
different synthesis methods, as well as their subtly 
different sounds.  These simulations have a number of 
things in common:  

--Legato phrasing is provided for.
--As much expressive control as practical is provided. 
--Control is given over the register (corresponding to 
  physical size of the simulated instrument), sometimes
  variable within a note.
--They are to be called with dB and my generalized pitch 
  notation (i.e., with pitches refering to user-defined
  scales, modes and chords). (see README.txt.)
--Small variations in automatic expression, where appropriate.

In general, there are three types of instruments---sustained,
impulsive and unique.  Each of these categories lends itself 
to different forms of simulation, and some actual instruments 
have special considerations (e.g., tromba marinas have their
trumsheits, hurdy gurdies have their mouches, etc.) to be
simulated.  The following is a list of types, synthesis 
methods and the characteristic controls for each:


COMMON CONTROLS
	In most instruments, legato passages are indicated by negative
	durations and end with the last positive duration (this is different
	for fof-based instruments). Sometimes, instruments need to be 
	passed the next/previous pitch/loudness in order to perform legato
	phrases.  This can normally be handled automatically, using 
	np and pp operators in the score.  Outside of legato phrases these
	fields should be set accordingly (usually, the next/last dB should 
	be 0 and the next/last pitch is not very critical.
	
	Usually, p4 is the loudness in dB and p5 is the pitch in 
	generalized pitch notation. Usually, instruments can glissando 
	to a target pitch.  

	Usually, instruments have a swell function, peaking at a given 
	fraction of the note length and indicating a swell by a given
	dB of loudness (which may be negative) and to a given vibrato
	depth.  The swell can also be connected to other expressive 
	parameters.

	Usually, instruments have a "register" parameter, which relates 
	to the physical size of the actual instrument---in the simulation 
	it offsets the formants and changes some other parameters 
	accordingly.  The "home" register of an instrument is numbered 0, 
	and corresponds to a range of pitches indicated in the instrument's 
	documentation. Integer register parameters indicate this same
	range shifted by a number of perfect fifths.

	The last pfield of a simulation indicates the zak channel which
	it outputs on.  This channel can then be used by mixers or 
	effects channels and output with an output instrument (like  
	monoOut or localizer.

SUSTAINED INSTRUMENTS

	WAVESHAPING
	I like to interpolate between the simultaneous output
	of a number of different transfer functions, depending
	on pitch.  This makes it possible to mimic the formants
	of an instrument while getting the variability of 
	spectrum inherent in waveshaping.

	--The register can change by a given amount along with the swell.
	--There are six simultaneous control functions (dB-related, inverse
	vibrato, an lfo (with a controllable frequency sweep), tunable noise 
	(brown or pink), swell, and linear) which can be weighted and 
	combined to control the spectral richness. Since the spectrum 
	varies in a complex way with this control function (but generally
	becomes brighter as the value increases), it can be a powerful
	technique for producing lively, interesting sounds. 


	SUBTRACTIVE---PITCHED SOURCE
	Excellent for its clean sound and ability to simulate 
	formants.

	--It can have tremolo as well as vibrato.


	SUBTRACTIVE---NOISE SOURCE
	Excellent for its breathy sound and ability to simulate 
	formants.  I use comb-filtered blue noise as a source
	and compress the output.  The blueness (high-pass-
	filtered white noise) and the compression help to control
	the unruliness and jitter of the noise, and the comb filters
	serve to make it more-or-less strongly pitched.  This
	introduces the interesting feature of line width to the 
	partials.

	--These have the property of linewidth---the width of their 
	partials in the spectrum, measured in units of quartertones 
	(since this is on the scale of pitch discrimination).  The 
	linewidth can vary with the swell.
	--There is also a built-in compressor which deals with the 
	unruliness of the noise source.  The compression factor can
	be set in the score and varied with the swell.


	FOF
	Similar to a clean, efficient subtractive instrument.

	--The register can vary with the swell.
	--These have spectral tremolo, a variation in brightness 
	linked to vibrato.


	PHYSICAL SIMULATIONS
	Csound provides a number of ready-made simulations and 
	tools for physical simulation.  I'll try to provide my
	own little front-end instruments for these when possible, 
	and when the parameter estimation is easy (which is why
	I'm not using other methods, e.g., FM).


IMPULSIVE	---none yet.
UNIQUE

So far, the following instruments are available:

SUSTAINED---(in WS, SUB-P, SUB-N, FOF)
	
	French Horns

IMPULSIVE INSTRUMENTS	---none yet.
UNIQUE INSTRUMENTS

There are many more to come, I hope.  Personally, I'm very
interested in simulating instruments of the Renaissance and 
Medieval eras, as well as non-Western instruments, but for now, 
most of the data I have available is for classical Western
orchestral instruments.  I'd appreciate any more pointers to 
acoustical data!

-----------------------------------------Dr. Michael Saunders
							MichaelSaunders7@hotmail.com
http://members.fortunecity.com/pp/csound/index.html	