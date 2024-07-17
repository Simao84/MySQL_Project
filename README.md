### Project Overview
In this project, we are going to establish a database system for agribusiness management. The database will store data on temperature, pesticide usage, crop yield, and the GDP of various countries. This database system will enable farmers, agronomists, and agro-consultants to retrieve data for understanding the optimal use of pesticides and how different temperature ranges impact crops. This will help maximize crop yields, reduce crop yield losses, and manage pesticide costs effectively. Additionally, this will assist policymakers in setting safe pesticide usage limits and creating guidelines to mitigate the effects of temperature extremes on crops.
### Data
1. Data sources
We obtained data for this project from the following sources:
 - Kaggle: The first source was Kaggle for the yield, pesticides and temperature data
   
https://www.kaggle.com/code/patelris/crop-yield-eda-viz/input?select=yield.csv

https://www.kaggle.com/code/patelris/crop-yield-eda-viz/input?select=pesticides.csv
  - World bank: The second source was the world bank for the data on GDP
    
https://databank.worldbank.org/indicator/NY.GDP.MKTP.CD/1ff4a498/Popular-Indicators#advancedDownloadOptions

2. Data Description
- Yield: Contains data on different types of agricultural yields worldwide from 1961 to 2016. It has 12 variables and 56,717 rows.
- Pesticides: Details the amount of pesticides used in various countries from 1990 to 2016. It has 7 variables and 4,349 rows.
- Temperature: Provides information on average temperatures recorded in different countries and cities from 1849 to 2013. It has 7 variables and 239,178 rows.
- GDP: Contains data on the gross domestic product (GDP) in USD of various countries from 1979 to 2021. It has 3 variables and 8,295 rows.
### Business questions
The three personas mentioned above want to answer the questions below:
1. What is the correlation between pesticide usage and crops yield across different countries and years?
2. How do regional temperature variations impact crop yields for different countries?
3. Which crops and regions are most vulnerable to temperaure fluctuations based on historical yield data?
4. Have countries with higher pesticide use seen diminishing returns on crop yields over time?
5. Is there a link between a country’s GDP and its pesticude usage or crop productivity?
### Project Workflow
This project will cover four main aspect of database system implementation:
1. Data Modeling
2. Data Integration
3. SQL query: We are going to create views to allow the clients to run queries to answer business questions formulated above.
4. Performance:
After running the query before and after adding the primary/foreign keys and the search index, it was evident in the figure below that the transition from full table scans to indexed searches drastically reduced query cost, rows examined, and execution time. The execution time decreased from 0.0494 seconds to 0.0045 seconds with better index utilization. The number of rows examined reduced from 38,160 to 295 rows. The query cost significantly lowered from 28,339.654 to 103.45, reflecting a more efficient query execution.
   
![image](https://github.com/user-attachments/assets/ba6deec0-6ff6-44fe-86d9-b4954ce08159)



