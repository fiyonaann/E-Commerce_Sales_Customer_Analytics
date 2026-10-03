-- E-Commerce Sales & Customer Analysis
-- SQL Analysis Queries

-- What is the overall order status distribution?
SELECT 
    order_status,
    COUNT(*) AS total_orders
FROM orders
GROUP BY order_status
ORDER BY total_orders DESC;

-- How many orders were placed in each year?
SELECT 
    YEAR(order_purchase_timestamp) AS order_year,
    COUNT(*) AS total_orders
FROM orders
GROUP BY YEAR(order_purchase_timestamp)
ORDER BY order_year;

-- Which months had the highest number of orders?
SELECT
    YEAR(order_purchase_timestamp) AS order_year,
    MONTH(order_purchase_timestamp) AS order_month,
    COUNT(*) AS total_orders
FROM orders
GROUP BY
    YEAR(order_purchase_timestamp),
    MONTH(order_purchase_timestamp)
ORDER BY total_orders DESC;

-- How many unique customers placed orders?
SELECT COUNT(DISTINCT customer_id) AS unique_customers
FROM orders;

-- Which customers placed more than one order?
SELECT 
    customer_id,
    COUNT(*) AS total_orders
FROM orders
GROUP BY customer_id
HAVING COUNT(*) > 1
ORDER BY total_orders DESC;

-- how many customers placed 2, 3, 4+ orders
SELECT
    total_orders,
    COUNT(*) AS number_of_customers
FROM (
    SELECT customer_id, COUNT(*) AS total_orders
    FROM orders
    GROUP BY customer_id
) AS customer_orders
GROUP BY total_orders
ORDER BY total_orders;

-- Total revenue, average order value & highest order value
SELECT
    SUM(payment_value) AS total_revenue,
    AVG(payment_value) AS average_order_value,
    MAX(payment_value) AS highest_order_value
FROM payments;

-- Revenue by payment type
SELECT
    payment_type,
    COUNT(*) AS total_payments,
    SUM(payment_value) AS total_revenue,
    AVG(payment_value) AS average_payment
FROM payments
GROUP BY payment_type
ORDER BY total_revenue DESC;

-- Which product categories generate the most revenue?
SELECT
    p.product_category_name,
    COUNT(oi.order_id) AS total_items_sold,
    SUM(oi.price) AS total_revenue
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
GROUP BY p.product_category_name
ORDER BY total_revenue DESC;

-- Top 10 revenue-generating categories.
SELECT
    ct.product_category_name_english AS category,
    COUNT(oi.order_id) AS items_sold,
    SUM(oi.price) AS revenue
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
JOIN category_translation ct
    ON p.product_category_name = ct.product_category_name
GROUP BY ct.product_category_name_english
ORDER BY revenue DESC
LIMIT 10;

-- Which product categories have the highest average price?
SELECT
    ct.product_category_name_english AS category,
    COUNT(oi.order_id) AS items_sold,
    ROUND(AVG(oi.price), 2) AS average_price
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
JOIN category_translation ct
    ON p.product_category_name = ct.product_category_name
GROUP BY ct.product_category_name_english
ORDER BY average_price DESC
LIMIT 10;

-- Payment method performance
SELECT
    payment_type,
    COUNT(*) AS total_payments,
    ROUND(SUM(payment_value), 2) AS total_revenue,
    ROUND(AVG(payment_value), 2) AS average_payment
FROM payments
GROUP BY payment_type
ORDER BY total_revenue DESC;

-- Review score distribution
SELECT
    review_score,
    COUNT(*) AS total_reviews
FROM reviews
GROUP BY review_score
ORDER BY review_score;

-- Overall average customer rating
SELECT
    ROUND(AVG(review_score), 2) AS average_review_score
FROM reviews;

-- Average delivery time
SELECT
    ROUND(
        AVG(
            DATEDIFF(
                order_delivered_customer_date,
                order_purchase_timestamp
            )
        ), 2
    ) AS average_delivery_days
FROM orders
WHERE order_delivered_customer_date IS NOT NULL;

-- Late delivery analysis
SELECT
    COUNT(*) AS late_deliveries
