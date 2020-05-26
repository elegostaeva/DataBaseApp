-- Количество экземпляров книги на абонементах в текущее время --
SELECT COUNT(*)
FROM delivery
  JOIN book b on delivery.id_book = b.id_book
WHERE b.book_name = :book_name AND delivery.real_return_date IS NULL AND (julianday('now') -
                                                                          julianday(delivery.date_of_receipt)) < 186;


-- Количество экземпляров книги в холлах в текущее время --
SELECT COUNT(*)
FROM book b
WHERE b.book_name = :book_name AND b.id_hall = :hall_id;