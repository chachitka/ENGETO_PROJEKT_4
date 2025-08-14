WITH prumerne_mzdy AS (
    SELECT
        rok,
        ROUND(AVG(prumerna_mzda), 2) AS rocni_prumerna_mzda
    FROM t_lenka_krcmarikova_projekt_sql_primary_final
    GROUP BY rok
),
ceny_potravin AS (
    SELECT
        rok,
        potravina,
        jednotka,
        ROUND(AVG(cena_potraviny), 2) AS prumerna_cena
    FROM t_lenka_krcmarikova_projekt_sql_primary_final
    WHERE potravina IN ('Chléb konzumní kmínový', 'Mléko polotučné pasterované')
    GROUP BY rok, potravina, jednotka
),
hranice_let AS (
    SELECT MIN(rok) AS rok FROM t_lenka_krcmarikova_projekt_sql_primary_final
    UNION
    SELECT MAX(rok) AS rok FROM t_lenka_krcmarikova_projekt_sql_primary_final
)
SELECT
    m.rok,
    m.rocni_prumerna_mzda,
    p.potravina,
    p.prumerna_cena,
    p.jednotka,
    ROUND(m.rocni_prumerna_mzda / p.prumerna_cena, 2) AS kupni_sila
FROM prumerne_mzdy m
JOIN ceny_potravin p ON m.rok = p.rok
JOIN hranice_let h ON m.rok = h.rok
ORDER BY m.rok, p.potravina;


Pivotová tabulka

WITH prumerne_mzdy AS (
    SELECT
        rok,
        AVG(prumerna_mzda) AS rocni_prumerna_mzda
    FROM t_lenka_krcmarikova_projekt_sql_primary_final
    GROUP BY rok
),
ceny_potravin AS (
    SELECT
        rok,
        potravina,
        AVG(cena_potraviny) AS prumerna_cena
    FROM t_lenka_krcmarikova_projekt_sql_primary_final
    WHERE potravina IN ('Chléb konzumní kmínový', 'Mléko polotučné pasterované')
    GROUP BY rok, potravina
),
hranice_let AS (
    SELECT MIN(rok) AS rok FROM t_lenka_krcmarikova_projekt_sql_primary_final
    UNION
    SELECT MAX(rok) AS rok FROM t_lenka_krcmarikova_projekt_sql_primary_final
),
spojene AS (
    SELECT
        m.rok,
        m.rocni_prumerna_mzda,
        p.potravina,
        ROUND(m.rocni_prumerna_mzda / p.prumerna_cena, 2) AS kupni_sila
    FROM prumerne_mzdy m
    JOIN ceny_potravin p ON m.rok = p.rok
    JOIN hranice_let h ON m.rok = h.rok
)
SELECT
    rok,
    rocni_prumerna_mzda,
    MAX(CASE WHEN potravina = 'Chléb konzumní kmínový' THEN kupni_sila END) AS kupni_sila_chleba,
    MAX(CASE WHEN potravina = 'Mléko polotučné pasterované' THEN kupni_sila END) AS kupni_sila_mleka
FROM spojene
GROUP BY rok, rocni_prumerna_mzda
ORDER BY rok;


