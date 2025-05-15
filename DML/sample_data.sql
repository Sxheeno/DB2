-- we delete everything so we can run this anytime and if we accidentely run again we won't get errors/ this is optional if first time
DELETE FROM RENTAL_EQUIPMENT;
DELETE FROM MAINTENANCE_LOG;
DELETE FROM RENTAL;
DELETE FROM CAR;
DELETE FROM CUSTOMER;
DELETE FROM EXTRA_EQUIPMENT;
DELETE FROM MODEL;
DELETE FROM LOCATION;
DELETE FROM MANUFACTURER;
DELETE FROM CAR_CATEGORY;

COMMIT;

DROP SEQUENCE manufacturer_seq;
DROP SEQUENCE model_seq;
DROP SEQUENCE location_seq;
DROP SEQUENCE customer_seq;
DROP SEQUENCE equipment_seq;
DROP SEQUENCE rental_seq;
DROP SEQUENCE maintenance_log_seq;

CREATE SEQUENCE manufacturer_seq START WITH 1;
CREATE SEQUENCE model_seq START WITH 1;
CREATE SEQUENCE location_seq START WITH 1;
CREATE SEQUENCE customer_seq START WITH 100;
CREATE SEQUENCE equipment_seq START WITH 1;
CREATE SEQUENCE rental_seq START WITH 1000;
CREATE SEQUENCE maintenance_log_seq START WITH 1;

-- Mandatory section
INSERT INTO car_category VALUES ('ECO', 'Economy', 1.0);
INSERT INTO car_category VALUES ('LUX', 'Luxury', 2.5);
INSERT INTO car_category VALUES ('SUV', 'Sports Utility Vehicle', 1.8);
INSERT INTO car_category VALUES ('VAN', 'Van', 1.2);

INSERT INTO manufacturer (name, country, founded_date) VALUES ('Toyota', 'Japan', TO_DATE('1937-08-28', 'YYYY-MM-DD'));
INSERT INTO manufacturer (name, country, founded_date) VALUES ('Nissan', 'Japan', TO_DATE('1933-12-26', 'YYYY-MM-DD'));
INSERT INTO manufacturer (name, country, founded_date) VALUES ('Ford', 'USA', TO_DATE('1903-06-16', 'YYYY-MM-DD'));
INSERT INTO manufacturer (name, country, founded_date) VALUES ('BMW', 'Germany', TO_DATE('1916-03-07', 'YYYY-MM-DD'));
INSERT INTO manufacturer (name, country, founded_date) VALUES ('Honda', 'Japan', TO_DATE('1948-09-24', 'YYYY-MM-DD'));
INSERT INTO manufacturer (name, country, founded_date) VALUES ('Tesla', 'USA', TO_DATE ('2003-07-01', 'YYYY-MM-DD'));

INSERT INTO model (manufacturer_id, model_name, engine_size, category_code, seats, fuel_type) VALUES (1, 'Corolla', 1.8, 'ECO', 5, 'Petrol');
INSERT INTO model (manufacturer_id, model_name, engine_size, category_code, seats, fuel_type) VALUES (1, 'Camry', 2.5, 'LUX', 5, 'Hybrid');
INSERT INTO model (manufacturer_id, model_name, engine_size, category_code, seats, fuel_type) VALUES (2, 'Patrol', 5.6, 'SUV', 7, 'Petrol');
INSERT INTO model (manufacturer_id, model_name, engine_size, category_code, seats, fuel_type) VALUES (3, 'Focus', 2.0, 'ECO', 5, 'Petrol');
INSERT INTO model (manufacturer_id, model_name, engine_size, category_code, seats, fuel_type) VALUES (4, 'X5', 3.0, 'SUV', 5, 'Diesel');
INSERT INTO model (manufacturer_id, model_name, engine_size, category_code, seats, fuel_type) VALUES (5, 'Accord', 1.5, 'LUX', 5, 'Hybrid');
INSERT INTO model (manufacturer_id, model_name, engine_size, category_code, seats, fuel_type) VALUES (6, 'Model 3', 0, 'LUX', 5, 'Electric');

