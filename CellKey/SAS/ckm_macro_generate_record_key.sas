
/* Macro for attaching record key to microdata */
/* ------------------------------------------- */

/* Reinhard, Tent 30.11.2018 */

%macro ckm_generate_record_key(inputfile, outputfile=&inputfile._rkey, rkey=rkey, seed=);

	data &outputfile;
		set &inputfile;
		if _n_ =1 then call streaminit(&seed.); 	/* set random number seed */

		&rkey = rand("Uniform");     		/* recordkey ~ U(0,1) */
	run;

%mend ckm_generate_record_key;

