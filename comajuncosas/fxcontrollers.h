#define FxControllers(FxSlot)
#
kndxS$FxSlot. init $FxSlot.-1
kFxSelS$FxSlot. table kndxS$FxSlot., giFxftSel	

if (kFxSelS$FxSlot.==0) goto Control0S$FxSlot.
if (kFxSelS$FxSlot.==1) goto Control1S$FxSlot.
if (kFxSelS$FxSlot.==2) goto Control2S$FxSlot.
if (kFxSelS$FxSlot.==3) goto Control3S$FxSlot.
if (kFxSelS$FxSlot.==4) goto Control4S$FxSlot.
if (kFxSelS$FxSlot.==5) goto Control5S$FxSlot.
if (kFxSelS$FxSlot.==6) goto Control6S$FxSlot.
if (kFxSelS$FxSlot.==7) goto Control7S$FxSlot.
if (kFxSelS$FxSlot.==8) goto Control8S$FxSlot.

goto ControllersDoneS$FxSlot. 

Control0S$FxSlot.:
goto ControllersDoneS$FxSlot.

Control1S$FxSlot.:
zkw gk1Fx1Slot$FxSlot.,0+16*(kndxS$FxSlot.)
zkw gk2Fx1Slot$FxSlot.,1+16*(kndxS$FxSlot.)
goto ControllersDoneS$FxSlot.

Control2S$FxSlot.:
zkw gk1Fx2Slot$FxSlot.,0+16*(kndxS$FxSlot.)
zkw gk2Fx2Slot$FxSlot.,1+16*(kndxS$FxSlot.)
goto ControllersDoneS$FxSlot.

Control3S$FxSlot.:
zkw gk1Fx3Slot$FxSlot.,0+16*(kndxS$FxSlot.)
zkw gk2Fx3Slot$FxSlot.,1+16*(kndxS$FxSlot.)
zkw gk3Fx3Slot$FxSlot.,2+16*(kndxS$FxSlot.)

zkw gk4Fx3Slot$FxSlot.,3+16*(kndxS$FxSlot.)
	ktrigS$FxSlot.	metro	4.2

kr0S$FxSlot. zkr 1+16*kndxS$FxSlot.
krfS$FxSlot. zkr 2+16*kndxS$FxSlot.
kFx3xS$FxSlot.=27.5*kr0S$FxSlot.
kFx3wS$FxSlot.=27.5*(krfS$FxSlot.);-kr0S$FxSlot.)
FLsetOverlay	ktrigS$FxSlot.,kFx3xS$FxSlot.,2,kFx3wS$FxSlot.,75,gih5Fx3Slot$FxSlot. 

goto ControllersDoneS$FxSlot.

Control4S$FxSlot.:
zkw gk1Fx4Slot$FxSlot.,0+16*(kndxS$FxSlot.)
zkw gk2Fx4Slot$FxSlot.,1+16*(kndxS$FxSlot.)
zkw gk3Fx4Slot$FxSlot.,2+16*(kndxS$FxSlot.)
goto ControllersDoneS$FxSlot.

Control5S$FxSlot.:
zkw gk2Fx5Slot$FxSlot.,0+16*(kndxS$FxSlot.)
zkw gk4Fx5Slot$FxSlot.,1+16*(kndxS$FxSlot.)
zkw gk5Fx5Slot$FxSlot.,2+16*(kndxS$FxSlot.)
goto ControllersDoneS$FxSlot.

Control6S$FxSlot.:
zkw gk1Fx6Slot$FxSlot.,0+16*(kndxS$FxSlot.)
zkw gk5Fx6Slot$FxSlot.,1+16*(kndxS$FxSlot.)
zkw gk6Fx6Slot$FxSlot.,2+16*(kndxS$FxSlot.)
zkw gk7Fx6Slot$FxSlot.,3+16*(kndxS$FxSlot.)
zkw gk8Fx6Slot$FxSlot.,4+16*(kndxS$FxSlot.)
goto ControllersDoneS$FxSlot.

Control7S$FxSlot.:
zkw gk1Fx7Slot$FxSlot. ,0+16*(kndxS$FxSlot.)
zkw gk9Fx7Slot$FxSlot. ,1+16*(kndxS$FxSlot.)
zkw gk10Fx7Slot$FxSlot.,2+16*(kndxS$FxSlot.)
zkw gk11Fx7Slot$FxSlot.,3+16*(kndxS$FxSlot.)
zkw gk12Fx7Slot$FxSlot.,4+16*(kndxS$FxSlot.)
goto ControllersDoneS$FxSlot.

Control8S$FxSlot.:
zkw gk1Fx8Slot$FxSlot. ,0+16*(kndxS$FxSlot.)
zkw gk2Fx8Slot$FxSlot. ,1+16*(kndxS$FxSlot.)
zkw gk3Fx8Slot$FxSlot. ,2+16*(kndxS$FxSlot.)
zkw gk4Fx8Slot$FxSlot. ,3+16*(kndxS$FxSlot.)
zkw gk5Fx8Slot$FxSlot. ,4+16*(kndxS$FxSlot.)
zkw gk6Fx8Slot$FxSlot. ,5+16*(kndxS$FxSlot.)
zkw gk7Fx8Slot$FxSlot. ,6+16*(kndxS$FxSlot.)
zkw gk8Fx8Slot$FxSlot. ,7+16*(kndxS$FxSlot.)
zkw gk9Fx8Slot$FxSlot. ,8+16*(kndxS$FxSlot.)
goto ControllersDoneS$FxSlot.

ControllersDoneS$FxSlot.:
#