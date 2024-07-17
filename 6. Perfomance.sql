 -- Perfomance --

CREATE TABLE Pesticides_Final 
(   Country VARCHAR(100),
    Year INT ,
    Pesticide_Use_tonnes DECIMAL(10, 2));
    
-- Create the Yield table
CREATE TABLE Yield_Final (
    Country VARCHAR(100),
    Year INT,
    Crop VARCHAR(100),
    Yield_hg_ha INT 
);

-- Create the GDP table
CREATE TABLE GDP_Final (
    Country VARCHAR(100),
    Year INT,
    GDP_Billions DECIMAL(15, 2)
);

-- INSERT DATA INTO TABLES --

-- Insert into Pesticides
INSERT INTO Pesticides_Final (Country, Year, Pesticide_Use_tonnes)
SELECT DISTINCT Country, Year , value
FROM Pesticides_raw
WHERE year BETWEEN 1990 AND 2013
ON DUPLICATE KEY UPDATE  -- This prevents duplicates if you rerun the script
    Country = VALUES(Country),
    Year = VALUES(Year),
    Pesticide_Use_tonnes = VALUES(Pesticide_Use_tonnes);
    
-- Insert into Yield
INSERT INTO yield_Final (Country, Year, Crop, Yield_hg_ha)
SELECT DISTINCT Country, Year, Item, Value
FROM yield_raw
WHERE year BETWEEN 1990 AND 2013
ON DUPLICATE KEY UPDATE 
    Year = VALUES(Year),
    Crop = VALUES(Crop),
    Yield_hg_ha = VALUES(Yield_hg_ha);
    
-- Inserting into GDP
INSERT INTO GDP_Final (Country, Year, GDP_Billions)
SELECT Country, Year, Value
FROM GDP_raw

-- CKECK PERFOMANCE --
-- The query below must be run in a different slq tab for execution
SELECT 
    g.Year,
    g.Country,
    g.GDP_Billions AS GDP,
    p.Pesticide_Use_tonnes AS PesticideUse,
    y.Yield_hg_ha AS Yield,
    y.crop
FROM GDP_Final g
INNER JOIN Pesticides_Final p ON g.Country = p.Country AND g.Year = p.Year
INNER JOIN Yield_Final y ON p.Country = y.Country AND p.Year = y.Year
WHERE g.GDP_Billions > 1846.60 AND g.Year = 2013;

-- RUN Ctrl+Alt+X in order to chekc the query perfomance
-- -------------------------------------------------------------------------------------
-- I prefer to drop the tables because ???
DROP TABLE Pesticides_Final;
DROP TABLE Yield_Final;
DROP TABLE GDP_Final;


USE agrodb;

-- Create the Yield table
CREATE TABLE Pesticides_Final 
(   Country VARCHAR(100),
    Year INT ,
    Pesticide_Use_tonnes DECIMAL(10, 2),
    CONSTRAINT PK_Pest_Fin PRIMARY KEY CLUSTERED 
    (
    Country, 
    year
    )
);
    
-- Create the Yield table
CREATE TABLE Yield_Final (
    YieldID INT AUTO_INCREMENT PRIMARY KEY,
    Country VARCHAR(100),
    Year INT,
    Crop VARCHAR(100),
    Yield_hg_ha INT 
);

-- Create the GDP table
CREATE TABLE GDP_Final (
    Country VARCHAR(100),
    Year INT,
    GDP_Billions DECIMAL(15, 2),
    CONSTRAINT PK_GDP_Fin PRIMARY KEY CLUSTERED (Country, year)
);

-- Create the Temperature_Final table
CREATE TABLE Temperature_Final (
    Temperature INT AUTO_INCREMENT PRIMARY KEY,
    Country VARCHAR(100),
    Year INT,
    Date DATE,
    Avg_Temperature DECIMAL(7, 3) NULL,
    AverageTemperatureUncertainty DECIMAL(7, 3) NULL,
    City VARCHAR(100)
);

