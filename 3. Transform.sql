
-- INSERT DATA INTO Yield_Final --
INSERT INTO yield_Final (Country, Year, Crop, Yield_hg_ha)
SELECT DISTINCT Country, Year, Item, Value
FROM yield_raw
WHERE year BETWEEN 1990 AND 2013
ON DUPLICATE KEY UPDATE 
    Year = VALUES(Year),
    Crop = VALUES(Crop),
    Yield_hg_ha = VALUES(Yield_hg_ha);
    
-- INSERT DATA INTO Pesticides_Final --
INSERT INTO Pesticides_Final (Country, Year, Pesticide_Use_tonnes)
SELECT DISTINCT Country, Year , value
FROM Pesticides_raw
WHERE year BETWEEN 1990 AND 2013
ON DUPLICATE KEY UPDATE  -- This prevents duplicates if you rerun the script
    Country = VALUES(Country),
    Year = VALUES(Year),
    Pesticide_Use_tonnes = VALUES(Pesticide_Use_tonnes);
    
-- INSERT DATA INTO Temperature_Final --
INSERT INTO Temperature_Final (Country, City, Year, Date, Avg_Temperature, AverageTemperatureUncertainty)
SELECT Country, City, Year(Date) AS Year, Date,AverageTemperature, AverageTemperatureUncertainty
FROM Temperature_raw
WHERE YEAR(Date) BETWEEN 1990 AND 2013
ON DUPLICATE KEY UPDATE  -- This prevents duplicates if you rerun the script
    country = Values(country),
    City = VALUES(City),
    Year = VALUES(Year),
    date = Values(Date),
    Avg_Temperature = VALUES(Avg_Temperature),
	AverageTemperatureUncertainty = VALUES(AverageTemperatureUncertainty);

-- INSERT DATA INTO GDP --
INSERT INTO GDP_Final (Country, Year, GDP_Billions)
SELECT Country, Year, Value
FROM GDP_raw

-- Eliminating mismatch between tables before Normalization --

-- Insert missing rows from yield_Final into Pesticides_Final to avoid orphaned rows
INSERT IGNORE INTO Pesticides_Final (Country, Year)
SELECT y.Country, y.Year
FROM Yield_Final y
LEFT JOIN Pesticides_Final p ON y.Country = p.Country AND y.Year = p.Year
WHERE p.Country IS NULL AND p.Year IS NULL

-- Insert missing rows from yield_Final into GDP_Final to avoid orphaned row
INSERT IGNORE INTO GDP_Final (Country, Year)
SELECT y.Country, y.Year
FROM Yield_Final y
LEFT JOIN GDP_Final g ON y.Country = g.Country AND y.Year = g.Year
WHERE g.Country IS NULL AND g.Year IS NULL;

-- Insert missing rows from Pesticides_Final into Temperature_Final to avoid orphaned row
INSERT INTO Temperature_Final (Country, Year)
SELECT p.Country, p.Year
FROM Pesticides_Final p
LEFT JOIN Temperature_Final t ON p.Country = t.Country AND p.Year = t.Year
WHERE t.Country IS NULL AND t.Year IS NULL;

SELECT * FROM Temperature_Final