-- Перечень читателей, у которых на руках книга --
SELECT readers.*
FROM readers
JOIN tickets t on readers.id_reader = t.id_reader
JOIN delivery d on t.id_ticket = d.id_ticket
JOIN book b on d.id_book = b.id_book
WHERE b.book_name = :book_name AND (julianday('now') - julianday(d.date_of_receipt)) < 186 AND d.real_return_date IS NULL;

-- Читатель, который должен раньше всех сдать книгу --

SELECT readers.*
FROM readers
       JOIN tickets t on readers.id_reader = t.id_reader
       JOIN delivery d on t.id_ticket = d.id_ticket
       JOIN book b on d.id_book = b.id_book
WHERE b.book_name = :book_name AND (julianday('now') - julianday(d.date_of_receipt)) < 186 AND d.real_return_date IS NULL
ORDER BY d.estimated_return_date ASC ;
