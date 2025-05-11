-- Monthly revenue by location
SELECT 
    l.city AS location,
    TO_CHAR(r.start_date, 'YYYY-MM') AS month,
    COUNT(r.rental_id) AS rental_count,
    SUM(r.total_cost) AS total_revenue,
    ROUND(AVG(r.total_cost), 2) AS avg_rental_value
FROM rental r
JOIN car c ON r.car_registration = c.registration
JOIN location l ON c.location_id = l.location_id
WHERE r.status = 'COMPLETED'
GROUP BY l.city, TO_CHAR(r.start_date, 'YYYY-MM')
ORDER BY l.city, month;