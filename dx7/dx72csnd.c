#include "stdio.h"

#define CURRENT_POSITION 1

float  FreqTableCoarse[2][32] = {{0.5, 1, 2,  3,  4,  5,
                                   6,  7,  8,  9,  10, 11,
                                  12, 13, 14, 15, 16, 17,
                                  18, 19, 20, 21, 22, 23, 
                                  24, 25, 26, 27, 28, 29,
                                  30, 31},
                                 {1, 10, 100,  1000,  1,  10,
                                 100, 1000, 1, 10, 100, 1000,
                                  1, 10, 100, 1000, 1, 10,
                                 100, 1000, 1, 10, 100, 1000, 
                                  1, 10, 100, 1000, 1, 10,
                                  100, 1000}};
float   FreqTableFine[2][100] = {{1.00, 1.01, 1.02, 1.03, 1.04,
                                  1.05, 1.06, 1.07, 1.08, 1.09,
                                  1.10, 1.11, 1.12, 1.13, 1.14,
                                  1.15, 1.16, 1.17, 1.18, 1.19,
                                  1.20, 1.21, 1.22, 1.23, 1.24,
                                  1.25, 1.26, 1.27, 1.28, 1.29,
                                  1.30, 1.31, 1.32, 1.33, 1.34,
                                  1.35, 1.36, 1.37, 1.38, 1.39,
                                  1.40, 1.41, 1.42, 1.43, 1.44,
                                  1.45, 1.46, 1.47, 1.48, 1.49,
                                  1.50, 1.51, 1.52, 1.53, 1.54,
                                  1.55, 1.56, 1.57, 1.58, 1.59,
                                  1.60, 1.61, 1.62, 1.63, 1.64,
                                  1.65, 1.66, 1.67, 1.68, 1.69,
                                  1.70, 1.71, 1.72, 1.73, 1.74,
                                  1.75, 1.76, 1.77, 1.78, 1.79,
                                  1.80, 1.81, 1.82, 1.83, 1.84,
                                  1.85, 1.86, 1.87, 1.88, 1.89,
                                  1.90, 1.91, 1.92, 1.93, 1.94,
                                  1.95, 1.96, 1.97, 1.98, 1.99},
                                 {1.000, 1.023, 1.047, 1.072, 1.096,
                                  1.122, 1.148, 1.175, 1.202, 1.230,
                                  1.259, 1.288, 1.318, 1.349, 1.380,
                                  1.413, 1.445, 1.479, 1.514, 1.549,
                                  1.585, 1.622, 1.660, 1.698, 1.738,
                                  1.778, 1.820, 1.862, 1.905, 1.950,
                                  1.995, 2.042, 2.089, 2.138, 2.188,
                                  2.239, 2.291, 2.344, 2.399, 2.455,
                                  2.512, 2.570, 2.630, 2.692, 2.716,
                                  2.818, 2.884, 2.951, 3.020, 3.090,
                                  3.162, 3.236, 3.311, 3.388, 3.467,
                                  3.548, 3.631, 3.715, 3.802, 3.890,
                                  3.981, 4.074, 4.169, 4.266, 4.365,
                                  4.467, 4.571, 4.677, 4.786, 4.898,
                                  5.012, 5.129, 5.248, 5.370, 5.495,
                                  5.623, 5.754, 5.888, 6.026, 6.166,
                                  6.310, 6.457, 6.607, 6.761, 6.918,
                                  7.079, 7.244, 7.413, 7.586, 7.762,
                                  7.943, 8.128, 8.318, 8.511, 8.718,
                                  8.913, 9.120, 9.333, 9.550, 9.772}};

struct dx7_operator {
unsigned char OP_EG_R1;   
unsigned char OP_EG_R2;     
unsigned char OP_EG_R3;      
unsigned char OP_EG_R4;      
unsigned char OP_EG_L1;     
unsigned char OP_EG_L2;     
unsigned char OP_EG_L3;     
unsigned char OP_EG_L4;     
unsigned char LEV_SCL_BRK_PT; 
unsigned char SCL_LEFT_DEPTH;
unsigned char SCL_RGHT_DEPTH;
unsigned char SCL_LEFT_CURVE:2;
unsigned char SCL_RIGHT_CURVE:6;
unsigned char OSC_RATE_SCALE:3;
unsigned char OSC_DETUNE:5;
unsigned char AMP_MOD_SENS:2;
unsigned char KEY_VEL_SENS:6;
unsigned char OUTPUT_LEV; 
unsigned char OSC_MODE:1;
unsigned char FREQ_COARSE:7;
unsigned char FREQ_FINE;
} operator[6];

