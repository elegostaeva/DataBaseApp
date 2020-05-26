-- Наиболее заказываемая книга --

SELECT book.book_name,COUNT(book.book_name)
FROM book
JOIN delivery d on book.id_book = d.id_book
GROUP BY book.book_name
HAVING COUNT(book.book_name) = (
         SELECT MAX(y.num)
         FROM (SELECT COUNT(*) AS num
         FROM book
         JOIN delivery d on book.id_book = d.id_book
         GROUP BY book.book_name) y
       );