-- INSERT --
# Insert into Pesticides
INSERT INTO Pesticides_Final (Country, Year, Pesticide_Use_tonnes)
SELECT DISTINCT Country, Year , value
FROM Pesticides_raw
WHERE year BETWEEN 1990 AND 2013
ON DUPLICATE KEY UPDATE  -- This prevents duplicates if you rerun the script
    Country = VALUES(Country),
    Year = VALUES(Year),
    Pesticide_Use_tonnes = VALUES(Pesticide_Use_tonnes);
    
-- Insert into Yield
INSERT INTO yield_Final (Country, Year, Crop, Yield_hg_ha)
SELECT DISTINCT Country, Year, Item, Value
FROM yield_raw
WHERE year BETWEEN 1990 AND 2013
ON DUPLICATE KEY UPDATE 
    Year = VALUES(Year),
    Crop = VALUES(Crop),
    Yield_hg_ha = VALUES(Yield_hg_ha);
    
-- Inserting into GDP
INSERT INTO GDP_Final (Country, Year, GDP_Billions)
SELECT Country, Year, Value
FROM GDP_raw

-- Inserting into Location
INSERT INTO Temperature_Final (Country, City, Year, Date, Avg_Temperature, AverageTemperatureUncertainty)
SELECT Country, City, Year(Date) AS Year, Date,AverageTemperature, AverageTemperatureUncertainty
FROM Temperature_raw
WHERE year BETWEEN 1990 AND 2013
ON DUPLICATE KEY UPDATE  -- This prevents duplicates if you rerun the script
    country = Values(country),
    City = VALUES(City),
    Year = VALUES(Year),
    date = Values(Date),
    Avg_Temperature = VALUES(Avg_Temperature),
	AverageTemperatureUncertainty = VALUES(AverageTemperatureUncertainty);
    
-- Filling row mismatch -- 
-- Insert missing rows from Yield_Finalinto Pesticides_Final to avoid orphaned rows
INSERT IGNORE INTO Pesticides_Final (Country, Year)
SELECT y.Country, y.Year
FROM Yield_Final y
LEFT JOIN Pesticides_Final p ON y.Country = p.Country AND y.Year = p.Year
WHERE p.Country IS NULL AND p.Year IS NULL

-- Insert missing rows from Yield_Final into GDP_Final to avoid orphaned rows
INSERT IGNORE INTO GDP_Final (Country, Year)
SELECT y.Country, y.Year
FROM Yield_Final y
LEFT JOIN GDP_Final g ON y.Country = g.Country AND y.Year = g.Year
WHERE g.Country IS NULL AND g.Year IS NULL;

-- Insert missing rows from Pesticides_Final into Temperature_Final  to avoid orphaned rows
INSERT INTO Temperature_Final (Country, Year)
SELECT p.Country, p.Year
FROM Pesticides_Final p
LEFT JOIN Temperature_Final t ON p.Country = t.Country AND p.Year = t.Year
WHERE t.Country IS NULL AND t.Year IS NULL;

-- ADD FOREIGN KEY --
ALTER TABLE Yield_Final
ADD CONSTRAINT FK_Yield_Pest_Fin 
FOREIGN KEY (Country, year) REFERENCES Pesticides_Final (Country, year);
    

ALTER TABLE Yield_Final
ADD CONSTRAINT FK_Yield_GDP_Fin FOREIGN KEY (Country, year)
REFERENCES GDP_Final (Country, year);

CREATE INDEX idx_GDP_Fin ON GDP_Final (GDP_Billions,Year);

CREATE INDEX idx_temp_country_year ON Temperature_Final (Country, year);

ALTER TABLE Pesticides_Final
    ADD CONSTRAINT FK_Pest_Temp_Fin 
    FOREIGN KEY (Country, year) REFERENCES Temperature_Final (Country, year);
    
    

    

    
