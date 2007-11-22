#define FxInOut2(FxSlot'In'Out)
#
;comprova bypass d'usuari
;despres aquesta variable global la passarem com parametre del call
if  gkFx$FxSlot.bypass==0 kgoto bypass$FxSlot.

;els indexs per les taules de parametres (num efecte - 1)
kndx$FxSlot. init $FxSlot.-1
andx$FxSlot. init $FxSlot.-1

;primer rebem els (per ara) booleans de canals de recepcio actius
;despres NO SERAN booleans!
vtabk kndx$FxSlot., giRftCols, kR1toMe,kR2toMe,kR3toMe,kR4toMe,kR5toMe,kR6toMe,kR7toMe,kR8toMe

;si la suma de booleans=0 es que l'efecte no reb senyal i apliquem un bypass automatic per estalviar Cpu
;en el cas de l'efecte 1 sempre te entrada i per tant ho ignorem
kRecvCount$FxSlot. table kndx$FxSlot.,giFxRecvCount
if (kRecvCount$FxSlot.==0 && $FxSlot.!=1 ) kgoto bypass$FxSlot.

;si  la suma de booleans=0 es que l'efecte no envia senyal i apliquem un bypass automatic per estalviar Cpu
;en el cas de l'efecte 1 sempre te sortida i per tant ho ignorem
kSendCount$FxSlot. table kndx$FxSlot.,giFxSendCount
if (kSendCount$FxSlot.==0 && $FxSlot.!=8) kgoto bypass$FxSlot.

;despres rebem el senyal de tots els canals (en previsio d'una implementacio que permeti fades)
;quan implementem fades caldra actualitzar els "booleans" a k-rate!
a0=0
vtaba a0, giFxfnChnls, aFx1out,aFx2out,aFx3out,aFx4out,aFx5out,aFx6out,aFx7out,aFx8out

;finalment l'entrada sera la suma de cada canal multiplicat pel boolea de recepcio d'aquest canal
;i dividit pel nombre de canals d'entrada (normalitzat)
aFxIn$FxSlot. mac kR1toMe, aFx1out,kR2toMe, aFx2out,kR3toMe, aFx3out,kR4toMe, aFx4out,\
                                 kR5toMe, aFx5out,kR6toMe, aFx6out,kR7toMe, aFx7out,kR8toMe, aFx8out,
aFxIn$FxSlot. divz aFxIn$FxSlot.,kRecvCount$FxSlot.,0

;reb ganancia d'entrada i multiplica-ho, si cal afegeix el senyal d'entrada
aFxIn$FxSlot. = (aFxIn$FxSlot.+$In.)*ampdb(gkFx$FxSlot.inGain)

kInrms$FxSlot. rms aFxIn$FxSlot.
ktrigIn$FxSlot. metro 5
FLsetVal	ktrigIn$FxSlot.,kInrms$FxSlot., giFx$FxSlot.inRmsh

;deixem el senyal a l'entrada de l'efecte per al seu processat
tabw aFxIn$FxSlot.,andx$FxSlot.,giFxfnChnlsIn
;reb el senyal processat de l'efecte
aFxOut$FxSlot. tab andx$FxSlot.,giFxfnChnlsOut

;reb ganancia de sortida i l'aplica
aFxOut$FxSlot. = aFxOut$FxSlot.*ampdb(gkFx$FxSlot.outGain)
;escriu al canal de sortida
tabw aFxOut$FxSlot.,andx$FxSlot., giFxfnChnls

kOutrms$FxSlot. rms aFxOut$FxSlot.
ktrigOut$FxSlot. metro 5
FLsetVal	ktrigOut$FxSlot.,kOutrms$FxSlot., giFx$FxSlot.outRmsh

$Out.=aFxOut$FxSlot.

bypass$FxSlot.:
#