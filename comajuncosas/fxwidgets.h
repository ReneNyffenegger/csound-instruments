#define FxWidgets(FxSlot)
#
if ($FxSlot.!=p4) igoto WidgetsDoneS$FxSlot.

iFxPrevSelS$FxSlot. tab_i $FxSlot.-1, giFxftPrevSel	
iFxSelS$FxSlot.     tab_i $FxSlot.-1, giFxftSel	

if (iFxPrevSelS$FxSlot.==0) igoto Hide0S$FxSlot.
if (iFxPrevSelS$FxSlot.==1) igoto Hide1S$FxSlot.
if (iFxPrevSelS$FxSlot.==2) igoto Hide2S$FxSlot.
if (iFxPrevSelS$FxSlot.==3) igoto Hide3S$FxSlot.
if (iFxPrevSelS$FxSlot.==4) igoto Hide4S$FxSlot.
if (iFxPrevSelS$FxSlot.==5) igoto Hide5S$FxSlot.
if (iFxPrevSelS$FxSlot.==6) igoto Hide6S$FxSlot.
if (iFxPrevSelS$FxSlot.==7) igoto Hide7S$FxSlot.
if (iFxPrevSelS$FxSlot.==8) igoto Hide8S$FxSlot.
igoto ShowS$FxSlot.

Hide0S$FxSlot.:
FLhide giFx0$FxSlot.name
igoto ShowS$FxSlot.

Hide1S$FxSlot.:
FLhide giFx1$FxSlot.name
FLhide gih1Fx1Slot$FxSlot.
FLhide gih2Fx1Slot$FxSlot.
igoto ShowS$FxSlot.

Hide2S$FxSlot.:
FLhide giFx2$FxSlot.name
FLhide gih1Fx2Slot$FxSlot.
FLhide gih2Fx2Slot$FxSlot.
igoto ShowS$FxSlot.

Hide3S$FxSlot.:
FLhide giFx3$FxSlot.name
	FLhide gih1Fx3valSlot$FxSlot.
FLhide gih1Fx3Slot$FxSlot.
FLhide gih2Fx3Slot$FxSlot.
FLhide gih3Fx3Slot$FxSlot.
FLhide gih4Fx3Slot$FxSlot.
FLhide gih5Fx3Slot$FxSlot.
igoto ShowS$FxSlot.

Hide4S$FxSlot.:
FLhide giFx4$FxSlot.name
FLhide gih1Fx4Slot$FxSlot.
FLhide gih2Fx4Slot$FxSlot.
FLhide gih3Fx4Slot$FxSlot.
igoto ShowS$FxSlot.

Hide5S$FxSlot.:
FLhide giFx5$FxSlot.name
FLhide gih1Fx5Slot$FxSlot.
FLhide gih2Fx5Slot$FxSlot.
FLhide gih3Fx5Slot$FxSlot.
FLhide gih4Fx5Slot$FxSlot.
FLhide gih5Fx5Slot$FxSlot.
FLhide gih6Fx5Slot$FxSlot.
FLhide gih7Fx5Slot$FxSlot.
igoto ShowS$FxSlot.

Hide6S$FxSlot.:
FLhide giFx6$FxSlot.name
FLhide gih1Fx6Slot$FxSlot.
FLhide gih2Fx6Slot$FxSlot.
FLhide gih3Fx6Slot$FxSlot.
FLhide gih4Fx6Slot$FxSlot.
FLhide gih5Fx6Slotval$FxSlot.
FLhide gih6Fx6Slotval$FxSlot.
FLhide gih7Fx6Slotval$FxSlot.
FLhide gih5Fx6Slot$FxSlot.
FLhide gih6Fx6Slot$FxSlot.
FLhide gih7Fx6Slot$FxSlot.
FLhide gih8Fx6Slot$FxSlot.
igoto ShowS$FxSlot.

Hide7S$FxSlot.:
FLhide giFx7$FxSlot.name
FLhide gih1Fx7Slot$FxSlot.
FLhide gih2Fx7Slot$FxSlot.
FLhide gih3Fx7Slot$FxSlot.
FLhide gih4Fx7Slot$FxSlot.
FLhide gih5Fx7Slot$FxSlot.
FLhide gih6Fx7Slot$FxSlot.
FLhide gih7Fx7Slot$FxSlot.
FLhide gih8Fx7Slot$FxSlot.
FLhide gih9Fx7Slotval$FxSlot.
FLhide gih10Fx7Slotval$FxSlot.
FLhide gih11Fx7Slotval$FxSlot.
FLhide gih12Fx7Slotval$FxSlot.
FLhide gih9Fx7Slot$FxSlot.
FLhide gih10Fx7Slot$FxSlot.
FLhide gih11Fx7Slot$FxSlot.
FLhide gih12Fx7Slot$FxSlot.
igoto ShowS$FxSlot.

Hide8S$FxSlot.:
FLhide giFx8$FxSlot.name
FLhide gih1Fx8Slot$FxSlot.
FLhide gih2Fx8Slot$FxSlot.
FLhide gih3Fx8Slot$FxSlot.
FLhide gih4Fx8Slot$FxSlot.
FLhide gih5Fx8Slot$FxSlot.
FLhide gih6Fx8Slot$FxSlot.
FLhide gih7Fx8Slot$FxSlot.
FLhide gih8Fx8Slot$FxSlot.
FLhide gih9Fx8Slot$FxSlot.
igoto ShowS$FxSlot.

