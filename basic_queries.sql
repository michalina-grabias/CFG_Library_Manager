-- extract all the users who gave 5 stars to book X
-- which group did give the highest average rating?
-- which user has the most books in their library
-- books from which century are the most popular

USE library_manager;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- 1. Using any type of the joins create a view that combines multiple tables in a logical way
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- Show all users that are students

SELECT u.user_first_name, u.user_last_name, a.user_role 
FROM users AS u
RIGHT JOIN
users_affiliation AS a
ON
u.user_id = a.user_id
WHERE a.user_role = "student";

-- create a view to see user information and their role
CREATE VIEW users_roles_info
AS
SELECT u.user_id, u.user_first_name, u.user_last_name, u.user_age, a.user_role
FROM users AS u
INNER JOIN
users_affiliation AS a
ON u.user_id = a.user_id;


-- create a view to see all users arranged by how many books they've read and what is their role
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
-- 2. Create a stored function that can be applied to a query in your DB
-- -- -- -- -- -- -- -- ---- -- -- -- -- -- -- -- ---- -- -- -- -- -- -- -- ---- -- -- -- -- --

-- show me a shelf of a user

-- give me all the reviews for book id X




-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- 3. Prepare an example query with a subquery to demonstrate how to extract data from your DB for analysis
-- -- -- -- -- -- -- -- ---- -- -- -- -- -- -- -- ---- -- -- -- -- -- -- -- ---- -- -- -- -- --

SELECT r.user_id, COUNT(r.book_id) AS books_read
FROM reading_status AS r
WHERE r.r_status = "read"
GROUP BY user_id
ORDER BY books_read DESC;
    

-- show me all the books with review of x

SELECT b.book_title, b.author_first_name, b.author_last_name, average_rating
FROM books AS b
WHERE b.book_id IN 
    (SELECT r.book_id
	FROM (SELECT r.book_id, AVG(r.rating) AS average_rating
        FROM ratings AS r
        WHERE average_rating < 3
        GROUP BY r.book_id
        ORDER BY average_rating DESC));

SELECT r.book_id, AVG(r.rating) AS average_rating
FROM ratings AS r
HAVING average_rating > 4
GROUP BY r.book_id
ORDER BY average_rating DESC;



-- -- -- -- -- -- -- -- ---- -- -- -- -- -- -- -- ---- -- -- -- -- -- -- -- ---- -- -- -- -- --
-- -- -- -- -- -- -- -- ---- -- -- -- -- -- -- -- ---- -- -- -- -- -- -- -- ---- -- -- -- -- --
-- Advanced options (at least 2-3)

- create a stored procedure and demonstrate how it runs
- create a trigger and demonstrate how it runs
- create an event and demonstrate how it runs
- create a view that uses at least 3-4 base tables
- prepare and demonstrate a query that uses the view to produce a logically arranged result set for analysis
- prepare an example query with group by and having to demonstrate how to extract data from your DB for analysis