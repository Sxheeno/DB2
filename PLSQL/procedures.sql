CREATE OR REPLACE PROCEDURE add_customer(
    p_first_name VARCHAR2,
    p_last_name VARCHAR2,
    p_cpr_passport VARCHAR2,
    p_phone VARCHAR2,
    p_street VARCHAR2,
    p_block VARCHAR2,
    p_city VARCHAR2,
    p_email VARCHAR2
) AS
BEGIN
    INSERT INTO customer (
        first_name, last_name, cpr_passport, 
        phone, street, block, city, email
    ) VALUES (
        INITCAP(p_first_name), INITCAP(p_last_name), p_cpr_passport,
        p_phone, p_street, p_block, p_city, LOWER(p_email)
    );
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Customer added successfully');
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error adding customer: ' || SQLERRM);
END;
/

-- Additional procedures for rental processing, reports, etc.