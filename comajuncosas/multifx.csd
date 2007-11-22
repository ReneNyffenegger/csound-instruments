<CsoundSynthesizer>
<CsOptions>

-+S -+p12 -b1764 -t0 

</CsOptions>
<CsInstruments>

sr=22050
kr=22050
ksmps=1
nchnls=1
zakinit 1,128
;1 a location for Input->MultiFx
;128 k locations for control parameters

iFxftOffset=200;index base per les taules del multiefectes

#include :FxMenus.h:

#include :FxContainer.h:

#include :FxUpdtFile.h:

#include :FxUpdtCol.h:

#include :FxInOut2.h:

#include :FxWidgets.h:

#include :FxControllers.h:


FLcolor  0,0,0
iPh=600
iPl=1000
	FLpanel	"Jcn MultiFx machine",iPl,iPh
FLcolor  -1

imargin=5
ilength=300
iheight=iPh-2*imargin
	FLtabs	ilength,iheight,imargin,imargin

iborder=7
itabsh=30
itabsl=10

	FLgroup	"Control",ilength-itabsl,iheight-itabsh,itabsl,itabsh,iborder

;menu de seleccio d'efectes
iEffects  FLbox  "Effects", 1, 4, 12, 40, 15,   20,40
FLlabel  11,2,4,0,0,0 
;en triar un efecte tambe l'activem (ocupant el lloc del que hi havia abans)
;p1:instr4.1, pero no esta implementat, per tant instr 4..11 (tots iguals)
;p2:0 (activa immediatament)
;p3:1 (-1, event de durada indefinida)
;p4:n (nombre de contenidor, del 1 al 8)
;p5:kFxnsel (quin efecte hi havia abans)
;per saber quin efecte hem triat llegim el valor actual de kFxnsel

gkFx1sel, iFx1sel FLcount  "Fx 1", 0, 10, 1, 1, 2, 50, 20,40,  65, 0,12,0,-1,1 
gkFx2sel, iFx2sel FLcount  "Fx 2", 0, 10, 1, 1, 2, 50, 20,40,  85, 0,12,0,-1,2 
gkFx3sel, iFx3sel FLcount  "Fx 3", 0, 10, 1, 1, 2, 50, 20,40, 105, 0,12,0,-1,3 
gkFx4sel, iFx4sel FLcount  "Fx 4", 0, 10, 1, 1, 2, 50, 20,40, 125, 0,12,0,-1,4
gkFx5sel, iFx5sel FLcount  "Fx 5", 0, 10, 1, 1, 2, 50, 20,40, 145, 0,12,0,-1,5
gkFx6sel, iFx6sel FLcount  "Fx 6", 0, 10, 1, 1, 2, 50, 20,40, 165, 0,12,0,-1,6
gkFx7sel, iFx7sel FLcount  "Fx 7", 0, 10, 1, 1, 2, 50, 20,40, 185, 0,12,0,-1,7
gkFx8sel, iFx8sel FLcount  "Fx 8", 0, 10, 1, 1, 2, 50, 20,40, 205, 0,12,0,-1,8

FLlabel  -1
FLcolor   0,0,0, 255,255,50
FLlabel  11, 2, 1, 255, 255, 50

kFx1trig, iFx1trig   FLbutton  "@>", 1, 0, 1, 35, 20, 260,   65, 0, 4,0,-1,1 
kFx2trig, iFx2trig   FLbutton  "@>", 1, 0, 1, 35, 20, 260,   85, 0, 5,0,-1,2 
kFx3trig, iFx3trig   FLbutton  "@>", 1, 0, 1, 35, 20, 260,  105, 0, 6,0,-1,3 
kFx4trig, iFx4trig   FLbutton  "@>", 1, 0, 1, 35, 20, 260,  125, 0, 7,0,-1,4 
kFx5trig, iFx5trig   FLbutton  "@>", 1, 0, 1, 35, 20, 260,  145, 0, 8,0,-1,5 
kFx6trig, iFx6trig   FLbutton  "@>", 1, 0, 1, 35, 20, 260,  165, 0, 9,0,-1,6 
kFx7trig, iFx7trig   FLbutton  "@>", 1, 0, 1, 35, 20, 260,  185, 0,10,0,-1,7 
kFx8trig, iFx8trig   FLbutton  "@>", 1, 0, 1, 35, 20, 260,  205, 0,11,0,-1,8 

FLlabel  -1
FLcolor  -1
FLsetColor2 50, 255, 50,iFx1trig
FLsetColor2 50, 255, 50,iFx2trig
FLsetColor2 50, 255, 50,iFx3trig
FLsetColor2 50, 255, 50,iFx4trig
FLsetColor2 50, 255, 50,iFx5trig
FLsetColor2 50, 255, 50,iFx6trig
FLsetColor2 50, 255, 50,iFx7trig
FLsetColor2 50, 255, 50,iFx8trig


FLcolor   0,0,0, 255,255,50
FLlabel  12, 2, 4, 255, 255, 50 

