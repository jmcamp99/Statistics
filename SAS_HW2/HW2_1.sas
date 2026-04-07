proc import out=Snowgeese /* name to give dataset once imported into SAS */
	datafile="/home/u64313401/SNOWGEESE.txt" /* location of txt file to import */
	/*dbms=dlm /*Format of file being imported (dlm assumes spaces are used as delimiters)*/
	dbms=tab /*Format of file being imported (tab assumes spaces are used as tab delimiters)*/
	replace; /*Replace the file if it already exists*/
	getnames=YES; /*Use first row as variable names (set to NO if first row doesn't contain variable names)*/
run;

 proc print data=Snowgeese;
 run;
 
 proc reg data=Snowgeese;
  model WtChange=DigEff ADFiber/p cli clm clb;
run;

proc import out=wateroil /* name to give dataset once imported into SAS */
	datafile="/home/u64313401/WATEROIL.txt" /* location of txt file to import */
	/*dbms=dlm /*Format of file being imported (dlm assumes spaces are used as delimiters)*/
	dbms=tab /*Format of file being imported (tab assumes spaces are used as tab delimiters)*/
	replace; /*Replace the file if it already exists*/
	getnames=YES; /*Use first row as variable names (set to NO if first row doesn't contain variable names)*/
run;

 proc print data=wateroil;
 run;
 
 proc reg data=wateroil;
  model Voltage=Volume Salinity Temperature Delay Surfactant SpanTriton SolidPart/p cli clm clb;
run;