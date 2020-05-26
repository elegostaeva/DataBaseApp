-- Выбрать все книги, которые ни разу не выдавались --

SELECT *
FROM book
WHERE id_book NOT IN
      (SELECT DISTINCT (id_book)
       FROM delivery
      );