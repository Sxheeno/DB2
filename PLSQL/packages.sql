-- RENTAL MANAGEMENT PACKAGE
CREATE OR REPLACE PACKAGE rental_pkg AS
    -- Procedures
    PROCEDURE process_rental(
        p_customer_id NUMBER,
        p_car_reg VARCHAR2,
        p_start_date DATE,
        p_end_date DATE,
        p_equipment_ids NUMBER_ARRAY DEFAULT NULL,
        p_equipment_qty NUMBER_ARRAY DEFAULT NULL
    );
    
    PROCEDURE complete_rental(
        p_rental_id NUMBER,
        p_actual_return_date DATE DEFAULT SYSDATE
    );
    
    -- Functions
    FUNCTION check_availability(
        p_car_reg VARCHAR2,
        p_start_date DATE,
        p_end_date DATE
    ) RETURN BOOLEAN;
    
    FUNCTION calculate_late_fee(
        p_rental_id NUMBER
    ) RETURN NUMBER;
    
    -- Exceptions
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
        p_equipment_ids NUMBER_ARRAY DEFAULT NULL,
        p_equipment_qty NUMBER_ARRAY DEFAULT NULL
    ) IS
        v_available BOOLEAN;
        v_total_cost NUMBER;
        v_rental_id NUMBER;
    BEGIN
        -- Validate dates
        IF p_start_date >= p_end_date THEN
            RAISE e_invalid_dates;
        END IF;
        
        -- Check availability
        v_available := check_availability(p_car_reg, p_start_date, p_end_date);
        IF NOT v_available THEN
            RAISE e_car_unavailable;
        END IF;
        
        -- Calculate total cost
        v_total_cost := calculate_rental_cost(
            p_car_reg, p_start_date, p_end_date, 
            p_equipment_ids, p_equipment_qty
        );
        
        -- Create rental record
        INSERT INTO rental (
            customer_id, car_registration, 
            start_date, end_date, total_cost
        ) VALUES (
            p_customer_id, p_car_reg,
            p_start_date, p_end_date, v_total_cost
        )
        RETURNING rental_id INTO v_rental_id;
        
        -- Add equipment if provided
        IF p_equipment_ids IS NOT NULL THEN
            FOR i IN 1..p_equipment_ids.COUNT LOOP
                INSERT INTO rental_equipment VALUES (
                    v_rental_id, p_equipment_ids(i), p_equipment_qty(i)
                );
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
    
    -- Implement other package procedures/functions here
END rental_pkg;
/