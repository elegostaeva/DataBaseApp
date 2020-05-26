-- Перечень книг, заказанных данным читателем за год --
SELECT b.*
FROM delivery
  JOIN book b on delivery.id_book = b.id_book
  JOIN tickets t on delivery.id_ticket = t.id_ticket
  JOIN readers r on t.id_reader = r.id_reader
WHERE r.id_reader = :reader_id AND (julianday('now') -
                                    julianday(delivery.date_of_receipt)) < 365;


-- Количество книг, заказанных данным читателем за год --
SELECT COUNT(*)
FROM delivery
       JOIN book b on delivery.id_book = b.id_book
       JOIN tickets t on delivery.id_ticket = t.id_ticket
       JOIN readers r on t.id_reader = r.id_reader
WHERE r.id_reader = :reader_id AND (julianday('now') -
                                    julianday(delivery.date_of_receipt)) < 365;


-- Список книг, находящихся на руках у читателя --
SELECT b.*
FROM delivery
  JOIN book b on delivery.id_book = b.id_book
  JOIN tickets t on delivery.id_ticket = t.id_ticket
  JOIN readers r on t.id_reader = r.id_reader
WHERE r.id_reader = :reader_id AND delivery.real_return_date IS NULL AND (julianday('now') -
                                                                          julianday(delivery.date_of_receipt)) < 186;
