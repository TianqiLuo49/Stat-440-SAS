/* Tianqi Luo */
/* Midterm Submission */

/* Remember to save this template file as midterm_YourNetID.sas */
/* You'll need to switch the following portion
             "~/my_courses/dunger_sas/midterm" access=readonly
   to 
             "C:\440\midterm";
   before making your final submission. */
  
libname midterm "C:\440\midterm";

/* Midterm */

/* Read the raw data first */
data uiuc_football;
infile 'C:\440\midterm\illinifb16.dat' dlm = ',' dsd missover;
input Obs Season Conf $ W L T Pct SRS SOS AP_pre AP_high AP_post ConfTitle $ Coach: $50. Record $ Bowl : $20. BowlResult $;
label Obs = 'Observation Number'
      W = 'Wins'
      L = 'Losses'
      T = 'Ties'
      Pct = 'Win percentage'
      SRS = 'Simple Rating System'
      SOS = 'Strength of Schedule'
      AP_pre = 'Pre-Season AP poll rank'
      AP_high = 'Season Highest rank of AP poll'
      AP_post = 'End of Season AP poll Rank'
      ConfTitle = 'Win Conference Title'
      Record = 'Coach Record'
      Bowl = 'Post-Season Bowl Game'
      BowlResult = 'Result of Bowl Game';
run;


/* Validate the data */


/* Check if each variable has missing values */
title "Check for missing values";
proc freq data = uiuc_football nlevels;
   table _all_ /noprint;
run;
/* We can see that L, Pct, Coach and Record have missing values, which is not normal */
/* Others with missing values are normal */


/* Print out the observations where win percentage is calculated incorrectly */
title "Print out the wrong Pcts";
proc print data = uiuc_football label;
   var Coach Season W L T Pct Record;
   where round(W/(W+L+T), .001) ^= Pct;
run;

/* Print out the observations that need cleaning */
title "Print out the variables that need cleaning";
proc print data = uiuc_football label;
    var Coach Season W L T Pct Record;
    where L = . or Pct = . or  Coach = ' ' or Record = ' ';
run;

/* Check if there's spelling problems with ConfTitle */
title "Print out the spelling errors";
proc print data = uiuc_football label;
    var Season ConfTitle;
    where ConfTitle ^ = 'N' and ConfTitle ^ = 'Y';
run;

/* We can see there are two observations that mispell Y as 'y' and N as 'No'. */


/* Clean the data */
data clean_uiuc_football;
   set uiuc_football;
   /* Clean data for the Coach variable and the Record variable */
   if Coach = 'John Mackovic (6-5) Lou Tepper (0-1)' then do 
   Coach = 'John Mackovic';
   Record = '(6-5)';
   end;
   
   else if Coach = 'Ron Zook (6-6) Vic Koenning (1-0)' then do
   Coach = 'Ron Zook';
   Record = '(6-6)';
   end;
   
   else if Coach = ' ' then do 
   Coach = 'Arthur Hall';
   Record =  '(9-2-1)';
   Pct = 0.750;
   end;
   
   /* Clean data for the variables with an empty value */
   else if Season = 1927 then do
   L = 0;
   Pct = 0.875;
   end;
   
   /* Clean data for the ConfTitle variable */
   else if ConfTitle = 'No' then ConfTitle = 'N';
   else if COnfTItle = 'y' then ConfTitle = 'Y';
   
   /* Clean data for the incorrect calculations of the Pct variable */
   if Pct ^= round(W/(W+L+T), .001) then Pct = round(W/(W+L+T), .001);
   
   /* Add a decade variable for all the seasons */
   if 1890 <= Season <= 1899 then  Decade = '1890s';
   else if 1900 <= Season <= 1909 then Decade = '1900s';
   else if 1910 <= Season <= 1919 then Decade = '1910s';
   else if 1920 <= Season <= 1929 then Decade = '1920s';
   else if 1930 <= Season <= 1939 then Decade = '1930s';
   else if 1940 <= Season <= 1949 then Decade = '1940s';
   else if 1950 <= Season <= 1959 then Decade = '1950s';
   else if 1960 <= Season <= 1969 then Decade = '1960s';
   else if 1970 <= Season <= 1979 then Decade = '1970s';
   else if 1980 <= Season <= 1989 then Decade = '1980s';
   else if 1990 <= Season <= 1999 then Decade = '1990s';
   else if 2000 <= Season <= 2009 then Decade = '2000s';
   else if 2010 <= Season <= 2019 then Decade = '2010s';
run;


/* Use the same validations to validate the data */
/* If it prints out nothing, then our data is cleaned */
title "Check cleaned data with proc freq to see if there's anymore missing values";
proc freq data = clean_uiuc_football;
    table _all_ /noprint;
run;

/* Since it prints out nothing, there's no missing data in Pct, Coach, W, L, T, and Record */


/* Use the validations to check for the correct calculations of Pct */
/* If it prints out nothing, then our data is cleaned */
title "Check if there's any more wrong Pcts";
proc print data = clean_uiuc_football label;
   var Coach Season W L T Pct Record;
   where round(W/(W+L+T), .001) ^= Pct;
run;   

title "Check if there's any more wrong data";
proc freq data = clean_uiuc_football;
    table ConfTitle Coach L;
run;

/* Since it prints out nothing, all the Pct calculations are correct */


/* Use proc means to find the coach with the most wins */
title "Find the coach with the most wins";
proc means data = clean_uiuc_football  sum maxdec = 0;
    class Coach;
    var W;
run;

/* Now we compare the AP poll rankings for Pre-Season, During Season and Post Season */
/* First sort the data by Ap_pre variable */
title "Find the season with the highest AP ranking for preseason";
proc sort data = clean_uiuc_football  out = ap_pre_ranking;
by AP_pre;
run;

/* Print out the results where AP_pre has values */
title "Find the season with the highest AP ranking during season";
proc print data = ap_pre_ranking;
var Season AP_pre;
where AP_pre ^ =.;
run;

/* Do the same thing for Ap_high */
proc sort data = clean_uiuc_football out = ap_high_ranking;
by AP_high;
run;

proc print data = ap_high_ranking;
var Season AP_high;
where AP_high ^= .;
run;

/* Do the same thing for Ap_post */
title "Find the season with the highest AP ranking for postseason";
proc sort data = clean_uiuc_football out = ap_post_ranking;
by AP_post;
run;

proc print data = ap_post_ranking;
var Season AP_post;
where AP_post ^= .;
run;

/* Use proc freq to find the number of times(frequency) of the wins in ConfTitle */
title "Find how many times Illinois has won conference title";
proc freq data = clean_uiuc_football;
   table ConfTitle;
run;

/* Find the decade with the most wins using proc means */
title "Find the decade with the most wins";
proc means data = clean_uiuc_football sum maxdec = 0 ;
     class Decade;
     var W;
run;




   






