giFx1menu FLbox  "Bypassed", 5, 2, 12, 160, 20, 95,65
giFx2menu FLbox  "Bypassed", 5, 2, 12, 160, 20, 95,85
giFx3menu FLbox  "Bypassed", 5, 2, 12, 160, 20, 95,105
giFx4menu FLbox  "Bypassed", 5, 2, 12, 160, 20, 95,125
giFx5menu FLbox  "Bypassed", 5, 2, 12, 160, 20, 95,145
giFx6menu FLbox  "Bypassed", 5, 2, 12, 160, 20, 95,165
giFx7menu FLbox  "Bypassed", 5, 2, 12, 160, 20, 95,185
giFx8menu FLbox  "Bypassed", 5, 2, 12, 160, 20, 95,205


FLlabel  -1
FLcolor  -1

;taula de control dels bypass d'usuari (per defecte tot a 0, per tant en bypass)
giFxfnBypass ftgen 0+iFxftOffset,0,8,-2,0,0,0,0,0,0,0,0

;taula pels comptadors de canals de recepcio
giFxRecvCount ftgen 1+iFxftOffset,0,8,-2,0,0,0,0,0,0,0,0

;taula pels comptadors de canals d'emissio
giFxSendCount ftgen 2+iFxftOffset,0,8,-2,0,0,0,0,0,0,0,0

;taula per emmagatzemar el senyal a cada node (post-effect)
giFxfnChnls ftgen 3+iFxftOffset,0,8,-2,0,0,0,0,0,0,0,0

;taula per emmagatzemar les entrades als efectes
giFxfnChnlsIn    ftgen 4+iFxftOffset,0,8,-2,0,0,0,0,0,0,0,0

;taula per emmagatzemar les sortides dels efectes
giFxfnChnlsOut ftgen 5+iFxftOffset,0,8,-2,0,0,0,0,0,0,0,0

iRouting  FLbox  "Routing", 1, 4, 12, 40, 15,   20,245
;crea els arrays que emmagatzemen els (per ara) booleans de rutejat del senyal, inicialment tots a 0
;matriu de rutejat per files (amb una copia per certes operacions)
giRftFiles           ftgen 6+iFxftOffset,0,64,-2,0
giRftFilesTemp ftgen 7+iFxftOffset,0,64,-2,0
;matriu de rutejat per columnes
giRftCols           ftgen 8+iFxftOffset,0,64,-2,0

;taula de ihandles pels indicadors de canals d'emissio per efecte (8 per efecte)
giRftFilesh           ftgen  9+iFxftOffset,0,64,-2,0
;taula de ihandles pels indicadors de canals de recepcio per efecte (8 per efecte)
giRftColsh           ftgen 10+iFxftOffset,0,64,-2,0

;taula per emmagatzemar els presets d'efecte a cadascun dels 8 slots
giFxftSel		     ftgen 11+iFxftOffset,0,8,-2,0,0,0,0,0,0,0,0

;taula per emmagatzemar els anteriors presets d'efecte a cadascun dels 8 slots
giFxftPrevSel	     ftgen 12+iFxftOffset,0,8,-2,0,0,0,0,0,0,0,0

;taula per emmagatzemar els valors dels controladors grafics (fins a 16 per efecte)
giFxftControllers ftgen 13+iFxftOffset,0,128,-2,0

;exponential scaling curves for In&Out gain sliders. 3 options, at your taste!
;apparently GEN 16 doesn't work properly, so here it is a polynomical approx. with GEN3
;obtained from Excel and a Simple Least Squares Data Fitting applet by Bryan Lewis, Kent State University
;http://nimitz.mcs.kent.edu/~blewis/stat/lsq.html (well Excel alone can do the same, but it is a cool applet ;p)
;from about -144dB to about +6dB, and gain at 3/4 of 0dB.
;iSldScl ftgen 14+iFxftOffset,0,1024, -3, 0 ,1024, 5.478247013781992,-0.00015063242013087854, -0.00011514640926238098,0.00000017156068396816607,-0.00000000019339717610902452
;same from -96dB to +6dB
;iSldScl ftgen 14+iFxftOffset,0,1024, -3, 0 ,1024, 5.815753465623118,-0.010799741944358074,-0.00005548262071942746,0.00000005208034991921489,-0.00000000008056246766402279
;same from -44dB to +6dB
giSldScl ftgen 14+iFxftOffset,0,1024, -3, 0 ,1024, 5.988943392916905,-0.018676119919874844,-0.000017492181131539073,-0.0000000034436917860384394,-0.000000000008106362790168901

