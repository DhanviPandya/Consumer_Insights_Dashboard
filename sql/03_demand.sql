-- sql/03_demand.sql
SELECT 
    Location,
    Category,
    SUM(PurchaseAmount) AS revenue,
    COUNT(*) AS transactions
FROM consumer_behavior.customer_purchases
GROUP BY Location, Category
ORDER BY revenue DESC;

SELECT 
    Gender,
    COUNT(*) AS customers,
    ROUND(AVG(Age),1) AS avg_age,
    MIN(Age) AS min_age,
    MAX(Age) AS max_age
FROM consumer_behavior.customer_purchases
GROUP BY Gender;