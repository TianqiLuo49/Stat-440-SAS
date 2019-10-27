/* Tianqi Luo */
/* HW02 Submission */

/* Remember to save this template file as HW1_YourNetID.sas */
/* You'll need to switch the following portion
             "~/my_courses/dunger_sas/hw02" access=readonly
   to 
             "C:\440\hw02";
   before making your final submission. */
  
libname hw02 "C:\440\hw02";

/* Exercise 1 */

/* Exercise 1(a) */
title 'Exercise 1(a)';
proc contents data=hw02.FMLI142;
run;

proc contents data=hw02.MEMI142;
run;



/* Exercise 1(b) */
title 'Exercise 1(b)';
proc format;
value $urban      1 = 'Urban'
                  2 = 'Rural';

value $education  00 = 'Never attended school'
                  10 = 'First through eighth grade'
                  11 = 'Ninth through twelfth grade (no H.S. diploma)'
                  12 = 'High school graduate'
                  13 = 'Some college, less than college graduate'
                  14 = 'Associate’s degree (occupational/vocational or academic)'
                  15 = 'Bachelor’s degree'
                  16 = 'Master’s degree, (professional/Doctorate degree)*';

value $marital     1 = 'Married'
                   2 = 'Widowed'
                   3 = 'Divorced'
                   4 = 'Separated'
                   5 = 'Never married';

value $race        1 = 'White'
                   2 = 'Black'
                   3 = 'Native American'
                   4 = 'Asian'
                   5 = 'Pacific Islander'
                   6 = 'Multi-race';
                  
value $region       1 = 'Northeast'
                    2 = 'Midwest'
                    3 = 'South'
                    4 = 'West';
                   
value $sex           1 = 'Male'
                     2 = 'Female';
                    
value $inclass       01 = 'Less than $5,000'
                     02 = '$5,000 to $9,999'
                     03 = '$10,000 to $14,999'
                     04 = '$15,000 to $19,999'
                     05 = '$20,000 to $29,999'
                     06 = '$30,000 to $39,999'
                     07 = '$40,000 to $49,999'
                     08 = '$50,000 to $69,999'
                     09 = '$70,000 and over';

value $state         01 = 'Alabama' 29 = 'Missouri'
                     02 = 'Alaska' 30 = 'Montana'
                     04 = 'Arizona' 31 = 'Nebraska'
                     05 = 'Arkansas' 32 = 'Nevada'
                     06 = 'California' 33 = 'New Hampshire'
                     08 = 'Colorado' 34 = 'New Jersey'
                     09 = 'Connecticut' 36 = 'New York'
                     10 = 'Delaware' 37 = 'North Carolina'
                     11 = 'District of Columbia' 39 = 'Ohio'
                     12 = 'Florida' 40 = 'Oklahoma'
                     13 = 'Georgia' 41 = 'Oregon'
                     15 = 'Hawaii' 42 = 'Pennsylvania'
                     16 = 'Idaho' 44 = 'Rhode Island'
                     17 = 'Illinois' 45 = 'South Carolina'
                     18 = 'Indiana' 46 = 'South Dakota'
                     20 = 'Kansas' 47 = 'Tennessee'
                     21 = 'Kentucky' 48 = 'Texas'
                     22 = 'Louisiana' 49 =' Utah'
                     23 = 'Maine' 51 = 'Virginia'
                     24 = 'Maryland' 53 = 'Washington'
                     25 = 'Massachuse';

value $second_inclass 1 = 'Less than 0.1667'
                      2 = '0.1667 – 0.3333'
                      3 = '0.3334 – 0.4999'
                      4 = '0.5000 – 0.6666'
                      5 = '0.6667 – 0.8333'
                      6 = '0.8334 – 1.0000';
                     
value $second_education  1 = 'No schooling completed, or less than 1 year'
                         2 = 'Nursery, kindergarten, and elementary (grades 1-8)'
                         3 = 'High school (grades 9-12, no degree)'
                         4 = 'High school graduate – high school diploma or the equivalent (GED)'
                         5 = 'Some college but no degree'
                         6 =  'Associate’s degree in college'
                         7 = 'Bachelor’s degree (BA, AB, BS, etc.)'
                         8 = 'Master’s professional, or doctorate degree (MA, MS, MBA, MD, JD, PhD, etc.)';