FLcolor  0,0,0
FLcolor2  255, 255, 50
gkR1to1, giR1to1h   FLbutton  " ", 1, 0, 2, 20, 20,0*(20)+ (ilength-20*8)/2,0*(20)+270, -1
gkR1to2, giR1to2h   FLbutton  " ", 1, 0, 2, 20, 20,1*(20)+ (ilength-20*8)/2,0*(20)+270, -1
gkR1to3, giR1to3h   FLbutton  " ", 1, 0, 2, 20, 20,2*(20)+ (ilength-20*8)/2,0*(20)+270, -1
gkR1to4, giR1to4h   FLbutton  " ", 1, 0, 2, 20, 20,3*(20)+ (ilength-20*8)/2,0*(20)+270, -1
gkR1to5, giR1to5h   FLbutton  " ", 1, 0, 2, 20, 20,4*(20)+ (ilength-20*8)/2,0*(20)+270, -1
gkR1to6, giR1to6h   FLbutton  " ", 1, 0, 2, 20, 20,5*(20)+ (ilength-20*8)/2,0*(20)+270, -1
gkR1to7, giR1to7h   FLbutton  " ", 1, 0, 2, 20, 20,6*(20)+ (ilength-20*8)/2,0*(20)+270, -1
gkR1to8, giR1to8h   FLbutton  " ", 1, 0, 2, 20, 20,7*(20)+ (ilength-20*8)/2,0*(20)+270, -1

gkR2to1, giR2to1h   FLbutton  " ", 1, 0, 2, 20, 20,0*(20)+ (ilength-20*8)/2,1*(20)+270, -1
gkR2to2, giR2to2h   FLbutton  " ", 1, 0, 2, 20, 20,1*(20)+ (ilength-20*8)/2,1*(20)+270, -1
gkR2to3, giR2to3h   FLbutton  " ", 1, 0, 2, 20, 20,2*(20)+ (ilength-20*8)/2,1*(20)+270, -1
gkR2to4, giR2to4h   FLbutton  " ", 1, 0, 2, 20, 20,3*(20)+ (ilength-20*8)/2,1*(20)+270, -1
gkR2to5, giR2to5h   FLbutton  " ", 1, 0, 2, 20, 20,4*(20)+ (ilength-20*8)/2,1*(20)+270, -1
gkR2to6, giR2to6h   FLbutton  " ", 1, 0, 2, 20, 20,5*(20)+ (ilength-20*8)/2,1*(20)+270, -1
gkR2to7, giR2to7h   FLbutton  " ", 1, 0, 2, 20, 20,6*(20)+ (ilength-20*8)/2,1*(20)+270, -1
gkR2to8, giR2to8h   FLbutton  " ", 1, 0, 2, 20, 20,7*(20)+ (ilength-20*8)/2,1*(20)+270, -1

gkR3to1, giR3to1h   FLbutton  " ", 1, 0, 2, 20, 20,0*(20)+ (ilength-20*8)/2,2*(20)+270, -1
gkR3to2, giR3to2h   FLbutton  " ", 1, 0, 2, 20, 20,1*(20)+ (ilength-20*8)/2,2*(20)+270, -1
gkR3to3, giR3to3h   FLbutton  " ", 1, 0, 2, 20, 20,2*(20)+ (ilength-20*8)/2,2*(20)+270, -1
gkR3to4, giR3to4h   FLbutton  " ", 1, 0, 2, 20, 20,3*(20)+ (ilength-20*8)/2,2*(20)+270, -1
gkR3to5, giR3to5h   FLbutton  " ", 1, 0, 2, 20, 20,4*(20)+ (ilength-20*8)/2,2*(20)+270, -1
gkR3to6, giR3to6h   FLbutton  " ", 1, 0, 2, 20, 20,5*(20)+ (ilength-20*8)/2,2*(20)+270, -1
gkR3to7, giR3to7h   FLbutton  " ", 1, 0, 2, 20, 20,6*(20)+ (ilength-20*8)/2,2*(20)+270, -1
gkR3to8, giR3to8h   FLbutton  " ", 1, 0, 2, 20, 20,7*(20)+ (ilength-20*8)/2,2*(20)+270, -1

gkR4to1, giR4to1h   FLbutton  " ", 1, 0, 2, 20, 20,0*(20)+ (ilength-20*8)/2,3*(20)+270, -1
gkR4to2, giR4to2h   FLbutton  " ", 1, 0, 2, 20, 20,1*(20)+ (ilength-20*8)/2,3*(20)+270, -1
gkR4to3, giR4to3h   FLbutton  " ", 1, 0, 2, 20, 20,2*(20)+ (ilength-20*8)/2,3*(20)+270, -1
gkR4to4, giR4to4h   FLbutton  " ", 1, 0, 2, 20, 20,3*(20)+ (ilength-20*8)/2,3*(20)+270, -1
gkR4to5, giR4to5h   FLbutton  " ", 1, 0, 2, 20, 20,4*(20)+ (ilength-20*8)/2,3*(20)+270, -1
gkR4to6, giR4to6h   FLbutton  " ", 1, 0, 2, 20, 20,5*(20)+ (ilength-20*8)/2,3*(20)+270, -1
gkR4to7, giR4to7h   FLbutton  " ", 1, 0, 2, 20, 20,6*(20)+ (ilength-20*8)/2,3*(20)+270, -1
gkR4to8, giR4to8h   FLbutton  " ", 1, 0, 2, 20, 20,7*(20)+ (ilength-20*8)/2,3*(20)+270, -1

