-- 1. Selezionare tutte le nazioni il cui nome inizia con la P e la cui area è maggiore di 1000 kmq
SELECT name
FROM countries c
WHERE name LIKE 'P%' AND area > 1000; 
-- 2. Contare quante nazioni sono presenti nel database
SELECT COUNT(*)
FROM countries;
-- 3. Selezionare il nome delle regioni del continente europeo, in ordine alfabetico
SELECT r.name
FROM regions r
JOIN continents c ON r.continent_id = c.continent_id
WHERE c.name = 'Europe'
ORDER BY r.name;
-- 4. Contare quante regioni sono presenti nel continente Africa
SELECT c.name, COUNT(r.region_id) AS region_count
FROM continents c
JOIN regions r ON c.continent_id = r.continent_id
WHERE c.name = 'Africa';
-- 5. Selezionare quali nazioni non hanno un national day
SELECT name
FROM countries c
WHERE national_day IS null;
-- 6. Per ogni nazione, in ordine alfabetico, selezionare il nome, la regione e il continente
SELECT c.name AS countries_name , r.name AS region_name, con.name AS continents_name
FROM countries c
JOIN regions r ON c.region_id = r.region_id
JOIN continents con ON r.continent_id = con.continent_id
ORDER BY c.name;
-- 7. Selezionare le lingue ufficiali dell’Albania
SELECT l.`language`  
FROM country_languages cl
JOIN countries c ON cl.country_id = c.country_id
JOIN languages l ON cl.language_id  = l.language_id 
WHERE c.name = 'Albania' AND cl.official = 1;
-- 8. Selezionare il Gross domestic product (GDP) medio dello United Kingdom tra il 2000 e il 2010
SELECT AVG (cs.gdp)
FROM country_stats cs
JOIN countries c ON cs.country_id = c.country_id
WHERE c.name = 'United Kingdom' AND (cs.`year` >= 2000 AND cs.`year`<=2010);
-- 9. Selezionare tutte le nazioni in cui si parla hindi, ordinate dalla più estesa alla meno estesa
SELECT c.name 
FROM countries c
JOIN country_languages cl ON c.country_id = cl.country_id
JOIN languages l ON cl.language_id = l.language_id
WHERE l.`language` = 'Hindi'
ORDER BY c.area DESC;
-- 10. Modificare la nazione di nome Italy, inserendo come national day il 2 giugno 1946
UPDATE country
SET national_day = '1946-06-02'
WHERE name = 'Italy';
-- BONUUS
-- 11. Selezionare le nazioni il cui national day è avvenuto prima del 1900, ordinate per national day dal più recente al meno recente
SELECT c.name , c.national_day 
FROM countries c  
WHERE YEAR(national_day) < 1900
ORDER BY national_day DESC;
-- 12. Contare quante lingue sono parlate in Italia
SELECT COUNT(DISTINCT language_id) AS lingue_parlate_in_italia
FROM countries c
JOIN country_languages cl ON c.country_id = cl.country_id
WHERE c.name = 'Italy';
-- 13. Per la regione Antarctica mostrare il valore dell’area totale e dell’area media delle nazioni
SELECT SUM(area) AS total_area, AVG(area) AS average_area
FROM countries 
JOIN regions ON countries.region_id = regions.region_id
WHERE regions.name = 'Antarctica';
