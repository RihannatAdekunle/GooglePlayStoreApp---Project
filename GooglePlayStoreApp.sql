----Analytical Questions

--Question 1 - What are the top 5 categories with the highest average app rating?

SELECT TOP 5 Category,AVG(rating) AS Average_rate
FROM googleplaystore$
GROUP BY Category 
ORDER BY Average_rate DESC;

-- Question 2 - Which apps have the highest number of installs across different genres

SELECT Genres,App,
CAST(REPLACE(Installs, ',', '') AS BIGINT) AS Installs
from googleplaystore$
ORDER by CAST(REPLACE(Installs, ',', '') AS BIGINT) DESC

--Question 3 - What is the most common Android version required for apps?

SELECT [Android Ver],COUNT(app) AS app_num
FROM googleplaystore$
GROUP BY [Android Ver]
ORDER BY app_num DESC

--Question 4 - Find the app with the highest number of installs in each category.

WITH highest_instal 
AS( 
SELECT App,category,
CAST(REPLACE(Installs, ',', '') AS BIGINT) AS Installs,
ROW_NUMBER() OVER (PARTITION BY category ORDER BY CAST(REPLACE(Installs, ',', '') AS BIGINT) DESC) AS cate
FROM googleplaystore$)
SELECT app,category,installs
FROM highest_instal
WHERE cate = 1;

--Question 5 - Identify apps that have a higher than average rating within their genre.

SELECT app,Genres,rating
FROM googleplaystore$
WHERE rating >(
	SELECT AVG(rating)
	FROM googleplaystore$);

--Question 6 - Calculate the percentage of free apps in each category

WITH app_count
AS(
SELECT Category,COUNT(*) AS total_app,
		COUNT(CASE WHEN Type = 'Free' then 1 END) free_app
FROM googleplaystore$
GROUP BY Category
)
SELECT category,total_app,free_app,
CONCAT((free_app * 100/total_app),'%') AS Percent_of_Free_App
FROM app_count;

--Question 7 - Top most expensive paid App
SELECT TOP 10 App,Category,MAX(price) AS ExpensiveApps
FROM googleplaystore$
GROUP BY App,Category
ORDER BY ExpensiveApps DESC


--Question 8 - What is the average price of paid apps, and which category has the highest number of paid apps?

SELECT CONCAT('$',AVG(price)) AS average_paid,Type,Category,COUNT(app) AS total_app
FROM googleplaystore$
WHERE Type = 'Paid'
GROUP BY category,Type 
ORDER BY total_app DESC

--Question 9 -  What is the rating distribution across different categories?

SELECT Category,COUNT(App) AS App_num,
Case WHEN Rating <= 1.9 THEN 'Poor'
	WHEN Rating <= 2.9 THEN 'Fair'
	WHEN Rating <= 3.9 THEN 'Good'
	WHEN Rating <= 4.9 THEN 'Very Good'
	ELSE 'Best'
	END AS Rate
FROM googleplaystore$
GROUP BY Category,
Case WHEN Rating <= 1.9 THEN 'Poor'
	WHEN Rating <= 2.9 THEN 'Fair'
	WHEN Rating <= 3.9 THEN 'Good'
	WHEN Rating <= 4.9 THEN 'Very Good'
	ELSE 'Best'
	END 
ORDER BY Category,Rate;

--Question 10 - Find the top 5 genres by total installs and analyze their growth trends by LastUpdated

WITH TopGenres 
AS(
SELECT TOP 5 Genres, SUM(CAST(Installs AS BIGINT)) AS TotalInstalls
FROM googleplaystore$
WHERE Installs IS NOT NULL
GROUP BY Genres
ORDER BY TotalInstalls DESC
)
SELECT g.Genres, YEAR([Last Updated]) AS YearUpdated, COUNT(App) AS AppCount, 
    SUM(CAST(Installs AS BIGINT)) AS TotalInstallsInYear,
    LAG(SUM(CAST(Installs AS BIGINT))) OVER (PARTITION BY g.Genres ORDER BY YEAR([Last Updated])) AS PreviousYearInstalls,
    SUM(CAST(Installs AS BIGINT)) - LAG(SUM(CAST(Installs AS BIGINT))) OVER (PARTITION BY g.Genres ORDER BY YEAR([Last Updated]))
	AS InstallGrowth
FROM googleplaystore$ AS g
INNER JOIN TopGenres AS tg ON g.Genres = tg.Genres
WHERE [Last Updated] IS NOT NULL
GROUP BY g.Genres, YEAR([Last Updated])
ORDER BY g.Genres, YearUpdated DESC;

--QUESTION 11 - Which categories have seen the most improvement in average ratings after their last update?
 
 WITH categoryrating
 AS(
 SELECT Category,
 AVG(Rating) AS Averate_rate,
 YEAR([Last Updated]) AS yearupdate
 FROM googleplaystore$
 GROUP BY Category,YEAR([Last Updated])
 ),
  CategoryRatingImprovement
  AS(
  SELECT category,Averate_rate,yearupdate,
  LAG(Averate_rate) OVER(PARTITION BY Category ORDER BY yearupdate) as PreviousAvgRating
  FROM categoryrating
  )

  SELECT Category,Averate_rate,yearupdate,PreviousAvgRating,
  (Averate_rate - PreviousAvgRating) AS RatingImprovement
  FROM CategoryRatingImprovement
  WHERE PreviousAvgRating IS NOT NULL
  ORDER BY RatingImprovement DESC;






 