ShowS$FxSlot.:

if (iFxSelS$FxSlot.==0) igoto Show0S$FxSlot.
if (iFxSelS$FxSlot.==1) igoto Show1S$FxSlot.
if (iFxSelS$FxSlot.==2) igoto Show2S$FxSlot.
if (iFxSelS$FxSlot.==3) igoto Show3S$FxSlot.
if (iFxSelS$FxSlot.==4) igoto Show4S$FxSlot.
if (iFxSelS$FxSlot.==5) igoto Show5S$FxSlot.
if (iFxSelS$FxSlot.==6) igoto Show6S$FxSlot.
if (iFxSelS$FxSlot.==7) igoto Show7S$FxSlot.
if (iFxSelS$FxSlot.==8) igoto Show8S$FxSlot.
igoto WidgetsDoneS$FxSlot. 

Show0S$FxSlot.:
FLshow giFx0$FxSlot.name
igoto WidgetsDoneS$FxSlot.

Show1S$FxSlot.:
FLshow giFx1$FxSlot.name
FLshow gih1Fx1Slot$FxSlot.
FLshow gih2Fx1Slot$FxSlot.
igoto WidgetsDoneS$FxSlot.

Show2S$FxSlot.:
FLshow giFx2$FxSlot.name
FLshow gih1Fx2Slot$FxSlot.
FLshow gih2Fx2Slot$FxSlot.
igoto WidgetsDoneS$FxSlot.

Show3S$FxSlot.:
FLshow giFx3$FxSlot.name
	FLshow gih1Fx3valSlot$FxSlot.
FLshow gih1Fx3Slot$FxSlot.
FLshow gih2Fx3Slot$FxSlot.
FLshow gih3Fx3Slot$FxSlot.
FLshow gih4Fx3Slot$FxSlot.
FLshow gih5Fx3Slot$FxSlot.
igoto WidgetsDoneS$FxSlot.

Show4S$FxSlot.:
FLshow giFx4$FxSlot.name
FLshow gih1Fx4Slot$FxSlot.
FLshow gih2Fx4Slot$FxSlot.
FLshow gih3Fx4Slot$FxSlot.
igoto WidgetsDoneS$FxSlot.

Show5S$FxSlot.:
FLshow giFx5$FxSlot.name
FLshow gih1Fx5Slot$FxSlot.
FLshow gih2Fx5Slot$FxSlot.
FLshow gih3Fx5Slot$FxSlot.
FLshow gih4Fx5Slot$FxSlot.
FLshow gih5Fx5Slot$FxSlot.
FLshow gih6Fx5Slot$FxSlot.
FLshow gih7Fx5Slot$FxSlot.
igoto WidgetsDoneS$FxSlot.

Show6S$FxSlot.:
FLshow giFx6$FxSlot.name
FLshow gih1Fx6Slot$FxSlot.
FLshow gih2Fx6Slot$FxSlot.
FLshow gih3Fx6Slot$FxSlot.
FLshow gih4Fx6Slot$FxSlot.
FLshow gih5Fx6Slotval$FxSlot.
FLshow gih6Fx6Slotval$FxSlot.
FLshow gih7Fx6Slotval$FxSlot.
FLshow gih5Fx6Slot$FxSlot.
FLshow gih6Fx6Slot$FxSlot.
FLshow gih7Fx6Slot$FxSlot.
FLshow gih8Fx6Slot$FxSlot.
igoto WidgetsDoneS$FxSlot.

Show7S$FxSlot.:
FLshow giFx7$FxSlot.name
FLshow gih1Fx7Slot$FxSlot.
FLshow gih2Fx7Slot$FxSlot.
FLshow gih3Fx7Slot$FxSlot.
FLshow gih4Fx7Slot$FxSlot.
FLshow gih5Fx7Slot$FxSlot.
FLshow gih6Fx7Slot$FxSlot.
FLshow gih7Fx7Slot$FxSlot.
FLshow gih8Fx7Slot$FxSlot.
FLshow gih9Fx7Slotval$FxSlot.
FLshow gih10Fx7Slotval$FxSlot.
FLshow gih11Fx7Slotval$FxSlot.
FLshow gih12Fx7Slotval$FxSlot.
FLshow gih9Fx7Slot$FxSlot.
FLshow gih10Fx7Slot$FxSlot.
FLshow gih11Fx7Slot$FxSlot.
FLshow gih12Fx7Slot$FxSlot.
igoto WidgetsDoneS$FxSlot.

Show8S$FxSlot.:
FLshow giFx7$FxSlot.name
FLshow gih1Fx8Slot$FxSlot.
FLshow gih2Fx8Slot$FxSlot.
FLshow gih3Fx8Slot$FxSlot.
FLshow gih4Fx8Slot$FxSlot.
FLshow gih5Fx8Slot$FxSlot.
FLshow gih6Fx8Slot$FxSlot.
FLshow gih7Fx8Slot$FxSlot.
FLshow gih8Fx8Slot$FxSlot.
FLshow gih9Fx8Slot$FxSlot.
igoto WidgetsDoneS$FxSlot.

WidgetsDoneS$FxSlot.:
#

; telefon Per 00 44 1273 623 875