gkR5to1, giR5to1h   FLbutton  " ", 1, 0, 2, 20, 20,0*(20)+ (ilength-20*8)/2,4*(20)+270, -1
gkR5to2, giR5to2h   FLbutton  " ", 1, 0, 2, 20, 20,1*(20)+ (ilength-20*8)/2,4*(20)+270, -1
gkR5to3, giR5to3h   FLbutton  " ", 1, 0, 2, 20, 20,2*(20)+ (ilength-20*8)/2,4*(20)+270, -1
gkR5to4, giR5to4h   FLbutton  " ", 1, 0, 2, 20, 20,3*(20)+ (ilength-20*8)/2,4*(20)+270, -1
gkR5to5, giR5to5h   FLbutton  " ", 1, 0, 2, 20, 20,4*(20)+ (ilength-20*8)/2,4*(20)+270, -1
gkR5to6, giR5to6h   FLbutton  " ", 1, 0, 2, 20, 20,5*(20)+ (ilength-20*8)/2,4*(20)+270, -1
gkR5to7, giR5to7h   FLbutton  " ", 1, 0, 2, 20, 20,6*(20)+ (ilength-20*8)/2,4*(20)+270, -1
gkR5to8, giR5to8h   FLbutton  " ", 1, 0, 2, 20, 20,7*(20)+ (ilength-20*8)/2,4*(20)+270, -1

gkR6to1, giR6to1h   FLbutton  " ", 1, 0, 2, 20, 20,0*(20)+ (ilength-20*8)/2,5*(20)+270, -1
gkR6to2, giR6to2h   FLbutton  " ", 1, 0, 2, 20, 20,1*(20)+ (ilength-20*8)/2,5*(20)+270, -1
gkR6to3, giR6to3h   FLbutton  " ", 1, 0, 2, 20, 20,2*(20)+ (ilength-20*8)/2,5*(20)+270, -1
gkR6to4, giR6to4h   FLbutton  " ", 1, 0, 2, 20, 20,3*(20)+ (ilength-20*8)/2,5*(20)+270, -1
gkR6to5, giR6to5h   FLbutton  " ", 1, 0, 2, 20, 20,4*(20)+ (ilength-20*8)/2,5*(20)+270, -1
gkR6to6, giR6to6h   FLbutton  " ", 1, 0, 2, 20, 20,5*(20)+ (ilength-20*8)/2,5*(20)+270, -1
gkR6to7, giR6to7h   FLbutton  " ", 1, 0, 2, 20, 20,6*(20)+ (ilength-20*8)/2,5*(20)+270, -1
gkR6to8, giR6to8h   FLbutton  " ", 1, 0, 2, 20, 20,7*(20)+ (ilength-20*8)/2,5*(20)+270, -1

gkR7to1, giR7to1h   FLbutton  " ", 1, 0, 2, 20, 20,0*(20)+ (ilength-20*8)/2,6*(20)+270, -1
gkR7to2, giR7to2h   FLbutton  " ", 1, 0, 2, 20, 20,1*(20)+ (ilength-20*8)/2,6*(20)+270, -1
gkR7to3, giR7to3h   FLbutton  " ", 1, 0, 2, 20, 20,2*(20)+ (ilength-20*8)/2,6*(20)+270, -1
gkR7to4, giR7to4h   FLbutton  " ", 1, 0, 2, 20, 20,3*(20)+ (ilength-20*8)/2,6*(20)+270, -1
gkR7to5, giR7to5h   FLbutton  " ", 1, 0, 2, 20, 20,4*(20)+ (ilength-20*8)/2,6*(20)+270, -1
gkR7to6, giR7to6h   FLbutton  " ", 1, 0, 2, 20, 20,5*(20)+ (ilength-20*8)/2,6*(20)+270, -1
gkR7to7, giR7to7h   FLbutton  " ", 1, 0, 2, 20, 20,6*(20)+ (ilength-20*8)/2,6*(20)+270, -1
gkR7to8, giR7to8h   FLbutton  " ", 1, 0, 2, 20, 20,7*(20)+ (ilength-20*8)/2,6*(20)+270, -1

