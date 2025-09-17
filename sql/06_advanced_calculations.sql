SELECT 
    CustomerID,
    SubscriptionStatus,
    SUM(PurchaseAmount) AS total_spent,
    COUNT(*) AS transactions,
    MAX(PreviousPurchases) AS prev_purchases
FROM consumer_behavior.customer_purchases
GROUP BY CustomerID, SubscriptionStatus;


SELECT 
    Location,
    AVG(PreviousPurchases) AS avg_prev_purchases,
    ROUND(AVG(ReviewRating),2) AS avg_rating,
    COUNT(*) AS transactions
FROM consumer_behavior.customer_purchases
GROUP BY Location
ORDER BY avg_prev_purchases ASC, avg_rating ASC;

SELECT 
    CustomerID,
    Category
FROM consumer_behavior.customer_purchases;
