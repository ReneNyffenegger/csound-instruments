#include<stdio.h>
#define RAND(min,max) ((random()/(float)0x7fffffff)*(max-min))+min
#define PHS1 (0.)
#define PHS2 (0.25)
#define PHS3 (0.5)
#define PHS4 (0.75)
#define PHS5 (0.75)
#define PHS6 (0.5)
#define PHS7 (0.25)
#define PHS8 (0.)
#define NHARMS (8)
#define NARGS (5)
#define GENOUT "dogen"
#define OUT_SCORE "/homes/other/eric/CSOUND/TONES/zeit.s"
main(argc,argv) int argc; char *argv[];
{
double atof();
FILE *fp1, *fopen();

float dur, minf, maxf;
float tfac, tsp, sp1, rcspeed, distort;
float sadj;
int harm = 0;
if( argc < NARGS+1 ) usage();
dur = atof( argv[1] );
minf = atof( argv[2] );
maxf = atof( argv[3] );
sadj = atof( argv[4] );
distort = atof( argv[5] );
fp1 = fopen( OUT_SCORE, "w");
putfuncs(fp1);
srandom( time( 0 ) );
tfac = RAND(.95, 1.05);
tsp = (RAND(.3,1.)) * sadj;
sp1 = (RAND(.1,.7)) *sadj;
rcspeed = RAND(.2,.7) * sadj;
putnote( ++harm, PHS1, tfac, tsp, sp1, dur, rcspeed, distort, fp1 );
putnote( ++harm, PHS2, tfac, tsp, sp1, dur, rcspeed , distort, fp1 );
putnote( ++harm, PHS3, tfac, tsp, sp1, dur, rcspeed , distort, fp1 );
putnote( ++harm, PHS4, tfac, tsp, sp1, dur, rcspeed , distort, fp1 );
putnote( ++harm, PHS5, tfac, tsp, sp1, dur, rcspeed , distort, fp1 );
putnote( ++harm, PHS6, tfac, tsp, sp1, dur, rcspeed , distort, fp1 );
putnote( ++harm, PHS7, tfac, tsp, sp1, dur, rcspeed, distort, fp1  );
putnote( ++harm, PHS8, tfac, tsp, sp1, dur, rcspeed, distort, fp1  );
makegens(minf,maxf);
endmsg();
}
endmsg()
{
	fprintf(stderr,"score written to %s\n",OUT_SCORE);
	fprintf(stderr,"to run, type:\n");
	fprintf(stderr,"csh dogen ; doit zeit zeit\n");
}
makegens(min,max)
float min,max;
{
FILE *fp, *fopen();
float freq1, freq2, freq3;
float tr1, tr2, tr3,tr4;
float fdur, sumdur;
freq1 = RAND(min, max);
freq2 = RAND(min, max);
freq3 = RAND(min, max);
tr1 = RAND(.9,1.1);
tr2 = RAND(.9,1.1);
tr3 = RAND(.9,1.1);
tr4 = RAND(.9,1.1);
sumdur = 0.0;
fp = fopen( GENOUT, "w");
fprintf(fp, "gen1 -L2K 0 %f ",freq1);
fdur = RAND(.7,1.); sumdur += fdur;
fprintf(fp,"%f %f ", sumdur, freq1*(RAND(.95,1.05)));
sumdur += .05;
fprintf(fp,"%f %f ", sumdur, freq2);
fdur = RAND(.7,1.); sumdur += fdur;
fprintf(fp,"%f %f ", sumdur, freq2*(RAND(.95,1.05)));
sumdur += .05;
fprintf(fp,"%f %f ", sumdur, freq3);
fdur = RAND(.7,1.); sumdur += fdur;
fprintf(fp,"%f %f ", sumdur, freq3*(RAND(.95,1.05)));
sumdur += .05;
fprintf(fp,"%f %f >/tmp/soundin.80\n", sumdur, freq1);
sumdur = 0.0;
freq1 = RAND(min, max);
freq2 = RAND(min, max);
freq3 = RAND(min, max);

fprintf(fp, "gen1 -L2K 0 %f ",freq1);
fdur = RAND(.7,1.); sumdur += fdur;
fprintf(fp,"%f %f ", sumdur, freq1*(RAND(.95,1.05)));
sumdur += .05;
fprintf(fp,"%f %f ", sumdur, freq2);
fdur = RAND(.7,1.); sumdur += fdur;
fprintf(fp,"%f %f ", sumdur, freq2*(RAND(.95,1.05)));
sumdur += .05;
fprintf(fp,"%f %f ", sumdur, freq3);
fdur = RAND(.7,1.); sumdur += fdur;
fprintf(fp,"%f %f ", sumdur, freq3*(RAND(.95,1.05)));
sumdur += .05;
fprintf(fp,"%f %f >/tmp/soundin.83\n", sumdur, freq1);

/* t func */
fprintf(fp,"gen1 -L2K 0 %f .9 %f 1. %f 1.9 %f 2. %f 2.9 %f 3 %f 3.9 %f 4 %f >/tmp/soundin.81\n",
tr1,tr1*(RAND(.95,1.05)),tr2,tr2*(RAND(.95,1.05)),tr3,tr3*(RAND(.95,1.05)),tr4,tr4*(RAND(.95,1.05)),tr1);
fprintf(fp,"gen5 -L4K 1 -.5 90Deg 0 .5 90Deg > /tmp/soundin.82\n");
}
putnote( partial, phs, tfac, tsp, speed, dur, rcsp, diss, fp )
int partial;
float  phs, tfac, tsp, speed, dur, rcsp, diss;
FILE *fp;
{
float seed, devdepth, devspeed, vd, vspeed;

	seed = RAND(0.,1.);
	devdepth = (RAND(.001,.01)) * diss;
	devspeed = RAND(.1,3.);
	vspeed = RAND(1., 9.);
	vd = (RAND(.001,.01)) * diss;
	fprintf(fp,"i1 0 %.2f %f %f %f %f %f %f %f %f %d %f %f\n",
	dur, speed, devdepth, devspeed, seed,tfac*(RAND(.99,1.01)),
	tsp*(RAND(.99,1.01)),vd, vspeed, partial, phs, rcsp);
}

putfuncs(fp)
FILE *fp;
{
	fprintf(fp,"f1 0 2048 -1 80 0\n");
	fprintf(fp,"f2 0 4096 10 1\n");
	fprintf(fp,"f3 0 2048 -1 81 0\n");
	fprintf(fp,"f4 0 4096 -1 82 0\n");
	fprintf(fp,"f5 0 2048 -1 83 0\n");
}
usage()
{
	fprintf(stderr,"dur minfreq maxfreq speed_scalar distortion_multiplier[1=preset]\n");
	exit(0);
}
