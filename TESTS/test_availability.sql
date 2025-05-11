DECLARE
  v_available BOOLEAN;
BEGIN
  DBMS_OUTPUT.PUT_LINE('=== CAR AVAILABILITY TEST ===');
  
  v_available := is_car_available('ABC123', SYSDATE+10, SYSDATE+15);
  DBMS_OUTPUT.PUT_LINE(CASE WHEN v_available THEN 'PASS' ELSE 'FAIL' END || ': Car available check');
  
  INSERT INTO rental (customer_id, car_registration, start_date, end_date, total_cost, status)
  VALUES (1, 'ABC123', SYSDATE+12, SYSDATE+14, 75.00, 'CONFIRMED');
  
  v_available := is_car_available('ABC123', SYSDATE+10, SYSDATE+15);
  DBMS_OUTPUT.PUT_LINE(CASE WHEN NOT v_available THEN 'PASS' ELSE 'FAIL' END || ': Car unavailable during rental');
  
  DELETE FROM rental WHERE car_registration = 'ABC123' AND status = 'CONFIRMED';
  COMMIT;
EXCEPTION WHEN OTHERS THEN
  DBMS_OUTPUT.PUT_LINE('TEST ERROR: ' || SQLERRM);
  ROLLBACK;
END;
/