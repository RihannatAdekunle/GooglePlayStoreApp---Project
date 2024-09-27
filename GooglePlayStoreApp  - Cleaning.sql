--Updating the null value in rating column to average rating 
UPDATE googleplaystore$
SET Rating = (SELECT AVG(rating) FROM googleplaystore$ WHERE Rating IS NOT NULL)
WHERE Rating is NULL;

--updating the null review column to zero
UPDATE googleplaystore$
SET Reviews = 0 
WHERE Reviews IS NULL;

-- Remove leading/trailing spaces in Size Column
UPDATE googleplaystore$
SET Size = LTRIM(RTRIM(Size));  

---convert and updating size column from Varchar to float data type
UPDATE googleplaystore$
SET Size = CASE
    WHEN Size LIKE '%M' THEN CAST(REPLACE(Size, 'M', '') AS FLOAT)
    WHEN Size LIKE '%k' THEN CAST(REPLACE(Size, 'k', '') AS FLOAT) / 1024  
    ELSE NULL  
END
WHERE Size IS NOT NULL AND Size NOT LIKE '%Varies%';

SELECT DISTINCT size FROM googleplaystore$;

---Removing the + sign in install column
UPDATE googleplaystore$
SET Installs = REPLACE(REPLACE(Installs, '+', ''), ',', '');

 --Remove leading/trailing spaces
UPDATE googleplaystore$
SET Installs= LTRIM(RTRIM(Installs)); 

-- Convert and updating Installs to INT using TRY_CAST() 
UPDATE googleplaystore$
SET Installs = TRY_CAST(Installs AS INT)
WHERE TRY_CAST(Installs AS INT) IS NOT NULL;

SELECT DISTINCT Installs FROM googleplaystore$;

--Standizing price column
UPDATE googleplaystore$
SET Price = CASE 
			WHEN Price LIKE 'Free' THEN '0' 
			ELSE REPLACE(Price, '$', '')
			END;

--Remove duplicate
WITH duplicate AS (
    SELECT *,
           ROW_NUMBER() OVER(PARTITION BY App, Category, Rating ORDER BY (SELECT NULL)) AS rn
    FROM googleplaystore$
)
DELETE FROM duplicate WHERE rn > 1;

--Delete Null rows in the app column
DELETE FROM googleplaystore$
WHERE App IS NULL;

--Convert and updating last update Coulmn to Date type
UPDATE googleplaystore$
SET [Last Updated] = CONVERT(DATE, [Last Updated], 120);

--Cleaning the Android Version column while preserving "Varies with device"
UPDATE googleplaystore$
SET [Android Ver] = CASE
    WHEN [Android Ver] = 'Varies with device' THEN [Android Ver]
    ELSE SUBSTRING([Android Ver], 1, CHARINDEX(' ', [Android Ver] + ' ') - 1)
END
WHERE [Android Ver] != 'Varies with device'; 

-- Clean the AndroidVer column further by removing any text after the numeric value
UPDATE googleplaystore$
SET [Android Ver] = LEFT([Android Ver], PATINDEX('%[^0-9.]%', [Android Ver] + ' ') - 1)
WHERE [Android Ver] NOT LIKE '%Varies%';

-- Convert the cleaned numeric values to a numeric format (FLOAT)
UPDATE googleplaystore$
SET [Android Ver] = CAST([Android Ver] AS FLOAT)
WHERE [Android Ver] NOT LIKE '%Varies%' AND ISNUMERIC([Android Ver]) = 1;