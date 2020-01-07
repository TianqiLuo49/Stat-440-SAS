/* Group 27 */
/* Final Project */

/* In this project, we're using the UCI bicycle data of Portugal Bike Rentals */

/* For my part of the project, I'll be analyzing the windspeed and whether or not it has any correlation with the number of the total bike rentals */


/* First, we read in the day.csv from the data */
data day;
infile "/home/tianqiluo490/Stat 440/Final Project/day.csv" dsd truncover firstobs =2;
input instant  dteday: yymmdd. season yr mnth holiday weekday workingday weathersit temp atemp hum windspeed casual registered cnt;
format dteday mmddyy8.;
daily_temp = temp;
daily_atemp = atemp;
daily_hum = hum;
daily_windspeed = windspeed;
daily_casual = casual;
daily_registered = registered;
daily_cnt = cnt;
drop temp atemp hum windspeed casual registered cnt;
run;


/* Second, we read in the hour.csv from the data */
data hour;
infile "/home/tianqiluo490/Stat 440/Final Project/hour.csv" dsd truncover firstobs = 2;
input instant  dteday: yymmdd. season yr mnth hr holiday weekday workingday weathersit temp atemp hum windspeed casual registered cnt;
format dteday mmddyy8.;
run;

/* Validate the hour data to make sure the data is exactly the same as described in the txt file */
proc print data = hour;
var dteday season yr mnth holiday weekday workingday weathersit temp atemp hum  windspeed casual registered cnt;
where dteday = . or  temp = . or atemp = . or hum = . or windspeed = . or casual = . or registered = . or cnt = . or (season < 1 and season > 4) or (hr < 0 and hr > 23) or (weekday < 0 and weekday > 5) or (weathersit < 1 and weathersit > 4)
or (1 < mnth and mnth > 12) or (0 < yr and yr > 1) or (0 < workingday and workingday > 1) or (cnt ^ = registered + casual);
run;

/* Since it prints out nothing, our data is clean */

/* Again, validate the day data to make sure the data is clean */
proc print data = day;
var dteday season yr mnth holiday weekday workingday weathersit daily_temp daily_atemp daily_hum  daily_windspeed daily_casual daily_registered  daily_cnt;
where dteday = . or  daily_temp = . or daily_atemp = . or daily_hum = . or daily_windspeed = . or daily_casual = . or daily_registered = . or daily_cnt = . or (season < 1 and season > 4) or (weekday < 0 and weekday > 5) or (weathersit < 1 and weathersit > 4)
or (1 < mnth and mnth > 12) or (0 < yr and yr > 1) or (0 < workingday and workingday > 1) or (daily_cnt ^ = daily_registered + daily_casual);
run;





/* We'll set the formats for the data so it's easier to read */
/* Set six formats for season, year, weekday, workingday, month, weathersit, holiday */
proc format;
value $season       1 = 'Spring'
                    2 = 'Summer'
                    3 = 'Fall'
                    4 = 'Winter';
      
      
value $year         0 = '2011'
                    1 = '2012';

value $weekday      0 = 'Sunday'
                    1 = 'Monday'
                    2 = 'Tuesday'
                    3 = 'Wednesday'
                    4 = 'Thursday'
                    5 = 'Friday'
                    6 = 'Saturday';

value $workingday   0 = 'No'
                    1 = 'Yes';
                    
value $month        01 = 'January'
                    02 = 'February'
                    03 = 'March'
                    04 = 'April'
                    05 = 'May'
                    06 = 'June'
                    07 = 'July'
                    08 = 'August'
                    09 = 'September'
                    10 = 'October'
                    11 = 'November'
                    12 = 'December';

value $weathersit   1 = 'Clear/few clouds/partly cloudly'
                    2 = 'Mist + Cloudy/Broken Clouds/few clouds'
                    3 = 'Light Snow/Rain'
                    4 = 'Heavy Rain/Snow/Pallets';

value $holiday      0 = 'No'
                    1 = 'Yes';
run;

/* We'll merge these two data */

/* We sort the day data first, by dteday */            
proc sort data = day out = sorted_day;
by dteday;
run;

/* We also sort the hour data, by dteday */
proc sort data = hour out = sorted_hour;
by dteday;
run;

/* Merge the two data */
data hour_and_day;
merge sorted_day sorted_hour;
by dteday;

/* Change the numeric variables into character variables */
yr_char = put(yr, $2.);
holiday_char = put(holiday, $1.);
season_char = put(season, $1.);
weekday_char = put(weekday, $1.);
workingday_char = put(workingday, $1.);
mnth_char = put(mnth, $z2.);
weathersit_char = put(weathersit, $1.);

/* Set the format for the variables */
format season_char $season.
       yr_char $year.
       weekday_char $weekday.
       workingday_char $workingday.
       mnth_char $month.
       weathersit_char $weathersit.
       holiday_char $holiday.;

/* Set the labels for the variables */
label dteday = 'Date'
      yr_char = 'Year'
      mnth_char = 'Month'
      season_char = 'Season'
      weekday_char = 'Weekday'
      workingday_char = 'Weekday or No'
      weathersit_char = 'Weather Situation'
      holiday_char = 'Holiday or No'
      temp = 'Hourly Normalized Temperature'
      atemp = 'Hourly Normalized Feeling Temperature'
      hum = 'Hourly Humidity'
      windspeed = 'Hourly Wind Speed'
      casual = 'Hourly Casual Users'
      registered = 'Hourly Registered Users'
      cnt = 'Hourly Total Rental Bikes'
      daily_temp = 'Average Daily Temperature'
      daily_atemp = 'Average Daily Feeling Temperature'
      daily_hum = 'Average Daily Humidity'
      daily_windspeed = 'Average Daily Windspeed'
      daily_casual = 'Total Daily Casual Users'
      daily_registered = 'Total Daily Registered Users'
      daily_cnt = 'Total Daily Rental Bikes'
      hr = 'Hour'
    TempConvertedDaily = 'Daily Temperature'
	TempConvertedHourly = "Hourly Temperature"
	TempConvertedDailyFeeling = "Daily Temperature Feeling"
	TempConvertedHourlyFeeling = "Hourly Temperature Feeling"
	HumidityConvertedDaily = "Daily Humidity"
	HumidityConvertedHourly = "Humidity by Hour";
