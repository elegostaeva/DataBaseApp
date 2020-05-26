-- Для читателей вывести книги, которые они чаще всего берут. Если читатель берёт несколько книг одинаково часто,
-- вывести книгу с "наименьшим" в алфавитном порядке названим.

SELECT book.book_name
FROM book
       JOIN delivery d on book.id_book = d.id_book
       JOIN tickets t on d.id_ticket = t.id_ticket
       JOIN readers r on t.id_reader = r.id_reader
WHERE r.id_reader IN ('8')
GROUP BY book.book_name
HAVING COUNT(book.book_name) = (
  SELECT MAX(y.num)
  FROM (SELECT COUNT(*) AS num
        FROM book
               JOIN delivery d on book.id_book = d.id_book
               JOIN tickets t on d.id_ticket = t.id_ticket
               JOIN readers r on t.id_reader = r.id_reader
        WHERE r.id_reader IN ('8')
        GROUP BY book.id_book) y
)
ORDER BY book_name DESC
LIMIT 1;

-- Вывести всех читателей
-- distinct on