gkR8to1, giR8to1h   FLbutton  " ", 1, 0, 2, 20, 20,0*(20)+ (ilength-20*8)/2,7*(20)+270, -1
gkR8to2, giR8to2h   FLbutton  " ", 1, 0, 2, 20, 20,1*(20)+ (ilength-20*8)/2,7*(20)+270, -1
gkR8to3, giR8to3h   FLbutton  " ", 1, 0, 2, 20, 20,2*(20)+ (ilength-20*8)/2,7*(20)+270, -1
gkR8to4, giR8to4h   FLbutton  " ", 1, 0, 2, 20, 20,3*(20)+ (ilength-20*8)/2,7*(20)+270, -1
gkR8to5, giR8to5h   FLbutton  " ", 1, 0, 2, 20, 20,4*(20)+ (ilength-20*8)/2,7*(20)+270, -1
gkR8to6, giR8to6h   FLbutton  " ", 1, 0, 2, 20, 20,5*(20)+ (ilength-20*8)/2,7*(20)+270, -1
gkR8to7, giR8to7h   FLbutton  " ", 1, 0, 2, 20, 20,6*(20)+ (ilength-20*8)/2,7*(20)+270, -1
gkR8to8, giR8to8h   FLbutton  " ", 1, 0, 2, 20, 20,7*(20)+ (ilength-20*8)/2,7*(20)+270, -1
FLcolor  -1
FLcolor2  -1


iPresets  FLbox  "Presets", 1, 4, 12, 40, 15,   20,450

	FLgroup_end

	FLgroup	"Automate",ilength-itabsl,iheight-itabsh, itabsl,itabsh,iborder
	FLgroup_end

	FLgroup	"Setup",ilength-itabsl,iheight-itabsh, itabsl,itabsh,iborder

	FLgroup_end

	FLgroup	"About",ilength-itabsl,iheight-itabsh, itabsl,itabsh,iborder

	FLgroup_end

	FLtabs_end

ifxpannelh=(iPh-itabsh-imargin)/4
ifxpannell=(iPl-ilength-2*imargin)/2
ifxborder=3

	FLpanel	"Fx1",ifxpannell,ifxpannelh,ilength+imargin,itabsh,ifxborder
 		$FxContainer(1)
	FLpanel_end

	FLpanel	"Fx2",ifxpannell,ifxpannelh,ilength+imargin,itabsh+ifxpannelh,ifxborder
 		$FxContainer(2)
	FLpanel_end

	FLpanel	"Fx3",ifxpannell,ifxpannelh,ilength+imargin,itabsh+2*ifxpannelh,ifxborder
 		$FxContainer(3)
	FLpanel_end

	FLpanel	"Fx4",ifxpannell,ifxpannelh,ilength+imargin,itabsh+3*ifxpannelh,ifxborder
 		$FxContainer(4)
	FLpanel_end

	FLpanel	"Fx5",ifxpannell,ifxpannelh,ilength+imargin+ifxpannell,itabsh,ifxborder
 		$FxContainer(5)
	FLpanel_end

	FLpanel	"Fx6",ifxpannell,ifxpannelh,ilength+imargin+ifxpannell,itabsh+ifxpannelh,ifxborder
 		$FxContainer(6)
	FLpanel_end

	FLpanel	"Fx7",ifxpannell,ifxpannelh,ilength+imargin+ifxpannell,itabsh+2*ifxpannelh,ifxborder
 		$FxContainer(7)
	FLpanel_end

	FLpanel	"Fx8",ifxpannell,ifxpannelh,ilength+imargin+ifxpannell,itabsh+3*ifxpannelh,ifxborder
 		$FxContainer(8)
	FLpanel_end

	FLpanel_end



	FLrun


;instrument principal
instr 1
;activa els efectes de cada node (efecte buit, instrs x20)

schedule	 20, 0, -1, 1
schedule	120, 0, -1, 2
schedule	220, 0, -1, 3
schedule	320, 0, -1, 4
schedule	420, 0, -1, 5
schedule	520, 0, -1, 6
schedule	620, 0, -1, 7
schedule	720, 0, -1, 8

;envia els valors dels controladors grafics a la taula de controladors
$FxControllers.(1)
$FxControllers.(2)
$FxControllers.(3)
$FxControllers.(4)
$FxControllers.(5)
$FxControllers.(6)
$FxControllers.(7)
$FxControllers.(8)

;com que no es possible DESACTIVAR instruments amb FLbutton, nomes activar-los,
;no podem actualitzar els arrays de rutejat quan desactivem un boto
;a no ser que tinguem 64 triggers activats (!)
;en comptes d'aixo jo faig una actualitzacio total de totes les taules cada cert temps <<kr

reinitUpdateR:
;actualitzo cada 0.1sec
timout 0, .1, nextUpdateR
rireturn

$FxUpdtFile(1)
$FxUpdtFile(2)
$FxUpdtFile(3)
$FxUpdtFile(4)
$FxUpdtFile(5)
$FxUpdtFile(6)
$FxUpdtFile(7)
$FxUpdtFile(8)

$FxUpdtCol(1)
$FxUpdtCol(2)
$FxUpdtCol(3)
$FxUpdtCol(4)
$FxUpdtCol(5)
$FxUpdtCol(6)
$FxUpdtCol(7)
$FxUpdtCol(8)

;taula de control dels bypass d'usuari
vtabwk 0,giFxfnBypass, gkFx1bypass,gkFx2bypass,gkFx3bypass,gkFx4bypass,gkFx5bypass,gkFx6bypass,gkFx7bypass,gkFx8bypass,
	
