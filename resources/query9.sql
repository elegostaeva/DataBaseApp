-- Число выбывших читателей за последний год --
SELECT COUNT(*)
FROM readers
WHERE (julianday('now') - julianday(readers.retired_data)) < 365;


-- Перечень выбывших читателей за последний год --
SELECT readers.*
FROM readers
WHERE (julianday('now') - julianday(readers.retired_data)) < 365;


-- Число выбывших читателей за последний год в данном холле--
SELECT COUNT(*)
FROM readers
JOIN readers_in_halls rih on readers.id_reader = rih.id_reader
WHERE rih.id_hall = :hall_id AND (julianday('now') - julianday(readers.retired_data)) < 365;


-- Число выбывших читателей за последний год на данной кафедре--
SELECT COUNT(*)
FROM readers
JOIN students s on readers.id_reader = s.id_reader
JOIN departments d on s.id_department = d.id_department
WHERE s.id_department = :department_id AND (julianday('now') - julianday(readers.retired_data)) < 365;