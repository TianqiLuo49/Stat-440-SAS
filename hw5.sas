/* Tianqi Luo */
/* HW05 Submission */

/* Remember to save this template file as HW1_YourNetID.sas */
/* You'll need to switch the following portion
             "~/my_courses/dunger_sas/hw05" access=readonly
   to 
             "C:\440\hw05";
   before making your final submission. */
  
libname hw05 "C:\440\hw05";
;


/* Exercise 1 */

/* Exercise 1(a) */
title "Exercise 1(a)";

proc print data = hw05.shoes_tracker;
run;

data shoes_tracker_tluo4;
set hw05.shoes_tracker;
Supplier_Country = upcase(Supplier_Country);
if Product_ID = 22020030007	then Product_ID = 220200300079;
else if Product_ID = 2202003001290 then Product_ID = 220200300129;
if Product_Category = " " then Product_Category = "Shoes";
if Product_Name = "Mns.raptor Precision Sg Football" then Product_Name = "Men's Raptor Precision Sg Football";
else if Product_Name = "men's running shoes piedmont" then Product_Name = "Men's Running Shoes Piedmont";
if Supplier_ID = 2963 then Supplier_Name = "3Top Sports";
else if Supplier_ID = 14682 then Supplier_Name = "Greenline Sports Ltd.";
else if Supplier_ID = . then Supplier_ID = 2963;
if Supplier_Country = "UT" then Supplier_Country = "US";
run;

/* Exercise 1(b) */
title "Exericise 1(b)";
proc freq data = shoes_tracker_tluo4;
run;

proc print data = shoes_tracker_tluo4;
run;

/* Exercise 2 */

/* Exercise 2(a) */
data rushing_tluo4;
length Season 4 Player $30 Team $3 Yds 6;
infile "C:\440\hw05\badrush.txt" dlm = '09'x missover;
input Season  Player $ @;
if Player = "Matt Forte" then input Games Att Yds: comma6. Avg YPG Lg TD FD;
if Player ^= "Matt Forte" then input Team $ Games Att Yds: comma6. Avg YPG Lg TD FD;
format Yds comma6.;
run;

/* Exercise 2(b) */
proc contents data = rushing_tluo4;
run;



       
/* Exercise 2(d) */
title "Exercise 2(d)";
proc print data = rushing_tluo4;
var Season Team Player Games Lg Yds TD FD;
where Season not between 2010 and 2014 or
      Player = " " or 
      Team = "  "  or 
      Games not between 1 and 16 or 
      Lg > 100 or 
      Lg < 0 and Yds > 0 or 
      Td = . or 
      FD = .;
run;

proc print data = rushing_tluo4;
var Avg;
where Avg ^= round(Yds/Att, 0.01);
run;

proc print data = rushing_tluo4;
var YPG;
where YPG ^= round(Yds/Games, 0.1);
run;


/* Exercise 2(e) */
title "Exercise 2(e)";
data rush_tluo4;
set rushing_tluo4;
if Team = " " then Team = "NYJ";
if Player = " " then Player = "LeSean McCoy";
if Season = 1912 then Season = 2012;
else if Season = 20111 then Season = 2011;
else if Season = 20010 then Season = 2010;
if Games = 0.16 then Games = 16;
if Lg = 2800 then Lg = 28;
else if Lg = -35 then Lg = 35;
else if Lg = 910 then Lg = 91;
if Avg ^= round(Yds/Att, 0.01) then Avg = round(Yds/Att, 0.01);
if YPG ^= round(Yds/Games, 0.1) then YPG = round(Yds/Games, 0.1);
if Player = "Knowshon Moreno" then FD = 53;
if Player = "Darren McFadden" then FD = 7;
if Player = "Darren McFadden" then TD = 2;
else if Player = "Daryl Richardson" then TD = 0;
else if Player = "LeGarrette Blount" then FD = 7;
else if Player = "Ben Roethlisberger" then FD = 15;
else if Player = "Donovan McNabb" then FD = 8;
run;

/* Exercise 2(f) */
proc print data = rush_tluo4;
var Season Team Player Games Lg Yds TD FD;
where Season not between 2010 and 2014 or
      Player = " " or 
      Team = "  "  or 
      Games not between 1 and 16 or 
      Lg > 100 or 
      Lg < 0 and Yds > 0 or 
      Td = . or 
      FD = . or 
      Avg ^= round(Yds/Att, 0.01) or 
      YPG ^= round(Yds/Games, 0.1);
run;


 
 
 
 
 
 
 
 
 
 
 
 



