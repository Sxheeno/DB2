INSERT INTO car_category VALUES ('ECO', 'Economy', 1.0);
INSERT INTO car_category VALUES ('LUX', 'Luxury', 2.5);
INSERT INTO car_category VALUES ('SUV', 'Sports Utility Vehicle', 1.8);

INSERT INTO manufacturer (name, country, founded_date) VALUES ('Toyota', 'Japan', TO_DATE('1937-08-28', 'YYYY-MM-DD'));
INSERT INTO manufacturer (name, country, founded_date) VALUES ('Nissan', 'Japan', TO_DATE('1933-12-26', 'YYYY-MM-DD'));
INSERT INTO manufacturer (name, country, founded_date) VALUES ('Ford', 'USA', TO_DATE('1903-06-16', 'YYYY-MM-DD'));
INSERT INTO manufacturer (name, country, founded_date) VALUES ('BMW', 'Germany', TO_DATE('1916-03-07', 'YYYY-MM-DD'));
INSERT INTO manufacturer (name, country, founded_date) VALUES ('Honda', 'Japan', TO_DATE('1948-09-24', 'YYYY-MM-DD'));

INSERT INTO model (manufacturer_id, model_name, engine_size, category_code, seats, fuel_type) VALUES (1, 'Corolla', 1.8, 'ECO', 5, 'Petrol');
INSERT INTO model (manufacturer_id, model_name, engine_size, category_code, seats, fuel_type) VALUES (1, 'Camry', 2.5, 'LUX', 5, 'Hybrid');
INSERT INTO model (manufacturer_id, model_name, engine_size, category_code, seats, fuel_type) VALUES (2, 'Patrol', 5.6, 'SUV', 7, 'Petrol');
INSERT INTO model (manufacturer_id, model_name, engine_size, category_code, seats, fuel_type) VALUES (3, 'Focus', 2.0, 'ECO', 5, 'Petrol');
INSERT INTO model (manufacturer_id, model_name, engine_size, category_code, seats, fuel_type) VALUES (4, 'X5', 3.0, 'SUV', 5, 'Diesel');
INSERT INTO model (manufacturer_id, model_name, engine_size, category_code, seats, fuel_type) VALUES (5, 'Accord', 1.5, 'LUX', 5, 'Hybrid');

INSERT INTO location (location_name, address_line1, city, phone, opening_hours) VALUES ('Main Branch', 'Building 45, Road 2305', 'Manama', '(973) 12345678', '07:00-22:00');
INSERT INTO location (location_name, address_line1, city, phone) VALUES ('Riffa Branch', 'Building 12, Road 1012', 'Riffa', '(973) 87654321');
INSERT INTO location (location_name, address_line1, city, phone) VALUES ('Muharraq Branch', 'Building 7, Road 789', 'Muharraq', '(973) 55556666');

INSERT INTO customer (first_name, last_name, cpr_passport, phone, street, block, city, email, loyalty_points) VALUES ('Ahmed', 'Alawi', '990101123', '(973) 11122233', 'Road 1001', 'Block 305', 'Manama', 'ahmed.alawi@email.com', 150);
INSERT INTO customer (first_name, last_name, cpr_passport, phone, street, block, city, email) VALUES ('Fatima', 'Khalid', '980202456', '(973) 44455566', 'Avenue 202', 'Block 412', 'Riffa', 'fatima.k@email.com');
INSERT INTO customer (first_name, last_name, cpr_passport, phone, street, block, city, email, loyalty_points) VALUES ('John', 'Smith', 'PASSPORT123', '(973) 77788899', 'Street 15', 'Block 107', 'Muharraq', 'john.smith@email.com', 75);

INSERT INTO car (registration, model_id, year_manufactured, color, mileage, daily_rate, status, location_id, last_service_date, next_service_mileage) VALUES ('ABC123', 1, 2020, 'White', 15000, 25.00, 'AVAILABLE', 1, SYSDATE-30, 20000);
INSERT INTO car (registration, model_id, year_manufactured, color, mileage, daily_rate, status, location_id, last_service_date, next_service_mileage) VALUES ('XYZ789', 3, 2021, 'Black', 8000, 90.00, 'AVAILABLE', 2, SYSDATE-60, 15000);
INSERT INTO car (registration, model_id, year_manufactured, color, mileage, daily_rate, status, location_id, last_service_date, next_service_mileage) VALUES ('DEF456', 2, 2022, 'Silver', 5000, 75.00, 'AVAILABLE', 1, SYSDATE-15, 10000);
INSERT INTO car (registration, model_id, year_manufactured, color, mileage, daily_rate, status, location_id, last_service_date, next_service_mileage) VALUES ('GHI789', 4, 2019, 'Blue', 30000, 20.00, 'MAINTENANCE', 3, SYSDATE-90, 35000);

INSERT INTO extra_equipment (description, daily_price, quantity, reorder_threshold) VALUES ('Child Seat', 10.00, 15, 5);
INSERT INTO extra_equipment (description, daily_price, quantity, reorder_threshold) VALUES ('GPS Unit', 15.00, 20, 3);
INSERT INTO extra_equipment (description, daily_price, quantity, reorder_threshold) VALUES ('Roof Rack', 20.00, 8, 2);

INSERT INTO rental (customer_id, car_registration, start_date, end_date, total_cost, status, payment_method) VALUES (1, 'ABC123', SYSDATE-10, SYSDATE-5, 150.00, 'COMPLETED', 'Credit Card');
INSERT INTO rental (customer_id, car_registration, start_date, end_date, total_cost, status, payment_method) VALUES (2, 'XYZ789', SYSDATE-3, SYSDATE+4, 630.00, 'ONGOING', 'Debit Card');
INSERT INTO rental (customer_id, car_registration, start_date, end_date, total_cost, status, payment_method, discount_amount) VALUES (3, 'DEF456', SYSDATE+5, SYSDATE+10, 337.50, 'CONFIRMED', 'Cash', 37.50);

INSERT INTO rental_equipment VALUES (2, 1, 2);
INSERT INTO rental_equipment VALUES (2, 2, 1);
INSERT INTO rental_equipment VALUES (3, 3, 1);

INSERT INTO maintenance_log (car_registration, maintenance_type, cost, description, technician) VALUES ('GHI789', 'Oil Change', 30.00, 'Regular oil and filter change', 'Ali Mohammed');
INSERT INTO maintenance_log (car_registration, maintenance_type, cost, description, technician) VALUES ('ABC123', 'Brake Service', 120.00, 'Replaced brake pads and rotors', 'Hassan Ahmed');

COMMIT;