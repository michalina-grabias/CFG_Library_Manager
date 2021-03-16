-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- 1. Create database
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
CREATE DATABASE library_manager;
USE library_manager;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- 2. Create tables and set primary & foreign keys
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

CREATE TABLE users
    (user_id VARCHAR(10) NOT NULL, 
    user_first_name VARCHAR(50) NOT NULL,
    user_last_name VARCHAR(50) NOT NULL,
    user_email VARCHAR(50) NOT NULL,
    user_age INT,
    user_gender VARCHAR(20),
CONSTRAINT
    pk_user_id
PRIMARY KEY
    (user_id)
);


CREATE TABLE books
    (book_id VARCHAR(10) NOT NULL,
    book_title VARCHAR(100) NOT NULL,
    author_first_name VARCHAR(50) NOT NULL,
    author_last_name VARCHAR(50) NOT NULL,
    year_published INT NOT NULL,
CONSTRAINT
    pk_book_id
PRIMARY KEY
    (book_id));


CREATE TABLE book_genres
    (book_id VARCHAR(10) NOT NULL,
    genre VARCHAR(50), 
FOREIGN KEY
    (book_id)
REFERENCES
    books(book_id)
);


CREATE TABLE ratings
    (user_id VARCHAR(10) NOT NULL,
    book_id VARCHAR(10) NOT NULL,
    rating INT,
    comment VARCHAR(200),
FOREIGN KEY 
    (user_id)
REFERENCES 
    users(user_id),
FOREIGN KEY
    (book_id)
REFERENCES
    books(book_id)
);


CREATE TABLE users_affiliation
    (user_id VARCHAR(10) NOT NULL,
    user_role VARCHAR(50),
FOREIGN KEY
    (user_id)
REFERENCES 
    users(user_id)
);


CREATE TABLE reading_status
    (user_id VARCHAR(10) NOT NULL,
    book_id VARCHAR(10) NOT NULL,
    r_status VARCHAR(50) NOT NULL,
FOREIGN KEY
    (user_id)
REFERENCES
    users(user_id),
FOREIGN KEY
    (book_id)
REFERENCES
    books(book_id)
);

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- 3. Insert data into tables
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
INSERT INTO users
    (user_id, user_first_name, user_last_name, user_email, user_age, user_gender)
VALUES
    ('U1', 'Ella', 'Smith', 'ellas@gmail.com', 23, 'F'),
    ('U2', 'Katie', 'Jackson', 'katie@gmail.com', 15, 'F'),
    ('U3', 'Marc', 'Allen', 'marc@gmail.com', 12, 'M'),
    ('U4', 'Kelly', 'Sam', 'kelly@gmail.com', 37, 'F'),
    ('U5', 'Ian', 'Smith', 'ian@gmail.com', 31, 'M'),
    ('U6', 'Sarah', 'Nowak', 'sarah@gmail.com', 26, 'F'),
    ('U7', 'Anna', 'Kowalski', 'anna@gmail.com', 60, 'F'),
    ('U8', 'Jacob', 'Johnson', 'jacob@gmail.com', 29, 'M'),
    ('U9', 'Adam', 'Rowland', 'adam@gmail.com', 13, 'M'),
    ('U10', 'John', 'Brown', 'john@gmail.com', 43, 'M'),
    ('U11', 'Hannah', 'Watson', 'hannah@gmail.com', 45, 'F'),
    ('U12', 'Sam', 'Dubois', 'sam@gmail.com', 21, 'M'),
    ('U13', 'Allan', 'Taylor', 'allan@gmail.com', 33, 'M'),
    ('U14', 'Amber', 'Davies', 'amber@gmail.com', 18, 'F'),
    ('U15', 'Clarice', 'Evans', 'clarice@gmail.com', 19, 'F')
    ;

INSERT INTO books
    (book_id, book_title, author_first_name, author_last_name, year_published)
VALUES
    ('B1', 'Jane Eyre', 'Charlotte', 'Bronte', 1847),
    ('B2', 'Pride and Prejudice', 'Jane', 'Austen', 1813),
    ('B3', 'Les Miserables', 'Victor', 'Hugo', 1862),
    ('B4', 'Twilight', 'Stephanie', 'Meyer', 2005),
    ('B5', '1984', 'George', 'Orwell', 1949),
    ('B6', 'Cloud Atlas', 'David', 'Mitchell', 2004),
    ('B7', 'The Remains of the Day', 'Kazuo', 'Ishiguro', 1989),
    ('B8', 'Never Let Me Go', 'Kazuo', 'Ishiguro', 2005),
    ('B9', 'Catch-22', 'Joseph', 'Heller', 1961),
    ('B10', 'Becoming', 'Michelle', 'Obama', 2018),
    ('B11', 'Steve Jobs', 'Walter', 'Isaacson', 2011),
    ('B12', 'The Emperor', 'Ryszard', 'Kapuscinski', 1989),
    ('B13', 'Sophie\'s World', 'Jostein', 'Bronte', 1995),
    ('B14', 'A Promised Land', 'Barack', 'Obama', 2020),
    ('B15', 'The Catcher in the Rye', 'J. D.', 'Salinger', 2001)
    ;

INSERT INTO book_genres
    (book_id, genre)
