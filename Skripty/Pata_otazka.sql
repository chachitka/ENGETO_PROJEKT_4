WITH hdp_roky AS (
    SELECT
        rok,
        ROUND(AVG(hdp_na_obyvatele), 2) AS prumerne_hdp
    FROM t_lenka_krcmarikova_projekt_SQL_secondary_final
    GROUP BY rok
),
mzdy_roky AS (
    SELECT
        rok,
        ROUND(AVG(prumerna_mzda), 2) AS prumerna_mzda
    FROM t_lenka_krcmarikova_projekt_sql_primary_final
    GROUP BY rok
),
ceny_roky AS (
    SELECT
        rok,
        ROUND(AVG(cena_potraviny), 2) AS prumerna_cena
    FROM t_lenka_krcmarikova_projekt_sql_primary_final
    GROUP BY rok
),
spojene AS (
    SELECT
        h.rok,
        h.prumerne_hdp,
        m.prumerna_mzda,
        c.prumerna_cena
    FROM hdp_roky h
    JOIN mzdy_roky m ON h.rok = m.rok
    JOIN ceny_roky c ON h.rok = c.rok
),
mezirocni_zmeny AS (
    SELECT
        t1.rok,
        t1.rok - 1 AS predchozi_rok,
        ROUND(((t1.prumerne_hdp - t2.prumerne_hdp) / t2.prumerne_hdp * 100), 2) AS zmena_hdp,
        ROUND(((t1.prumerna_mzda - t2.prumerna_mzda) / t2.prumerna_mzda * 100), 2) AS zmena_mzdy,
        ROUND(((t1.prumerna_cena - t2.prumerna_cena) / t2.prumerna_cena * 100), 2) AS zmena_cen
    FROM spojene t1
    JOIN spojene t2 ON t1.rok = t2.rok + 1
)
SELECT * FROM mezirocni_zmeny
WHERE zmena_hdp > 3 AND (zmena_mzdy > 5 OR zmena_cen > 5)
ORDER BY rok;



WITH hdp_roky AS (
    SELECT
        rok,
        ROUND(AVG(hdp_na_obyvatele), 2) AS prumerne_hdp
    FROM t_lenka_krcmarikova_projekt_SQL_secondary_final
    GROUP BY rok
),
mzdy_roky AS (
    SELECT
        rok,
        ROUND(AVG(prumerna_mzda), 2) AS prumerna_mzda
    FROM t_lenka_krcmarikova_projekt_sql_primary_final
    GROUP BY rok
),
ceny_roky AS (
    SELECT
        rok,
        ROUND(AVG(cena_potraviny), 2) AS prumerna_cena
    FROM t_lenka_krcmarikova_projekt_sql_primary_final
    GROUP BY rok
),
spojene AS (
    SELECT
        h.rok,
        h.prumerne_hdp,
        m.prumerna_mzda,
        c.prumerna_cena
    FROM hdp_roky h
    JOIN mzdy_roky m ON h.rok = m.rok
    JOIN ceny_roky c ON h.rok = c.rok
),
mezirocni_zmeny AS (
    SELECT
        t1.rok,
        t1.rok - 1 AS predchozi_rok,
        ROUND(((t1.prumerne_hdp - t2.prumerne_hdp) / t2.prumerne_hdp * 100), 2) AS zmena_hdp,
        ROUND(((t1.prumerna_mzda - t2.prumerna_mzda) / t2.prumerna_mzda * 100), 2) AS zmena_mzdy,
        ROUND(((t1.prumerna_cena - t2.prumerna_cena) / t2.prumerna_cena * 100), 2) AS zmena_cen,
        ROUND((((t1.prumerna_mzda - t2.prumerna_mzda) / t2.prumerna_mzda * 100) - ((t1.prumerne_hdp - t2.prumerne_hdp) / t2.prumerne_hdp * 100)), 2) AS rozdil_mzdy_hdp,
        ROUND((((t1.prumerna_cena - t2.prumerna_cena) / t2.prumerna_cena * 100) - ((t1.prumerne_hdp - t2.prumerne_hdp) / t2.prumerne_hdp * 100)), 2) AS rozdil_ceny_hdp
    FROM spojene t1
    JOIN spojene t2 ON t1.rok = t2.rok + 1
)
SELECT *
FROM mezirocni_zmeny
ORDER BY rok;


Pivotová tabulka

WITH hdp_roky AS (
    SELECT
        rok,
        ROUND(AVG(hdp_na_obyvatele), 2) AS prumerne_hdp
    FROM t_lenka_krcmarikova_projekt_SQL_secondary_final
    GROUP BY rok
),
mzdy_roky AS (
    SELECT
        rok,
        ROUND(AVG(prumerna_mzda), 2) AS prumerna_mzda
    FROM t_lenka_krcmarikova_projekt_sql_primary_final
    GROUP BY rok
),
ceny_roky AS (
    SELECT
        rok,
        ROUND(AVG(cena_potraviny), 2) AS prumerna_cena
    FROM t_lenka_krcmarikova_projekt_sql_primary_final
    GROUP BY rok
),
spojene AS (
    SELECT
        h.rok,
        h.prumerne_hdp,
        m.prumerna_mzda,
        c.prumerna_cena
    FROM hdp_roky h
    JOIN mzdy_roky m ON h.rok = m.rok
    JOIN ceny_roky c ON h.rok = c.rok
),
mezirocni_zmeny AS (
    SELECT
        t1.rok,
        ROUND(((t1.prumerne_hdp - t2.prumerne_hdp) / t2.prumerne_hdp * 100), 2) AS zmena_hdp,
        ROUND(((t1.prumerna_mzda - t2.prumerna_mzda) / t2.prumerna_mzda * 100), 2) AS zmena_mzdy,
        ROUND(((t1.prumerna_cena - t2.prumerna_cena) / t2.prumerna_cena * 100), 2) AS zmena_cen,
        ROUND((((t1.prumerna_mzda - t2.prumerna_mzda) / t2.prumerna_mzda * 100) -
               ((t1.prumerne_hdp - t2.prumerne_hdp) / t2.prumerne_hdp * 100)), 2) AS rozdil_mzdy_hdp,
        ROUND((((t1.prumerna_cena - t2.prumerna_cena) / t2.prumerna_cena * 100) -
               ((t1.prumerne_hdp - t2.prumerne_hdp) / t2.prumerne_hdp * 100)), 2) AS rozdil_ceny_hdp
    FROM spojene t1
    JOIN spojene t2 ON t1.rok = t2.rok + 1
)
SELECT
    rok,
    CONCAT(zmena_hdp, ' %') AS zmena_hdp,
    CONCAT(zmena_mzdy, ' %') AS zmena_mzdy,
    CONCAT(zmena_cen, ' %') AS zmena_cen,
    CONCAT(rozdil_mzdy_hdp, ' %') AS rozdil_mzdy_hdp,
    CONCAT(rozdil_ceny_hdp, ' %') AS rozdil_ceny_hdp
FROM mezirocni_zmeny
ORDER BY rok;

