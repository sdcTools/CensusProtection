
/* 
=========================================================================
Simple Example: How to generate record key and attach it to the microdata 
=========================================================================

Destatis, 11/30/2018

*/

/* Specify the library (where you can find microdata and ptable) */
libname data "YOUR/PATH/";

/* Attach record key to Microdata */
%ckm_generate_record_key(inputfile=data.hc_9_2_synth_microdata, outputfile=data.hc_9_2_synth_rkey, rkey=rkey, seed=123456);
