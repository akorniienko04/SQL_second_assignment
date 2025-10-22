USE SQL_2;







explain

WITH
order_counts AS(
    SELECT customer_id, COUNT(*) AS orders_total
    FROM orders
    GROUP BY customer_id
),
avg_price_per_order AS(
    SELECT order_id, AVG(price) AS avg_price_for_order
    FROM order_items
    GROUP BY order_id
)

SELECT
    c.customer_id,
    c.name,
    c.country,
    o.order_date,
    i.product_name,
    i.price,
    oc.orders_total,
    ap.avg_price_for_order
FROM customers c
JOIN 
orders o ON c.customer_id = o.customer_id
JOIN order_items i ON o.order_id = i.order_id
LEFT JOIN order_counts oc ON c.customer_id = oc.customer_id
LEFT JOIN avg_price_per_order ap ON o.order_id = ap.order_id
WHERE o.status = 'Completed'
ORDER BY o.order_date DESC;


