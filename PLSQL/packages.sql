CREATE OR REPLACE PACKAGE rental_pkg AS
    PROCEDURE process_rental(
        p_customer_id NUMBER,
        p_car_reg VARCHAR2,
        p_start_date DATE,
        p_end_date DATE,
        p_equipment_ids IN number_array DEFAULT NULL,
        p_equipment_qty IN number_array DEFAULT NULL
    );
    
    PROCEDURE complete_rental(
        p_rental_id NUMBER,
        p_actual_return_date DATE DEFAULT SYSDATE
    );
    
    FUNCTION check_availability(
        p_car_reg VARCHAR2,
        p_start_date DATE,
        p_end_date DATE
    ) RETURN BOOLEAN;
    
    e_car_unavailable EXCEPTION;
    e_invalid_dates EXCEPTION;
END rental_pkg;
/

CREATE OR REPLACE PACKAGE BODY rental_pkg AS
    PROCEDURE process_rental(
        p_customer_id NUMBER,
        p_car_reg VARCHAR2,
        p_start_date DATE,
        p_end_date DATE,
        p_equipment_ids number_array DEFAULT NULL,
        p_equipment_qty number_array DEFAULT NULL
    ) IS
        v_available BOOLEAN;
        v_total_cost NUMBER;
        v_rental_id NUMBER;
    BEGIN
        IF p_start_date >= p_end_date THEN RAISE e_invalid_dates; END IF;
        
        v_available := check_availability(p_car_reg, p_start_date, p_end_date);
        IF NOT v_available THEN RAISE e_car_unavailable; END IF;
        
        v_total_cost := calculate_rental_cost(p_car_reg, p_start_date, p_end_date, p_equipment_ids, p_equipment_qty);
        
        INSERT INTO rental (customer_id, car_registration, start_date, end_date, total_cost)
        VALUES (p_customer_id, p_car_reg, p_start_date, p_end_date, v_total_cost)
        RETURNING rental_id INTO v_rental_id;
        
        IF p_equipment_ids IS NOT NULL THEN
            FOR i IN 1..p_equipment_ids.COUNT LOOP
                INSERT INTO rental_equipment VALUES (v_rental_id, p_equipment_ids(i), p_equipment_qty(i));
            END LOOP;
        END IF;
        
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Rental processed successfully. ID: ' || v_rental_id);
    EXCEPTION
        WHEN e_car_unavailable THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('Error: Car is not available for the selected dates');
        WHEN e_invalid_dates THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('Error: End date must be after start date');
        WHEN OTHERS THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('Error processing rental: ' || SQLERRM);
    END process_rental;
    
    PROCEDURE complete_rental(p_rental_id NUMBER, p_actual_return_date DATE DEFAULT SYSDATE) IS
        v_late_fee NUMBER := 0;
    BEGIN
        SELECT CASE WHEN p_actual_return_date > end_date THEN (p_actual_return_date - end_date) * (c.daily_rate * 0.1) ELSE 0 END
        INTO v_late_fee
        FROM rental r JOIN car c ON r.car_registration = c.registration
        WHERE r.rental_id = p_rental_id;
        
        UPDATE rental
        SET status = 'COMPLETED', actual_return_date = p_actual_return_date, total_cost = total_cost + v_late_fee
        WHERE rental_id = p_rental_id;
        
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Rental completed successfully');
        IF v_late_fee > 0 THEN DBMS_OUTPUT.PUT_LINE('Late fee applied: ' || TO_CHAR(v_late_fee, 'FM9990.00')); END IF;
    EXCEPTION WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error completing rental: ' || SQLERRM);
    END complete_rental;
    
    FUNCTION check_availability(p_car_reg VARCHAR2, p_start_date DATE, p_end_date DATE) RETURN BOOLEAN IS
        v_conflicts NUMBER;
        v_car_status VARCHAR2(20);
    BEGIN
        SELECT status INTO v_car_status FROM car WHERE registration = p_car_reg;
        IF v_car_status != 'AVAILABLE' THEN RETURN FALSE; END IF;
        
        SELECT COUNT(*) INTO v_conflicts
        FROM rental
        WHERE car_registration = p_car_reg
        AND status IN ('CONFIRMED', 'ONGOING')
        AND NOT (end_date < p_start_date OR start_date > p_end_date);
        
        RETURN (v_conflicts = 0);
    EXCEPTION WHEN NO_DATA_FOUND THEN RETURN FALSE;
    END check_availability;
END rental_pkg;
/