INSERT INTO location (location_name, address_line1, city, phone, opening_hours) VALUES ('Main Branch', 'Building 45, Road 2305', 'Manama', '(973) 12345678', '07:00-22:00');
INSERT INTO location (location_name, address_line1, city, phone, opening_hours) VALUES ('Riffa Branch', 'Building 12, Road 1012', 'Riffa', '(973) 87654321','07:00-22:00');
INSERT INTO location (location_name, address_line1, city, phone, opening_hours) VALUES ('Muharraq Branch', 'Building 7, Road 789', 'Muharraq', '(973) 55556666','07:00-22:00');
INSERT INTO location (location_name, address_line1, city, phone, opening_hours) VALUES ('Airport Branch', 'Bahrain International Airport', 'Muharraq', '(973) 99998888','07:00-22:00');

INSERT INTO customer (first_name, last_name, cpr_passport, phone, street, block, city, email, loyalty_points) VALUES ('Ahmed', 'Alawi', '990101123', '(973) 11122233', 'Road 1001', 'Block 305', 'Manama', 'ahmed.alawi@email.com', 150);
INSERT INTO customer (first_name, last_name, cpr_passport, phone, street, block, city, email, loyalty_points) VALUES ('Fatima', 'Khalid', '980202456', '(973) 44455566', 'Avenue 202', 'Block 412', 'Riffa', 'fatima.k@email.com', 150);
INSERT INTO customer (first_name, last_name, cpr_passport, phone, street, block, city, email, loyalty_points) VALUES ('John', 'Smith', 'PASSPORT123', '(973) 77788899', 'Street 15', 'Block 107', 'Muharraq', 'john.smith@email.com', 75);
INSERT INTO customer (first_name, last_name, cpr_passport, phone, street, block, city, email, loyalty_points) VALUES ('Ali', 'Hassan', '990303789', '(973) 33344455', 'Road 405', 'Block 210', 'Manama', 'ali.h@email.com', 150);
INSERT INTO customer (first_name, last_name, cpr_passport, phone, street, block, city, email, loyalty_points) VALUES ('Maryam', 'Abdullah', '950505123', '(973) 66677788', 'Avenue 50', 'Block 99', 'Riffa', 'maryam.a@email.com', 150);
INSERT INTO customer (first_name, last_name, cpr_passport, phone, street, block, city, email, loyalty_points) VALUES ('Yusuf', 'Mohammed', 'PASSPORT456', '(973) 22233344', 'Street 8', 'Block 5', 'Muharraq', 'yusuf.m@email.com', 150);


INSERT INTO car (registration, model_id, year_manufactured, color, mileage, daily_rate, status, location_id, last_service_date, next_service_mileage) VALUES ('ABC123', 1, 2020, 'White', 15000, 25.00, 'AVAILABLE', 1, SYSDATE-30, 20000);
INSERT INTO car (registration, model_id, year_manufactured, color, mileage, daily_rate, status, location_id, last_service_date, next_service_mileage) VALUES ('XYZ789', 3, 2021, 'Black', 8000, 90.00, 'AVAILABLE', 2, SYSDATE-60, 15000);
INSERT INTO car (registration, model_id, year_manufactured, color, mileage, daily_rate, status, location_id, last_service_date, next_service_mileage) VALUES ('DEF456', 2, 2022, 'Silver', 5000, 75.00, 'AVAILABLE', 1, SYSDATE-15, 10000);
INSERT INTO car (registration, model_id, year_manufactured, color, mileage, daily_rate, status, location_id, last_service_date, next_service_mileage) VALUES ('GHI789', 4, 2019, 'Blue', 30000, 20.00, 'MAINTENANCE', 3, SYSDATE-90, 35000);
INSERT INTO car (registration, model_id, year_manufactured, color, mileage, daily_rate, status, location_id) VALUES ('JKL012', 5, 2021, 'Red', 12000, 110.00, 'AVAILABLE', 4);
INSERT INTO car (registration, model_id, year_manufactured, color, mileage, daily_rate, status, location_id) VALUES ('MNO345', 6, 2023, 'White', 2000, 150.00, 'AVAILABLE', 1);
INSERT INTO car (registration, model_id, year_manufactured, color, mileage, daily_rate, status, location_id) VALUES ('PQR678', 1, 2020, 'Gray', 18000, 25.00, 'AVAILABLE', 2);

