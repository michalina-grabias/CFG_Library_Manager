-- Advanced options

USE library_manager;
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- 1. Create a stored procedure and demonstrate how it runs
-- -- -- -- -- -- -- -- ---- -- -- -- -- -- -- -- ---- -- -- -- -- -- -- -- ---- -- -- -- -- --

-- Add a new book to user shelf
DELIMITER //

CREATE PROCEDURE UpdateBookshelf(IN user_id_in VARCHAR(10), IN book_id_in VARCHAR(10), IN r_status_in VARCHAR(50))
BEGIN
	INSERT INTO reading_status (user_id, book_id, r_status)
    VALUES ( user_id_in, book_id_in, r_status_in);
END//

DELIMITER ; 

CALL UpdateBookshelf("U5", "B11", "read");

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- 2. Create a trigger and demonstrate how it runs
-- -- -- -- -- -- -- -- ---- -- -- -- -- -- -- -- ---- -- -- -- -- -- -- -- ---- -- -- -- -- --

-- Alert every time a user adds a "read" book to add a review

CREATE TRIGGER added_review
AFTER INSERT
ON ratings FOR EACH ROW
INSERT INTO reading_status
SET
user_id = ratings.user_id,
book_id = ratings.book_id,
r_status = "read";

INSERT INTO ratings
	(user_id, book_id, rating, comment)
VALUES 
	("U2", "B15", 5, NULL);

DESCRIBE ratings;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- 3. Create an event and demonstrate how it runs
-- -- -- -- -- -- -- -- ---- -- -- -- -- -- -- -- ---- -- -- -- -- -- -- -- ---- -- -- -- -- --

-- Log in last user activity

CREATE TABLE user_activity
(user_id INT NOT NULL AUTO_INCREMENT, 
last_update TIMESTAMP,
PRIMARY KEY (user_id));


DELIMITER //
CREATE EVENT user_login
ON SCHEDULE AT NOW() + INTERVAL 12 HOUR
DO
BEGIN
	INSERT INTO user_activity(last_update)
    VALUES (NOW());
END//

DELIMITER ;


-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- 4. Create a view that uses at least 3-4 base tables
-- -- -- -- -- -- -- -- ---- -- -- -- -- -- -- -- ---- -- -- -- -- -- -- -- ---- -- -- -- -- --



--- create a view to show book info, average rating & sth
-- show me books with rating > X

 --- add something more here
-- Show all users users arranged by how many books they've read and what is their role
CREATE VIEW all_users_ranking
AS
SELECT u.user_id, u.user_first_name, u.user_last_name, u.user_age, a.user_role, r.books_read
FROM users AS u
INNER JOIN
users_affiliation AS a
ON u.user_id = a.user_id
INNER JOIN
(SELECT r.user_id, COUNT(r.book_id) AS books_read
FROM reading_status AS r
WHERE r.r_status = "read"
GROUP BY user_id
ORDER BY books_read DESC) AS r
ON u.user_id = r.user_id;


-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- 5. Prepare and demonstrate a query that uses the view to produce a logically arranged result set for analysis
-- 6. Prepare an example query with group by and having to demonstrate how to extract data from your DB for analysis
-- -- -- -- -- -- -- -- ---- -- -- -- -- -- -- -- ---- -- -- -- -- -- -- -- ---- -- -- -- -- --

-- Select all students that have read more than 1 book
SELECT a.user_first_name, a.user_last_name, a.user_role, a.books_read
FROM all_users_ranking AS a
WHERE user_role = "student"
HAVING books_read >= 1;

-- Look at how much people read by role
SELECT a.user_role, AVG(books_read) AS average_books_read
FROM all_users_ranking AS a
GROUP BY user_role;

-- Show me all users arranged by how many books they read
SELECT r.user_id, COUNT(r.book_id) AS books_read
FROM reading_status AS r
WHERE r.r_status = "read"
GROUP BY user_id
ORDER BY books_read DESC;
