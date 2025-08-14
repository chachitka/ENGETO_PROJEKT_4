CREATE TABLE t_lenka_krcmarikova_projekt_SQL_secondary_final AS
SELECT 
  e.year AS rok,
  e.country AS stat,
  ROUND(e.gdp::numeric / e.population::numeric, 2) AS hdp_na_obyvatele,
  e.population,
  ROUND(e.gdp::numeric, 2) AS hdp_celkem,
  ROUND(e.taxes::numeric, 2) AS danova_zatez,
  ROUND(e.fertility::numeric, 2) AS porodnost,
  ROUND(e.mortaliy_under5::numeric, 2) AS umrtnost_deti,
  ROUND(e.gini::numeric, 2) AS gini_koeficient
FROM economies e
JOIN countries c
  ON e.country = c.country
WHERE c.continent = 'Europe'
  AND e.gdp IS NOT NULL
  AND e.population IS NOT NULL
ORDER BY e.year, e.country;