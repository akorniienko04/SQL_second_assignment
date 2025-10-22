USE SQL_2;

SELECT
    c.name,
    c.email,
    c.country,
    o.order_date,
    o.total_amount,
    i.product_name,
    i.quantity,
    i.price
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items i ON o.order_id = i.order_id
WHERE o.status = 'Completed'
  AND i.price > (
      SELECT AVG(price)
      FROM order_items
  )
  AND c.country IN (
      SELECT DISTINCT country
      FROM customers
      WHERE country IS NOT NULL
  )
ORDER BY o.order_date DESC;



