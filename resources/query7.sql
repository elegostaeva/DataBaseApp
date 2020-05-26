-- Количество экземпляров книги для данного читального зала --
SELECT COUNT(*)
    FROM book
WHERE book.book_name = :book_name AND book.id_hall = :id_hall;


-- Количество экземпляров книги во всей библиотеке --
SELECT COUNT(*)
FROM book
WHERE book.book_name = :book_name AND book.id_hall NOT NULL;