;torna a posar a 0 el comptador
reinit reinitUpdateR

nextUpdateR:

endin

;contenidor de l'efecte
;enruta el senyal cap a l'efecte
;i controla els bypass d'usuari i de programa
instr 2
aMasterIn zar 0
gaOUT init 0
$FxInOut2.(1'aMasterIn'at1) 
$FxInOut2.(2'0'at2) 
$FxInOut2.(3'0'at3) 
$FxInOut2.(4'0'at4) 
$FxInOut2.(5'0'at5) 
$FxInOut2.(6'0'at6) 
$FxInOut2.(7'0'at7) 
$FxInOut2.(8'0'aMasterOut) 

out aMasterOut*5000
endin

	instr 3; GENERADOR DE SENYAL DE PROVA
k0 oscil 1,.1,1
kamp=.5*(k0+1)
;a1	oscili	kamp, 440, 1; optional input signal, by now...

a1 diskin "1b.wav",1,0,1
a1=a1/40000

;envia al multiefectes
zaw a1,0
	endin

;disparadors: s'activen quan activem un nou efecte al slot corresponent,
;segons els p-fields rebuts, activen al seu torn l'efecte desitjat
;l'hi envien els p-fields adients i es desactiven tot seguit

instr 4,5,6,7,8,9,10,11;
;p4:slot number (1..8)
indx=p4-1
iSlot100 = indx*100; una mica d'algebra XD

;actualitza els presets d'efecte per cada slot
vtabwi 0,giFxftSel,i(gkFx1sel),i(gkFx2sel),i(gkFx3sel),i(gkFx4sel),\
                   i(gkFx5sel),i(gkFx6sel),i(gkFx7sel),i(gkFx8sel)

;desactiva l'efecte anterior (sobreescriu amb p3=0)
iFxPrevSel tab_i indx, giFxftPrevSel	
call 20+iSlot100+iFxPrevSel,0,0,p4
;activa el nou efecte
iFxSel tab_i indx, giFxftSel	
call 20+iSlot100+iFxSel,0,-1,p4
;actualitza els interfaces de cada efecte
;nomes caldria del que toca pero no es pot :(
;(caldria diferenciar cada instrument:+CODI PERO +DEPRESSA)
;pero de fet nomes consulta taules i salta condicionals...
$FxWidgets.(1)
$FxWidgets.(2)
$FxWidgets.(3)
$FxWidgets.(4)
$FxWidgets.(5)
$FxWidgets.(6)
$FxWidgets.(7)
$FxWidgets.(8)
;actualitza l'efecte "anterior" com el nou efecte
tabw_i	iFxSel, indx, giFxftPrevSel
;desactiva
turnoff
endin


;menus: s'activen quan triem un nou efecte al slot corresponent,
;segons els p-fields rebuts, mostrem el nom de l'efecte triat
;es desactiven tot seguit

instr 12;

$FxMenus.(1)
$FxMenus.(2)
$FxMenus.(3)
$FxMenus.(4)
$FxMenus.(5)
$FxMenus.(6)
$FxMenus.(7)
$FxMenus.(8)
;desactiva
turnoff
endin



;instruments efecte : cadascun esta copiat 8 vegades
;per respectar l'ordre d'enviament del senyal
;a mes deixem espai per a un total de 100 efectes :)

;p2:0 (activa immediatament)
;p3:1 (-1, event de durada indefinida)
;p4:n (nombre de contenidor, del 1 al 8)
;p5:kFxnsel (quin efecte hi havia abans) per netejar la pantalla

instr 20,120,220,320,420,520,620,720
;efecte "bypass"
andx init p4-1

;reb
aFxIn tab andx,giFxfnChnlsIn

;processa
aFxOut=aFxIn;no fa res

;envia
tabw aFxOut,andx,giFxfnChnlsOut
endin

instr 21,121,221,321,421,521,621,721
;efecte "Bit depth / sample rate reducer"
andx init p4-1
kndx init p4-1

;reb
aFxIn tab andx,giFxfnChnlsIn

;efectuem el processat
kbits  zkr 0+16*kndx
kfold  zkr 1+16*kndx

aFxIn	limit	aFxIn, -1,1        ;hard clip to constrain to [-1,1]
kin      downsamp  aFxIn
kin      = kin + 1                 ; Add DC to avoid (-)
kin      = kin*(kbits/2)           ; Divide signal level
kin      = int(kin)                ; Quantise
aout     upsamp  kin               ; Convert to sr
aout     = aout*(2/kbits) - 1      ; Scale and remove DC
aFxOut     fold  aout, kfold       ; Resample

;envia
tabw aFxOut,andx,giFxfnChnlsOut
endin

instr 22,122,222,322,422,522,622,722
;efecte "Direct Convolver"
andx init p4-1
kndx init p4-1

;reb
aFxIn tab andx,giFxfnChnlsIn

;efectuem el processat
iIRfn = 100
isize = ftlen(iIRfn)

kX zkr 0+16*kndx
kY zkr 1+16*kndx

