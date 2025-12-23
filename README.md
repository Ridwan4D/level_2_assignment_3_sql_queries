# Vehicle Rental System – Database Design & SQL Queries

## Project Overview
This project represents a simplified **Vehicle Rental System** designed to demonstrate core database concepts including **ERD design**, **table relationships**, **primary & foreign keys**, and **SQL querying techniques**.

The system manages users, vehicles, and bookings while supporting real-world rental business logic such as vehicle availability, booking status, and cost calculation.

This assignment focuses purely on **database design and SQL**, not application-level implementation.

---

## Objectives
By completing this project, the following concepts are demonstrated:

- Designing an ERD with:
  - One-to-Many relationships
  - Many-to-One relationships
  - Logical One-to-One relationships
- Proper use of:
  - Primary Keys (PK)
  - Foreign Keys (FK)
- Writing SQL queries using:
  - `JOIN`
  - `EXISTS / NOT EXISTS`
  - `WHERE`
  - `GROUP BY` and `HAVING`

---

## Database Tables

### Users Table
Stores system users.

**Fields:**
- `user_id` (PK)
- `name`
- `email` (Unique)
- `password`
- `phone`
- `role` (Admin / Customer)

**Business Rules:**
- Each user must have a unique email.
- Role determines system access (Admin or Customer).

---

### Vehicles Table
Stores rentable vehicles.

**Fields:**
- `vehicle_id` (PK)
- `vehicle_name`
- `vehicle_type` (Car / Bike / Truck)
- `model`
- `registration_number` (Unique)
- `price_per_day`
- `availability_status` (Available / Rented / Maintenance)

---

### Bookings Table
Stores booking records.

**Fields:**
- `booking_id` (PK)
- `user_id` (FK → Users)
- `vehicle_id` (FK → Vehicles)
- `start_date`
- `end_date`
- `booking_status` (Pending / Confirmed / Completed / Cancelled)
- `total_cost`

**Business Rules:**
- One booking belongs to exactly one user and one vehicle.
- A user can have multiple bookings.
- A vehicle can have multiple bookings over time.

---

## ERD Relationships

- **One-to-Many:**  
  Users → Bookings

- **Many-to-One:**  
  Bookings → Vehicles

- **Logical One-to-One:**  
  Each booking connects exactly one user and one vehicle.

The ERD includes:
- Primary keys
- Foreign keys
- Relationship cardinality
- Status fields

**ERD Tool Used:** Lucidchart  
 **Submission:** Public shareable ERD link

---

## SQL Queries Explanation (`queries.sql`)

All required queries are written and explained inside the `queries.sql` file.

### Query 1: Booking Details with Customer & Vehicle
- Uses `INNER JOIN`
- Displays:
  - Customer name
  - Vehicle name
  - Booking information

### Query 2: Vehicles Never Booked
- Uses `NOT EXISTS`
- Finds vehicles that do not appear in the bookings table.

### Query 3: Available Vehicles by Type
- Uses `WHERE`
- Filters vehicles by:
  - Availability status
  - Vehicle type (e.g., Car)

### Query 4: Vehicles with More Than 2 Bookings
- Uses:
  - `GROUP BY`
  - `HAVING`
  - `COUNT`
- Displays vehicles with booking count greater than 2.
---

