 -- Create user type
CREATE TYPE
  user_role AS ENUM('Admin', 'Customer');

-- Create vehicle type
CREATE TYPE
  vehicle_status AS ENUM('available', 'rented', 'maintenance');

-- Create bookings type
CREATE TYPE
  booking_status AS ENUM('pending', 'confirmed', 'completed', 'cancelled');

-- Create users table
CREATE TABLE
  users (
    user_id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    email VARCHAR(50) UNIQUE NOT NULL,
    phone VARCHAR(20) NOT NULL,
    role user_role NOT NULL DEFAULT 'Customer'
  )
  -- Insert Data into usres
INSERT INTO
  users (name, email, phone, role)
VALUES
  (
    'Alice',
    'alice@example.com',
    '1234567890',
    'Customer'
  ),
  ('Bob', 'bob@example.com', '0987654321', 'Admin'),
  (
    'Charlie',
    'charlie@example.com',
    '1122334455',
    'Customer'
  );

-- Create Vehicles Table
CREATE TABLE
  vehicles (
    vehicle_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    type
      VARCHAR(50) NOT NULL,
      model INT NOT NULL,
      registration_number VARCHAR(50) NOT NULL UNIQUE,
      rental_price DECIMAL(10, 2) NOT NULL,
      status vehicle_status NOT NULL
  );

-- Insert data into Vehicles Table
INSERT INTO
  vehicles (
    vehicle_id,
    name,
    type
,
      model,
      registration_number,
      rental_price,
      status
  )
VALUES
  (
    1,
    'Toyota Corolla',
    'car',
    2022,
    'ABC-123',
    50.00,
    'available'
  ),
  (
    2,
    'Honda Civic',
    'car',
    2021,
    'DEF-456',
    60.00,
    'rented'
  ),
  (
    3,
    'Yamaha R15',
    'bike',
    2023,
    'GHI-789',
    30.00,
    'available'
  ),
  (
    4,
    'Ford F-150',
    'truck',
    2020,
    'JKL-012',
    100.00,
    'maintenance'
  );

-- Create Bookings Table
CREATE TABLE
  bookings (
    booking_id INT PRIMARY KEY,
    user_id INT NOT NULL REFERENCES users (user_id),
    vehicle_id INT NOT NULL REFERENCES vehicles (vehicle_id),
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    status booking_status NOT NULL,
    total_cost DECIMAL(10, 2) NOT NULL
  );

-- Insert data into Bookings Table
INSERT INTO
  bookings (
    booking_id,
    user_id,
    vehicle_id,
    start_date,
    end_date,
    status,
    total_cost
  )
VALUES
  (
    1,
    1,
    2,
    '2023-10-01',
    '2023-10-05',
    'completed',
    240.00
  ),
  (
    2,
    1,
    2,
    '2023-11-01',
    '2023-11-03',
    'completed',
    120.00
  ),
  (
    3,
    3,
    2,
    '2023-12-01',
    '2023-12-02',
    'confirmed',
    60.00
  ),
  (
    4,
    1,
    1,
    '2023-12-10',
    '2023-12-12',
    'pending',
    100.00
  );

-- Query -1: Find all vehicles that have never been booked.
SELECT
  booking_id,
  u.name,
  v.name,
  b.start_date,
  b.end_date,
  b.status
FROM
  bookings b
  JOIN users u USING (user_id)
  JOIN vehicles v USING (vehicle_id);

-- Query -2: Find all vehicles that have never been booked.
SELECT
  *
FROM
  vehicles v
WHERE
  NOT EXISTS (
    SELECT
      *
    FROM
      bookings b
    WHERE
      b.vehicle_id = v.vehicle_id
  );

-- Query -3: Retrieve all available vehicles of a specific type (e.g. cars).
SELECT
  *
FROM
  vehicles
WHERE
type
  = 'car'
  AND status = 'available';

-- Query -4: Find the total number of bookings for each vehicle and display only those vehicles that have more than 2 bookings.
SELECT
  v.name,
  COUNT(*) AS total_bookings
FROM
  bookings b
  JOIN vehicles v USING (vehicle_id)
GROUP BY
  v.name
HAVING
  COUNT(*) > 2;