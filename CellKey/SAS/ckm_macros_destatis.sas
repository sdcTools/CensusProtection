

/* Macro ckm (Cell Key Method) */
/* --------------------------- */

/* Tobias Enderle, 30.11.2018 */
/* 
Macro for perturbation for ptables from R-package "ptable" using the argument type="destatis" 
(direct approach using probabilities instead of pre-drawn perturbation noise values) 
*/

%macro ckm_perturbation(input=, table_var=, cfreq=, ckey=, weight=, ptable=, ckmlabel=);

	/* Determine the treshold value for symmetry, 
	   i.e. all original frequencies larger than the treshold value will be perturbed the same way (using the identical perturbation distribution)
	*/
	proc sql noprint;
		select max(i)
		  into :threshold trimmed
		  from &ptable.
		;
	quit;
	%put Threshold value for symmetry: &threshold.;

	data &input._input;
		set &input. (keep=&cfreq. &weight. &ckey. &table_var.) ;

		ID = _n_;

		/* Cellkey (only decimals are relevant) */
		&ckey. = mod(&ckey.,1);

		/* Auxiliary variable for perturbation (uses the information given by treshold value for symmetry) */
		aux = &cfreq.;
		if &cfreq. > &threshold. then aux = &threshold.;

		/* No perturbation if cellkey is zero */
		if &ckey.= 0 then aux=0;

		/* Weighting */
		%if %isBlank(&weight.) = 1 %then %do;
			%let weight = weight;
			weight = &cfreq.;
		%end;

		if &ckey.= 0 then weight_adj = 0;
			else weight_adj = &weight. / &cfreq.;		

	run;

	/* Outputfile */
	%let output=&input._&ckmlabel.;
	%put Outfile: &output.;

	/* Perturbation */
	proc sql;
		create table &output. (drop=aux rename=(v=noise))
		as select
			b.v, (a.&cfreq. + b.v)*weight_adj as &ckmlabel.,
			a.*

		from &input._input as a
			left join &ptable. as b
				on (a.aux) = (b.i)

				and (
				(	(a.&ckey.) GT (b.p_int_lb) and (a.&ckey.) LE (b.p_int_ub)  )
				or
				(a.&ckey.) = 0
				)
			order by ID
		;		
		
	quit;


	proc delete data=&input._input;
	run;


%mend;

/* Important macro to check is parameter is empty or not */
%macro isBlank(param);
  %sysevalf(%superq(param)=,boolean)
%mend isBlank;


/* Aggregation (proc summary for ckm) */
/* ================================== */


%macro ckm_summary(input=, output=, table_var=, rkey=rkey, ckey=ckey, rfreq=, cfreq=, weight=);
	
	/* Number of variables */
	%let nvar = %sysfunc(countw(&table_var.));

	%do i=1 %to &nvar.;

		%let var = %scan(&table_var., &i. ," ");
		%put var=t&var.t;

		%if &i. = 1 %then %do;	
			%let class = class &var./mlf %str(;) ;
			%let format = format &var. $&var..;
		%end;
		%else %do;
			%let class = &class. class &var./mlf %str(;); 
			%let format = &format. &var. $&var..;
		%end;

	%end;

	%put class=&class.;
	%put format=&format.;


	/* Preliminary editing (i.e. record frequency variable)*/
	data &input._work;
		set &input.;

		%if  %isBlank(&rfreq.) = 1 %then %do;
			rfreq = 1;
		%end;
	
	run;

	%if %isBlank(&rfreq.) = 1 %then %let rfreq = rfreq;


	/* sum of weight only if weight variable is available */
	%if %isBlank(&weight.) = 1 %then %do;
			%let sum_weight =;
			%let weight = ;
	%end;
	%else %let sum_weight= sum(&weight.)=&weight. ;
	%put sum_weight: &sum_weight.;


	/* Aggregation */
	proc summary data=&input._work nway completetypes;
		&class.
		var &rfreq. &rkey. &weight.;
		output out=&input._totals (drop=_type_ _freq_) sum(&rfreq.)=&cfreq. sum(&rkey.)=&ckey. &sum_weight.;
		&format. ;
	run;

	
	/* Editing */	
	data &output.;
		set &input._totals;

		/* only decimals are relevant */
		&ckey. = mod(&ckey.,1);

		/* Zeroes */
		if &cfreq. = . then do;
			&cfreq. = 0;
			&ckey. = 0;
		end;
		/*if &cfreq. ~= . then output;*/
	run;

	proc delete data=&input._work; run;
	proc delete data=&input._totals; run;

%mend;



%macro VarExist
/*----------------------------------------------------------------------
Check for the existence of a specified variable.
----------------------------------------------------------------------*/
(ds	/* Data set name */
, var);

/*----------------------------------------------------------------------
Usage Notes:

%if %varexist(&data,NAME)
  %then %put input data set contains variable NAME;

The macro calls resolves to 0 when either the data set does not exist
or the variable is not in the specified data set.
----------------------------------------------------------------------*/

    %local rc dsid result;


/*----------------------------------------------------------------------
Use SYSFUNC to execute OPEN, VARNUM, and CLOSE functions.
-----------------------------------------------------------------------*/

    %let dsid = %sysfunc(open(&ds));
 
    %if %sysfunc(varnum(&dsid, &var)) > 0 %then %do;
        %let result = 1;
        %put NOTE: Var &var exists in &ds;
    %end;
    %else %do;
        %let result = 0;
        %put NOTE: Var &var not exists in &ds;
    %end;
 
    %let rc = %sysfunc(close(&dsid));
    &result

%mend VarExist;
 

%macro ckm_import_ptable(csvfile=, output=);

	proc import datafile="&csvfile."	out=&output. replace;
		delimiter = ";"; 
		getnames=yes;
	run;
	
	/* Check, if user has exported the correct perturbation table from R-package "ptable" */
	%let ch1 = %VarExist(&output., i);
	%let ch2 = %VarExist(&output., v);
	%let ch3 = %VarExist(&output., p_int_lb);
	%let ch4 = %VarExist(&output., p_int_ub);

	%let check = %eval(&ch1. + &ch2. + &ch3. + &ch4.);
	%put Check: &check.;

	%let missing = ;
	%if &ch1. = 0 %then %let missing = &missing. i;
	%if &ch2. = 0 %then %let missing = &missing. v;
	%if &ch3. = 0 %then %let missing = &missing. p_int_lb;
	%if &ch4. = 0 %then %let missing = &missing. p_int_ub;


	%if &check < 4 %then %put %str(ER)ROR: The variable(s) &missing. is missing in the perturbation table. Please, export the perturbation table in the R-package "ptable" using %str(pt_export(..., tool="SAS")).; 


%mend;
