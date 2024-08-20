CREATE DATABASE cocoa_chocolate;
-- ------------------------------------------------------database creation-------------------------------------------------------------------------------
CREATE TABLE cocoa (
    cocoa_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    company_name VARCHAR(100) NOT NULL,
    bean_origin VARCHAR(100) NOT NULL,
    review_year YEAR NOT NULL,
    cocoa_percent CHAR(5) NOT NULL,
    company_location VARCHAR(50) NOT NULL,
    rating DECIMAL(3 , 2 ) NOT NULL,
    bean_type VARCHAR(100) NOT NULL,
    broad_bean_origin VARCHAR(100) NOT NULL
);
-- ------------------------------------------------------------------------------------------------------------------------------------------------------
-- -----------------------------------------------------------feature engineering------------------------------------------------------------------------
SELECT company_location,
(CASE
    WHEN company_location IN ('U.S.A.' , 'mexico',
			 'canada',
			 'costa rica',
			 'guatemala',
			 'grenada',
			 'nicaragua') THEN 'north america'
    WHEN company_location IN ('Suriname' , 'peru',
			 'ecuador',
			 'brazil',
			 'venezuela',
			 'colombia',
			 'chile') THEN 'south america'
	WHEN company_location IN ('japan' , 'South Korea',
			 'singapore',
			 'vietnam',
			 'isreal',
			 'philippines') THEN 'asia'
	WHEN company_location IN ('sao tome' , 'south africa', 'ghana', 'madagascar') THEN 'africa'
	WHEN company_location IN ('fiji' , 'australia') THEN 'oceania'
	ELSE 'europe'
END) AS continent
FROM cocoa;

ALTER TABLE cocoa ADD COLUMN continent VARCHAR (100);
UPDATE cocoa 
SET continent = (CASE
        WHEN company_location IN ('U.S.A.' , 'mexico',
			 'canada',
			 'costa rica',
			 'guatemala',
			 'grenada',
			 'nicaragua') THEN 'north america'
         WHEN company_location IN ('Suriname' , 'peru',
			 'ecuador',
			 'brazil',
			 'venezuela',
			 'colombia',
			 'chile') THEN 'south america'
        WHEN company_location IN ('japan' , 'South Korea',
			 'singapore',
			 'vietnam',
			 'isreal',
			 'philippines') THEN 'asia'
        WHEN company_location IN ('sao tome' , 'south africa', 'ghana', 'madagascar') THEN 'africa'
        WHEN company_location IN ('fiji' , 'australia') THEN 'oceania'
        ELSE 'europe'
    END);

SELECT 
    rating,
    (CASE
        WHEN rating BETWEEN 1.0 AND 1.99 THEN 'unpleasant'
        WHEN rating BETWEEN 2.0 AND 2.99 THEN 'dissappoint'
        WHEN rating BETWEEN 3.0 AND 3.99 THEN 'satisfactory'
        WHEN rating BETWEEN 4.0 AND 4.99 THEN 'premium'
        WHEN rating = 5 THEN 'elite'
    END) AS rating_meaning
FROM
    cocoa;    
    
ALTER TABLE cocoa ADD COLUMN rating_meaning VARCHAR(20);
UPDATE cocoa 
SET 
    rating_meaning = (CASE
        WHEN rating BETWEEN 1.0 AND 1.99 THEN 'unpleasant'
        WHEN rating BETWEEN 2.0 AND 2.99 THEN 'dissappoint'
        WHEN rating BETWEEN 3.0 AND 3.99 THEN 'satisfactory'
        WHEN rating BETWEEN 4.0 AND 4.99 THEN 'premium'
        ELSE'elite'
    END); 
ALTER TABLE cocoa
drop column continent;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
-- ----------------------------------------------------------------cocoa EDA---------------------------------------------------------------------------
-- Which company has the highest-rated chocolate with the highest cocoa percentage?
SELECT company_name,
       rating,
       cocoa_percent
FROM cocoa
WHERE rating = (SELECT MAX(rating)
			    FROM cocoa)
           AND (SELECT MAX(cocoa_percent)
                FROM cocoa);
                
-- Can you tell me the average rating for chocolates from each broad bean origin?
SELECT broad_bean_origin, 
       AVG(rating) AS 'average rating'
FROM cocoa
GROUP BY broad_bean_origin;

-- What is the distribution of ratings for chocolates with different bean types?
SELECT bean_type, 
       COUNT(*), 
       MAX(rating), 
       MIN(rating)
FROM cocoa
GROUP BY bean_type;

-- Which company produces the most highly-rated chocolates from a specific bean origin?
SELECT company_name, 
       MAX(rating) AS 'max rating', 
       bean_origin
FROM cocoa
GROUP BY company_name ,bean_origin
ORDER BY 'max rating' DESC;

-- Can you provide me with a list of companies that have chocolates with a cocoa percentage above a certain threshold?
SELECT company_name, 
       cocoa_percent
FROM cocoa
WHERE cocoa_percent > '70%';

-- What is the average cocoa percentage for chocolates produced in each company location?
SELECT company_location, 
       AVG(cocoa_percent) AS 'average per'
FROM cocoa
GROUP BY company_location;

-- Can you give me the top 5 companies with the highest-rated chocolates overall?
SELECT company_name, 
       MAX(rating)
FROM cocoa
GROUP BY company_name
LIMIT 5;

-- which continent has the highest cocoa bean_type exports?
SELECT continent, 
	   COUNT(*) AS 'total count'
FROM cocoa
GROUP BY continent;

-- What is the average rating of cocoa bean quality across each continent?
SELECT continent, 
       AVG(rating) AS 'avg rating', 
       COUNT(*) AS count
FROM cocoa
GROUP BY continent
ORDER BY 'avg rating' DESC;

-- which countries produce the highest ratings?
SELECT company_location, 
       MAX(rating), 
       continent
FROM cocoa
GROUP BY company_location , continent