struct dx7_globals {
unsigned char PITCH_EG_R1;  
unsigned char PITCH_EG_R2;  
unsigned char PITCH_EG_R3;   
unsigned char PITCH_EG_R4;   
unsigned char PITCH_EG_L1;   
unsigned char PITCH_EG_L2;   
unsigned char PITCH_EG_L3;   
unsigned char PITCH_EG_L4;   
unsigned char ALGORITHM; 
unsigned char FEEDBACK:3;
unsigned char OSC_KEY_SYNC:5;
unsigned char LFO_SPEED;
unsigned char LFO_DELAY;     
unsigned char LF_PT_MOD_DEP; 
unsigned char LF_AM_MOD_DEP; 
unsigned char SYNC:1;
unsigned char WAVE:3;
unsigned char LF_PT_MOD_SNS:4;
unsigned char TRANSPOSE;
char NAME[10];
} global;


main(argc,argv)
int argc;
char *argv[];
{
FILE *fpin,*fpout;
unsigned short x,y,z,SCL_LEFT_CURVE,SCL_RIGHT_CURVE,OSC_DETUNE,OSC_RATE_SCALE;
unsigned short KEY_VEL_SENS,AMP_MOD_SENS,FREQ_COARSE,OSC_MODE;
char header[6];
char out[7];
int total, count=0,op=0;
float frequency;
char name[11];
if((fpin=fopen(argv[1],"rb"))==0)  {
	printf("Cannot open file %s\n",argv[1]);
	exit(1);
	}

fread(&header, 6L, 1, fpin);

for (count=0;count<32;count++) {
  op=0;
  fread((&(operator[op])), 17L, 6, fpin);
  fread(&global, 16L, 1, fpin);
  fread(&name, 10, 1, fpin);
  name[10] = '\0';
  sprintf(out,"patch%02dALG%02d.sco",count+1,global.ALGORITHM+1);
  if ((fpout=fopen(out,"w")) == 0) {
    printf("Couldn't open %s\n",out);
    exit(1);
    }

  printtop(fpout,global.ALGORITHM+1,&name);

 
  total = 11;

  for (op=5;op>=0;op--) {
    total++;
    fprintf(fpout,"f%d   0    32    -2    %d    ",total,operator[op].OUTPUT_LEV);
    fprintf(fpout,"%d   ",operator[op].KEY_VEL_SENS);
    fprintf(fpout,"%d   ",operator[op].OP_EG_R1);   
    fprintf(fpout,"%d   ",operator[op].OP_EG_R2);     
    fprintf(fpout,"%d   ",operator[op].OP_EG_R3);      
    fprintf(fpout,"%d   \n",operator[op].OP_EG_R4);
    fprintf(fpout,"        %d   ",operator[op].OP_EG_L1);         
    fprintf(fpout,"%d   ",operator[op].OP_EG_L2);      
    fprintf(fpout,"%d   ",operator[op].OP_EG_L3);    
    fprintf(fpout,"%d   \n",operator[op].OP_EG_L4);    
    fprintf(fpout,"        %d   ",operator[op].AMP_MOD_SENS);
    fprintf(fpout,"%d   ",operator[op].OSC_MODE);
    frequency = FreqTableCoarse[operator[op].OSC_MODE][operator[op].FREQ_COARSE] * FreqTableFine[operator[op].OSC_MODE][operator[op].FREQ_FINE];
    fprintf(fpout,"%f   ",frequency);
    fprintf(fpout,"%d   \n",((int)operator[op].OSC_DETUNE)-7);
    fprintf(fpout,"        %d   \n",operator[op].OSC_RATE_SCALE);
  }
  
  
  fprintf(fpout,"t 0 20\n");
  fprintf(fpout,"i01 0 2.49 6.00 87 0 %d ",global.LFO_DELAY);
  fprintf(fpout,"%d %d \n",global.LF_PT_MOD_DEP,global.LFO_SPEED);
  fprintf(fpout," 12 13 14 15 16 17 2 4000\n");
  fprintf(fpout," 3 8 4 6 10 9 11 %d\n",global.FEEDBACK);
  fprintf(fpout,"; Algorithm = %d\n",global.ALGORITHM+1);
  fprintf(fpout,"; Patch name is %s\n\n",name);
  printbottom(fpout);
  fclose(fpout);
  }
fclose(fpin);

}


