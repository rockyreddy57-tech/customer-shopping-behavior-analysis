-- Customer Shopping Behaviour: SQL queries
-- Table: shopping (3,900 rows)

-- Q1: Which categories generate the most revenue?
SELECT category,
       SUM(purchase_amount_usd) AS total_revenue,
       ROUND(AVG(purchase_amount_usd), 2) AS avg_spend,
       COUNT(*) AS orders
FROM shopping
GROUP BY category
ORDER BY total_revenue DESC;

-- Q2: What share of revenue does each category contribute?
SELECT category,
       SUM(purchase_amount_usd) AS revenue,
       ROUND(100.0 * SUM(purchase_amount_usd) / SUM(SUM(purchase_amount_usd)) OVER (), 1) AS pct_of_total
FROM shopping
GROUP BY category
ORDER BY revenue DESC;

-- Q3: Do subscribers spend more than non-subscribers?
SELECT subscription_status,
       COUNT(*) AS purchases,
       ROUND(AVG(purchase_amount_usd), 2) AS avg_spend
FROM shopping
GROUP BY subscription_status;

-- Q4: How are purchases split across spend segments?
SELECT CASE WHEN purchase_amount_usd >= 70 THEN 'High'
            WHEN purchase_amount_usd >= 40 THEN 'Medium'
            ELSE 'Low' END AS spend_segment,
       COUNT(*) AS purchases
FROM shopping
GROUP BY spend_segment
ORDER BY purchases DESC;

-- Q5: Which states have revenue above 5,500?
SELECT location, SUM(purchase_amount_usd) AS revenue
FROM shopping
GROUP BY location
HAVING SUM(purchase_amount_usd) > 5500
ORDER BY revenue DESC;

-- Q6: What are the top 3 items in each category?
WITH item_rev AS (
    SELECT category, item_purchased, SUM(purchase_amount_usd) AS revenue
    FROM shopping
    GROUP BY category, item_purchased
),
ranked AS (
    SELECT *, RANK() OVER (PARTITION BY category ORDER BY revenue DESC) AS rnk
    FROM item_rev
)
SELECT category, item_purchased, revenue, rnk
FROM ranked
WHERE rnk <= 3
ORDER BY category, rnk;

-- Q7: How does each season compare to the best season?
SELECT season,
       SUM(purchase_amount_usd) AS revenue,
       SUM(purchase_amount_usd) - MAX(SUM(purchase_amount_usd)) OVER () AS gap_vs_best
FROM shopping
GROUP BY season
ORDER BY revenue DESC;

-- Q8: Do discounts change spend or ratings?
SELECT discount_applied,
       COUNT(*) AS orders,
       ROUND(AVG(purchase_amount_usd), 2) AS avg_spend,
       ROUND(AVG(review_rating), 2) AS avg_rating
FROM shopping
GROUP BY discount_applied;

-- Q9: What is the gender mix within each age group?
WITH grp AS (
    SELECT age_group, gender, COUNT(*) AS n
    FROM shopping
    GROUP BY age_group, gender
)
SELECT age_group, gender, n,
       ROUND(100.0 * n / SUM(n) OVER (PARTITION BY age_group), 1) AS pct_within_age_group
FROM grp
ORDER BY age_group, gender;

-- Q10: Who are the top 5 customers by previous purchases?
SELECT customer_id, previous_purchases, purchase_amount_usd, subscription_status
FROM (
    SELECT *, ROW_NUMBER() OVER (ORDER BY previous_purchases DESC, purchase_amount_usd DESC) AS rn
    FROM shopping
)
WHERE rn <= 5;

