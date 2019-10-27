/* Tianqi Luo */
/* HW06 Submission */

/* Remember to save this template file as HW6_YourNetID.sas */
/* You'll need to switch the following portion
             "~/my_courses/dunger_sas/hw06" access=readonly
   to 
             "C:\440\hw06";
   before making your final submission. */
  
libname hw06 "C:\440\hw06";

/* Exercise 1 */

/* Exercise 1(a) */
title "Exercise 1(a)";

/* First sort the two data sets by the Model */
proc sort data = hw06.inventory out = sorted_inventory;
by Model;
run;


proc sort data = hw06.purchase out = sorted_purchase;
by  Model;
run;

/* Merge the two data sets*/
data purchase_price_tluo4;
merge sorted_inventory sorted_purchase;
by Model;
/* Add a new variable TotalCost */
TotalCost = Price * Quantity;
format TotalCost dollar8.2;
if CustNumber = . then delete;
run;

/* Exercise 1(b) */
title "Exercise 1(b)";
proc print data = purchase_price_tluo4 noobs;
run;

/* Exercise 1(c) */
title "Exercise 1(c)";
data not_purchased_tluo4;
merge sorted_inventory sorted_purchase;
by Model;
/* Select the models not purchased by CustNumber */
if CustNumber ^= . then delete;
drop CustNumber Quantity;
run;

/* Exercise 1(d) */
title "Exercise 1(d)";
proc print data = not_purchased_tluo4 noobs;
run;

/* Exercise 1(e) */
title "Exercise 1(e)";
data purchase_price_tluo4 not_purchased_tluo4;
merge sorted_inventory sorted_purchase;
by Model;
TotalCost = Price * Quantity;
format TotalCost dollar8.2;
if CustNumber = . then output not_purchased_tluo4;
else output purchase_price_tluo4;
run;



/* Exercise 2 */

/* Exercise 2(a) */
title "Exercise 2(a)";
proc contents data = hw06.fmli071;
proc contents data = hw06.fmli072;
proc contents data = hw06.fmli073;
proc contents data = hw06.fmli074;
proc contents data = hw06.memi071;
proc contents data = hw06.memi072;
proc contents data = hw06.memi073;
proc contents data = hw06.memi074;
run;

/* Exercise 2(b) */

title "Exercise 2(b)";

/* First we build a new variable QTR in the four datasets */
/* Set QTR to 1,2,3,4 with respect to their quarter */
data fmli071;
set hw06.fmli071;
QTR = 1;      
run;


data fmli072;
set hw06.fmli072;
QTR = 2;
run;

data fmli073;
set hw06.fmli073;
QTR = 3;
run;

data fmli074;
set hw06.fmli074;
QTR = 4;
run;

/* When we finish creating the four new datasets with the QTR variable, we concatenate them */
data fmli2007_tluo4;
set fmli071 fmli072 fmli073 fmli074;
run;

/* Exercise 2(c) */
title "Exercise 2(c)";
proc contents data = fmli2007_tluo4;
run;

/* Exercise 2(d) */
title "Exercise 2(d)";
/* Same with Exercise 2(b), we need to add variable QTR to the original four data sets */
/* Set the QTR as 1,2,3,4 with respect to their data set */

data memi071;
set hw06.memi071;
QTR = 1;
run;

data memi072;
set hw06.memi072;
QTR = 2;
run;

data memi073;
set hw06.memi073;
QTR = 3;
run;

data memi074;
set hw06.memi074;
QTR = 4;
run;

/* Concatenate the four data sets into one data */
data memi2007_tluo4;
set memi071 memi072 memi073 memi074;
run;

/* Exercise 2(e) */
title "Exercise 2(e)";
proc contents data = memi2007_tluo4;
run;

/* Exercise 2(f) */
/* First sort the two data by CU_ID */
title "Exercise 2(f)";

proc sort data = memi2007_tluo4 out = sorted_memi2007;
by CU_ID;
run;

proc sort data = fmli2007_tluo4 out = sorted_fmli2007;
by CU_ID;
run;

/* Merge the two sorted data */
data ce2007_tluo4;
merge sorted_fmli2007 sorted_memi2007;
by CU_ID;
run;

/* Exercise 2(g) */
title "Exercise 2(g)";
proc contents data = ce2007_tluo4;
run;

/* Exercise 2(h) */
title "Exercise 2(h)";
/* First create four sorted data sets from memi071-memi072 by CU_ID */
/* Since memi071-memi072 includes fmli071-fmli072, we only need to sort the former */


proc sort data = hw06.memi071 out = sorted_memi071;
by CU_ID;
run;

proc sort data = hw06.memi072 out = sorted_memi072;
by CU_ID;
run;

proc sort data = hw06.memi073 out = sorted_memi073;
by CU_ID;
run;

proc sort data = hw06.memi074 out = sorted_memi074;
by CU_ID;
run;

/* Merge them if CU_ID appears in 1,2,3, or 1,2,4, or 2,3,4 */


data memi_123;
merge sorted_memi071(IN = me1) sorted_memi072(IN = me2) sorted_memi073(IN = me3);
if me1 and me2 and me3;
by CU_ID;
run;

data memi_124;
merge sorted_memi071(IN = me1) sorted_memi072(IN = me2) sorted_memi074(IN = me4);
if me1 and me2 and me4;
by CU_ID;
run;

data memi_234;
merge sorted_memi072(IN = me2) sorted_memi073(IN = me3) sorted_memi074(IN = me4);
if me2 and me3 and me4;
by CU_ID;
run;

/* Merge all the data and get rid of the duplicates */
data atleast_three_tluo4_with_dupe;
merge memi_123 memi_124 memi_234;
by CU_ID;
run;

proc sort data = atleast_three_tluo4_with_dupe out = atleast_three_tluo4 nodupkey equals;
by CU_ID;
run;

/* Merge all the data with the ones that appear in all four data sets, and get rid of duplicates */
data all_four_tluo4_with_dupe;
merge sorted_memi071(IN = me1) sorted_memi072(IN = me2) sorted_memi073(IN = me3) sorted_memi074(IN = me4);
if me1 and me2 and me3 and me4;
by CU_ID;
run;

proc sort data = all_four_tluo4_with_dupe out = all_four_tluo4 nodupkey equals;
by CU_ID;
run;

/* Exercise 2(i) */
title "Exercise 2(i)";
/* Use ods select to only the first table */
proc contents data = atleast_three_tluo4;
ods select attributes;
run;

proc contents data = all_four_tluo4;
ods select attributes;
run;
























































































