printtop (fpout,algorithm,name)
FILE *fpout;
char *name;
int algorithm;
{
fprintf(fpout,";====================================================================;\n");
fprintf(fpout,";       Test score for DX7 alg %02d orc                                ;\n",algorithm);
fprintf(fpout,";                                                                    ;\n");
fprintf(fpout,";       (imitates the %s voice...sorta)                      ;\n",name);
fprintf(fpout,";                                                                    ;\n");
fprintf(fpout,";       DX72Csound by Jeff Harrington  idealord@dorsai.org           ;\n");
fprintf(fpout,";       After Models by Russell Pinkston                             ;\n");
fprintf(fpout,";  Thanks to T. Suzuki of Yamaha Corp. for the DX7 frequency tables  ;\n");       
fprintf(fpout,";====================================================================;\n");
fprintf(fpout,"f01     0       512     10      1\n");
fprintf(fpout,"; operator fpoutput level to amp scale function (data from Chowning/Bristow)\n");
fprintf(fpout,"f02     0       128     7       0       10      .003    10      .013\n");
fprintf(fpout,"        10      .031    10      .079    10      .188    10      .446\n");
fprintf(fpout,"        5       .690    5       1.068   5       1.639   5       2.512\n");
fprintf(fpout,"        5       3.894   5       6.029   5       9.263   4       13.119\n");
fprintf(fpout,"        29      13.119\n");
fprintf(fpout,"; rate scaling function\n");
fprintf(fpout,"f03     0       128     7       0       128     1\n");
fprintf(fpout,"; eg rate rise function for lvl change between 0 and 99 (data from Opcode)\n");
fprintf(fpout,"f04     0       128     -7      38      5       22.8    5       12      5\n");
fprintf(fpout,"        7.5     5       4.8     5       2.7     5       1.8     5       1.3\n");
fprintf(fpout,"        8       .737    3       .615    3       .505    3       .409    3\n");       
fprintf(fpout,"        .321    6       .080    6       .055    2       .032    3       .024\n");
fprintf(fpout,"        3       .018    3       .014    3       .011    3       .008    3\n");       
fprintf(fpout,"        .008    3       .007    3       .005    3       .003    32      .003\n");
fprintf(fpout,"; eg rate rise percentage function\n");
fprintf(fpout,"f05     0       128     -7      .00001  31      .00001  4       .02     5\n");
fprintf(fpout,"        .06     10      .14     10      .24     10      .35     10      .50\n");
fprintf(fpout,"        10      .70     5       .86     4       1.0     29      1.0\n");
fprintf(fpout,"; eg rate decay function for lvl change between 0 and 99\n");
fprintf(fpout,"f06     0       128     -7      318     4       181     5       115     5\n");
fprintf(fpout,"        63      5       39.7    5       20      5       11.2    5       7\n");       
fprintf(fpout,"        8       5.66    3       3.98    6       1.99    3       1.34    3\n");       
fprintf(fpout,"        .99     3       .71     5       .41     3       .15     3       .081\n");
fprintf(fpout,"        3       .068    3       .047    3       .037    3       .025    3\n");
fprintf(fpout,"        .02     3       .013    3       .008    36      .008\n");
fprintf(fpout,"; eg rate decay percentage function\n");
fprintf(fpout,"f07     0       128     -7      .00001  10      .25     10      .35     10\n");
fprintf(fpout,"        .43     10      .52     10      .59     10      .70     10      .77\n");
fprintf(fpout,"        10      .84     10      .92     9       1.0     29      1.0\n");
fprintf(fpout,"; eg level to peak deviation mapping function (index in radians = Index / 2PI)\n");
fprintf(fpout,"f08     0       128     -7      0       10      .000477 10      .002\n");
fprintf(fpout,"        10      .00493  10      .01257  10      .02992  10      .07098\n");
fprintf(fpout,"        5       .10981  5       .16997  5       .260855 5       .39979\n");
fprintf(fpout,"        5       .61974  5       .95954  5       1.47425 4       2.08795\n");
fprintf(fpout,"        29      2.08795\n");
fprintf(fpout,"; velocity to amp factor mapping function (rough guess)\n");
fprintf(fpout,"f09     0       129     9       .25     1       0\n");
fprintf(fpout,"; velocity sensitivity scaling function\n");
fprintf(fpout,"f10     0       8       -7      0       8       1\n");
fprintf(fpout,"; feedback scaling function\n");
fprintf(fpout,"f11     0       8       -7      0       8       7\n");            
}

printbottom (fpout)
FILE *fpout;
{
fprintf(fpout,"i 1.1   1.00   2.54  6.07    87\n");
fprintf(fpout,"i 1.2   2.00   2.16  6.08    75\n");
fprintf(fpout,"i 1.3   2.49   2.20  7.03    90\n");
fprintf(fpout,"i 1.4   3.01   2.20  7.04    74\n");
fprintf(fpout,"i 1.5   3.50   2.18  7.11    90\n");
fprintf(fpout,"i 1     4.01   2.15  8.00    75\n");
fprintf(fpout,"i 1.1   4.24   2.13  8.07    69\n");
fprintf(fpout,"i 1.2   4.50   2.07  8.08    72\n");
fprintf(fpout,"i 1.3   4.72   2.09  9.03    90\n");
fprintf(fpout,"i 1.4   4.98   2.16  9.00    79\n");
fprintf(fpout,"f0         9                             ;allow for a 4-beat final decay.\n");
fprintf(fpout,"e\n");
}














