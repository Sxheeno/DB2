CREATE INDEX idx_car_model ON car(model_id);
CREATE INDEX idx_car_location ON car(location_id, status);
CREATE INDEX idx_rental_dates ON rental(start_date, end_date);
CREATE INDEX idx_car_status ON car(status);
CREATE INDEX idx_model_manufacturer ON model(manufacturer_id, category_code);
CREATE INDEX idx_rental_customer ON rental(customer_id, status);
