# Analýza dostupnosti potravin na základě průměrných příjmů za určité časové období

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
 
Projekt je určen jako ukázka praktického použití SQL jazyka a práce s databázemi.

---
## Obsah:

- [Datové zdroje](#datové_zdroje)
- [Výzkumné otázky](#výzkumné_otázky)
- [Struktura projektu](#struktura_projektu)
- [Motivace a cíl](#motivace-a-cíl)
- [Kontakt](#kontakt)

---

## Datové zdroje

1.	czechia_payroll – Informace o mzdách v různých odvětvích za několikaleté období. Datová sada pochází z Portálu otevřených dat ČR,
2.	czechia_payroll_industry_branch – Číselník odvětví v tabulce mezd, 
3.	czechia_price – Informace o cenách vybraných potravin za několikaleté období. Datová sada pochází z Portálu otevřených dat ČR,
4.	czechia_price_category – Číselník kategorií potravin, které se vyskytují v našem přehledu,
5. 	economies - HDP, GINI, daňová zátěž, atd. pro daný stát a rok.

---

## Výzkumné otázky

V projektu se hledaly odpovědi na otázky:

1.	Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?
2.	Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd? 
3.	Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)? 
4.	Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)? 
5.	Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo následujícím roce výraznějším růstem? 

---

## Struktura projektu

Projekt se skládá z následujících částí:

* Dvě tabulky, ze kterých se získávají pomocí dotazů informace:
 - t_lenka_krcmarikova_projekt_sql_primary_final 
   (pro data mezd a cen potravin za Českou republiku sjednocených totožné porovnatelné období),
 - t_lenka_krcmarikova_projekt_SQL_secondary_final 
   (pro dodatečná data o dalších evropských státech).

* Skripty pro jednotlivé výzkumné otázky - sada dotazů, které z tabulek získavají odpovědi na výzkumné otázky

---

## Motivace a cíl

Tento projekt vznikl v rámci studia jazyka SQL a práce s databázemi. Cíle byly:  

- Naučit se jazyk SQL a pracovat s databázemi,
- Získat zkušenosti s reálnými daty,
- Vyzkoušet tvorbu tabulek, používání jazyka SQL formou psaní dotazů na tabulky,
- Dokumentovat projekt pro prezentaci a budoucí využití.

---

## Kontakt

Pokud máš otázky nebo zpětnou vazbu:
📧 l.krcmarikova@seznam.cz 


---
Tento projekt je dostupný pod [MIT licencí](LICENSE).




