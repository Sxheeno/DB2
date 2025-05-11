-- Detailed view of active rentals
SELECT 
    r.rental_id,
    c.first_name || ' ' || c.last_name AS customer_name,
    car.registration,
    m.model_name || ' (' || man.name || ')' AS car_details,
    r.start_date,
    r.end_date,
    r.total_cost,
    (SELECT COUNT(*) FROM rental_equipment WHERE rental_id = r.rental_id) AS equipment_count
FROM rental r
JOIN customer c ON r.customer_id = c.customer_id
JOIN car ON r.car_registration = car.registration
JOIN model m ON car.model_id = m.model_id
JOIN manufacturer man ON m.manufacturer_id = man.manufacturer_id
WHERE r.status IN ('CONFIRMED', 'ONGOING')
ORDER BY r.start_date;