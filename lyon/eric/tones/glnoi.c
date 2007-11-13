#include<stdio.h>
#define IRAND(min,max) (random()%(max-min))+min
#define RAND(min,max) ((random()/(float)0x7fffffff)*(max-min))+min
#define SNDFILE (1)
#define SKIP (0.0)
/*
score generator for drnoi.orch
skewed chords according to fixed ratios
*/

typedef struct
{
	float dur;
	float sttime;
	float freqs[20];
	int nfreqs;
	float tdev;
} CLUST;
main(argc,argv) int argc; char *argv[];
{
CLUST clust[40];
float stfreq;
float minfreq;
float maxfreq;
float tdur;
float realtime;
float basefreq;
float freq;
int winter;
float dev;
int ninters = 12; 	/* number of intervals to use */
int nclust = 0;
int i=0;
int j;
float min, max;
float iamp, istart, idur, ifreq1, ifreq2, iseed;
float ifreq1a;
static float inters[] =
{
1.5, 1.333333, 1.25, 1.2, 1.1666667, 1.142857, 2.0,
3., 2.66667, 2.5, 2.4, 2.333, 2.2856
};

double atof();
if(argc<5) usage();
basefreq = atof( argv[1] );
minfreq = atof( argv[2] );
maxfreq = atof( argv[3] );
tdur = atof( argv[4] );
srandom(time(0));

realtime = 0.;
while( realtime < tdur)
{
	clust[nclust].dur = RAND( 4.0,6.);
	clust[nclust].sttime = realtime;
	clust[nclust].tdev = RAND(.1,.5);
	i = 0;
	freq = basefreq;
	while( freq < maxfreq )
	{
		clust[nclust].freqs[i] = freq;
		winter = random()%ninters;
		freq *= inters[ winter ];
		i++;
	}
	clust[nclust].nfreqs = i;
	realtime += RAND(2.0,5.0);
	winter = random()%ninters;
	basefreq /= inters[ winter ];
	while( basefreq < minfreq ) basefreq *= 2.0;
	++nclust;
}
for( i = 0; i < nclust; i++ )
{
	for( j = 0; j < clust[i].nfreqs; j++)
	{
		max = clust[i].tdev * clust[i].dur ;
		min = max * -1.0;
		dev = RAND( min, max );
		istart = clust[i].sttime + dev;
		if( istart < 0.0 ) istart = 0;
		min = .9;
		max = 1./min;
		dev = RAND( min, max);
		idur = clust[i].dur * dev;
		if( istart + idur > tdur ) idur = tdur-istart;
		ifreq1 = clust[i].freqs[j];
		ifreq1a = ifreq1 * (RAND(.6,.9));
		ifreq2 = ifreq1 * ( RAND(.99,1.01) );
		iamp = RAND(.2,.6);
		iseed = RAND(0.,1.);
		printf("i1 %f %f %f %f %f %f %f\n",
		istart,idur,ifreq1,ifreq1a,ifreq2,iamp,iseed);
	}
}
}

usage(){
printf("stfreq minfreq maxfreq tdur\n");
exit(0);
}
