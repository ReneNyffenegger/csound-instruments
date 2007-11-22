#define FxUpdtCol(FxSlot)
#
;els indexs per les taules de parametres (num efecte - 1)
kndxC$FxSlot. init $FxSlot.-1
indxC$FxSlot. init $FxSlot.-1

;COLUMNES:entrades de l'efecte (array 8*8)
vtabwk  kndxC$FxSlot., giRftCols, gkR1to$FxSlot.,gkR2to$FxSlot.,gkR3to$FxSlot.,gkR4to$FxSlot.,\
				        gkR5to$FxSlot.,gkR6to$FxSlot.,gkR7to$FxSlot.,gkR8to$FxSlot.

;actualitza fila  d'indicadors de recepcio (Val_i amb i(k)?)
FLsetVal	1,gkR1to$FxSlot.,giFx$FxSlot.inCh1h  
FLsetVal	1,gkR2to$FxSlot.,giFx$FxSlot.inCh2h  
FLsetVal	1,gkR3to$FxSlot.,giFx$FxSlot.inCh3h  
FLsetVal	1,gkR4to$FxSlot.,giFx$FxSlot.inCh4h  
FLsetVal	1,gkR5to$FxSlot.,giFx$FxSlot.inCh5h 
FLsetVal	1,gkR6to$FxSlot.,giFx$FxSlot.inCh6h  
FLsetVal	1,gkR7to$FxSlot.,giFx$FxSlot.inCh7h  
FLsetVal	1,gkR8to$FxSlot.,giFx$FxSlot.inCh8h  

;taula pels comptadors de canals de recepcio
tabw (gkR1to$FxSlot.+gkR2to$FxSlot.+gkR3to$FxSlot.+gkR4to$FxSlot.\
        +gkR5to$FxSlot.+gkR6to$FxSlot.+gkR7to$FxSlot.+gkR8to$FxSlot.), indxC$FxSlot., giFxRecvCount
#