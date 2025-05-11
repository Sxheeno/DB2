-- All cars with model and manufacturer details
SELECT 
    c.registration,
    m.model_name,
    man.name AS manufacturer,
    c.color,
    c.year_manufactured,
    c.daily_rate,
    cat.description AS category,
    l.city AS location,
    c.status
FROM car c
JOIN model m ON c.model_id = m.model_id
JOIN manufacturer man ON m.manufacturer_id = man.manufacturer_id
JOIN car_category cat ON m.category_code = cat.category_code
JOIN location l ON c.location_id = l.location_id
ORDER BY c.status, man.name, m.model_name;