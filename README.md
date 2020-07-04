Bikeshare Demand Analyis and Prediction.

<<<<<Shiny app of the exploratory analysis and vizualization can be found on: https://patricenycdsa.shinyapps.io/R_Shiny_Project/>>>>>>

Main obectives:

1- Are there patterns in the data?
2- Can these patterns help predict rideshare demand yearly monthly, daily and hourly ?
3- Prediction model (Future work)

1.1
a- The first observation was that we have two different type of users: Members and Casual
b- Exploratory analysis showed a pattern of usage between the two type of users:
	A- Registered users accounts for about 80% of ride per year and per season
	B- Ride demand seems to increases in warm season and decrease in coder one for both user group. 

1.2
Analysis illustrated that the two user types have consistent pattern for every year. So now, I tuned to explore each user independently in the entire dataset. 
a- The data confirms that the two user types usage follow the same pattern (80% for Registered users and 20 %  for Causa)l in the combined data set as it did  when we looked at the data yearly.
b- When exploring data hourly, it appears the two user type have different peak time:
	A- Registered users have two peaks: Morning at 8 AM and evening at 5 PM.
	B- Casual users have peak from 2PM to 5 PM with a steady increase and decrease on the two tails.

2.1
Based on the analysis I can make following conclusion on rideshare demand in the dataset:
1- Registered users accounts for about 80% of rides yearly, seasonal and daily and casual users for 20%.
3-Demand increases with warmer weather and decrease with colder weather. 
2- Hourly, Registered users have two peak times: 8 AM and 5 PM where they account for about 90% of demand. Casual users have a peak from 2PM to 5 PM where they account for about 30 % of demand during that time.

3.
Future on this project will consist on implementing a regression analysis model which can allow us to predict daily and hourly of bike rental. 
Given current work, we know that ride demand is strongly dependant on three variables: temperature, time and user type hence will need to be integrated into the algorithm. 


