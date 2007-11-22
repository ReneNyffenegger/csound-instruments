#define FxUpdtFile(FxSlot)
#
;els indexs per les taules de parametres (num efecte - 1)
kndxF$FxSlot. init $FxSlot.-1
indxF$FxSlot. init $FxSlot.-1

;FILES:sortides de l'efecte (array 8*8)
vtabwk  kndxF$FxSlot., giRftFiles, gkR$FxSlot.to1,gkR$FxSlot.to2,gkR$FxSlot.to3,gkR$FxSlot.to4,\
				       gkR$FxSlot.to5,gkR$FxSlot.to6,gkR$FxSlot.to7,gkR$FxSlot.to8

;actualitza fila  d'indicadors d'emissio
FLsetVal	1,gkR$FxSlot.to1,giFx$FxSlot.outCh1h  
FLsetVal	1,gkR$FxSlot.to2,giFx$FxSlot.outCh2h  
FLsetVal	1,gkR$FxSlot.to3,giFx$FxSlot.outCh3h  
FLsetVal	1,gkR$FxSlot.to4,giFx$FxSlot.outCh4h  
FLsetVal	1,gkR$FxSlot.to5,giFx$FxSlot.outCh5h 
FLsetVal	1,gkR$FxSlot.to6,giFx$FxSlot.outCh6h  
FLsetVal	1,gkR$FxSlot.to7,giFx$FxSlot.outCh7h  
FLsetVal	1,gkR$FxSlot.to8,giFx$FxSlot.outCh8h 

;taula pels comptadors de canals d'emissio
tabw	 (gkR$FxSlot.to1+gkR$FxSlot.to2+gkR$FxSlot.to3+gkR$FxSlot.to4\
	+gkR$FxSlot.to5+gkR$FxSlot.to6+gkR$FxSlot.to7+gkR$FxSlot.to8), indxF$FxSlot., giFxSendCount
#