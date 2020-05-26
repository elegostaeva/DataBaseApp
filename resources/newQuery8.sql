--Вывести всех читателей и их процент нарушений, у которых процент нарушений превышает 10--

SELECT readers.*
FROM readers
    INNER JOIN (SELECT tickets.id_reader as id_reader, COUNT(*) as count
      FROM tickets
             JOIN delivery d on tickets.id_ticket = d.id_ticket
             JOIN book b on d.id_book = b.id_book
             JOIN readers_violations rv on b.id_book = rv.id_book
      group by tickets.id_reader
     ) as violations_count
  ON readers.id_reader = violations_count.id_reader
       INNER JOIN
     (SELECT tickets.id_reader as id_reader, COUNT(*) as count
      FROM tickets
             JOIN delivery d on tickets.id_ticket = d.id_ticket
             JOIN book b on d.id_book = b.id_book
      group by tickets.id_reader
     ) as book_count
    ON violations_count.id_reader = book_count.id_reader
WHERE violations_count.count / book_count.count > 0.5;

-- group by having

SELECT rv.id_ticket, rv.id_violation
FROM book
LEFT JOIN readers_violations rv on book.id_book = rv.id_book
GROUP BY rv.id_ticket
HAVING COUNT(rv.id_violation) / COUNT(book.id_book) > 0.5;