kphaseX1 init 0
kphaseX1 = (1+kphaseX1)%isize
kphaseX2 = int((1+kX)*kphaseX1)%isize

kphaseY1 init 0
kphaseY1 = (1+kphaseY1)%isize
kphaseY2 = int((1+kY)*kphaseY1)%isize

kosc1 tablei kphaseX2,101
kosc2 tablei kphaseY2,101

tabw	kosc1*kosc2, kphaseX2, iIRfn 


aFxOut dconv aFxIn, isize, iIRfn

;envia
tabw aFxOut,andx,giFxfnChnlsOut
endin


instr 23,123,223,323,423,523,623,723
;efecte "Feingenbaum Ringmod"
andx init p4-1
kndx init p4-1

;reb
aFxIn tab andx,giFxfnChnlsIn

;Synthesis by Functional Iterations
; instrument based on an article by Di Scipio & Prignano
; Journal of New Music Research, vol.25 (1996), pp. 31-46

kcount= 0; reset counter for iterations.
inb = 4;number of iterations

kfreq zkr 0+16*kndx
kr1   zkr 1+16*kndx
krw   zkr 2+16*kndx
kx0   zkr 3+16*kndx

aosc oscili 1, kfreq, 102
ar = kr1 + (krw)*aosc; cyclic ar to get an arbitrary pitched wave

ax upsamp kx0
iter: 
ax = sin(ar * ax)
kcount = kcount + 1
if kcount < inb goto iter

out: 
aFxOut=aFxIn*(2*ax-1)

;envia
tabw aFxOut,andx,giFxfnChnlsOut
endin


instr 24,124,224,324,424,524,624,724
;efecte "Morpheable filter"
andx init p4-1
kndx init p4-1

;reb
aFxIn tab andx,giFxfnChnlsIn

;efectuem el processat
kVcf1 zkr 0+16*kndx
kVcf2 zkr 1+16*kndx
kVcf3 zkr 2+16*kndx

klow limit 1-kVcf2,0,1
kband mirror kVcf2,0,1
khigh limit kVcf2-1,0,1

alow, ahigh, aband svfilter aFxIn, kVcf1, kVcf3,1
aFxOut mac klow,alow,kband,aband,khigh,ahigh

;envia
tabw aFxOut,andx,giFxfnChnlsOut
endin

instr 25,125,225,325,425,525,625,725
;efecte "variable Comb/Allpass"
andx init p4-1
kndx init p4-1

;reb
aFxIn tab andx,giFxfnChnlsIn

;processa
kRvt  zkr 0+16*kndx
kLpt  zkr 1+16*kndx
kMode zkr 2+16*kndx

kcoeff= exp(log(0.001)*(kLpt/kRvt))
;one shared delay should be enough but Csound crashes (?)
a1_	delayr	10;hey lots of RAM! :)
aDel_a	deltap3	kLpt
a2_	delayr	10
aDel_b	deltap3	kLpt

if (kMode==1) kgoto Alpass

Comb:
aFxOut=aDel_a
kgoto Next

Alpass:
aFxOut=aDel_b-kcoeff*aFxIn
kgoto Next

Next:
	delayw	aFxIn+kcoeff*aFxOut
	delayw	aFxIn+kcoeff*aFxOut
;envia
tabw aFxOut,andx,giFxfnChnlsOut
endin

instr 26,126,226,326,426,526,626,726
;efecte "Zoelter's Parametric Eq"
andx init p4-1
kndx init p4-1

;reb
aFxIn tab andx,giFxfnChnlsIn

;efectuem el processat
kMode    zkr 0+16*kndx
kFreq    zkr 1+16*kndx
kGain    zkr 2+16*kndx
kQ       zkr 3+16*kndx
kSoftSat zkr 4+16*kndx

kPrevMode init 0
kNewMode trigger kMode, kPrevMode, 2

if (kNewMode==0) kgoto Next
reinit ChangeMode

ChangeMode:
imode=i(kMode)
Next:
aFxOut pareq aFxIn, kFreq, ampdb(kGain), kQ, imode
rireturn

if (kSoftSat==0) kgoto noSat
aFxOut=tanh(aFxOut); a veure si posem algo mes sofisticat...
noSat:

kPrevMode=kMode
;envia
tabw aFxOut,andx,giFxfnChnlsOut
endin


instr 27,127,227,327,427,527,627,727
;efecte "R. Bristow Johnson's Eq"
andx init p4-1
kndx init p4-1

;reb
aFxIn tab andx,giFxfnChnlsIn

;efectuem el processat

kfilterType  zkr 0+16*kndx
kFreq        zkr 1+16*kndx
kdBgain      zkr 2+16*kndx
kQ           zkr 3+16*kndx
kS           zkr 4+16*kndx

ipi =  3.14159265359
kA = 10^(kdBgain/40)
komega = 2*ipi*kFreq/sr
kcs = cos(komega)
ksn = sin(komega)
kalpha = ksn*sinh(1/(2*kQ))
kbeta = sqrt((kA^2+1)/kS - (kA-1)^2)

