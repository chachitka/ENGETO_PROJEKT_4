WITH prumerne_ceny_potravin AS (
    SELECT
        rok,
        ROUND(AVG(cena_potraviny), 2) AS prumerna_cena
    FROM t_lenka_krcmarikova_projekt_sql_primary_final
    GROUP BY rok
),
prumerne_mzdy AS (
    SELECT
        rok,
        ROUND(AVG(prumerna_mzda), 2) AS prumerna_mzda
    FROM t_lenka_krcmarikova_projekt_sql_primary_final
    GROUP BY rok
),
ceny_a_mzdy AS (
    SELECT
        c.rok,
        c.prumerna_cena,
        m.prumerna_mzda
    FROM prumerne_ceny_potravin c
    JOIN prumerne_mzdy m ON c.rok = m.rok
),
mezirocni_zmeny AS (
    SELECT
        t1.rok,
        ROUND(((t1.prumerna_cena - t2.prumerna_cena) / t2.prumerna_cena * 100), 2) AS procentualni_zmena_cen,
        ROUND(((t1.prumerna_mzda - t2.prumerna_mzda) / t2.prumerna_mzda * 100), 2) AS procentualni_zmena_mezd,
        ROUND(((t1.prumerna_cena - t2.prumerna_cena) / t2.prumerna_cena * 100)
             - ((t1.prumerna_mzda - t2.prumerna_mzda) / t2.prumerna_mzda * 100), 2) AS rozdil
    FROM ceny_a_mzdy t1
    JOIN ceny_a_mzdy t2 ON t1.rok = t2.rok + 1
)
SELECT
    rok,
    procentualni_zmena_cen,
    procentualni_zmena_mezd,
    rozdil
FROM mezirocni_zmeny
WHERE rozdil > 10
ORDER BY rok;