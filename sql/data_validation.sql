-- Check row counts

SELECT COUNT(*) AS customers_count
FROM customers;

SELECT COUNT(*) AS orders_count
FROM orders;

SELECT COUNT(*) AS order_items_count
FROM order_items;

SELECT COUNT(*) AS payments_count
FROM order_payments;

SELECT COUNT(*) AS reviews_count
FROM order_reviews;

SELECT COUNT(*) AS products_count
FROM products;

SELECT COUNT(*) AS sellers_count
FROM sellers;


-- Check for NULL customer IDs

SELECT COUNT(*)
FROM customers
WHERE customer_id IS NULL;


-- Check for NULL order IDs

SELECT COUNT(*)
FROM orders
WHERE order_id IS NULL;


-- Check duplicate customers

SELECT customer_unique_id,
       COUNT(*) AS cnt
FROM customers
GROUP BY customer_unique_id
HAVING COUNT(*) > 1;


-- Check order date range

SELECT MIN(order_purchase_timestamp) AS first_order,
       MAX(order_purchase_timestamp) AS last_order
FROM orders;


-- Check payment value range

SELECT MIN(payment_value) AS min_payment,
       MAX(payment_value) AS max_payment,
       AVG(payment_value) AS avg_payment
FROM order_payments;