FROM orders
WHERE order_delivered_customer_date IS NOT NULL
  AND order_delivered_customer_date > order_estimated_delivery_date;
  
  -- Late delivery percentage
SELECT
    ROUND(
        100.0 * SUM(
            CASE
                WHEN order_delivered_customer_date > order_estimated_delivery_date
                THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS late_delivery_percentage
FROM orders
WHERE order_delivered_customer_date IS NOT NULL;

-- Late delivery percentage by year
SELECT
    YEAR(order_purchase_timestamp) AS order_year,
    ROUND(
        100.0 * SUM(
            CASE
                WHEN order_delivered_customer_date > order_estimated_delivery_date
                THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS late_delivery_percentage
FROM orders
WHERE order_delivered_customer_date IS NOT NULL
GROUP BY YEAR(order_purchase_timestamp)
ORDER BY order_year;

-- Payment method performance
SELECT
    payment_type,
    COUNT(*) AS total_payments,
    ROUND(SUM(payment_value), 2) AS total_revenue,
    ROUND(AVG(payment_value), 2) AS average_payment
FROM payments
GROUP BY payment_type
ORDER BY total_revenue DESC;

-- Review score distribution
SELECT
    review_score,
    COUNT(*) AS total_reviews
FROM reviews
GROUP BY review_score
ORDER BY review_score;

-- Top 10 products by revenue
SELECT
    oi.product_id,
    COUNT(oi.order_id) AS items_sold,
    ROUND(SUM(oi.price), 2) AS total_revenue
FROM order_items oi
GROUP BY oi.product_id
ORDER BY total_revenue DESC
LIMIT 10;

-- Top 10 product categories by revenue
SELECT
    p.product_category_name AS category,
    COUNT(oi.order_id) AS items_sold,
    ROUND(SUM(oi.price), 2) AS total_revenue
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
GROUP BY p.product_category_name
ORDER BY total_revenue DESC
LIMIT 10;

-- Top 10 categories by average product price
SELECT
    ct.product_category_name_english AS category,
    COUNT(oi.order_id) AS items_sold,
    ROUND(AVG(oi.price), 2) AS average_price
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
JOIN category_translation ct
    ON p.product_category_name = ct.product_category_name
GROUP BY ct.product_category_name_english
ORDER BY average_price DESC
LIMIT 10;

-- Top 10 sellers by revenue
SELECT
    oi.seller_id,
    COUNT(oi.order_id) AS items_sold,
    ROUND(SUM(oi.price), 2) AS total_revenue
FROM order_items oi
GROUP BY oi.seller_id
ORDER BY total_revenue DESC
LIMIT 10;

-- Average order value by seller
SELECT
    oi.seller_id,
    COUNT(oi.order_id) AS items_sold,
    ROUND(AVG(oi.price), 2) AS average_order_value
FROM order_items oi
GROUP BY oi.seller_id
ORDER BY average_order_value DESC
LIMIT 10;

-- Customer order frequency
SELECT
    customer_id,
    COUNT(order_id) AS total_orders
FROM orders
GROUP BY customer_id
ORDER BY total_orders DESC
LIMIT 10;

-- Customers who placed more than one order
SELECT
    customer_id,
    COUNT(order_id) AS total_orders
FROM orders
GROUP BY customer_id
HAVING COUNT(order_id) > 1
ORDER BY total_orders DESC;

-- Total revenue by customer
SELECT
    o.customer_id,
    ROUND(SUM(p.payment_value), 2) AS total_spent
FROM orders o
JOIN payments p
    ON o.order_id = p.order_id
GROUP BY o.customer_id
ORDER BY total_spent DESC
LIMIT 10;

-- Average spending per customer
SELECT
    o.customer_id,
    ROUND(AVG(p.payment_value), 2) AS average_spent
FROM orders o
JOIN payments p
    ON o.order_id = p.order_id
GROUP BY o.customer_id
ORDER BY average_spent DESC
LIMIT 10;

-- Overall average order value
SELECT ROUND(AVG(payment_value), 2) AS average_order_value FROM payments;

-- Total number of orders
SELECT COUNT(*) AS total_orders FROM orders;

-- Total number of customers
SELECT COUNT(*) AS total_customers FROM customers;

-- Total number of products
SELECT COUNT(*) AS total_products FROM products;

-- Total number of sellers
SELECT COUNT(*) AS total_sellers FROM sellers;

-- Total number of reviews
SELECT COUNT(*) AS total_reviews FROM reviews;

-- Total number of product categories
SELECT COUNT(DISTINCT product_category_name) AS total_categories FROM products;

-- Monthly revenue trend
SELECT
    YEAR(o.order_purchase_timestamp) AS order_year,
    MONTH(o.order_purchase_timestamp) AS order_month,
    ROUND(SUM(p.payment_value), 2) AS total_revenue
FROM orders o
JOIN payments p
    ON o.order_id = p.order_id
GROUP BY
    YEAR(o.order_purchase_timestamp),
    MONTH(o.order_purchase_timestamp)
ORDER BY
    order_year,
    order_month;
    
-- Revenue by order status
SELECT
    o.order_status,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(p.payment_value), 2) AS total_revenue
FROM orders o
JOIN payments p
    ON o.order_id = p.order_id
GROUP BY o.order_status
ORDER BY total_revenue DESC;

-- Revenue by product category
SELECT
    ct.product_category_name_english AS category,
    ROUND(SUM(oi.price), 2) AS total_revenue,
    COUNT(oi.order_id) AS items_sold
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
JOIN category_translation ct
    ON p.product_category_name = ct.product_category_name
GROUP BY ct.product_category_name_english
ORDER BY total_revenue DESC;

-- Orders by customer state
SELECT
    c.customer_state,
    COUNT(DISTINCT o.order_id) AS total_orders
FROM orders o
JOIN customers c
    ON o.customer_id = c.customer_id
GROUP BY c.customer_state
ORDER BY total_orders DESC;

-- Revenue by customer state
SELECT
    c.customer_state,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(p.payment_value), 2) AS total_revenue
FROM orders o
JOIN customers c
    ON o.customer_id = c.customer_id
JOIN payments p
    ON o.order_id = p.order_id
GROUP BY c.customer_state
ORDER BY total_revenue DESC;

-- Top 10 states by average order value
SELECT
    c.customer_state,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(p.payment_value) / COUNT(DISTINCT o.order_id), 2) AS average_order_value
FROM orders o
JOIN customers c
    ON o.customer_id = c.customer_id
JOIN payments p
    ON o.order_id = p.order_id
GROUP BY c.customer_state
ORDER BY average_order_value DESC
LIMIT 10;

-- Average review score by order status
SELECT
    o.order_status,
    COUNT(r.review_id) AS total_reviews,
    ROUND(AVG(r.review_score), 2) AS average_review_score
FROM orders o
JOIN reviews r
    ON o.order_id = r.order_id
GROUP BY o.order_status
ORDER BY average_review_score DESC;

-- Delivery time vs customer review score
SELECT
    r.review_score,
    ROUND(
        AVG(
            DATEDIFF(
                o.order_delivered_customer_date,
                o.order_purchase_timestamp
            )
        ), 2
    ) AS average_delivery_days,
    COUNT(*) AS total_reviews
FROM orders o
JOIN reviews r
    ON o.order_id = r.order_id
WHERE o.order_delivered_customer_date IS NOT NULL
GROUP BY r.review_score
ORDER BY r.review_score;

-- Repeat customer percentage
SELECT
    ROUND(
        100.0 * COUNT(*) / (SELECT COUNT(DISTINCT customer_id) FROM orders),
        2
    ) AS repeat_customer_percentage
FROM (
    SELECT customer_id
    FROM orders
    GROUP BY customer_id
    HAVING COUNT(order_id) > 1
) AS repeat_customers;

-- Monthly order trend
SELECT
    DATE_FORMAT(order_purchase_timestamp, '%Y-%m') AS order_month,
    COUNT(*) AS total_orders
FROM orders
GROUP BY DATE_FORMAT(order_purchase_timestamp, '%Y-%m')
ORDER BY order_month;

-- Month-over-month revenue growth
WITH monthly_revenue AS (
    SELECT
        DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m') AS order_month,
        SUM(p.payment_value) AS revenue
    FROM orders o
    JOIN payments p
        ON o.order_id = p.order_id
    GROUP BY DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m')
)
SELECT
    order_month,
    ROUND(revenue, 2) AS revenue,
    ROUND(
        100 * (revenue - LAG(revenue) OVER (ORDER BY order_month))
        / LAG(revenue) OVER (ORDER BY order_month),
        2
    ) AS mom_growth_percentage
FROM monthly_revenue
ORDER BY order_month;

-- Top 10 cities by number of orders
SELECT
    c.customer_city,
    c.customer_state,
    COUNT(DISTINCT o.order_id) AS total_orders
FROM orders o
JOIN customers c
    ON o.customer_id = c.customer_id
GROUP BY
    c.customer_city,
    c.customer_state
ORDER BY total_orders DESC
LIMIT 10;

-- Top 10 cities by revenue
SELECT
    c.customer_city,
    c.customer_state,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(p.payment_value), 2) AS total_revenue
