-- Пункт выдачи, на котором самое большое число читателей --

SELECT readers_in_halls.id_hall
FROM readers_in_halls
GROUP BY id_hall
ORDER BY COUNT(readers_in_halls.id_reader) DESC
LIMIT 1;


-- Пункт выдачи, на котором больше всего должников --

SELECT readers_in_halls.id_hall
FROM readers_in_halls
JOIN readers r on readers_in_halls.id_reader = r.id_reader
JOIN tickets t on r.id_reader = t.id_reader
JOIN readers_violations rv on t.id_ticket = rv.id_ticket
WHERE (julianday('now') - julianday(rv.violation_date)) < 186
GROUP BY id_hall
ORDER BY COUNT(readers_in_halls.id_reader) DESC
LIMIT 1;


-- Пункт выдачи, на котором самая большая сумма задолжности --

SELECT readers_in_halls.id_hall
FROM readers_in_halls
JOIN readers r on readers_in_halls.id_reader = r.id_reader
JOIN tickets t on r.id_reader = t.id_reader
JOIN delivery d on t.id_ticket = d.id_ticket
JOIN lost_book lb on t.id_ticket = lb.id_ticket
JOIN book b on d.id_book = b.id_book
GROUP BY readers_in_halls.id_hall
ORDER BY SUM(b.cost) DESC
LIMIT 1;

