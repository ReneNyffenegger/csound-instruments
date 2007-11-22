/*
pgmin - Reports MIDI program change messages at k-rate.

DESCRIPTION
This opcode polls MIDI input and reports program change messages and the respective channel they were transmitted on at its output.

SYNTAX
kpgm, kchan  pgmin

PERFORMANCE
kpgm  -  The program change message that was sent.

kchan  -  The channel this program change message was received on.

CREDITS
David Akbari - 2006
*/

	opcode	pgmin, kk, 0

kstatus, kchan, kdata1, kdata2	midiin

if	(kstatus == 192 && (kchan > 0 && kchan <= 16)) then
kpgm	=	kdata1
else
        kpgm    =       -1
        kchan   =       0
	endif

	xout	kpgm, kchan

		endop
 