FROM orders o
JOIN customers c
    ON o.customer_id = c.customer_id
JOIN payments p
    ON o.order_id = p.order_id
GROUP BY
    c.customer_city,
    c.customer_state
ORDER BY total_revenue DESC
LIMIT 10;

-- Top 10 sellers by number of orders
SELECT
    seller_id,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(SUM(price), 2) AS total_revenue
FROM order_items
GROUP BY seller_id
ORDER BY total_orders DESC
LIMIT 10;

-- Top 10 sellers by average review score
SELECT
    oi.seller_id,
    COUNT(DISTINCT oi.order_id) AS total_orders,
    ROUND(AVG(r.review_score), 2) AS average_review_score
FROM order_items oi
JOIN reviews r
    ON oi.order_id = r.order_id
GROUP BY oi.seller_id
HAVING COUNT(DISTINCT oi.order_id) >= 10
ORDER BY average_review_score DESC
LIMIT 10;

-- Seller revenue per item
SELECT
    seller_id,
    COUNT(order_id) AS items_sold,
    ROUND(SUM(price), 2) AS total_revenue,
    ROUND(AVG(price), 2) AS average_item_price
FROM order_items
GROUP BY seller_id
HAVING COUNT(order_id) >= 10
ORDER BY average_item_price DESC
LIMIT 10;

