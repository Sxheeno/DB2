-- Top customers by loyalty points and rentals
SELECT 
    c.first_name || ' ' || c.last_name AS customer_name,
    c.email,
    c.loyalty_points,
    COUNT(r.rental_id) AS rentals_count,
    SUM(r.total_cost) AS total_spent,
    ROUND(SUM(r.total_cost)/NULLIF(COUNT(r.rental_id), 0), 2) AS avg_spend_per_rental
FROM customer c
LEFT JOIN rental r ON c.customer_id = r.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name, c.email, c.loyalty_points
ORDER BY c.loyalty_points DESC NULLS LAST
FETCH FIRST 10 ROWS ONLY;