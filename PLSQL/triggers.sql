CREATE OR REPLACE TRIGGER trg_capitalize_names
BEFORE INSERT OR UPDATE ON customer
FOR EACH ROW
BEGIN
    :NEW.first_name := INITCAP(:NEW.first_name);
    :NEW.last_name := INITCAP(:NEW.last_name);
    :NEW.email := LOWER(:NEW.email);
END;
/

CREATE OR REPLACE TRIGGER trg_update_car_status
AFTER INSERT OR UPDATE OF status ON rental
FOR EACH ROW
BEGIN
    IF :NEW.status = 'ONGOING' THEN
        UPDATE car SET status = 'RENTED' WHERE registration = :NEW.car_registration;
    ELSIF :NEW.status = 'COMPLETED' THEN
        UPDATE car SET status = 'AVAILABLE' WHERE registration = :NEW.car_registration;
    END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_maintenance_log
AFTER UPDATE OF status ON car
FOR EACH ROW
WHEN (NEW.status = 'MAINTENANCE' AND OLD.status != 'MAINTENANCE')
BEGIN
    INSERT INTO maintenance_log (
        car_registration,
        maintenance_date,
        maintenance_type,
        description
    ) VALUES (
        :NEW.registration,
        SYSDATE,
        'Routine Check',
        'Car put under maintenance'
    );
END;
/