/*
midiMonitor - monitors midi input

DESCRIPTION
This opcode monitors incoming midi data and prints the messages to the console in a similar fashion to MIDI-OX. Useful if you want too see what 'ichan' and 'ictlno' parameters need to be passed to ctrl7 for a given slider or rotary pot.

SYNTAX
kMidiSig midiMonitor

PERFORMANCE
kMidiSig will be 1 if there is midi being input, otherwise it will be 0. Remember that you must use the -M flag to specify your MIDI device. 

CREDITS
Rory Walsh, 2006
*/

opcode midiMonitor, k,o
kMidiSig = 0
kstatus, kchan, kdata1, kdata2 midiin
k1 changed kstatus
k2 changed kchan
k3 changed kdata1
k4 changed kdata2
if((k1==1)||(k2==1)||(k3==1)||(k4==1)) then
printks "Value:%d ChanNo:%d CtrlNo:%d\n" , 0, kdata2, kchan, kdata1  
kMidiSig = 1   
endif 
xout kMidiSig
endop
 
