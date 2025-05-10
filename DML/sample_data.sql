-- TEST 1: Check car availability function
DECLARE
    v_available BOOLEAN;
BEGIN
    v_available := is_car_available('ABC123', SYSDATE+1, SYSDATE+5);
    DBMS_OUTPUT.PUT_LINE('Car ABC123 available: ' || 
        CASE WHEN v_available THEN 'YES' ELSE 'NO' END);
END;
/

-- TEST 2: Process a rental
BEGIN
    rental_pkg.process_rental(
        p_customer_id => 1,
        p_car_reg => 'ABC123',
        p_start_date => SYSDATE+1,
        p_end_date => SYSDATE+5,
        p_equipment_ids => NUMBER_ARRAY(1, 2),
        p_equipment_qty => NUMBER_ARRAY(1, 1)
    );
END;
/

-- TEST 3: Attempt overlapping rental (should fail)
BEGIN
    rental_pkg.process_rental(
        p_customer_id => 2,
        p_car_reg => 'ABC123',
        p_start_date => SYSDATE+3,
        p_end_date => SYSDATE+7
    );
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Expected error: ' || SQLERRM);
END;
/