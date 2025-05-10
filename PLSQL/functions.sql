-- CALCULATE RENTAL COST FUNCTION
CREATE OR REPLACE FUNCTION calculate_rental_cost(
    p_car_reg VARCHAR2,
    p_start_date DATE,
    p_end_date DATE,
    p_equipment_ids IN NUMBER_ARRAY DEFAULT NULL,
    p_equipment_qty IN NUMBER_ARRAY DEFAULT NULL
) RETURN NUMBER IS
    v_daily_rate NUMBER;
    v_days NUMBER;
    v_total_cost NUMBER := 0;
    v_equipment_cost NUMBER := 0;
BEGIN
    -- Get car daily rate
    SELECT daily_rate INTO v_daily_rate
    FROM car WHERE registration = p_car_reg;
    
    -- Calculate rental days
    v_days := p_end_date - p_start_date;
    
    -- Base car rental cost
    v_total_cost := v_daily_rate * v_days;
    
    -- Add equipment costs if provided
    IF p_equipment_ids IS NOT NULL THEN
        FOR i IN 1..p_equipment_ids.COUNT LOOP
            SELECT daily_price * p_equipment_qty(i) * v_days INTO v_equipment_cost
            FROM extra_equipment
            WHERE equipment_id = p_equipment_ids(i);
            
            v_total_cost := v_total_cost + v_equipment_cost;
        END LOOP;
    END IF;
    
    RETURN v_total_cost;
EXCEPTION
    WHEN OTHERS THEN
        RETURN -1; -- Error indicator
END;
/

-- CHECK CAR AVAILABILITY FUNCTION
CREATE OR REPLACE FUNCTION is_car_available(
    p_car_reg VARCHAR2,
    p_start_date DATE,
    p_end_date DATE
) RETURN BOOLEAN IS
    v_conflicts NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_conflicts
    FROM rental
    WHERE car_registration = p_car_reg
    AND status IN ('CONFIRMED', 'ONGOING')
    AND NOT (end_date < p_start_date OR start_date > p_end_date);
    
    RETURN (v_conflicts = 0);
END;
/

-- GENERATE INVOICE FUNCTION
CREATE OR REPLACE FUNCTION generate_invoice(
    p_rental_id NUMBER
) RETURN CLOB IS
    v_invoice CLOB;
    v_rental rental%ROWTYPE;
BEGIN
    -- Get rental details
    SELECT * INTO v_rental FROM rental WHERE rental_id = p_rental_id;
    
    -- Build invoice
    v_invoice := 'INVOICE FOR RENTAL #' || p_rental_id || CHR(10) ||
                 'Customer: ' || get_customer_name(v_rental.customer_id) || CHR(10) ||
                 'Car: ' || get_car_details(v_rental.car_registration) || CHR(10) ||
                 'Period: ' || TO_CHAR(v_rental.start_date, 'DD-MON-YYYY') || ' to ' || 
                 TO_CHAR(v_rental.end_date, 'DD-MON-YYYY') || CHR(10) ||
                 'Total Cost: ' || TO_CHAR(v_rental.total_cost, 'FML9,999.99');
    
    RETURN v_invoice;
END;
/