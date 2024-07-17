
-- ADD FOREIGN KEY --

-- ADD FOREIGN KEY on Yield_Final to establish relationship with Pesticides_Final
ALTER TABLE Yield_Final
    ADD CONSTRAINT FK_Yield_Pest_Fin 
    FOREIGN KEY (Country, year) REFERENCES Pesticides_Final (Country, year);

-- ADD FOREIGN KEY on Yield_Final to establish relationship with GDP_Final
ALTER TABLE Yield_Final
ADD CONSTRAINT FK_Yield_GDP_Fin FOREIGN KEY (Country, year)
REFERENCES GDP_Final (Country, year);



-- ADD FOREIGN KEY on Pesticides_Final to establish relationship with Temperature_Final

CREATE INDEX idx_temp_country_year ON Temperature_Final (Country, year);

ALTER TABLE Pesticides_Final
ADD CONSTRAINT FK_Pest_Temp_Fin 
FOREIGN KEY (Country, Year) REFERENCES Temperature_Final (Country, Year);

    
