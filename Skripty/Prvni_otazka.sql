SELECT
  rok,
  COUNT(*) AS pocet_odvetvi,
  COUNT(CASE WHEN rozdil_mzdy > 0 THEN 1 END) AS pocet_rostoucich,
  COUNT(CASE WHEN rozdil_mzdy < 0 THEN 1 END) AS pocet_klesajicich,
  COUNT(CASE WHEN rozdil_mzdy = 0 THEN 1 END) AS pocet_bez_zmeny
FROM (
  SELECT
    t1.rok,
    t1.odvetvi_kod,
    t1.prumerna_mzda,
    t2.prumerna_mzda AS mzda_predchozi_rok,
    t1.prumerna_mzda - t2.prumerna_mzda AS rozdil_mzdy
  FROM t_lenka_krcmarikova_projekt_sql_primary_final t1
  LEFT JOIN t_lenka_krcmarikova_projekt_sql_primary_final t2
    ON t1.odvetvi_kod = t2.odvetvi_kod
    AND t1.rok = t2.rok + 1
  WHERE t1.prumerna_mzda IS NOT NULL AND t2.prumerna_mzda IS NOT NULL
  GROUP BY t1.rok, t1.odvetvi_kod, t1.prumerna_mzda, t2.prumerna_mzda
) rozdily
GROUP BY rok
ORDER BY rok;


SELECT DISTINCT
  t1.rok,
  t1.odvetvi_nazev,
  ROUND(t1.prumerna_mzda, 2) AS prumerna_mzda,
  ROUND(t2.prumerna_mzda, 2) AS mzda_predchozi_rok,
  ROUND(t1.prumerna_mzda - t2.prumerna_mzda, 2) AS rozdil_mzdy,
  ROUND((t1.prumerna_mzda - t2.prumerna_mzda) / t2.prumerna_mzda * 100, 2) AS procentualni_zmena
FROM t_lenka_krcmarikova_projekt_sql_primary_final t1
JOIN t_lenka_krcmarikova_projekt_sql_primary_final t2
  ON t1.odvetvi_kod = t2.odvetvi_kod
  AND t1.rok = t2.rok + 1
WHERE t1.prumerna_mzda < t2.prumerna_mzda
	AND t1.rok in (2009, 2010, 2011, 2013, 2014, 2015, 2016)
ORDER BY t1.rok, t1.odvetvi_nazev;