INSERT INTO extra_equipment (description, daily_price, quantity, reorder_threshold) VALUES ('Child Seat', 10.00, 15, 5);
INSERT INTO extra_equipment (description, daily_price, quantity, reorder_threshold) VALUES ('GPS Unit', 15.00, 20, 3);
INSERT INTO extra_equipment (description, daily_price, quantity, reorder_threshold) VALUES ('Roof Rack', 20.00, 8, 2);
INSERT INTO extra_equipment (description, daily_price, quantity, reorder_threshold) VALUES('Winter Tires', 25.00, 5, 2);
INSERT INTO extra_equipment (description, daily_price, quantity, reorder_threshold) VALUES ('Cooler Box', 12.00, 10, 3);

INSERT INTO rental (customer_id, car_registration, start_date, end_date, total_cost, status, payment_method) VALUES (100, 'ABC123', SYSDATE-10, SYSDATE-5, 150.00, 'COMPLETED', 'Credit Card');
INSERT INTO rental (customer_id, car_registration, start_date, end_date, total_cost, status, payment_method) VALUES (101, 'XYZ789', SYSDATE-3, SYSDATE+4, 630.00, 'ONGOING', 'Debit Card');
INSERT INTO rental (customer_id, car_registration, start_date, end_date, total_cost, status, payment_method, discount_amount) VALUES (102, 'DEF456', SYSDATE+5, SYSDATE+10, 337.50, 'CONFIRMED', 'Cash', 37.50);
-- June 2022 Rentals (for view)
INSERT INTO rental (customer_id, car_registration, start_date, end_date, total_cost, status, payment_method, discount_amount) VALUES (100, 'ABC123', DATE '2022-06-01', DATE '2022-06-05', 125.00, 'COMPLETED', 'Credit Card', 0);
INSERT INTO rental (customer_id, car_registration, start_date, end_date, total_cost, status, payment_method, discount_amount) VALUES (101, 'XYZ789', DATE '2022-06-10', DATE '2022-06-15', 675.00, 'COMPLETED', 'Debit Card', 25.00);
INSERT INTO rental (customer_id, car_registration, start_date, end_date, total_cost, status, payment_method, discount_amount) VALUES (102, 'DEF456', DATE '2022-06-20', DATE '2022-06-25', 412.50, 'COMPLETED', 'Cash', 37.50);
INSERT INTO rental (customer_id, car_registration, start_date, end_date, total_cost, status, payment_method, discount_amount) VALUES (103, 'JKL012', SYSDATE-2, SYSDATE+5, 825.00, 'ONGOING', 'Credit Card', 0);
INSERT INTO rental (customer_id, car_registration, start_date, end_date, total_cost, status, payment_method, discount_amount) VALUES (104, 'MNO345', SYSDATE-1, SYSDATE+6, 900.00, 'ONGOING', 'Debit Card', 50.00);
INSERT INTO rental (customer_id, car_registration, start_date, end_date, total_cost, status, payment_method, discount_amount) VALUES (105, 'PQR678', SYSDATE+2, SYSDATE+7, 175.00, 'CONFIRMED', 'Cash', 0);

