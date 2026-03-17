-- ============================================================
-- PROJECT   : OTT vs Shopping Behaviour in India
-- AUTHOR    : Nithya Kattimani 
-- TOOL      : PostgreSQL 18 | pgAdmin
-- DATASETS  : ott_views (10,000 rows) | ecom_orders (10,000 rows)
-- OBJECTIVE : Analyze whether OTT viewing habits correlate with
--             e-commerce shopping behaviour across Indian cities
-- ============================================================


-- Q1: Total views per platform
-- Concepts: COUNT, GROUP BY, ORDER BY

SELECT platform, COUNT(*) AS total_views
FROM ott_views
GROUP BY platform
ORDER BY total_views DESC;

-- INSIGHT: SonyLIV leads with 2,051 views. Distribution is fairly even
-- across all 5 platforms suggesting no single platform dominates in India.


-- ============================================================
-- Q2: Genre with highest average watch time
-- Concepts: AVG, ROUND, GROUP BY, ORDER BY

SELECT genre, ROUND(AVG(watch_minutes), 2) AS avg_watch_minutes
FROM ott_views
GROUP BY genre
ORDER BY avg_watch_minutes DESC;

-- INSIGHT: Horror has highest avg watch time at 133 mins. Sci-Fi lowest
-- at 127 mins possibly due to complex storylines causing drop-offs.


-- ============================================================
-- Q3: City with highest total revenue
-- Concepts: SUM, ROUND, GROUP BY, ORDER BY

SELECT city, ROUND(SUM(total_amount), 2) AS total_revenue
FROM ecom_orders
GROUP BY city
ORDER BY total_revenue DESC;

-- INSIGHT: Chennai leads at Rs.35.3L. Delhi ranks last despite being
-- a metro -- suggesting lower order frequency or smaller basket sizes.


-- ============================================================
-- Q4: Total orders placed by each gender
-- Concepts: COUNT, GROUP BY, ORDER BY

SELECT gender, COUNT(*) AS total_orders
FROM ecom_orders
GROUP BY gender
ORDER BY total_orders DESC;

-- INSIGHT: Helps identify dominant customer segment for
-- targeted marketing campaigns.


-- ============================================================
-- Q5: Most used device and average rating per device
-- Concepts: COUNT, AVG, ROUND, GROUP BY, ORDER BY

SELECT device,
       COUNT(*) AS total_views,
       ROUND(AVG(rating), 2) AS avg_rating
FROM ott_views
GROUP BY device
ORDER BY total_views DESC;

-- INSIGHT: Tablets lead in views at 2,524. Mobile users give highest
-- avg rating at 3.06 despite having lowest view count.


-- ============================================================
-- Q6: Top 5 most ordered products
-- Concepts: COUNT, GROUP BY, ORDER BY, LIMIT

SELECT product, COUNT(*) AS total_orders
FROM ecom_orders
GROUP BY product
ORDER BY total_orders DESC
LIMIT 5;

-- INSIGHT: All top 5 products are Electronics. Smartphones lead at
-- 401 orders -- valuable for inventory and marketing decisions.


-- ============================================================
-- Q7: Category revenue and percentage of total revenue
-- Concepts: SUM, Subquery, GROUP BY, ORDER BY

SELECT category,
       ROUND(SUM(total_amount), 2) AS total_revenue,
       ROUND(SUM(total_amount) * 100.0 /
           (SELECT SUM(total_amount) FROM ecom_orders), 2) AS percentage
FROM ecom_orders
GROUP BY category
ORDER BY total_revenue DESC;

-- INSIGHT: Home & Kitchen (25.6%) + Electronics (24.4%) = 50% of all
-- revenue. Groceries at just 2.8% suggests offline grocery preference.


-- ============================================================
-- Q8: Most popular payment method for orders above Rs.5000
-- Concepts: COUNT, WHERE, GROUP BY, ORDER BY

SELECT payment_method, COUNT(*) AS total_orders
FROM ecom_orders
WHERE total_amount > 5000
GROUP BY payment_method
ORDER BY total_orders DESC;

-- INSIGHT: Debit Card and Cash on Delivery tie at 433 orders each for
-- high value purchases. Credit Card surprisingly ranks 4th.


-- ============================================================
-- Q9: Users who both watched OTT and placed orders
-- Concepts: JOIN, DISTINCT, ORDER BY

SELECT DISTINCT o.user_id, o.city
FROM ott_views o
JOIN ecom_orders e ON o.user_id = e.user_id
ORDER BY o.city;

-- INSIGHT: 2,801 unique users appear in both datasets. These are the
-- most valuable users for cross-platform targeted marketing.


-- ============================================================
-- Q10: Total shopping spend by OTT genre watched
-- Concepts: JOIN, SUM, GROUP BY, ORDER BY

SELECT o.genre,
       ROUND(SUM(e.total_amount), 2) AS total_spend
FROM ott_views o
JOIN ecom_orders e ON o.user_id = e.user_id
GROUP BY o.genre
ORDER BY total_spend DESC;

-- INSIGHT: Action viewers spend the most at Rs.1.42Cr. Horror viewers
-- spend the least at Rs.1.30Cr. Difference is small across genres
-- suggesting consistent shopping behaviour regardless of content preference.


-- ============================================================
-- Q11: Rank cities by total revenue using window function
-- Concepts: RANK(), OVER, GROUP BY

SELECT city,
       ROUND(SUM(total_amount), 2) AS total_revenue,
       RANK() OVER (ORDER BY SUM(total_amount) DESC) AS revenue_rank
FROM ecom_orders
GROUP BY city;

-- INSIGHT: Chennai ranks #1 at Rs.35.4L. Delhi ranks last at Rs.28.6L.
-- Ranking helps business teams prioritize city-level marketing budgets.


-- ============================================================
-- Q12: Segment orders as High, Medium or Low value
-- Concepts: CASE WHEN, ORDER BY, LIMIT

SELECT order_id, total_amount,
       CASE WHEN total_amount > 5000 THEN 'High Value'
            WHEN total_amount > 3000 THEN 'Medium Value'
            ELSE 'Low Value'
       END AS order_segment
FROM ecom_orders
ORDER BY total_amount DESC
LIMIT 20;

-- INSIGHT: Top 20 orders all exceed Rs.17,000 indicating a strong
-- premium buyer segment for loyalty programs and exclusive offers.


-- ============================================================
-- Q13: Month-wise total revenue trend
-- Concepts: TO_CHAR, SUM, COUNT, GROUP BY, ORDER BY

SELECT TO_CHAR(order_date, 'YYYY-MM') AS order_month,
       ROUND(SUM(total_amount), 2) AS monthly_revenue,
       COUNT(*) AS total_orders
FROM ecom_orders
GROUP BY order_month
ORDER BY order_month ASC;

-- INSIGHT: Revenue is consistent between Rs.11.7L-15L monthly.
-- July 2022 peaks at Rs.15.05L. No strong seasonal trend suggesting
-- steady year-round demand.
