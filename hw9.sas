/* Tianqi Luo */
/* HW09 Submission */

/* Remember to save this template file as HW9_YourNetID.sas */
/* You'll need to switch the following portion
             "~/my_courses/dunger_sas/hw09" access=readonly
   to 
             "C:\440\hw09";
   before making your final submission. */
  

libname hw09 "C:\440\hw09";

/* Exercise 1 */

/* Exercise 1(a) */

/* First sort the two data */
proc sort data = hw09.demographic out = sorted_demographic;
by ID;
run;

proc sort data = hw09.survey1 out = sorted_survey1;
by  Subj;
run;

/* Then merge the two data */
data demo1_tluo4;
merge sorted_demographic sorted_survey1(rename = (Subj = ID));
by ID;
run;

/* Exercise 1(b) */
title "Exercise 1(b)";
proc print data = demo1_tluo4;
run;



/* Exercise 1(c) */
title "Exercise 1(c)";
/* Change the ID from numeric variables to character variables using put function */
data char_survey2;
set hw09.survey2;
char_ID = put(ID, z3.);
drop ID;
rename char_ID = ID;
run;


/* Sort the new data set */
proc sort data = char_survey2 out = sorted_char_survey2;
by ID;
run;

/* Merge the two data sets */
data demo2_tluo4;
merge sorted_demographic sorted_char_survey2;
by ID;
run;

/* Exercise 1(d) */
title "Exercise 1(d)";
proc print data = demo2_tluo4;
run;

/* Exercise 2 */
data updated_tluo4;
set hw09.fivepeople;

/* Use put to change the ID variable to numeric */
num_ID = input (ID, 4.);
drop ID;
rename num_ID = ID;

/* Use scan to scan for the first names and last names, then use catt to concatenate them */
Firstname = scan(Name, 1, ' ');
Lastname = scan(Name, -1, ' ');
Newname = catx(", ", Lastname, Firstname); /* Separate them with a "," */
drop Name Firstname Lastname;
rename newname = Name;

/* Use compress to get rid of the punctuations, leaving only the listed characters and digits */
num_Phone = input(compress(Phone,,'kd'), 10.);
drop Phone;
rename num_Phone = Phone;

/* Use compress to get rid of the punctuations in Height, then use scan to scan for the feet and inches */
Height_char = compress(Height,,'kds'); 
Feet = scan(Height_char, 1, ' ');
Inches = scan(Height_char, 2, ' ');
if missing(Inches) then Inches = '0'; /* Set the missing Inches to be 0 */
HtSymbol = catt( Feet,"'" ,Inches, '"'); /* Use catt to concatenate the Feet and Inches with the ' and "". */
drop Height_char;

/* Calculate HtInches with Feet and Inches variables */
HtInches = 12*Feet + Inches;
drop Feet Inches;


/* We scan for the Integer part and the fraction part */
Integer = scan(Weight, 1, ' ');
Fraction = scan(Weight, 2, ' ');
if missing(Fraction) then Fraction = 0;
Numerator = scan(Fraction, 1, '/');  /* Scan for the Numerator in Fraction, set '/' as the delimiter */
Denominator = scan(Fraction, -1, '/');  /* Scan for the Denominator in Fraction *, set '/' as the delimiter */
 
Decimals = Numerator/Denominator; /* Calculate the decimal */
if missing(Decimals) then Decimals = 0;
WtPounds_char = put(Integer + Decimals, 10.3); /* Calculate Wtpounds and round it to 10.3 */
WtPounds = input(WtPounds_char, 10.3);
format WtPounds f10.3; /* Set the format to display the trailing zeros */

drop Integer Fraction Numerator Denominator Decimals WtPounds_char;
drop Height;
run;

/* Exercise 2(b) */
title "Exercise 2(b)";
proc print data = updated_tluo4;
var ID Name Phone HtSymbol HtInches Weight WtPounds;
run;

/* Exercise 2(c) */
title "Exercise 2(c)";
proc contents data = updated_tluo4;
run;












