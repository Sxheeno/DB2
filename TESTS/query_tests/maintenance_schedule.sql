-- Cars due for maintenance
SELECT 
    c.registration,
    m.model_name,
    man.name AS manufacturer,
    c.mileage,
    c.next_service_mileage,
    c.next_service_mileage - c.mileage AS miles_until_service,
    l.city AS location
FROM car c
JOIN model m ON c.model_id = m.model_id
JOIN manufacturer man ON m.manufacturer_id = man.manufacturer_id
JOIN location l ON c.location_id = l.location_id
WHERE c.status != 'MAINTENANCE'
AND (c.mileage >= c.next_service_mileage OR c.next_service_mileage - c.mileage < 1000)
ORDER BY miles_until_service;