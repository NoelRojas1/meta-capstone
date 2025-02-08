CREATE DATABASE IF NOT EXISTS Little_Lemon;
USE Little_Lemon;

CREATE TABLE customers (
    customer_id INT NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    phone_number VARCHAR(15),
    email VARCHAR(100),
    PRIMARY KEY (customer_id)
);

CREATE TABLE bookings (
    booking_id INT NOT NULL AUTO_INCREMENT,
    booking_date DATE,
    table_number INT,
    number_of_guests INT,
    customer_id INT,
    PRIMARY KEY (booking_id),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE
);

CREATE TABLE menu_items (
    item_id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(200),
    type VARCHAR(100),
    price DECIMAL(6,2),
    PRIMARY KEY (item_id)
);

CREATE TABLE menus (
    menu_id INT NOT NULL AUTO_INCREMENT,
    cuisine VARCHAR(20),
    PRIMARY KEY (menu_id)
);

CREATE TABLE menu_items_menus (
    menu_id INT,
    item_id INT,
    PRIMARY KEY (menu_id, item_id),
    FOREIGN KEY (menu_id) REFERENCES menus(menu_id) ON DELETE CASCADE,
    FOREIGN KEY (item_id) REFERENCES menu_items(item_id) ON DELETE CASCADE
);

CREATE TABLE orders (
    order_id INT NOT NULL AUTO_INCREMENT,
    order_date DATE,
    quantity INT NOT NULL CHECK (quantity > 0),
    total_cost DECIMAL(10,2), -- Increased precision
    customer_id INT,
    menu_id INT,
    PRIMARY KEY (order_id),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE SET NULL,
    FOREIGN KEY (menu_id) REFERENCES menus(menu_id) ON DELETE SET NULL
);

CREATE TABLE order_delivery_status (
    delivery_id INT NOT NULL AUTO_INCREMENT,
    order_id INT,
    delivery_date DATE,
    delivery_status ENUM('delivered', 'not_delivered'),
    PRIMARY KEY (delivery_id),
    FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE
);

CREATE TABLE staff_information (
    employee_id INT NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    role VARCHAR(50),
    salary DECIMAL(8,2),
    PRIMARY KEY (employee_id)
);

-- ===========================================================
INSERT INTO menu_items (item_id, name, type, price) 
VALUES
(1, 'Olives', 'Starters', 5.00), 
(2, 'Flatbread', 'Starters', 5.00),
(3, 'Minestrone', 'Starters', 8.00), 
(4, 'Tomato bread', 'Starters', 8.00), 
(5, 'Falafel', 'Starters', 7.00), 
(6, 'Hummus', 'Starters', 5.00), 
(7, 'Greek salad', 'Main Courses', 15.00), 
(8, 'Bean soup', 'Main Courses', 12.00), 
(9, 'Pizza', 'Main Courses', 15.00), 
(10, 'Greek yoghurt', 'Desserts', 7.00), 
(11, 'Ice cream', 'Desserts', 6.00),
(12, 'Cheesecake', 'Desserts', 4.00), 
(13, 'Athens White wine', 'Drinks', 25.00), 
(14, 'Corfu Red Wine', 'Drinks', 30.00), 
(15, 'Turkish Coffee', 'Drinks', 10.00), 
(16, 'Kabasa', 'Main Courses', 17.00);

INSERT INTO menus (menu_id, cuisine) 
VALUES
(1, 'Greek'),  
(2, 'Italian'), 
(3, 'Turkish');

INSERT INTO menu_items_menus (menu_id, item_id) 
VALUES 
(1, 1), (1, 2), (1, 7), (1, 6), (1, 10), (1, 13),
(2, 3), (2, 4), (2, 8), (2, 9), (2, 12), (2, 14), (2, 15),
(3, 5), (3, 6), (3, 16), (3, 11), (3, 15);

INSERT INTO customers (customer_id, first_name, last_name, phone_number, email)
VALUES 
(1, 'Alan', 'Iverson', '0757536371', 'alan.iverson@gmail.com'),
(2, 'Vanessa', 'McCarthy', '0757536372', 'v.mccarthy@gmail.com'),
(3, 'Marcos', 'Romero', '0757536373', 'm.romero@gmail.com'),
(4, 'Hiroki', 'Yamame', '0757536374', 'hiroki.y@gmail.com'),
(5, 'Anna', 'Iversen', '0757536375', 'anna.iversen@gmail.com'),
(6, 'Diana', 'Pinto', '0757536376', 'dianapinto@gmail.com'),
(7, 'Altay', 'Ayhan', '0757536377', 'ayhan.alt@gmail.com');

INSERT INTO bookings (booking_id, booking_date, table_number, number_of_guests, customer_id)
VALUES
(1, '2025-02-06', 12, 2, 1),  
(2, '2025-02-07', 12, 1, 2), 
(3, '2025-02-08', 19, 3, 3), 
(4, '2025-02-09', 15, 4, 4), 
(5, '2025-02-10', 5, 2, 5),
(6, '2025-02-11', 8, 5, 6); 

INSERT INTO orders (order_id, order_date, quantity, customer_id, menu_id, total_cost)
VALUES
(1, '2025-02-06', 1, 1, 2, 86.00), 
(2, '2025-02-07', 2, 2, 1, 37.00), 
(3, '2025-02-08', 2, 3, 1, 37.00), 
(4, '2025-02-09', 3, 4, 1, 40.00), 
(5, '2025-02-10', 1, 5, 1, 43.00);

INSERT INTO staff_information (employee_id, first_name, last_name, role, salary)  
VALUES  
(1, 'Sophia', 'Anderson', 'Manager', 55000.00),  
(2, 'Liam', 'Johnson', 'Head Chef', 48000.00),  
(3, 'Olivia', 'Martinez', 'Sous Chef', 42000.00),  
(4, 'Noah', 'Brown', 'Waiter', 25000.00),  
(5, 'Emma', 'Davis', 'Waitress', 25000.00),  
(6, 'James', 'Wilson', 'Bartender', 28000.00),  
(7, 'Ava', 'Taylor', 'Receptionist', 32000.00),  
(8, 'Mason', 'Moore', 'Dishwasher', 22000.00),  
(9, 'Isabella', 'White', 'Pastry Chef', 39000.00),  
(10, 'Ethan', 'Harris', 'Cleaner', 20000.00);