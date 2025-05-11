-- Equipment usage analysis
SELECT 
    e.description,
    e.quantity AS total_units,
    NVL(SUM(CASE WHEN r.status IN ('CONFIRMED', 'ONGOING') THEN re.quantity ELSE 0 END), 0) AS rented_units,
    ROUND(NVL(SUM(CASE WHEN r.status IN ('CONFIRMED', 'ONGOING') THEN re.quantity ELSE 0 END), 0) / e.quantity * 100, 1) AS utilization_percentage,
    CASE WHEN e.quantity - NVL(SUM(CASE WHEN r.status IN ('CONFIRMED', 'ONGOING') THEN re.quantity ELSE 0 END), 0) <= e.reorder_threshold 
         THEN 'YES' ELSE 'NO' END AS needs_reorder
FROM extra_equipment e
LEFT JOIN rental_equipment re ON e.equipment_id = re.equipment_id
LEFT JOIN rental r ON re.rental_id = r.rental_id
GROUP BY e.equipment_id, e.description, e.quantity, e.reorder_threshold
ORDER BY utilization_percentage DESC;