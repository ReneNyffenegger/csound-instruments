#include<stdio.h>
#define RAND(min,max) ((random()/(float)0x7fffffff)*(max-min))+min
#define IFILE 1
#define ISKIP 0
main(argc,argv) int argc; char *argv[];
{
float atof();
int i,j;
float amp,vs1,vs2;
float freqs[100];
float dur;
int nnotes=0;
float freq;
float min,max;
float now[500];
float durs[500];
srandom(time(0));
scanf("%f",&dur);
printf("f1 0 4096 10 1 .25 .15 .03\n");
printf("f2 0 4096 10 1\n");
	while(scanf("%f %f %f",&now[nnotes],&durs[nnotes],&freqs[nnotes])!=EOF) ++nnotes;
	amp = 1.0/7.0;
	for(i=0;i<nnotes;i++){
		vs1 = RAND(.5,3.5);
		vs2 = RAND(.5,3.5);
printf("i1 %f %f %f %f %f %f\n",now[i],durs[i],freqs[i],amp,vs1,vs2);
	}
min = 3000.; max = 5000.;
putout(min,max,dur);
min = 1000.; max = 2000.;
putout(min,max,dur);
min = 500.; max = 800.;
putout(min,max,dur);
min = 150.; max = 350.;
putout(min,max,dur);
min = 60.; max = 100.;
putout(min,max,dur);
printf("i3 0 %f\n",dur);
}

putout(min,max,dur) float min,max,dur;
{
float speed;
float phase;
float freq;
	speed = RAND(.5,1.5);
	phase = RAND(0.,1.);
	freq = RAND(min,max);
	printf("i2 0 %f %f %f %f\n",dur,freq,speed,phase);
}