if kfilterType = 0 kgoto LPF
if kfilterType = 1 kgoto HPF
if kfilterType = 2 kgoto BPF
if kfilterType = 3 kgoto Notch
if kfilterType = 4 kgoto PeakingEQ
if kfilterType = 5 kgoto lowShelf
if kfilterType = 6 kgoto highShelf

LPF:
kb0 = (1-kcs)/2
kb1 = 1-kcs
kb2 = (1-kcs)/2
ka0 = 1+kalpha
ka1 = -2*kcs
ka2 = 1-kalpha
kgoto end7
HPF:
kb0 = (1+kcs)/2
kb1 = -1-kcs
kb2 = (1+kcs)/2
ka0 = 1+kalpha
ka1 = -2*kcs
ka2 = 1-kalpha
kgoto end7
BPF:
kb0 = kalpha
kb1 = 0
kb2 = -kalpha
ka0 = 1+kalpha
ka1 = -2*kcs
ka2 = 1-kalpha
kgoto end7
Notch:
kb0 = 1
kb1 = -2*kcs
kb2 = 1
ka0 = 1+kalpha
ka1 = -2*kcs
ka2 = 1-kalpha
kgoto end7
PeakingEQ:
kb0 = 1+kalpha*kA
kb1 = -2*kcs
kb2 = 1-kalpha*kA
ka0 = 1+kalpha/kA
ka1 = -2*kcs
ka2 = 1-kalpha/kA
kgoto end7
lowShelf:
kb0 = kA*(  (kA+1)-(kA-1)*kcs+kbeta*ksn)
kb1 = 2*kA*((kA-1)-(kA+1)*kcs)
kb2 = kA*(  (kA+1)-(kA-1)*kcs-kbeta*ksn)
ka0 =       (kA+1)+(kA-1)*kcs+kbeta*ksn
ka1 = -2*(  (kA-1)+(kA+1)*kcs)
ka2 =       (kA+1)+(kA-1)*kcs-kbeta*ksn
kgoto end7
highShelf:
kb0 = kA*(   (kA+1)+(kA-1)*kcs+kbeta*ksn)
kb1 = -2*kA*((kA-1)+(kA+1)*kcs)
kb2 = kA*(   (kA+1)+(kA-1)*kcs-kbeta*ksn)
ka0 =        (kA+1)-(kA-1)*kcs+kbeta*ksn
ka1 = 2*(    (kA-1)-(kA+1)*kcs)
ka2 =        (kA+1)-(kA-1)*kcs-kbeta*ksn
end7:

aFxOut biquad aFxIn,kb0,kb1,kb2,-ka0,-ka1,-ka2

;envia
tabw aFxOut,andx,giFxfnChnlsOut
endin

instr 28,128,228,328,428,528,628,728
;efecte "BreakBeat Cutter"
andx init p4-1
kndx init p4-1

;reb
aFxIn tab andx,giFxfnChnlsIn

;efectuem el processat


kbpm			zkr 0+16*kndx
kbps=kbpm/60
ksubdiv			zkr 1+16*kndx
kbarlength		zkr 2+16*kndx
kphrasebars		zkr 3+16*kndx
knumrepeats		zkr 4+16*kndx
kstutterspeed		zkr 5+16*kndx
kstutterchance		zkr 6+16*kndx
kenvchoice 		zkr 7+16*kndx
ktrigger 		zkr 8+16*kndx

kbps			init 2
ksubdiv			init 8
kbarlength		init 4
kphrasebars		init 4
knumrepeats		init 2
kstutterspeed		init 2
kstutterchance		init .1
kenvchoice 		init 1
ktrigger 		init 1

kPrevMode init 0
kNewMode trigger ktrigger, kPrevMode, 2

if (kNewMode==0) kgoto Next
reinit ChangeMode

ChangeMode:

ibps=i(kbps)
isubdiv=i(ksubdiv)
ibarlength=i(kbarlength)
iphrasebars=i(kphrasebars)
inumrepeats=i(knumrepeats)
istutterspeed=i(kstutterspeed)
istutterchance=i(kstutterchance)
ienvchoice=i(kenvchoice)

Next:
aFxOut bbcutm aFxIn,ibps,isubdiv,ibarlength,iphrasebars,inumrepeats,istutterspeed,istutterchance,ienvchoice
rireturn

kPrevMode=ktrigger
;envia
tabw aFxOut,andx,giFxfnChnlsOut
endin



</CsInstruments>
<CsScore>

f1 0 1024 10 1
; taules per l'efecte Direct Convolver
f100 0 16 -2 0;IR
f101 0 16 10 1;sine
; taula per l'efecte feigenbaum ringmod
f102 0 1024 10 1 1 0 1;sine in [0,1]


i1 0 3600
i2 0 3600
i3 0 3600

</CsScore>
</CsoundSynthesizer>
