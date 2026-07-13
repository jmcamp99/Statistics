DATA traffic;
INPUT SignalType $ Delay;    
DATALINES;
Pretimed 36.6  
Pretimed 39.2  
Pretimed 30.4  
Pretimed 37.1  
Pretimed 34.1   
SemiAct 17.5  
SemiAct 20.6 
SemiAct 18.7  
SemiAct 25.7 
SemiAct 22.0
FullyAct 15.0  
FullyAct 10.4 
FullyAct 18.9 
FullyAct 10.5 
FullyAct 5.2
;

PROC PRINT DATA=traffic; RUN;

PROC GLM DATA=traffic PLOTS=DIAGNOSTICS;
  CLASS SignalType;  
  MODEL Delay = SignalType / SOLUTION;
  LSMEANS SignalType / STDERR CL PDIFF;
  MEANS SignalType / hovtest=bf; /* Brown-Forsythe test */
  MEANS SignalType / tukey cldiff;
  MEANS SignalType / lsd cldiff;
  MEANS SignalType / bon cldiff;
  CONTRAST 'Pretimed vs SemiAct & FullyAct' SignalType 1 -0.5 -0.5;
  CONTRAST 'SemiAct vs FullyAct' SignalType 0 1 -1;
  RUN;
  
  
/* Question 2 */

Data lettuce;
Input Nitrogen Heads;
Datalines;
0   104
0   114
0    90
0   140
50  134
50  130
50  144
50  174
100 146
100 142
100 152
100 156
150 147
150 160
150 160
150 163
;
run;

PROC PRINT DATA=lettuce; RUN;


proc glm data=lettuce PLOTS= DIAGNOSTICS;
    CLASS Nitrogen;                 
    MODEL Heads = Nitrogen;         
	CONTRAST 'Linear' Nitrogen -3 -1 1 3;
    CONTRAST 'Quadratic' Nitrogen 1 -1 -1 1;

run;

/* Question 3 */
Data adrenal;
Input Stage Treatment $ Steroid;
Datalines;
1 T1 6.98
1 T1 6.58
1 T1 6.86
1 T2 8.62
1 T2 9.40
1 T2 9.20
2 T1 5.38
2 T1 7.31
2 T1 6.65
2 T2 4.96
2 T2 6.80
2 T2 7.61
3 T1 7.02
3 T1 9.23
3 T1 7.32
3 T2 7.17
3 T2 6.52
3 T2 6.86
;
run;

PROC PRINT DATA=adrenal; RUN;

proc glm data=adrenal;
    Class Stage Treatment;
    Model Steroid = Stage Treatment Stage*Treatment;
    
	LSMEANS Stage*Treatment / STDERR PDIFF;
    LSMEANS Stage Treatment Stage*Treatment / STDERR PDIFF;
    
run;


