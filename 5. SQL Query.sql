## SQL Query 1
# The query below retrieves the crop, maximum yield value, country, and year for each crop from the yield table, ordered by year in descending order.
# It does this by first finding the maximum yield value for each crop in a subquery, 
# and then joining that subquery with the yield table to retrieve the rows where the yield value matches the maximum for that crop.

CREATE VIEW highest_yield_by_crop AS
SELECT yield.crop, recs.top, yield.country, yield.year
FROM yield
JOIN (
    SELECT crop, MAX(yield_hg_ha) AS top
    FROM yield
    GROUP BY crop
) recs
ON yield.yield_hg_ha = recs.top AND yield.crop = recs.crop
ORDER BY yield.year DESC;

## SQL Query 2
# The query below retrieves the year, country, pesticide usage in tonnes, GDP in billions, and average temperature for each country and year, 
# filtered to include only years after 1989, non-zero pesticide usage, and non-empty average temperature values. The results are ordered by year in ascending order
# This query combines data from three different tables: pesticides, temperature, and GDP. 
# It allows analyzing the relationship between pesticide usage, average temperature, and GDP for each country and year. 
# By filtering for years after 1989 and non-zero pesticide usage, the query focuses on relevant data points.

CREATE VIEW country_year_data AS
SELECT tpr.year, tpr.country, pp.Pesticide_Use_tonnes, gdp.GDP_Billions, tpr.avg_t
FROM pesticides pp
JOIN (
    SELECT country, year, AVG(Avg_Temperature) AS avg_t
    FROM temperature
    WHERE year > 1989
    GROUP BY country, year
) tpr
ON pp.country = tpr.country AND pp.year = tpr.year
JOIN gdp
ON tpr.country = gdp.country AND pp.year = gdp.year
WHERE pp.Pesticide_Use_tonnes > 0 AND tpr.avg_t <> ''
ORDER BY tpr.year;


## SQL Query 3
# The query below calculates the correlation between pesticide usage (PesticideUse) and crop yield (Yield_hg_ha) for each combination of country and crop. 
# The correlation is calculated using the Pearson correlation coefficient formula, which involves summing the products of the deviations from the means (averages) 
# ratings5ratings5for pesticide usage and crop yield and dividing by the square root of the product of the sum of squared deviations for pesticide usage and crop yield.

CREATE VIEW correlation_pesticide_yield AS
SELECT
    Country,
    Crop,
    (SUM((PesticideUse - avgPesticideUse) * (Yield_hg_ha - avgYield_hg_ha)) / 
     SQRT(SUM(POWER(PesticideUse - avgPesticideUse, 2)) * SUM(POWER(Yield_hg_ha - avgYield_hg_ha, 2)))) AS Correlation_Pest_Yield
FROM (
    SELECT
        Country,
        Crop,
        PesticideUse,
        Yield_hg_ha,
        AVG(PesticideUse) OVER (PARTITION BY Country, Crop) AS avgPesticideUse,
        AVG(Yield_hg_ha) OVER (PARTITION BY Country, Crop) AS avgYield_hg_ha
    FROM PesticideYield
) AS SubQuery
GROUP BY
    Country,
    Crop
HAVING
    Correlation_Pest_Yield IS NOT NULL;
