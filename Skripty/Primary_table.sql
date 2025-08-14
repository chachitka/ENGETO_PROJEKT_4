CREATE TABLE t_lenka_krcmarikova_projekt_SQL_primary_final AS
SELECT 
  mzdy.rok,
  mzdy.odvetvi_kod,
  mzdy.odvetvi_nazev,
  mzdy.prumerna_mzda,
  ceny.potravina,
  ceny.mnozstvi,
  ceny.jednotka,
  ceny.cena_potraviny
FROM (
  SELECT 
    cp.payroll_year AS rok,
    cp.industry_branch_code AS odvetvi_kod,
    cpib.name AS odvetvi_nazev,
    ROUND(AVG(cp.value)::numeric, 2) AS prumerna_mzda
  FROM czechia_payroll cp
  JOIN czechia_payroll_industry_branch cpib 
    ON cp.industry_branch_code = cpib.code
  WHERE cp.value_type_code = 5958
  GROUP BY cp.payroll_year, cp.industry_branch_code, cpib.name
) mzdy
JOIN (
  SELECT 
    EXTRACT(YEAR FROM cp.date_from) AS rok,
    cpc.name AS potravina,
    cpc.price_value AS mnozstvi,
    cpc.price_unit AS jednotka,
    ROUND(AVG(cp.value)::numeric, 2) AS cena_potraviny
  FROM czechia_price cp
  JOIN czechia_price_category cpc
    ON cp.category_code = cpc.code
  GROUP BY rok, cpc.name, cpc.price_value, cpc.price_unit
) ceny
  ON mzdy.rok = ceny.rok
ORDER BY mzdy.rok, mzdy.odvetvi_kod, ceny.potravina;