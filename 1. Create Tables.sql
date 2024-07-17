USE agrodb;

-- Create main tables --
-- Create the Pesticides table
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

-- Create the Temperature table
CREATE TABLE Temperature_Final (
    Temperature INT AUTO_INCREMENT PRIMARY KEY,
    Country VARCHAR(100),
    Year INT,
    Date DATE,
    Avg_Temperature DECIMAL(7, 3) NULL,
    AverageTemperatureUncertainty DECIMAL(7, 3) NULL,
    City VARCHAR(100)
);


-- Create Stage tables --

-- Create a Yield_raw Table
CREATE TABLE Yield_raw (
    DomainCode VARCHAR(100),
    Domain VARCHAR(100),
    CountryCode INT,
    Country VARCHAR(100),
    ElementCode INT,
    Element VARCHAR(100),
    ItemCode INT,
    Item VARCHAR(100),
    YearCode INT,
    Year INT,
    Unit VARCHAR(100),
    Value INT
);

-- Create Pesticide_raw table
CREATE TABLE Pesticides_raw (
    Domain VARCHAR(255),
    Country VARCHAR(255),
    Element VARCHAR(255),
    Item VARCHAR(255),
    Year INT,
    Unit VARCHAR(255),
    Value DECIMAL(10, 2)
);

 -- Create Temperature_raw table
  CREATE TABLE Temperature_raw (
    Date DATE,
    AverageTemperature DECIMAL(7, 3) NULL,
    AverageTemperatureUncertainty DECIMAL(7, 3) NULL,
    City VARCHAR(100),
    Country VARCHAR(100),
    Latitude VARCHAR(100),
    Longitude VARCHAR(100)
);

-- Create GDP_raw
CREATE TABLE GDP_raw (
    Country VARCHAR(100),
    Year INT,
    Value DECIMAL(15, 2)
);