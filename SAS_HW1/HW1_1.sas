proc import out=BLACKBREAM /* name to give dataset once imported into SAS */
	datafile="/home/u64313401/BLACKBREAM.txt" /* location of txt file to import */
	/*dbms=dlm /*Format of file being imported (dlm assumes spaces are used as delimiters)*/
	dbms=tab /*Format of file being imported (tab assumes spaces are used as tab delimiters)*/
	replace; /*Replace the file if it already exists*/
	getnames=YES; /*Use first row as variable names (set to NO if first row doesn't contain variable names)*/
run;

 proc print data=BLACKBREAM;
 run;
	
data blackbream1;
	input x y;
	datalines;
	120 85
	136 63
	150 34
	155 39
	162 58
	169 35
	178 57
	184 12
	190 15
	;
	run;
	
proc print data=blackbream1;
run;
proc sgplot data=blackbream1;
	scatter x=x y=y;
run;
proc reg data=blackbream1;
	model y=x;
	output out=pred_results
		p=predicted_value
		r=residual;
run;

proc print data=pred_results;
run;

data heat;
	input x y;
	datalines;
	1.93 4.4
	1.95 5.3
	1.78 4.5
	1.64 4.5
	1.54 3.7
	1.32 2.8
	2.12 6.1
	1.88 4.9
	1.70 4.9
	1.58 4.1
	2.47 7.0
	2.37 6.7
	2.00 5.2
	1.77 4.7
	1.62 4.2
	2.77 6.0
	2.47 5.8
	2.24 5.2
	1.32 3.5
	1.26 3.2
	1.21 2.9
	2.26 5.3
	2.04 5.1
	1.88 4.6
	;
	run;

proc print data=heat;
run;
proc sgplot data=heat;
	scatter x=x y=y;
run;
proc reg data=heat;
	model y=x;
	output out=pred_results
		p=predicted_value
		r=residual;
run;

proc print data=pred_results;
run;
	