Diffamator
Version 0.91
July 2006
A randomizable FM synthesizer for csound 5.
by Andrés Cabrera (GUI by my wife Cristina =) )
Released under the GPL license (see gpl.txt).


Diffamator is an MIDI controlled FM synth which can be randomized to find interesting sounds. It features the same algorithms available in the Yamaha DX7 synth, but might not really sound exactly like it, since not all of the synth is implemented. It can also store presets in one of its 30 memory slots.

What's new in Version 0.91:
	* The FM instrument (instrument 1) can now be triggered by MIDI or from the score because it uses the MIDI interop opcodes.
	* An additional 'i Print' button has been added, which prints the score event for the current sound. It is accompanied by Frequency, Duration and velocity slots to determine the generated score text.
	* Keyboard command shortcuts have been added (See USING below).
	* Diffamator can now work without a GUI if the line #define ENABLEFL ## is commented out. This is useful to have some of the features (and the sounds!) of diffamator from the terminal (you still need a MIDI controller to hear diffamator in real-time)
	* Added lock toggle which keeps the algorithm locked when randomizing.

FILES
Included are the Diffamator files, in ordinary csd (Diffamator.csd) format and also in blue 0.107 format (Diffamator0.91.blue). 30 random presets have also been included (.preset files).

SETUP
To use Diffamator you need some sort of MIDI controller transmitting on channel 1, either a physical one, or some software emulation (even a sequencer transmitting via a virtual MIDI cable).
You will need to tell csound to run in realtime with audio output and MIDI input, which varies according to platform. Consult the csound manual for more detail.
Diffamator requires csound 5.02 (older version will not support preset saving).
You can adjust maximum polyphony for your system with the opcode maxalloc.
The ksmps size has a very clear effect on the sound of feedback. Lower values yield a 'smoother' Feedback but reduces polyphony.


USING
MIDI notes (on channel 1) to trigger the sound. You can control each FM operator's ADSR envelope, frequency ratio and phase separately, or you can use the transformation buttons to randomize and manipulate parameters. Diffamator uses the same algorithms as the Yamaha DX7. You can find them at:
http://www.adp-gmbh.ch/csound/dx7/algorithms.html

The transformation buttons do the following (the letter in parenthesis determines the key that can trigger that button):

Rand Mus (q)- Randomizes all Operator parameters, algorithm and feedback but keeping ratios in 0.5 multiple ratios, which tend to generate harmonic spectra

Rand FX (w)- Exactly as before, but ratios are completely randomized, generating mostly noisy and in-harmonic spectra

Attackify (e)- Shortens the attack and decay times, and decreases sustain level to all operators, effectively making the sound more percussive.

Padify (r)- Lengthens the attack and decay times to smooth the onset of the sound

+ Harm (t)- Moves the frequency ratios toward multiples of 0.5, making the sound tend to a more harmonic spectrum

- Harm (y)- Slightly randomizes the frequency ratios, slowly turning a harmonic sound into an in-harmonic one.

Switch + (u)- Switches Operator parameters one operator down

Switch - (i)- Switches Operator parameters one operator up.

You can also use the 'i Print' button to generate a score file line which will trigger the current sound using only instrument 1 (i.e. you only need instrument 1 if you use this line. All the rest, including the FLTK opcodes can be discarded). This is useful for using diffamator in your own compositions. In the GUI you can set the base frequency, duration and velocity of the event. Otherwise, you can modify the p-fields of the generated score event. p3 is duration, p4 is base frequency, and p5 is the velocity (1-127).
The lock toggle locks the algorithm so it's not modified when Diffamator is randomized. Using the lock toggle will invalidate key commands, since the focus goes to the toggle....

Other Keyboard shortcuts
---------------------
o - Increments the algorithm number
p - Decrements the algorithm number

Presets
-------
To recall presets, just press the preset button. To store a preset, Press the 'Store' button until it is lit, and the press the destination preset.
Note that you cannot currently save to the selected preset, you must store to another preset.

To kill Diffamator you can press the red strip with the black circle over the title.

You can run diffamator from the command line using something like (depending on your platform):

csound -+msg_color=false -+rtaudio=JACK -o dac:alsa_pcm:playback_ -+rtmidi=ALSA -M hw:4  -m0 --env:CSNOSTOP=yes diffamator.csd

Please send problems, comments and suggestions to andres at geminiflux [dot] com or the csound mailing list.

Enjoy!
