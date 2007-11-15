f 1 0 4096  10    5     0     3     0     1   
f 2 0 4096  10    6     5     4     2     2     1   
f 3 0 4096  10    10    1     2     3     4     5     6     7     8     9   


#define C           #0.00+#
#define Csharp      #0.01+#
#define Dflat       #0.01+#
#define D           #0.02+#
#define Dsharp      #0.03+#
#define Eflat       #0.03+#
#define E           #0.04+#
#define F           #0.05+#

#define oct(N)      #6+$N.#

#define ARGSA       #1.01 1.99 138#
#define ARGSB       #2.02 3.99 838#


i 510  0      2      5000   [$C.$oct(2)]  $ARGSA.
i 510  2      2      6000   [$Csharp.$oct(2)]    $ARGSB.
i 510  4      2      7000   [$D.$oct(1)]  $ARGSA.
i 510  6      4      8000   [$Eflat.$oct(0)]     $ARGSB.