VALUES
    ('B1', 'romance'),
    ('B1', 'gothic fiction'),
    ('B2', 'romance'),
    ('B2', 'historical fiction'),
    ('B3', 'historical fiction'),
    ('B4', 'coming-of-age story'),
    ('B5', 'dystopian novel'),
    ('B6', 'science fantasy'),
    ('B7', 'historical fiction'),
    ('B7', 'romance novel'),
    ('B8', 'dystopian novel'),
    ('B9', 'satire'),
    ('B10', 'autobiography'),
    ('B11', 'biography'),
    ('B12', 'biography'),
    ('B13', 'philosophical fiction'),
    ('B14', 'autobiography'),
    ('B1', 'coming-of-age story')
    ;

INSERT INTO ratings
    (user_id, book_id, rating, comment)
VALUES
    ('U1', 'B5', 5, 'excellent'),
    ('U1', 'B4', 2),
    ('U1', 'B1', 4),
    ('U2', 'B5', 5),
    ('U2', 'B4', 2),
    ('U2', 'B1', 4),
    ('U3', 'B10', 5, 'excellent'),
    ('U3', 'B5', 5, 'excellent'),
    ('U4', 'B5', 5, 'excellent'),
    ('U5', 'B5', 5),
    ('U6', 'B5', 5, 'excellent'),
    ('U7', 'B5', 4, 'very good!'),
    ('U8', 'B5', 5, 'excellent'),
    ('U9', 'B5', 5, 'excellent! read in one day'),
    ('U10', 'B5', 5),
    ('U11', 'B4', 1, 'not recommended'),
    ('U15', 'B4', 5),
    ('U8', 'B12', 3),
    ('U12', 'B15', 4, 'highly recommend'),
    ('U14', 'B14', 4),
    ('U13', 'B15', 4),
    ('U10', 'B9', 5, 'perfect for summer holiday!'),
    ('U11', 'B7', 3, 'mediocre'),
    ('U15', 'B12', 3, 'nothing special'),
    ('U11', 'B4', 2, 'boring'),
    ('U12', 'B6', 4, 'read in one day!');

INSERT INTO  users_affiliation
    (user_id, user_role)
VALUES
    ('U1', 'journalist'),
    ('U2', 'student'),
    ('U3', 'student'),
    ('U4', 'publisher'),
    ('U5', 'book critic'),
    ('U6', 'book critic'),
    ('U7', 'book critic'),
    ('U8', 'publisher'),
    ('U9', 'student'),
    ('U10', 'publisher'),
    ('U11', 'publisher'),
    ('U12', 'journalist'),
    ('U13', 'journalist'),
    ('U14', 'student'),
    ('U15', 'student')
    ;

INSERT INTO reading_status
    (user_id, book_id, r_status)
VALUES
    ('U1', 'B5', 'read'),
    ('U1', 'B4', 'read'),
    ('U1', 'B1', 'read'),
    ('U1', 'B2', 'to-read'),
    ('U1', 'B3', 'to-read'),
    ('U1', 'B6', 'to-read'),
    ('U1', 'B10', 'currently-reading'),
    ('U2', 'B5', 'read'),
    ('U2', 'B4', 'read'),
    ('U2', 'B1', 'read'),
    ('U2', 'B6', 'currently-reading'),
    ('U2', 'B10', 'currently-reading'),
    ('U2', 'B11', 'to-read'),
    ('U2', 'B15', 'to-read'),
    ('U3', 'B10', 'read'),
    ('U3', 'B5', 'read'),
    ('U3', 'B11', 'to-read'),
    ('U3', 'B12', 'to-read'),
    ('U3', 'B15', 'to-read'),
    ('U3', 'B1', 'currently-reading'),
    ('U3', 'B9', 'currently-reading'),
    ('U4', 'B5', 'read'),
    ('U4', 'B4', 'read'),
    ('U4', 'B12', 'read'),
    ('U4', 'B15', 'to-read'),
    ('U5', 'B5', 'read'),
    ('U5', 'B10', 'read'),
    ('U5', 'B5', 'currently-reading'),
    ('U6', 'B5', 'read'),
    ('U6', 'B4', 'to-read'),
    ('U6', 'B9', 'to-read'),
    ('U6', 'B10','to-read'),
    ('U6', 'B12', 'to-read'),
    ('U7', 'B5', 'read'),
    ('U7', 'B7', 'to-read'),
    ('U7', 'B6', 'to-read'),
    ('U7', 'B9', 'currently-reading'),
    ('U7', 'B12', 'to-read'),
    ('U8', 'B5', 'read'),
    ('U8', 'B6', 'to-read'),
    ('U8', 'B7', 'to-read'),
    ('U8', 'B8', 'to-read'),
    ('U8', 'B9', 'to-read'),
    ('U8', 'B10', 'to-read'),
    ('U9', 'B5', 'read'),
    ('U10', 'B5', 'read'),
    ('U10', 'B6', 'to-read'),
    ('U11', 'B6', 'to-read'),
    ('U11', 'B4', 'read'),
    ('U10', 'B12', 'to-read'),
    ('U15', 'B4', 'read'),
    ('U8', 'B12', 'read'),
    ('U12', 'B15', 'read'),
    ('U14', 'B14', 'read'),
    ('U13', 'B15', 'read'),
    ('U10', 'B9', 'read'),
    ('U11', 'B7', 'read'),
    ('U15', 'B12', 'read'),
    ('U11', 'B4', 'read'),
    ('U12', 'B6', 'read')
    ;