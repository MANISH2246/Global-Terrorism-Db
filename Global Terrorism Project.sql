show databases;
use global_terrorism;
select  * from globalterrorism;


1. Find the total number of terrorist events in the dataset.
SELECT COUNT(*) AS TotalEvents FROM globalterrorism;

2. List the top 10 countries with the most terrorist events.
SELECT Country, COUNT(*) AS EventCount
FROM globalterrorism
GROUP BY Country
ORDER BY EventCount DESC
LIMIT 10;

3. Calculate the percentage of events that occurred in each region.
SELECT Region, COUNT(*) AS EventCount,
       (COUNT(*) * 100.0 / (SELECT COUNT(*) FROM globalterrorism)) AS Percentage
FROM globalterrorism
GROUP BY Region;

4. Find the most common weapon types used in terrorist events.
SELECT WeaponType, COUNT(*) AS WeaponCount
FROM globalterrorism
GROUP BY WeaponType
ORDER BY WeaponCount DESC;

5. List the countries with the highest number of terrorist events in a specific month.
SELECT Month, Country, COUNT(*) AS EventCount
FROM globalterrorism
WHERE Month = 4
GROUP BY Month, Country
ORDER BY EventCount DESC;

6. Identify the years with the highest and lowest numbers of terrorist events.
SELECT Year, COUNT(*) AS EventCount
FROM globalterrorism
GROUP BY Year
ORDER BY EventCount DESC;

7. Find the most common targets of terrorist attacks.
SELECT Target, COUNT(*) AS TargetCount
FROM globalterrorism
GROUP BY Target
ORDER BY TargetCount DESC;

8. List the states with the highest number of terrorist events in a specific country.
SELECT Country, State, COUNT(*) AS EventCount
FROM globalterrorism
WHERE Country = 'United States'
GROUP BY Country, State
ORDER BY EventCount DESC;

9. Calculate the average number Attacks for each gang.
SELECT GangName, count(AttackType) AS Attacks
FROM globalterrorism
GROUP BY GangName;

10. Calculate the total number of events for each combination of attacktype and weapontype.
SELECT AttackType, WeaponType, COUNT(*) AS EventCount
FROM globalterrorism
GROUP BY AttackType, WeaponType;

11. Calculate the year-over-year percentage change in the number of terrorist events for each country.
SELECT Country, Year,
       100 * (COUNT(*) - LAG(COUNT(*)) OVER (PARTITION BY Country ORDER BY Year)) / 
       LAG(COUNT(*)) OVER (PARTITION BY Country ORDER BY Year) AS EventChangePercentage
FROM globalterrorism
GROUP BY Country, Year
ORDER BY Country, Year;

12. Find the countries where terrorist events have been increasing consistently for the last three years.
WITH EventChanges AS (
    SELECT Country, Year,
           100 * (COUNT(*) - LAG(COUNT(*)) OVER (PARTITION BY Country ORDER BY Year)) / 
           LAG(COUNT(*)) OVER (PARTITION BY Country ORDER BY Year) AS EventChangePercentage
    FROM globalterrorism
    GROUP BY Country, Year
)
SELECT Country
FROM EventChanges
WHERE EventChangePercentage > 0
GROUP BY Country
HAVING COUNT(*) = 3;

13. Calculate the cumulative number of Weapon over time, considering different regions.
SELECT Region, Year, 
       SUM(Weapon) OVER (PARTITION BY Region ORDER BY Year) AS CumulativeWeapon
FROM globalterrorism
ORDER BY Region, Year;

14. Identify temporal patterns in terrorist events using a time series analysis.
SELECT Year, Month, 
       AVG(COUNT(*)) OVER (ORDER BY Year, Month ROWS BETWEEN 2 PRECEDING AND 2 FOLLOWING) AS AvgEventCount
FROM globalterrorism
GROUP BY Year, Month
ORDER BY Year, Month;

15.showing the count of occurrences for each attack type, 
SELECT AttackType, COUNT(*) AS AttackCount
FROM globalterrorism
GROUP BY AttackType
ORDER BY AttackCount DESC;


