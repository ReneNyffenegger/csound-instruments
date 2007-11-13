#include<stdio.h>
#define RAND(min,max) ((random()/(float)0x7fffffff)*(max-min))+min
#define MINDEPTH .0005
#define MAXDEPTH .0015
#define MINSPEED (.5)
#define MAXSPEED (1.0)
main(argc,argv) int argc; char *argv[];
{
FILE *fp, *fopen();
double atof();
float dur,gain;
int wfile;
float p1,p2,p3,p4;
float s1,s2,s3,s4;
float depth;
if(argc<2){
	printf("dur gain file\n");
	exit(-1);
}
srandom(time(0));
dur = atof(*++argv);
gain = atof(*++argv);
wfile = atoi(*++argv);
printf("f1 0 8192 10 1\n");
depth = RAND(MINDEPTH,MAXDEPTH);
s1 = RAND(MINSPEED,MAXSPEED); 
s2 = RAND(MINSPEED,MAXSPEED); 
s3 = RAND(MINSPEED,MAXSPEED); 
s4 = RAND(MINSPEED,MAXSPEED); 
p1 = RAND(0.0,1.0); p2 = RAND(0.0,1.0); p3 = RAND(0.0,1.0); p4 = RAND(0.0,1.0);
printf("i1 0 %f %d 0 %f %f %f %f %f %f %f %f %f %f\n",
dur,wfile,depth,s1,s2,s3,s4,p1,p2,p3,p4,gain);
printf("i100 1 .001\n");
}
