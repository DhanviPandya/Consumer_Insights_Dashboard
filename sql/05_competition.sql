SELECT 
    DiscountApplied,
    PromoCodeUsed,
    COUNT(*) AS transactions,
    SUM(PurchaseAmount) AS revenue,
    ROUND(AVG(PurchaseAmount),2) AS avg_order_value
FROM consumer_behavior.customer_purchases
GROUP BY DiscountApplied, PromoCodeUsed
ORDER BY revenue DESC;

SELECT 
    ShippingType,
    ROUND(AVG(ReviewRating),2) AS avg_rating,
    COUNT(*) AS reviews
FROM consumer_behavior.customer_purchases
GROUP BY ShippingType
ORDER BY avg_rating ASC;

SELECT 
    PaymentMethod,
    COUNT(*) AS transactions,
    SUM(PurchaseAmount) AS revenue
FROM consumer_behavior.customer_purchases
GROUP BY PaymentMethod
ORDER BY transactions DESC;
