-- Задание 4 --

-- Перечень книг, поступивших за последний год --

SELECT book.*
FROM book
where (julianday('now') -
       julianday(book.date_of_receipt)) < 365;


-- Число книг, поступивших за последний год --

SELECT COUNT(*)
FROM book
where (julianday('now') -
       julianday(book.date_of_receipt)) < 365;


-- Перечень книг, утерянных за последний год --

SELECT book.*, rv.violation_date
FROM book
       JOIN readers_violations rv on book.id_book = rv.id_book
WHERE (julianday('now') - julianday(rv.violation_date)) < 365 AND rv.id_violation = 1;


-- Число книг, утерянных за последний год --

SELECT COUNT(*)
FROM book
            JOIN readers_violations rv on book.id_book = rv.id_book
WHERE (julianday('now') - julianday(rv.violation_date)) < 365 AND rv.id_violation = 1;


-- Перечень книг, поступивших за последний год в определенном холле--

SELECT book.*
FROM book
JOIN readers_halls rh on book.id_hall = rh.id_hall
where rh.id_hall = :hall_id AND (julianday('now') -
       julianday(book.date_of_receipt)) < 365;


-- Число книг, поступивших за последний год в определенном холле--

SELECT COUNT(*)
FROM book
            JOIN readers_halls rh on book.id_hall = rh.id_hall
where rh.id_hall = :hall_id AND (julianday('now') -
                                 julianday(book.date_of_receipt)) < 365;


-- Перечень книг, поступивших за последний год по указанному автору--

SELECT b.*
FROM book b
where author_surname = ? AND (julianday('now') -
       julianday(b.date_of_receipt)) < 365;


-- Число книг, поступивших за последний год по указанному автору--

SELECT COUNT(*)
FROM book b
where b.author_surname = :author_surname AND (julianday('now') -
                                              julianday(b.date_of_receipt)) < 365;

