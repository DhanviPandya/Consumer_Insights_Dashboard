SELECT COUNT(*) AS total_rows FROM customer_purchases;

SELECT 
  SUM(CASE WHEN CustomerID IS NULL THEN 1 ELSE 0 END) AS null_customerid,
  SUM(CASE WHEN Age IS NULL THEN 1 ELSE 0 END) AS null_age,
  SUM(CASE WHEN Gender IS NULL THEN 1 ELSE 0 END) AS null_gender,
  SUM(CASE WHEN ItemPurchased IS NULL THEN 1 ELSE 0 END) AS null_item,
  SUM(CASE WHEN Category IS NULL THEN 1 ELSE 0 END) AS null_category,
  SUM(CASE WHEN PurchaseAmount IS NULL THEN 1 ELSE 0 END) AS null_purchaseamount,
  SUM(CASE WHEN Location IS NULL THEN 1 ELSE 0 END) AS null_location,
  SUM(CASE WHEN Size IS NULL THEN 1 ELSE 0 END) AS null_size,
  SUM(CASE WHEN Colour IS NULL THEN 1 ELSE 0 END) AS null_color,
  SUM(CASE WHEN Season IS NULL THEN 1 ELSE 0 END) AS null_season,
  SUM(CASE WHEN ReviewRating IS NULL THEN 1 ELSE 0 END) AS null_review,
  SUM(CASE WHEN SubscriptionStatus IS NULL THEN 1 ELSE 0 END) AS null_subscription,
  SUM(CASE WHEN ShippingType IS NULL THEN 1 ELSE 0 END) AS null_shipping,
  SUM(CASE WHEN DiscountApplied IS NULL THEN 1 ELSE 0 END) AS null_discount,
  SUM(CASE WHEN PromoCodeUsed IS NULL THEN 1 ELSE 0 END) AS null_promocode,
  SUM(CASE WHEN PreviousPurchases IS NULL THEN 1 ELSE 0 END) AS null_previouspurchases,
  SUM(CASE WHEN PaymentMethod IS NULL THEN 1 ELSE 0 END) AS null_paymentmethod,
  SUM(CASE WHEN FrequencyOfPurchase IS NULL THEN 1 ELSE 0 END) AS null_frequency
FROM customer_purchases;

-- CustomerID should be unique and positive
SELECT MIN(CustomerID) AS min_id, MAX(CustomerID) AS max_id, COUNT(DISTINCT CustomerID) AS unique_ids
FROM customer_purchases;

-- Age: check for unrealistic ages (e.g., <10 or >100)
SELECT MIN(Age) AS min_age, MAX(Age) AS max_age 
FROM customer_purchases;

-- Purchase Amount (USD): look for negative or abnormally large amounts
SELECT MIN(`PurchaseAmount`) AS min_amount, MAX(`PurchaseAmount`) AS max_amount
FROM customer_purchases;

-- Review Rating: should be between 0 and 5
SELECT MIN(`ReviewRating`) AS min_rating, MAX(`ReviewRating`) AS max_rating
FROM customer_purchases;

-- Previous Purchases: look for negative or extremely high values
SELECT MIN(`PreviousPurchases`) AS min_prev, MAX(`PreviousPurchases`) AS max_prev 
FROM customer_purchases;

-- Gender: expect "Male", "Female" (maybe others if intended)
SELECT DISTINCT Gender FROM customer_purchases;

-- Category: clothing, footwear, outerwear, etc.
SELECT DISTINCT Category FROM customer_purchases;

-- Season: expect Winter, Spring, Summer, Fall
SELECT DISTINCT Season FROM customer_purchases;

-- Size: check for consistent options like S, M, L, XL
SELECT DISTINCT Size FROM customer_purchases;

-- Color: look for typos or inconsistent spellings
SELECT DISTINCT Colour FROM customer_purchases;

-- Subscription Status: likely Yes/No
SELECT DISTINCT `SubscriptionStatus` FROM customer_purchases;

-- Shipping Type: e.g., Standard, Express, Free Shipping
SELECT DISTINCT `ShippingType` FROM customer_purchases;

-- Discount Applied: expect Yes/No
SELECT DISTINCT `DiscountApplied` FROM customer_purchases;

-- Promo Code Used: expect Yes/No
SELECT DISTINCT `PromoCodeUsed` FROM customer_purchases;

-- Payment Method: e.g., PayPal, Credit Card, Venmo, Cash, Bank Transfer
SELECT DISTINCT `PaymentMethod` FROM customer_purchases;

-- Frequency of Purchases: e.g., Weekly, Monthly, Quarterly
SELECT DISTINCT `FrequencyOfPurchase` FROM customer_purchases;

-- Location: check for unique states/regions
SELECT DISTINCT Location FROM customer_purchases;

