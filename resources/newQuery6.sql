--Выбрать имена читателей-нарушителей, в названии книги при выдаче которой произошло нарушение есть подстрока "сад"

SELECT reader_name, reader_patronymic, reader_lastname, t.id_ticket, b.book_name, readers.id_reader
FROM readers
JOIN tickets t on readers.id_reader = t.id_reader
JOIN delivery d on t.id_ticket = d.id_ticket
JOIN book b on d.id_book = b.id_book
JOIN readers_violations rv on t.id_ticket = rv.id_ticket
WHERE LOWER( b.book_name ) LIKE  '%сад%';