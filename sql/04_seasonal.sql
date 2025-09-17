SELECT 
    Season,
    Category,
    SUM(PurchaseAmount) AS revenue,
    COUNT(*) AS transactions
FROM consumer_behavior.customer_purchases
GROUP BY Season, Category
ORDER BY Season, revenue DESC;

-- Colors
SELECT 
    Season,
    Colour,
    COUNT(*) AS purchases
FROM consumer_behavior.customer_purchases
GROUP BY Season, Colour
ORDER BY Season, purchases DESC;

-- Sizes
SELECT 
    Season,
    Size,
    COUNT(*) AS purchases
FROM consumer_behavior.customer_purchases
GROUP BY Season, Size
ORDER BY Season, purchases DESC;
