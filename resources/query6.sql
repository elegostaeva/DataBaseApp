-- Перечень книг, заказанных на межбиблиотечном абонементе за последний год --
SELECT b.book_name
FROM tickets
  JOIN delivery d on tickets.id_ticket = d.id_ticket
  JOIN book b on d.id_book = b.id_book
WHERE tickets.id_ticket = :ticket_id AND (julianday('now') -
                                          julianday(d.date_of_receipt)) < 365;


-- Общее число книг, заказанных на межбиблиотечном абонементе за последний год --
SELECT COUNT(*)
FROM tickets
       JOIN delivery d on tickets.id_ticket = d.id_ticket
       JOIN book b on d.id_book = b.id_book
WHERE tickets.id_ticket = :ticket_id AND (julianday('now') -
                                          julianday(d.date_of_receipt)) < 365;