-- Most frequently purchased product categories
SELECT
    ct.product_category_name_english AS category,
    COUNT(oi.order_id) AS items_sold
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
JOIN category_translation ct
    ON p.product_category_name = ct.product_category_name
GROUP BY ct.product_category_name_english
ORDER BY items_sold DESC
LIMIT 10;

-- Category performance overview
SELECT
    ct.product_category_name_english AS category,
    COUNT(oi.order_id) AS items_sold,
    ROUND(SUM(oi.price), 2) AS total_revenue,
    ROUND(AVG(oi.price), 2) AS average_price
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
JOIN category_translation ct
    ON p.product_category_name = ct.product_category_name
GROUP BY ct.product_category_name_english
ORDER BY total_revenue DESC
LIMIT 15;

-- Average delivery time by customer state
SELECT
    c.customer_state,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(
        AVG(
            DATEDIFF(
                o.order_delivered_customer_date,
                o.order_purchase_timestamp
            )
        ), 2
    ) AS average_delivery_days
FROM orders o
JOIN customers c
    ON o.customer_id = c.customer_id
WHERE o.order_delivered_customer_date IS NOT NULL
GROUP BY c.customer_state
ORDER BY average_delivery_days DESC;

-- Payment installments analysis
SELECT
    payment_installments,
    COUNT(*) AS total_payments,
    ROUND(AVG(payment_value), 2) AS average_payment_value,
    ROUND(SUM(payment_value), 2) AS total_revenue
FROM payments
GROUP BY payment_installments
ORDER BY payment_installments;

-- Review score: late vs on-time delivery
SELECT
    CASE
        WHEN o.order_delivered_customer_date > o.order_estimated_delivery_date
            THEN 'Late'
        ELSE 'On Time'
    END AS delivery_status,
    COUNT(r.review_id) AS total_reviews,
    ROUND(AVG(r.review_score), 2) AS average_review_score
