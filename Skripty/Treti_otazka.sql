WITH rocni_prumerne_ceny AS (
    SELECT
        rok,
        potravina,
        ROUND(AVG(cena_potraviny), 2) AS prumerna_cena
    FROM t_lenka_krcmarikova_projekt_sql_primary_final
    GROUP BY rok, potravina
),
mezirocni_zmena AS (
    SELECT
        t1.rok,
        t1.potravina,
        t1.prumerna_cena AS soucasna_cena,
        t2.prumerna_cena AS predchozi_cena,
        ROUND(((t1.prumerna_cena - t2.prumerna_cena) / t2.prumerna_cena * 100), 2) AS procentualni_zmena
    FROM rocni_prumerne_ceny t1
    LEFT JOIN rocni_prumerne_ceny t2
        ON t1.potravina = t2.potravina
        AND t1.rok = t2.rok + 1
    WHERE t2.prumerna_cena IS NOT null
)
SELECT
    potravina,
    ROUND(AVG(procentualni_zmena), 2) AS prumerna_mezirocni_zmena,
    COUNT(*) AS pocet_let
FROM mezirocni_zmena
--WHERE rok BETWEEN 2016 AND 2018 
GROUP BY potravina
HAVING COUNT(*) >= 5
ORDER BY prumerna_mezirocni_zmena;



