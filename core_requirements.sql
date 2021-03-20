-- Core requirements
USE library_manager;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- 1. Using any type of the joins create a view that combines multiple tables in a logical way
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- Show all users users arranged by how many books they've read and what is their role
CREATE VIEW all_users_ranking
AS
SELECT 
    u.user_id, u.user_first_name, u.user_last_name, u.user_age, a.user_role, r.books_read
FROM 
    users AS u
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



-- Show all users that are students
CREATE VIEW students
AS
SELECT 
    u.user_first_name, u.user_last_name, a.user_role 
FROM 
    users AS u
RIGHT JOIN
    users_affiliation AS a
    ON u.user_id = a.user_id
WHERE 
    a.user_role = "student";


-- Show user information and their role for all users
CREATE VIEW users_roles_info
AS
SELECT 
    u.user_id, u.user_first_name, u.user_last_name, u.user_age, a.user_role
FROM 
    users AS u
INNER JOIN
    users_affiliation AS a
    ON u.user_id = a.user_id;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- 2. Create a stored function that can be applied to a query in your DB
-- -- -- -- -- -- -- -- ---- -- -- -- -- -- -- -- ---- -- -- -- -- -- -- -- ---- -- -- -- -- --

-- Has the user read > 3 books this year (completed their yearly challenge)

DELIMITER //

CREATE FUNCTION HowManyBooksRead(books_read INT)
RETURNS VARCHAR(10)
DETERMINISTIC

BEGIN

    DECLARE challenge_completed VARCHAR(10);

    IF books_read >= 3 THEN
    SET challenge_completed = "YES";

    ELSE SET challenge_completed = "NO";

    END IF;

RETURN(challenge_completed);
END//

DELIMITER ; 

SELECT 
	user_first_name, user_last_name, HowManyBooksRead(books_read)
FROM 
	all_users_ranking;


-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- 3. Prepare an example query with a subquery to demonstrate how to extract data from your DB for analysis
-- -- -- -- -- -- -- -- ---- -- -- -- -- -- -- -- ---- -- -- -- -- -- -- -- ---- -- -- -- -- --

--  Arrange books by average rating
CREATE VIEW average_books_ratings 
AS
SELECT r.book_id, AVG(r.rating) AS average_rating
FROM ratings AS r
GROUP BY book_id
ORDER BY average_rating DESC;

-- Select books with rating higher / lower than
SELECT b.book_title, b.author_first_name, b.author_last_name
FROM books AS b
WHERE b.book_id IN 
	(SELECT a.book_id
	FROM average_books_ratings AS a
	WHERE average_rating > 4);