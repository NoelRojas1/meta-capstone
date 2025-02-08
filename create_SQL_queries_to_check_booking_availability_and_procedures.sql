-- Task 1
INSERT INTO bookings (booking_id, booking_date, table_number, customer_id) 
VALUES 
(1, '2022-10-10', 5, 1),
(2, '2022-11-12', 3, 3),
(3, '2022-10-11', 2, 2),
(4, '2022-10-13', 2, 1);

-- Task 2
DELIMITER $$
CREATE PROCEDURE check_booking (IN p_booking_date DATE, IN p_table_number INT)
BEGIN
    DECLARE table_status VARCHAR(50);

    IF EXISTS (
        SELECT 1 FROM bookings 
        WHERE booking_date = p_booking_date 
        AND table_number = p_table_number
    ) 
    THEN
        SET table_status = CONCAT('Table ', p_table_number, ' is already booked on ', p_booking_date);
    ELSE
        SET table_status = CONCAT('Table ', p_table_number, ' is available on ', p_booking_date);
    END IF;

    SELECT table_status AS booking_status;
END $$
DELIMITER ;

CALL check_booking('2025-02-10', 5);

-- Task 3
DELIMITER $$
CREATE PROCEDURE add_valid_booking (
    IN p_booking_date DATE,
    IN p_table_number INT,
    IN p_number_of_guests INT,
    IN p_customer_id INT
)
BEGIN
    DECLARE table_exists INT;

    START TRANSACTION;

    SELECT COUNT(*) INTO table_exists
    FROM bookings
    WHERE booking_date = p_booking_date
    AND table_number = p_table_number;

    IF table_exists > 0 THEN
        ROLLBACK;
        SELECT CONCAT('Table ', p_table_number, ' is already booked - booking cancelled') AS booking_status;
    ELSE
        INSERT INTO bookings (booking_date, table_number, number_of_guests, customer_id)
        VALUES (p_booking_date, p_table_number, p_number_of_guests, p_customer_id);

        COMMIT;
        SELECT CONCAT('Booking confirmed for Table ', p_table_number, ' on ', p_booking_date) AS booking_status;
    END IF;
END $$
DELIMITER ;

CALL add_valid_booking('2025-02-15', 5, 2, 1);