INSERT INTO rental (customer_id, car_registration, start_date, end_date, total_cost, status, payment_method, discount_amount) VALUES (100, 'GHI789', DATE '2023-01-05', DATE '2023-01-10', 150.00, 'COMPLETED', 'Credit Card', 0);
INSERT INTO rental (customer_id, car_registration, start_date, end_date, total_cost, status, payment_method, discount_amount) VALUES (101, 'ABC123', DATE '2023-02-15', DATE '2023-02-20', 125.00, 'COMPLETED', 'Debit Card', 10.00);
INSERT INTO rental (customer_id, car_registration, start_date, end_date, total_cost, status, payment_method, discount_amount) VALUES (102, 'XYZ789', DATE '2023-03-10', DATE '2023-03-15', 675.00, 'COMPLETED', 'Cash', 0);
INSERT INTO rental (customer_id, car_registration, start_date, end_date, total_cost, status, payment_method, discount_amount) VALUES (103, 'DEF456', DATE '2023-04-01', DATE '2023-04-05', 337.50, 'COMPLETED', 'Credit Card', 25.00);
INSERT INTO rental (customer_id, car_registration, start_date, end_date, total_cost, status, payment_method, discount_amount) VALUES (104, 'JKL012', DATE '2023-05-12', DATE '2023-05-17', 550.00, 'COMPLETED', 'Debit Card', 0);
INSERT INTO rental (customer_id, car_registration, start_date, end_date, total_cost, status, payment_method, discount_amount) VALUES (105, 'MNO345', DATE '2023-06-20', DATE '2023-06-25', 750.00, 'COMPLETED', 'Cash', 50.00);
INSERT INTO rental (customer_id, car_registration, start_date, end_date, total_cost, status, payment_method, discount_amount) VALUES (100, 'PQR678', DATE '2023-07-01', DATE '2023-07-07', 175.00, 'COMPLETED', 'Credit Card', 0);
INSERT INTO rental (customer_id, car_registration, start_date, end_date, total_cost, status, payment_method, discount_amount) VALUES (101, 'GHI789', DATE '2023-08-15', DATE '2023-08-20', 120.00, 'COMPLETED', 'Debit Card', 0);
INSERT INTO rental (customer_id, car_registration, start_date, end_date, total_cost, status, payment_method, discount_amount) VALUES (102, 'ABC123', DATE '2023-09-10', DATE '2023-09-15', 125.00, 'COMPLETED', 'Cash', 0);
INSERT INTO rental (customer_id, car_registration, start_date, end_date, total_cost, status, payment_method, discount_amount) VALUES (103, 'XYZ789', DATE '2023-10-05', DATE '2023-10-10', 675.00, 'COMPLETED', 'Credit Card', 25.00);
INSERT INTO rental (customer_id, car_registration, start_date, end_date, total_cost, status, payment_method, discount_amount) VALUES (104, 'DEF456', DATE '2023-11-12', DATE '2023-11-17', 337.50, 'COMPLETED', 'Debit Card', 0);
INSERT INTO rental (customer_id, car_registration, start_date, end_date, total_cost, status, payment_method, discount_amount) VALUES (105, 'JKL012', DATE '2023-12-20', DATE '2023-12-25', 550.00, 'COMPLETED', 'Cash', 50.00);


INSERT INTO rental_equipment VALUES (1001, 1, 2);  
INSERT INTO rental_equipment VALUES (1001, 2, 1);
INSERT INTO rental_equipment VALUES (1002, 3, 1);  
INSERT INTO rental_equipment VALUES (1003, 4, 1);  
INSERT INTO rental_equipment VALUES (1003, 2, 1);
INSERT INTO rental_equipment VALUES (1004, 1, 2);   
INSERT INTO rental_equipment VALUES (1004, 3, 1);
INSERT INTO rental_equipment VALUES (1005, 5, 1);

INSERT INTO maintenance_log (car_registration, maintenance_type, cost, description, technician) VALUES ('GHI789', 'Oil Change', 30.00, 'Regular oil and filter change', 'Ali Mohammed');
INSERT INTO maintenance_log (car_registration, maintenance_type, cost, description, technician) VALUES ('ABC123', 'Brake Service', 120.00, 'Replaced brake pads and rotors', 'Hassan Ahmed');
INSERT INTO maintenance_log (car_registration, maintenance_type, cost, description, technician) VALUES ('XYZ789', 'Tire Rotation', 50.00, 'Rotated tires and balance', 'Khalid Ahmed');
INSERT INTO maintenance_log (car_registration, maintenance_type, cost, description, technician) VALUES ('JKL012', 'Battery Check', 80.00, 'EV battery health inspection', 'Fatima Al-Mansoor');

COMMIT;
