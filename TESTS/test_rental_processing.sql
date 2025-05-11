DECLARE
  v_rental_id NUMBER;
BEGIN
  DBMS_OUTPUT.PUT_LINE('=== RENTAL PROCESSING TEST ===');
  
  rental_pkg.process_rental(
    p_customer_id => 1,
    p_car_reg => 'DEF456',
    p_start_date => SYSDATE+1,
    p_end_date => SYSDATE+3,
    p_equipment_ids => number_array(1, 2),
    p_equipment_qty => number_array(1, 1)
  );
  
  SELECT rental_id INTO v_rental_id FROM rental WHERE car_registration = 'DEF456' AND status = 'CONFIRMED';
  DBMS_OUTPUT.PUT_LINE('PASS: Rental created with ID ' || v_rental_id);
  
  rental_pkg.complete_rental(v_rental_id);
  DBMS_OUTPUT.PUT_LINE('PASS: Rental completed successfully');
  
  DELETE FROM rental_equipment WHERE rental_id = v_rental_id;
  DELETE FROM rental WHERE rental_id = v_rental_id;
  COMMIT;
EXCEPTION WHEN OTHERS THEN
  DBMS_OUTPUT.PUT_LINE('TEST ERROR: ' || SQLERRM);
  ROLLBACK;
END;
/