-- Task 1
DELIMITER $$
CREATE PROCEDURE add_booking (
    IN p_table_number INT,
    IN p_number_of_guests INT,
    IN p_customer_id INT,
    IN p_booking_date DATE
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

CALL add_booking(9, 5, 2, '2025-02-15');

-- Task 2
DELIMITER $$
CREATE PROCEDURE update_booking (
    IN p_booking_id INT,
    IN p_booking_date DATE
)
BEGIN
    DECLARE table_exists INT;

    START TRANSACTION;

    SELECT COUNT(*) INTO table_exists
    FROM bookings
    WHERE booking_id = p_booking_id;

    IF table_exists > 0 THEN
        UPDATE bookings
        SET booking_date = p_booking_date
        WHERE booking_id = p_booking_id;

        COMMIT;
        SELECT CONCAT('Booking #', p_booking_id, ' updated. New date = ', p_booking_date) AS booking_status;
    ELSE
		ROLLBACK;
        SELECT CONCAT('Booking does not exist') AS booking_status;
    END IF;
END $$
DELIMITER ;

CALL update_booking(8, '2025-02-14');

-- Task 3
DELIMITER $$
CREATE PROCEDURE cancel_booking(IN p_booking_id INT)
BEGIN
	DECLARE booking_exists INT;
    
    START TRANSACTION;
    
    SELECT COUNT(*) INTO booking_exists
    FROM bookings
    WHERE booking_id = p_booking_id;
    
    IF booking_exists > 0 THEN
	DELETE FROM bookings
    WHERE booking_id = p_booking_id;
    COMMIT;
    
    SELECT CONCAT('Booking #', p_booking_id, ' cancelled.') AS booking_status;
    ELSE
		ROLLBACK;
        SELECT CONCAT('Booking does not exist') AS booking_status;
    END IF;
END $$
DELIMITER ;

CALL cancel_booking(1);

DELIMITER $$

CREATE PROCEDURE get_max_quantity()
BEGIN
    SELECT * 
    FROM orders
    WHERE quantity = (SELECT MAX(quantity) FROM orders);
END $$

DELIMITER ;
