;---------------------------------------;
; Pinkston Example Complex Instrument 6 ;
;---------------------------------------;

  sr        =  22050
  kr        =  4410
  ksmps     =  5
  nchnls    =  2

instr   6                               ;three part gesture
;------------------- initialization block -----------------------------
  iamp1     =  p4                                 ;fine amp adjustments   
  iamp2     =  p4*1.5          
  iamp3     =  p4*.5           
  idur1     =  p3*p9                              ;portion of p3 for pt 1 
  idur2     =  p3*p10                             ;portion of p3 for pt 2 
  idur3     =  p3-idur2-idur1                     ;the rest to part 3     
  icps1a    =  cpspch(p5)              
  icps1b    =  icps1a*2                
  icps3     =  cpspch(p6)              
  iwave1    =  1                                  ;osc waveshape for pt 1 
  iwave3    =  2                                  ;osc waveshape for pt 3 
  ihamm     =  3                                  ;hamming func for lfo   
  ipanfn    =  p14                                ;pan control func (0-1) 
  iseed1    =  p7              
  iseed2    =  p8              
  imindur   =  p11                                ;min note len for part2 
  imaxnum   =  p12                                ;max gap factor (>= 1)  
  ioctrng   =  p13                                ;random pitch range     
  itime     =  0                                  ;time counter for pt 2          
  ilast     =  0                                  ;last note flag for pt 2                
;------------------- overall pan control for phrase --------------------
  kpan      oscil1i   0,1,p3,ipanfn                   
  kleft     =  sqrt(kpan)                      
  kright    =  sqrt(1-kpan)                    
;-----------------------------------------------------------------------                                        
part1:
                                                ;crescendo to part 2            
            timout    idur1,p3,part2              ;wait idur1 seconds             
  kenv1     expseg    1,idur1,iamp1,1,iamp1                   
  klfo1     oscil     1,7,ihamm                       
  kgate     randi     .5,5                        ;output between +/- .5          
  kgate     =  .5+kgate                           ;offset to between 0 - 1                
  asiga     oscili    kgate,icps1a,iwave1                     
  asigb     oscili    1-kgate,icps1b,iwave1                   
  asig1     =  (asiga+asigb)*kenv1*klfo1                       
            outs      asig1*kleft,asig1*kright                        
            kgoto     end                     
;------------------------------------------------------------------------                                       
part2:
                                                ;random series of pops          
            timout    idur2,p3,part3              ;wait for idur2 seconds         
  krndur    rand      .5,iseed1                   ;output between +/- .5          
  krndhz    rand      .5,iseed2                       
reset:
                                                ;compute next duration          
  irndur    =  (.5+i(krndur))*imaxnum             ;between 0 and imaxnum          
  idur      =  imindur+imindur*int(irndur+.5)     ;make dur = imindur*N           
if (itime+idur < idur2) igoto choose              ;until last note, choose                        
  ilast     =  1                                  ;last note - set flag           
  idur      =  idur2-itime                        ;trim duration to fit           
  ipitch    =  octpch(p6)                         ;use part 3 pitch, so...                
            igoto     continue                    ;skip random selection          
choose:
                                                ;select a random pitch                          
  irndoct   =  i(krndhz)*ioctrng                  ;between +/- ioctrng/2          
  ipitch    =  octpch(p5)+irndoct                 ;around pitch of part 1         
continue:                                       
  itime     =  itime+idur                         ;keep track of time             
                                        
  icf       =  cpsoct(ipitch)/2                   ;filter settings                
  ibwmin    =  icf/20                  
  ibwvar    =  icf*4                   
  kenv2     expseg    .01,.005,1,idur-.005,.001                       
            timout    0,idur,skip                 ;skip for idur seconds          
            reinit    reset                       ;then reinit from reset                 
skip:                                   
  anoise    rand      iamp2                   
  apitch    oscili    iamp2/2,cpsoct(ipitch+kenv2*.25),iwave1                 
  afilt1    butterbp  anoise+apitch,icf,ibwmin+kenv2*ibwvar                   
  afilt2    butterbp  afilt1,icf,ibwmin+kenv2*ibwvar                  
            rireturn                              ;end reinit pass here           
  asig2     =  afilt2*kenv2                       ;apply amp envelope             
            outs      asig2*kleft,asig2*kright                        
if (ilast != 1) kgoto end                         ;goto end til last note                 
;----------------------------------------------------------------------                                 
part3:
                                                ;diminuendo and ritard.         
  kenv3     line      1,idur3,0                   ;linear decay for amp           
  klfohz    expon     20,idur3,1                  ;exp decay for lfo rate         
  klfo3     oscil     1,klfohz,ihamm              ;hamming window for lfo         
  asig3     oscili    kenv3*iamp3,icps3,iwave3                        
            outs      asig3*kleft*klfo3,asig3*kright*(1-klfo3)                        
end:                                    
endin                           
