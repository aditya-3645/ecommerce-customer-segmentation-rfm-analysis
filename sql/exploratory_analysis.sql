/* ==========================================================
   Q1. What is the total revenue generated?
   ========================================================== */

SELECT
    ROUND(SUM(payment_value), 2) AS total_revenue
FROM order_payments;


/* ==========================================================
   Q2. How many unique customers are present?
   ========================================================== */

SELECT
    COUNT(DISTINCT customer_unique_id) AS total_customers
FROM customers;


/* ==========================================================
   Q3. How many orders were placed?
   ========================================================== */

SELECT
    COUNT(*) AS total_orders
FROM orders;


/* ==========================================================
   Q4. What is the average order value?
   ========================================================== */

SELECT
    ROUND(AVG(payment_value), 2) AS average_order_value
FROM order_payments;


/* ==========================================================
   Q5. What is the minimum, maximum and average payment value?
   ========================================================== */

SELECT
    MIN(payment_value) AS minimum_payment,
    MAX(payment_value) AS maximum_payment,
    ROUND(AVG(payment_value),2) AS average_payment
FROM order_payments;


/* ==========================================================
   Q6. What is the distribution of order statuses?
   ========================================================== */

SELECT
    order_status,
    COUNT(*) AS total_orders
FROM orders
GROUP BY order_status
ORDER BY total_orders DESC;


/* ==========================================================
   Q7. Which states have the highest number of customers?
   ========================================================== */

SELECT
    customer_state,
    COUNT(*) AS customer_count
FROM customers
GROUP BY customer_state
ORDER BY customer_count DESC
LIMIT 10;


/* ==========================================================
   Q8. Which states generate the most orders?
   ========================================================== */

SELECT
    c.customer_state,
    COUNT(o.order_id) AS total_orders
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_state
ORDER BY total_orders DESC
LIMIT 10;


/* ==========================================================
   Q9. What is the monthly order trend?
   ========================================================== */

SELECT
    DATE_FORMAT(order_purchase_timestamp,'%Y-%m') AS order_month,
    COUNT(*) AS total_orders
FROM orders
GROUP BY order_month
ORDER BY order_month;


/* ==========================================================
   Q10. What is the monthly revenue trend?
   ========================================================== */

SELECT
    DATE_FORMAT(o.order_purchase_timestamp,'%Y-%m') AS order_month,
    ROUND(SUM(p.payment_value),2) AS revenue
FROM orders o
JOIN order_payments p
    ON o.order_id = p.order_id
GROUP BY order_month
ORDER BY order_month;


/* ==========================================================
   Q11. Which payment types are most commonly used?
   ========================================================== */

SELECT
    payment_type,
    COUNT(*) AS usage_count
FROM order_payments
GROUP BY payment_type
ORDER BY usage_count DESC;


/* ==========================================================
   Q12. Top 10 highest revenue-generating customers
   ========================================================== */

SELECT
    c.customer_unique_id,
    ROUND(SUM(p.payment_value),2) AS total_spent
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_payments p
    ON o.order_id = p.order_id
GROUP BY c.customer_unique_id
ORDER BY total_spent DESC
LIMIT 10;


/* ==========================================================
   Q13. What is the overall dataset time period?
   ========================================================== */

SELECT
    MIN(order_purchase_timestamp) AS first_order_date,
    MAX(order_purchase_timestamp) AS last_order_date
FROM orders;


/* ==========================================================
   END OF EXPLORATORY DATA ANALYSIS
   ========================================================== */