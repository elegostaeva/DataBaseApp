-- Перечень читателей, лишенных права пользования библиотекой сроком более 2х месяцев по всей библиотеке --
SELECT r.*, v.months_of_punishment
FROM readers_violations
  JOIN violation v on readers_violations.id_violation = v.id_violation
  JOIN tickets t on readers_violations.id_ticket = t.id_ticket
  JOIN readers r on t.id_reader = r.id_reader
WHERE v.months_of_punishment > 2 AND (julianday('now') - julianday(readers_violations.violation_date)) < 186;


-- Перечень читателей, лишенных права пользования библиотекой сроком более 2х месяцев по кафедре --
SELECT r.*, v.months_of_punishment, c.id_cathedra
FROM readers_violations
       JOIN violation v on readers_violations.id_violation = v.id_violation
       JOIN tickets t on readers_violations.id_ticket = t.id_ticket
       JOIN readers r on t.id_reader = r.id_reader
       JOIN professors p on r.id_reader = p.id_reader
       JOIN cathedra c on p.id_cathedra = c.id_cathedra
WHERE c.id_cathedra = :cathedra_id AND v.months_of_punishment > 2 AND (julianday('now') - julianday(readers_violations.violation_date)) < 186;