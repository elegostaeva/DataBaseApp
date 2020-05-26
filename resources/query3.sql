-- 5 книг, наиболее часто заказываемых в данном холле --
SELECT book.book_name,COUNT(book.book_name)
FROM book
JOIN delivery d on book.id_book = d.id_book
WHERE book.id_hall = :hall_id
GROUP BY book.book_name
ORDER BY COUNT(book.book_name) DESC
LIMIT 5;
