/* Tianqi Luo */
/* HW02 Submission */

/* Remember to save this template file as HW1_YourNetID.sas */
/* You'll need to switch the following portion
             "~/my_courses/dunger_sas/hw03" access=readonly
   to 
             "C:\440\hw03";
   before making your final submission. */
  
libname hw03  "C:\440\hw03";

/* Exercise 1 */

/* Exercise 1(a) */
title "Exercise 1(a)";
data AUaids;
infile "C:\440\hw03\AUaids.dat" ;
input  number state $  sex $  diagnosis_date death_date  end_status $  category_transmission_reported $  age_diagnosed;
run;

proc format;
value $state 'NSW' = 'New South Wales'
             'QLD' = 'Queensland'
             'VIC' = 'Victoria';

value $sex    'M' = 'Male'
              'F' = 'Female';
 
value $end_status 'D' = 'Dead'
                  'A' = 'Alive';
run;

/* Exercise 1(b) */
title "Exercise 1(b)";
data AUaids_tluo4;
set AUaids;
format state $state.
       sex $sex.
       end_status $end_status.;

label  number = 'Observation Number'
       state  = 'State of Orgin'
       diagnosis_date = 'Date of Diagnosis'
       death_date = 'Date of Death'
       end_status = 'Status at End of Observation'
       category_transmission_reported = 'Reported Transmission Category'
       age_diagnosed = 'Age at Diagnosis';
 run;
 
 
 /* Exercise 1(c) */
title "Exercise 1(c)";
proc print data = AUaids_tluo4 (obs=10) NOOBS;
where state = 'QLD';
var number state sex diagnosis_date death_date end_status category_transmission_reported age_diagnosed;
run;

/* Exercise 1(d) */
title "Exercise 1(d)";
data under26_tluo4;
set AUaids;
format state $state.
       sex $sex.
       end_status $end_status.;

label  number = 'Observation Number'
       state  = 'State of Orgin'
       diagnosis_date = 'Date of Diagnosis'
       death_date = 'Date of Death'
       end_status = 'Status at End of Observation'
       category_transmission_reported = 'Reported Transmission Category'
       age_diagnosed = 'Age at Diagnosis';

where age_diagnosed < 26 and sex = "M" and category_transmission_reported = 'blood';
run;

/* Exercise 1(e) */
title "Exercise 1(e)";
proc print data = under26_tluo4 NOOBS;
var number state sex diagnosis_date death_date end_status category_transmission_reported age_diagnosed;
run;

/* Exercise 2 */

/* Exercise 2(a) */
title "Exercise 2(a)";
proc format;
value sleep  -999.0 = 'NA.';
run;

data sleep_tluo4;
infile "C:\440\hw03\sleep.dat" dlm=',';
length Species $ 30;
input  Species $  BodyWt  BrainWt  Slow   Para  Total  LifeSpan Gestation Pred Exposure Danger;
format BodyWt Brainwt comma8.2;
format Slow Para Total 6.1;
format Slow Para Total Gestation Lifespan sleep.;
label Bodywt = 'Body Weight(kg)'
      Brainwt = 'Brain Weight(g)'
      Slow = 'Slow Wave("nondreaming") Sleep(hrs/day)'
      Para = 'Paradoxical("dreaming") Sleep(hrs/day)'
      Total = 'Total Sleep(hrs/day)'
      LifeSpan = 'Maximum Life Span(years)'
      Gestation = 'Gestation time(days)'
      Pred = 'Predation Index'
      Exposure = 'Sleep Exposure Index'
      Danger = 'Overall Danger Index';
run;
       
/* Exercise 2(b) */
title "Exercise 2(b)";
proc contents data = sleep_tluo4;
run;

/* Exercise 2(c) */
title "Exercise 2(c)";
data big_tluo4;
set sleep_tluo4(keep = Species BodyWt BrainWt);
where BodyWt >= 150 and BrainWt >80;
run;

/* Exercise 2(d) */
title "Exercise 2(d)";
proc print data = big_tluo4 NOOBS label;
run;

/* Exercise 2(e) */
title "Exercise 2(e)";
data nottired_tluo4;
set sleep_tluo4(keep = Species Slow Para Total);
where 0 < Slow < 6 or 0 < Total < 6;
run;



/* Exercise 2(f) */
title "Exercise 2(f)";
proc print data = nottired_tluo4 NOOBS label;
run;


























       


