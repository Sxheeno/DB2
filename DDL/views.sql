-- ACTIVE RENTALS VIEW
CREATE OR REPLACE VIEW active_rentals AS
SELECT 
    r.rental_id,
    c.first_name || ' ' || c.last_name AS customer_name,
    car.registration,
    m.model_name,
    man.name AS manufacturer,
    r.start_date,
    r.end_date,
    r.total_cost
FROM rental r
JOIN customer c ON r.customer_id = c.customer_id
JOIN car ON r.car_registration = car.registration
JOIN model m ON car.model_id = m.model_id
JOIN manufacturer man ON m.manufacturer_id = man.manufacturer_id
WHERE r.status = 'ONGOING'
ORDER BY r.end_date;

-- CAR AVAILABILITY VIEW
CREATE OR REPLACE VIEW car_availability AS
SELECT 
    c.registration,
    m.model_name,
    man.name AS manufacturer,
    cat.description AS category,
    c.color,
    c.daily_rate,
    l.city AS location,
    c.status
FROM car c
JOIN model m ON c.model_id = m.model_id
JOIN manufacturer man ON m.manufacturer_id = man.manufacturer_id
JOIN car_category cat ON m.category_code = cat.category_code
JOIN location l ON c.location_id = l.location_id
ORDER BY l.city, m.model_name;

-- MONTHLY REVENUE REPORT VIEW
CREATE OR REPLACE VIEW monthly_revenue AS
SELECT 
    TO_CHAR(r.start_date, 'YYYY-MM') AS month,
    l.city AS location,
    COUNT(r.rental_id) AS rentals_count,
    SUM(r.total_cost) AS total_revenue,
    SUM(r.discount_amount) AS total_discounts,
    AVG(r.total_cost) AS avg_rental_value
FROM rental r
JOIN car c ON r.car_registration = c.registration
JOIN location l ON c.location_id = l.location_id
WHERE r.status = 'COMPLETED'
GROUP BY TO_CHAR(r.start_date, 'YYYY-MM'), l.city
ORDER BY month, l.city;

-- EQUIPMENT UTILIZATION VIEW
CREATE OR REPLACE VIEW equipment_utilization AS
SELECT 
    e.equipment_id,
    e.description,
    e.quantity AS total_quantity,
    NVL(SUM(re.quantity), 0) AS rented_quantity,
    e.quantity - NVL(SUM(re.quantity), 0) AS available_quantity,
    CASE WHEN e.quantity - NVL(SUM(re.quantity), 0) <= e.reorder_threshold THEN 'YES' ELSE 'NO' END AS needs_reorder
FROM extra_equipment e
LEFT JOIN rental_equipment re ON e.equipment_id = re.equipment_id
LEFT JOIN rental r ON re.rental_id = r.rental_id AND r.status = 'ONGOING'
GROUP BY e.equipment_id, e.description, e.quantity, e.reorder_threshold
ORDER BY available_quantity;