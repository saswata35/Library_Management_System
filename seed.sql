-- 1. Insert Authors (5 rows)
INSERT INTO authors (name, bio) VALUES
('J.K. Rowling', 'British author, best known for the Harry Potter series.'),
('George R.R. Martin', 'American novelist, author of A Song of Ice and Fire.'),
('Agatha Christie', 'English writer known for her detective mystery novels.'),
('J.R.R. Tolkien', 'English writer and philologist, author of The Lord of the Rings.'),
('Dan Brown', 'American author of thriller fiction, known for The Da Vinci Code.');

-- 2. Insert Books (5 rows)
INSERT INTO books (title, isbn, published_year, total_copies, available_copies) VALUES
('Harry Potter and the Sorcerer''s Stone', '978-0590353427', 1997, 5, 4),
('A Game of Thrones', '978-0553103540', 1996, 3, 2),
('And Then There Were None', '978-0062073488', 1939, 4, 4),
('The Fellowship of the Ring', '978-0618346257', 1954, 3, 3),
('The Da Vinci Code', '978-0307474278', 2003, 4, 3);

-- 3. Insert Book-Author Mappings (5 rows)
INSERT INTO book_authors (book_id, author_id) VALUES 
(1, 1), (2, 2), (3, 3), (4, 4), (5, 5);

-- 4. Insert Members (5 rows)
INSERT INTO members (name, email, join_date) VALUES
('Alice Smith', 'alice@example.com', '2025-01-10'),
('Bob Jones', 'bob@example.com', '2025-02-15'),
('Charlie Brown', 'charlie@example.com', '2025-03-20'),
('Diana Prince', 'diana@example.com', '2025-04-05'),
('Ethan Hunt', 'ethan@example.com', '2025-05-12');

-- 5. Insert Borrowing Records (5 rows)
INSERT INTO borrowings (book_id, member_id, borrow_date, due_date, return_date) VALUES
(1, 1, '2026-10-10', '2026-10-24', NULL),
(2, 2, '2026-10-15', '2026-10-29', NULL),
(5, 4, '2026-10-20', '2026-11-15', NULL),
(1, 3, '2026-09-01', '2026-09-15', '2026-09-12'),
(2, 3, '2026-09-05', '2026-09-19', '2026-09-18');