value $code               1 = 'Reference person'
                          2 = 'Spouse'
                          3 = 'Child or adopted child'
                          4 = 'Grandchild'
                          5 = 'In-law'
                          6 = 'Brother or sister'
                          7 = 'Mother or father'
                          8 = 'Other related person'
                          9 = 'Unrelated person'
                          0 = 'Unmarried Partner';                         
run;              
                     

/* Exercise 1(c) */
title 'Exercise 1(c)';
data fmli142_tluo4;
set hw02.FMLI142;
format BLS_URBN $urban.
       RACE2 $race.
       EDUC_REF EDUCA2 $education.
       MARITAL1 $marital.
       REGION $region.
       SEX_REF $sex.
       INCLASS $inclass.
       INCLASS2 $second_inclass.
       STATE $state.;

label BLS_URBN = 'Complete Bathrooms'
      AGE2 = 'Age of Spouse'
      AGE_REF= 'Age of reference person'
      BATHRMQ = 'Bathroom numbers'
      BEDROOMQ = 'Bedroom numbers'
      EDUCA2 = 'Education of Spouse'
      EDUC_REF = 'Education of Reference Person'
      FINCATAX = 'Amount of CU income after tax in the past 12 months'
      FINCBTAX = 'Amount of CU income before tax in the past 12 months'
      HHID = 'Identifier of household with more than one CU'
      HH_CU_Q = 'Counts of CUs in households'
      HLFBATHQ = 'Number of half bathrooms in this unit'
      INCLASS = 'Income class of CU'
      INCLASS2 = 'Income Class based on INC_Rank'
      INTERI = 'Interview number'
      MARITAL1 = 'Marital status of Reference Person'
      NEWID = 'CU identification number'
      NO_EARNR = 'Number of Earners'
      NUM_AUTO = 'Number of Automobiles'
      PRINEARN = 'Member Numbers'
      QINTRVMO = 'Interview month'
      QINTRVYR = 'Interview Year'
      RACE2 = 'Race of Spouse'
      RACE_REF = 'Race of Reference Person'
      SEX2 =  'Sex of Spouse'
      SEX_REF = 'Sex of Reference Person'
      CUID = 'Consumer Unit Identifying Variable';
      run;

data memi142_tluo4;
set hw02.MEMI142;
 format EDUCA $second_education.
        MARITAL $marital.
        SEX $sex.
        MEMBRACE $race.
        CU_CODE $code.;
  
  label CU_CODE = 'Member relationship to reference person'
        EDUCA =  'Highest level of school member has completed'
        MARITAL = 'Member marital status'
        MEMBNO =  'Person line number'
        MEMBRACE = 'Race of Member'
        NEWID =  'CU identification number'
        SALARYX = 'Salary income received in the past 12 months';
       run;


/* Exercise 1(d) */
title 'Exercise 1(d)';
proc contents data=fmli142_tluo4;
run;

proc contents data=memi142_tluo4;
run;

/* Exercise 1(e) */
title 'Exercise 1(e)';
options obs=10;
proc print data=fmli142_tluo4;
var NEWID CUID AGE_REF BLS_URBN MARITAL1 FINCATAX;
run;
options obs=10;
proc print data=memi142_tluo4;
var NEWID CU_CODE MARITAL SALARYX;
run;

/* Exercise 1(f) */
title 'Exercise 1(f)';
proc format;
value salary        low - 12000 = 'Impoverished'
                    30000 - 70000 = 'Middle Class'
                    70000 - 120000 = 'Upper Middle Class'
                    120000 -high = 'Upper Class'
                    other = 'Lower Class'
                     . = 'Missing';
run;
         

/* Exercise 1(g)*/ 
title 'Exercise 1(g)';
proc datasets library = WORK;
modify MEMI142_tluo4;
format SALARYX salary.;
run;
quit;

/* Exercise 1(h)*/
title 'Exercise 1(h)';
options obs=10;
proc print data = MEMI142_tluo4;
var NEWID EDUCA SALARYX;
run;

 















                   
             

               































