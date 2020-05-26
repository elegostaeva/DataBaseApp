-- Выдать всю информацию о читателе --
SELECT r.*, s.id_department, s.group_number, s.course, p.id_cathedra, p.degree, p.rank
FROM readers r
  LEFT JOIN students s on r.id_reader = s.id_reader
  LEFT JOIN professors p on r.id_reader = p.id_reader
  LEFT OUTER JOIN tickets t on r.id_reader = t.id_reader
  LEFT JOIN entrants e on r.id_reader = e.id_reader
WHERE r.reader_name = :reader_name AND r.reader_lastname = :reader_lastname
GROUP BY r.id_reader;


-- Информация о нарушениях читателя и книгах, потерянных читателем --

SELECT r.*, rv.id_violation, rv.violation_date, rv.id_book
FROM readers r
       LEFT JOIN students s on r.id_reader = s.id_reader
       LEFT JOIN professors p on r.id_reader = p.id_reader
       JOIN tickets t on r.id_reader = t.id_reader
       LEFT OUTER JOIN lost_book lb on t.id_ticket = lb.id_ticket
       LEFT OUTER JOIN readers_violations rv on t.id_ticket = rv.id_ticket
WHERE r.reader_name = :reader_name AND r.reader_lastname = :reader_lastname;