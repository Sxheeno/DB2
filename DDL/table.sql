-- MANUFACTURER TABLE
CREATE TABLE manufacturer (
    manufacturer_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR2(50) NOT NULL,
    country VARCHAR2(50),
    founded_date DATE
);

-- CAR_CATEGORY TABLE
CREATE TABLE car_category (
    category_code VARCHAR2(3) PRIMARY KEY,
    description VARCHAR2(50) NOT NULL,
    daily_rate_multiplier NUMBER(3,2) DEFAULT 1.00
);

-- MODEL TABLE
CREATE TABLE model (
    model_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    manufacturer_id NUMBER REFERENCES manufacturer(manufacturer_id),
    model_name VARCHAR2(50) NOT NULL,
    engine_size NUMBER,
    category_code VARCHAR2(3) REFERENCES car_category(category_code),
    seats NUMBER DEFAULT 5,
    fuel_type VARCHAR2(20) CHECK (fuel_type IN ('Petrol', 'Diesel', 'Hybrid', 'Electric'))
);

-- LOCATION TABLE
CREATE TABLE location (
    location_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    location_name VARCHAR2(50),
    address_line1 VARCHAR2(100) NOT NULL,
    city VARCHAR2(50) NOT NULL,
    phone VARCHAR2(20) NOT NULL,
    opening_hours VARCHAR2(100) DEFAULT '08:00-20:00'
);

-- CUSTOMER TABLE
CREATE TABLE customer (
    customer_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    first_name VARCHAR2(50) NOT NULL,
    last_name VARCHAR2(50) NOT NULL,
    cpr_passport VARCHAR2(20) NOT NULL UNIQUE,
    phone VARCHAR2(20) NOT NULL,
    street VARCHAR2(100) NOT NULL,
    block VARCHAR2(10) NOT NULL,
    city VARCHAR2(50) NOT NULL,
    email VARCHAR2(100) NOT NULL UNIQUE,
    registration_date DATE DEFAULT SYSDATE,
    loyalty_points NUMBER DEFAULT 0
);

-- CAR TABLE
CREATE TABLE car (
    registration VARCHAR2(20) PRIMARY KEY,
    model_id NUMBER REFERENCES model(model_id),
    year_manufactured NUMBER NOT NULL,
    color VARCHAR2(20) NOT NULL,
    mileage NUMBER DEFAULT 0,
    daily_rate NUMBER(10,2) NOT NULL,
    status VARCHAR2(20) DEFAULT 'AVAILABLE' CHECK (status IN ('AVAILABLE', 'RENTED', 'MAINTENANCE')),
    location_id NUMBER REFERENCES location(location_id),
    last_service_date DATE,
    next_service_mileage NUMBER
);

-- EXTRA_EQUIPMENT TABLE
CREATE TABLE extra_equipment (
    equipment_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    description VARCHAR2(100) NOT NULL,
    daily_price NUMBER(10,2) NOT NULL,
    quantity NUMBER DEFAULT 0,
    reorder_threshold NUMBER DEFAULT 5
);

-- RENTAL TABLE
CREATE TABLE rental (
    rental_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    customer_id NUMBER REFERENCES customer(customer_id),
    car_registration VARCHAR2(20) REFERENCES car(registration),
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    actual_return_date DATE,
    total_cost NUMBER(10,2),
    status VARCHAR2(20) DEFAULT 'CONFIRMED' CHECK (status IN ('CONFIRMED', 'ONGOING', 'CANCELLED', 'COMPLETED')),
    payment_method VARCHAR2(20),
    discount_amount NUMBER(10,2) DEFAULT 