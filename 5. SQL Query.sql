## SQL Query 1
# The query below retrieves the crop, maximum yield value, country, and year for each crop from the yield table, ordered by year in descending order.
# It does this by first finding the maximum yield value for each crop in a subquery, 
# and then joining that subquery with the yield table to retrieve the rows where the yield value matches the maximum for that crop.

select yield.crop, top, country, year from
yield join
(select crop, max(yield_hg_ha) top from yield
group by crop) recs
on yield.yield_hg_ha = recs.top and yield.crop = recs.crop
order by year desc;

## SQL Query 2
# The query below retrieves the year, country, pesticide usage in tonnes, GDP in billions, and average temperature for each country and year, 
# filtered to include only years after 1989, non-zero pesticide usage, and non-empty average temperature values. The results are ordered by year in ascending order
# This query combines data from three different tables: pesticides, temperature, and GDP. 
# It allows analyzing the relationship between pesticide usage, average temperature, and GDP for each country and year. 
# By filtering for years after 1989 and non-zero pesticide usage, the query focuses on relevant data points.

select tpr.year, tpr.country, pp.Pesticide_Use_tonnes, gdp.GDP_Billions, tpr.avg_t  from
pesticides pp
join
(select country, year, avg(Avg_Temperature) avg_t from temperature
where year > 1989
group by country, year) tpr
on pp.country = tpr.country and pp.year = tpr.year
join gdp
on tpr.country = gdp.country and pp.year = gdp.year
where Pesticide_Use_tonnes > 0 and avg_t <> ""
order by year;

## SQL Query 3
# The third query calculates the correlation between pesticide usage (PesticideUse) and crop yield (Yield_hg_ha) for each combination of country and crop. 
# The correlation is calculated using the Pearson correlation coefficient formula, which involves summing the products of the deviations from the means (averages) 
# for pesticide usage and crop yield and dividing by the square root of the product of the sum of squared deviations for pesticide usage and crop yield.

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
