# Cheap Rent-a-Car Database Design

## Entity Relationship Diagram
![ERD Diagram](ERD.drawio)

## Business Rules
1. **Rental Rules**
   - Minimum rental duration: 1 day
   - Maximum rental duration: 30 days
   - Late return penalty: 10% of daily rate per day
   - Cancellation fee: 10% if cancelled <24h before start

2. **Car Status Flow**
   AVAILABLE → CONFIRMED → ONGOING → AVAILABLE  
   AVAILABLE → MAINTENANCE → AVAILABLE

3. **Pricing Rules**
   - Economy cars: Base rate
   - Luxury cars: Base rate × 2.5
   - SUVs: Base rate × 1.8

## Data Validation
- Email: Standard format validation
- Phone: Bahraini format (+973 or local)
- CPR: 9 digits for residents
- Passport: 6-20 alphanumeric for non-residents

## Security Model
- **Admin**: Full access
- **Staff**: CRUD on rentals, read-only on financials
- **Customers**: Web portal access only