FROM orders o
JOIN reviews r
    ON o.order_id = r.order_id
WHERE o.order_delivered_customer_date IS NOT NULL
GROUP BY delivery_status;

-- Orders by day of week
SELECT
    DAYNAME(order_purchase_timestamp) AS day_of_week,
    COUNT(*) AS total_orders
FROM orders
GROUP BY DAYOFWEEK(order_purchase_timestamp), DAYNAME(order_purchase_timestamp)
ORDER BY DAYOFWEEK(order_purchase_timestamp);

-- Top 10 customers by total spending
SELECT
    o.customer_id,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(p.payment_value), 2) AS total_spent
FROM orders o
JOIN payments p
    ON o.order_id = p.order_id
GROUP BY o.customer_id
ORDER BY total_spent DESC
LIMIT 10;

-- Top 10 products by quantity sold
SELECT
    product_id,
    COUNT(*) AS quantity_sold,
    ROUND(SUM(price), 2) AS total_revenue
FROM order_items
GROUP BY product_id
ORDER BY quantity_sold DESC
LIMIT 10;

-- Top 10 categories by average customer rating
SELECT
    ct.product_category_name_english AS category,
    COUNT(r.review_id) AS total_reviews,
    ROUND(AVG(r.review_score), 2) AS average_rating
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
JOIN category_translation ct
    ON p.product_category_name = ct.product_category_name
JOIN reviews r
    ON oi.order_id = r.order_id
GROUP BY ct.product_category_name_english
HAVING COUNT(r.review_id) >= 100
ORDER BY average_rating DESC
LIMIT 10;

-- Category revenue contribution
WITH category_revenue AS (
    SELECT
        ct.product_category_name_english AS category,
        SUM(oi.price) AS revenue
    FROM order_items oi
    JOIN products p
        ON oi.product_id = p.product_id
    JOIN category_translation ct
        ON p.product_category_name = ct.product_category_name
    GROUP BY ct.product_category_name_english
)
SELECT
    category,
    ROUND(revenue, 2) AS revenue,
    ROUND(
        100 * revenue / SUM(revenue) OVER (),
        2
    ) AS revenue_percentage
FROM category_revenue
ORDER BY revenue DESC;

-- Repeat vs one-time customer spending
WITH customer_orders AS (
    SELECT
        o.customer_id,
        COUNT(DISTINCT o.order_id) AS order_count,
        SUM(p.payment_value) AS total_spent
    FROM orders o
    JOIN payments p
        ON o.order_id = p.order_id
    GROUP BY o.customer_id
)
SELECT
    CASE
        WHEN order_count = 1 THEN 'One-time Customer'
        ELSE 'Repeat Customer'
    END AS customer_type,
    COUNT(*) AS total_customers,
    ROUND(SUM(total_spent), 2) AS total_revenue,
    ROUND(AVG(total_spent), 2) AS average_customer_spend
FROM customer_orders
GROUP BY customer_type;

-- Revenue by year
SELECT
    YEAR(o.order_purchase_timestamp) AS order_year,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(p.payment_value), 2) AS total_revenue,
    ROUND(
        SUM(p.payment_value) / COUNT(DISTINCT o.order_id),
        2
    ) AS average_order_value
FROM orders o
JOIN payments p
    ON o.order_id = p.order_id
GROUP BY YEAR(o.order_purchase_timestamp)
ORDER BY order_year;

-- Overall E-commerce KPI Summary
SELECT
    (SELECT COUNT(*) FROM orders) AS total_orders,
    (SELECT COUNT(*) FROM customers) AS total_customers,
    (SELECT COUNT(*) FROM products) AS total_products,
    (SELECT COUNT(*) FROM sellers) AS total_sellers,
    (SELECT ROUND(SUM(payment_value), 2) FROM payments) AS total_revenue,
    (SELECT ROUND(AVG(payment_value), 2) FROM payments) AS average_order_value,
    (SELECT ROUND(AVG(review_score), 2) FROM reviews) AS average_review_score,
    (SELECT COUNT(*)
     FROM orders
     WHERE order_status = 'delivered') AS delivered_orders;