
-- Prepare the database server for loading local files 
Show variables LIKE "local_infile";
SET GLOBAL local_infile = 1; 

-- LOADING
-- LOADING Pesticide DATA --
LOAD DATA INFILE 'File path'
INTO TABLE Pesticides_raw
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
IGNORE 1 ROWS;

 -- LOADING Yield DATA --
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/yield_full_2.csv'
INTO TABLE Yield_raw
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(DomainCode, Domain, @CountryCode, Country, ElementCode, Element, ItemCode, Item, YearCode, Year, Unit, Value)
SET CountryCode = IF(@CountryCode = 'Use', NULL, @CountryCode);

     
 -- LOADING Temperature DATA --  
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/temperature.csv'
INTO TABLE Temperature_raw
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(Date, @AverageTemperature, @AverageTemperatureUncertainty, City, Country, Latitude, Longitude)
SET 
    AverageTemperature = NULLIF(@AverageTemperature, ''),
    AverageTemperatureUncertainty = NULLIF(AverageTemperatureUncertainty, '');
       
 -- LOADING GDP DATA --   
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/gdp_billions_noNAs.csv'
INTO TABLE GDP_raw
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
    
