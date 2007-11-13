f01 0 1025 7 -1 1024 1                             ; No effect
f02 0 1025 7 1 1024 -1                             ; Inverter
f03 0 1025 7 0 512 0 512 1                         ; Pos 1/2 wave rectifier
f04 0 1025 7 -1 512 0 512 0                        ; Neg 1/2 wave rectifier
f05 0 1025 7 1 512 0 512 1                         ; Full wave rectifier
f06 0 1025 -7 1 1024 1                             ; + DC offset
f07 0 1025 -7 -1 1024 -1                           ; - DC offset
f08 0 1025 -7 -1 512 0 256 .5 256 .5               ; Unipolar clipping distortion
f09 0 1025 7  0 512 1 0 -1 512 0                   ; 2's complement distortion
f10 0 1025 17 0 0 205 1 410 2 615 3 820 4          ; 5 Step staircase
f11 0 1025 17 0 0 128 1 256 2 384 3 512 4 640 5 768 6 896 7 ; 8 Step staircase
f12 0 1025 8 -1 12 -.99 1000 .99 12 1              ; Gentle distortion
f13 0 1025 8 -1 256 -.55 256 0 256 .45 256 1       ; Valve distortion
f14 0 1025 13 1 1 0 2 2 1                          ; Nice Distortion
f15 0 1025 13 1 1 0 10 .1                          ; Slight 2nd harmonic
f16 0 1025 7 -1 384 0 256 0 384 1                  ; Crossover distortion
f17 0 1025 -7 -.5 256 -.5 512 .5 256 .5            ; Hard clipping distortion
f18 0 1025 7 -1 500 0 6 -1 12 1 6 0 500 1          ; Zero crossing spike
f19 0 1025 7 -1 512 0 100 .2 2 0 410 1             ; Linear discontinuous
f20 0 1025 7 -1 128 -.75 0 0 256 0 0 -.25 256 .25 0 0 256 0 0 .75 128 1 ; Holes
f21 0 1025 7 0 64 1 128 -1 128 1 128 -1 128 1 128 -1 128 1 128 -1 64 0 ; 4 Triangles
f22 0 1025 9 .5 1 270                              ; Sine curve
f23 0 1025 5 .001 1024 1                           ; Exponential curve (unipolar)
f24 0 1025 8 -1 256 -.8 256 0 256 .8 256 1         ; Rough compress
f25 0 1025 13 1 1 0 1 1                            ; 2nd harmonic
f26 0 1025 13 1 1 0 1 1 1                          ; 2nd & 3rd harmonics
f27 0 1025 13 1 1 0 1 0 1                          ; 3rd harmonic
f28 0 1025 13 1 1 0 1 0 0 1                        ; 4th harmonic
f29 0 1025 13 1 1 0 1 0 0 0 1                      ; 5th harmonic
f30 0 1025 13 1 1 0 1 0 0 0 0 1                    ; 6th harmonic
f31 0 1025 13 1 1 0 1 0 0 0 0 0 1                  ; 7th harmonic
f32 0 1025 13 1 1 0 1 0 0 0 0 0 0 1                ; 8th harmonic
f33 0 1025 13 1 1 0 1 0 0 0 0 0 0 0 1              ; 9th harmonic
f34 0 1025 13 1 1 0 0 1 0 1 0 1 0 1 0 1 0 1 0 1    ; Even harmonics
f35 0 1025 13 1 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1      ; Odd harmonics
f36 0 1025 13 1 1 0 1 0 0 0 0 0 0 0 0 0 1 1 1 1 1 1; High harmonics
f37 0 1025 13 1 1 0 1 0 1 0 0 1 0 0 0 1 0 1        ; Random harmonics
f38 0 1025 10 0 1                                  ; 2 sines
f39 0 1025 10 0 0 1                                ; 3 sines
f40 0 1025 10 0 0 0 1                              ; 4 sines
f41 0 1025 10 0 0 0 0 1                            ; 5 sines
f42 0 1025 10 0 0 0 0 0 1                          ; 6 sines
f43 0 1025 10 0 0 0 0 0 0 1                        ; 7 sines
f44 0 1025 10 0 0 0 0 0 0 0 1                      ; 8 sines
f45 0 1025 10 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1      ; 16 sines
f46 0 1025 7 -1 512 -1 0 1 512 1                   ; 1-Bit D/A
f47 0 1025 21 2                                    ; Linear Noise
f48 0 1025 21 1                                    ; White Noise


;     Strt  Leng  Levl  LoFrq HiFrq Tabl1 Tabl2 Tabl3
i01   0.00  1.00  1.00  250   5000  26    02    05
e
