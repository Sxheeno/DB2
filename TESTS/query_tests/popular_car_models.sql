-- Most popular car models by rental count
SELECT 
    m.model_name,
    man.name AS manufacturer,
    cat.description AS category,
    COUNT(r.rental_id) AS rental_count,
    AVG(r.total_cost) AS avg_rental_price
FROM rental r
JOIN car c ON r.car_registration = c.registration
JOIN model m ON c.model_id = m.model_id
JOIN manufacturer man ON m.manufacturer_id = man.manufacturer_id
JOIN car_category cat ON m.category_code = cat.category_code
WHERE r.status = 'COMPLETED'
GROUP BY m.model_name, man.name, cat.description
ORDER BY rental_count DESC
FETCH FIRST 5 ROWS ONLY;