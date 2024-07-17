### Project Overview
In this project, we are going to establish a database system agribusiness management. The database will store data about temperature, pesticides on yield and the GDP of various countries. These data will enables Farmers/agronomists and Agro- Consultant to understanding the optimal use of pesticides and how different temperature range impact crops can help on	maximizing crop yields, reduce the crop yield losses, cost management on pesticides use. In addition, this helps Policy Makres in setting safe pesticide usage limits and in creating guidelines to mitigate the effects of temperature extremes on crops.
### Business questions
The three personas mentioned above want to answer the questions below:
1. What is the correlation between pesticide usage and crops yield across different countries and years?
2. How do regional temperature variations impact crop yields for different countries?
3. Which crops and regions are most vulnerable to temperaure fluctuations based on historical yield data?
4. Have countries with higher pesticide use seen diminishing returns on crop yields over time?
5. Is there a link between a country’s GDP and its pesticude usage or crop productivity?
### Data
1. Data sources: We obtained data for this project from the following sources
 - Kaggle- The first source was Kaggle for the yield, pesticides and temperature data
https://www.kaggle.com/code/patelris/crop-yield-eda-viz/input?select=yield.csv
https://www.kaggle.com/code/patelris/crop-yield-eda-viz/input?select=pesticides.csv
  - World bankv- The second source was the world bank for the data on GDP
https://databank.worldbank.org/indicator/NY.GDP.MKTP.CD/1ff4a498/Popular-Indicators#advancedDownloadOptions
2. Data Description

- Yield: Contains data on different types of agricultural yields worldwide from 1961 to 2016. It has 12 variables and 56,717 rows.
- Pesticides: Details the amount of pesticides used in various countries from 1990 to 2016. It has 7 variables and 4,349 rows
- Temperature: Provides information on average temperatures recorded in different countries and cities from 1849 to 2013. It has 7 variables and 239,178 rows.
- GDP: Contains data on the gross domestic product (GDP) in USD of various countries from 1979 to 2021. It has 3 variables and 8,295 rows 
  
### Project Workflow
This project will cover four main aspect of database system implementation:
1. Data Modeling
2. Data Integration
3. SQL query: We are going to create views to allow the clients to run queries to answer business questions formulated above.
4. performance
