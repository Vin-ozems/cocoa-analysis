# cocoa-chocolate-analysis
## Table of content
 - Project overview
 - Data source
 - Data description 
 - Tools 
 - Exploratory data analysis
 - Data analysis 
 - Results/Findings 
 - Recommendations
 - Limitations
 - Reference

### Overview
The project's goal is to explore the factors that influence the quality of chocolate, such as the origin of cocoa beans, the countries producing the highest-rated bars, and the relationship between cocoa solids percentage and ratings. This project analyzes a dataset of over 1,700 chocolate bars, focusing on expert ratings, cocoa origin, and cocoa percentage, It aim to identify key factors that contribute to high-quality chocolate by analyzing the relationships between cocoa bean origin, chocolate bar ratings, and cocoa percentage. The project seeks to uncover insights into where the best cocoa beans are grown and how these factors correlate with expert ratings, providing a deeper understanding of what makes certain chocolate bars superior.
This repository contains the SQL scripts and documentation for the cocoa/chocolate analysis project. The database is designed to manage information related to cocoa and their exportation across continents.

### Data description
- cocoa_id 
- company_name 
- bean_origin ,
- review_year 
- cocoa_percent 
- company_location 
- rating 
- bean_type 
- broad_bean_origin 

### Project process 

1. Database Creation: Execute the `create_database.sql` script to create the initial database.   
2. Table Creation: Run the `create_tables.sql` script to create the necessary tables.
3. Data Population using MYSQL import wizard
4. feature engineering
5. EDA cocoa/chocholate dataset

### Tools
SQL(MYSQL)

### Sample Queries
Here are some sample SQL queries to get you started:
1. What is the distribution of ratings for chocolates with different bean types?
```sql
SELECT bean_type, 
       COUNT(*), 
       MAX(rating),
       MIN(rating)
FROM cocoa
GROUP BY bean_type;
```

### Results/Findings 
### Recommendations
### Limitations
### Reference
   

