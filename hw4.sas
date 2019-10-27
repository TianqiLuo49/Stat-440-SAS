/* Tianqi Luo */
/* HW04 Submission */

/* Remember to save this template file as HW1_YourNetID.sas */
/* You'll need to switch the following portion
             "~/my_courses/dunger_sas/hw04" access=readonly
   to 
             "C:\440\hw04";
   before making your final submission. */
 
/* Exercise 1 */

/* Exercise 1(a) */
title "Exercise 1(a)";

data rushing_tluo4;
infile "C:\440\hw04\nflrush.dat" firstobs = 2;
input  Season 1-10 Player $10-35 Team $40-50  @70 Yds comma5.  Avg 75-85  Lg 91-98 TD  FD ;
format Yds comma5.;
label  Yds = 'Rushing Yards'
       Avg = 'Average rushing yards per attempt'
       Lg = 'Longest rushing attempt'
       TD = 'Rushing Touchdowns'
       FD = 'Rushing First-Downs';
run;



/* Exercise 1(b) */
title "Exercise 1(b)";
proc contents data = rushing_tluo4;
run;

/* Exercise 1(c) */
title "Exercise 1(c)";
proc sort data = rushing_tluo4 out = sorted_1;
by descending TD;
where 2013 <= Season <= 2015;
run;

proc print data = sorted_1(obs=10);
var Season Player TD;
run;

/* Exercise 1(d) */
title "Exercise 1(d)";
data localnfl_tluo4;
infile "C:\440\hw04\nflrush_quotes.dat" firstobs = 2  TRUNCOVER;
length Season 4 Player $ 20 Team $3;
input  Season & Player & $   Team & $ Games & Att  & Yds & comma6.  Avg & YPG & Lg & TD & FD &;
if Team eq 'GB' or Team eq 'Chi' or Team eq 'Stl' or Team eq 'Ind';
format Yds comma6.;
label  Yds = 'Rushing Yards'
       Avg = 'Average rushing yards per attempt'
       Lg = 'Longest rushing attempt'
       TD = 'Rushing Touchdowns'
       FD = 'Rushing First-Downs';
run;



/* Exercise 1(e) */
title "Exercise 1(e)";
proc contents data = localnfl_tluo4;
run;

/* Exercise 1(f) */
title "Exercise 1(f)";
proc sort data = localnfl_tluo4 out = sorted_2;
by descending Yds ;
run;

proc print data = sorted_2(obs = 10);
var Season Player Team Yds;
run;


/* Exercise 2 */

/* Exercise 2(a) */
title "Exercise 2(a)";
data low_earners4_tluo4;
infile "C:\440\hw04\employee_roster4.dat" dlm = '**' missover;
length name $20 company $10 department $17 section $20 organization $20 title $20;  
input ID  Name $ Country $ ;
input Company $ Department $  Section $  Organization $ Title $ Gender $;
input Salary dollar10.  birth_day   hire_date   termination_date 2-3;
if Department ^= 'Sales' then delete;
if Salary >= 25000 then delete;
format salary dollar10.;
format birth_day hire_date termination_date mmddyy.;
label organization = 'Organization Group'
      title = 'Job Title'
      birth_day = 'Birth Date'
      hire_date = 'Hire Date'
      termination_date = 'Termination Date';
run;




/* Exercise 2(b) */
title "Exercise 2(b)";
proc contents data = low_earners4_tluo4;
run;

/* Exercise 2(c) */
title "Exercise 2(c)";
proc print data = low_earners4_tluo4;
var  Name Gender Department Title Salary;
run;

















 








