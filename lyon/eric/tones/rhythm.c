#include<stdio.h>
/* atk points for use in melodies */
main(argc,argv) int argc; char *argv[];
{
float tempo, nbeats, subdiv;
int pattern[ 100 ];
int i, natks;
float now = 0.0, tadv;
fprintf(stderr,"enter tempo, beats_in_bar, beat_subdiv\n");
scanf("%f %f %f",&tempo, &nbeats, &subdiv);
fprintf(stderr,"enter 0/1 attack pattern\n");
natks = (int)(nbeats*subdiv);
tadv = (60./tempo)/subdiv;
for( i = 0; i < natks ; i++)
	{
	scanf("%d",&pattern[i]);
	}
for( i = 0; i < natks ; i++ )
	{
	if( pattern[i] == 1 )
		printf("%f\n",now);
	now += tadv;
	}
}