/* Then we converted Temperature and Humidity from decimals into the standard format for Celcius*/
/* Numbers used to convert temperature were provided by the source of datasheet*/	
	TempConvertedDaily = daily_temp*(39--8)+(-8);
	TempConvertedHourly = temp*(39--8)+(-8);
	TempConvertedDailyFeeling = daily_atemp*(50--8)+(-16);
	TempConvertedHourlyFeeling = atemp*(50--8)+(-16);
	HumidityConvertedDaily = daily_hum*100;
	HumidityConvertedHourly = hum*100; 
	
	if  TempConvertedDailyFeeling <= 15 then Condition = "cold";
	else if 15 < TempConvertedDailyFeeling <= 30 then Condition = "warm";
	else if TempConvertedDailyFeeling > 30 then Condition = "hot";
drop instant yr season weekday workingday mnth weathersit holiday;
run;



/* Print the descriptor portion of the data */
title "Print the descriptor portion of the data";
proc contents data = hour_and_day;
run;


/* Print the first 10 observations of our new data */
title "Print the first 10 observations of our new data hour_and_day";
proc print data = hour_and_day(obs = 10) noobs label;
var season_char hr daily_windspeed windspeed daily_cnt cnt;
run;


/* How does Temperature and Humidity affect the number of bike rentals?*/

/* Which month had the highest Count of Bike Rentals?*/
title "Total Count of Bike Rentals by Month";

proc sort data=hour_and_day out=work.HourDay;
by mnth_char;
run;

proc print data=Count_By_Month noobs label;
run;


/* Use sql to build data related to windspeed */

/* Determine which month has the highest average windspeed */
title "Determine which month has the highest average windspeed";
proc sql;
create table avg_windspeed_month as
select avg(windspeed) as average_windspeed, mnth_char
from hour_and_day
group by mnth_char;
quit;

proc sort data = avg_windspeed_month out =avg_windspeed_month_descending;
by descending average_windspeed;
run;

proc print data = avg_windspeed_month_descending;
run;

/* Determine which season has the highest average windspeed */
title "Determine which season has the highest average windspeed";
proc sql;
create table avg_windspeed_season as
select avg(windspeed) as average_windspeed, season_char
from hour_and_day
group by season_char;
quit;


proc sort data = avg_windspeed_season out = avg_windspeed_season_descending;
by descending average_windspeed;
run;

proc print data = avg_windspeed_season_descending;
run;

/* Determine which hour of the day has the highest average windspeed */
title "Determine which hour of the day has the highest average windspeed";
proc sql;
create table avg_windspeed_hr as
select avg(windspeed) as average_windspeed, hr
from hour_and_day
group by hr;
quit;

proc sort data = avg_windspeed_hr out = avg_windspeed_season_descending;
by descending average_windspeed;
run;

proc print data = avg_windspeed_season_descending;
run;



/* Use sql to determine the relationship between windspeed and casual users */
title "Determine the relationship between windspeed and casual average casual users";
proc sql;
create table most_casual as 
select windspeed, avg(casual) as average_casual
from hour_and_day
group by windspeed;
quit;

proc sort data = most_casual out = most_casual_descending;
by descending windspeed;
run;

proc print data = most_casual_descending;
run;


/* Use sql to determine the relationship between windspeed and registered users */
title "Determine the relationship between windspeed and average registered users";
proc sql;
create table most_registered as 
select windspeed, avg(registered) as average_registered
from hour_and_day
group by windspeed;
quit;

proc sort data = most_registered out = most_registered_descending;
by descending windspeed;
run;

proc print data = most_registered_descending;
run;


/* Use sql to determine the relationship between windspeed and cnt users*/
title "Determine the relationship between windspeed and average cnt users";
proc sql;
create table most_cnt as
select windspeed, avg(cnt) as average_cnt
from hour_and_day
group by windspeed;
quit;

proc sort data = most_cnt out = most_cnt_descending;
by descending windspeed;
run;

proc print data = most_cnt_descending;
run;

/* Use proc sql to count users by temperature */
title "Count users by condition";
proc sql;
create table user_by_condition as
select Condition, count(cnt) as total_users_by_condition label = "Total Users by Condition"
from hour_and_day
group by Condition;
quit;

proc print data = user_by_condition label;
run;

proc sort data = hour_and_day;
by condition;
run;

proc means data = hour_and_day;
by condition;
run;



/* Graphs */

proc freq data = hour_and_day nlevels;
tables dteday hr yr_char holiday_char season_char weekday_char mnth_char weathersit_char / missing;
run;


proc means data=hour_and_day missing;
run;

proc gchart data=hour;
vbar hr / sumvar=cnt discrete;
run;

proc gchart data=hour;
vbar weathersit / sumvar=cnt discrete;
run;

proc univariate data=hour_and_day;
hist;
run;

proc gplot data=hour_and_day;
plot daily_atemp * cnt;
run;

proc gplot data=hour_and_day;
plot daily_windspeed * cnt;
run;











