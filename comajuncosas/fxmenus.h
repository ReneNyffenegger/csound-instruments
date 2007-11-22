#define FxMenus(FxSlot)
#
if ($FxSlot.!=p4) igoto Done$FxSlot.

if (i(gkFx$FxSlot.sel)==0) igoto Preset$FxSlot._0
if (i(gkFx$FxSlot.sel)==1) igoto Preset$FxSlot._1
if (i(gkFx$FxSlot.sel)==2) igoto Preset$FxSlot._2
if (i(gkFx$FxSlot.sel)==3) igoto Preset$FxSlot._3
if (i(gkFx$FxSlot.sel)==4) igoto Preset$FxSlot._4
if (i(gkFx$FxSlot.sel)==5) igoto Preset$FxSlot._5
if (i(gkFx$FxSlot.sel)==6) igoto Preset$FxSlot._6
if (i(gkFx$FxSlot.sel)==7) igoto Preset$FxSlot._7
if (i(gkFx$FxSlot.sel)==8) igoto Preset$FxSlot._8

igoto Preset$FxSlot._00

Preset$FxSlot._00:
FLsetText  "-", giFx$FxSlot.menu
igoto Done$FxSlot.

Preset$FxSlot._0:
FLsetText  "Bypassed", giFx$FxSlot.menu
igoto Done$FxSlot.

Preset$FxSlot._1:
FLsetText  "Cruncher", giFx$FxSlot.menu
igoto Done$FxSlot.

Preset$FxSlot._2:
FLsetText  "Direct Convolver", giFx$FxSlot.menu
igoto Done$FxSlot.

Preset$FxSlot._3:
FLsetText  "Feigenbaum Ringmod", giFx$FxSlot.menu
igoto Done$FxSlot.

Preset$FxSlot._4:
FLsetText  "Morpheable Filter", giFx$FxSlot.menu
igoto Done$FxSlot.

Preset$FxSlot._5:
FLsetText  "variable Comb/Allpass", giFx$FxSlot.menu
igoto Done$FxSlot.

Preset$FxSlot._6:
FLsetText  "Zoelter's Parametric Eq", giFx$FxSlot.menu
igoto Done$FxSlot.

Preset$FxSlot._7:
FLsetText  "R. Bristow Johnson's Eq", giFx$FxSlot.menu
igoto Done$FxSlot.

Preset$FxSlot._8:
FLsetText  "BreakBeat Cutter", giFx$FxSlot.menu
igoto Done$FxSlot.

Done$FxSlot.:
#