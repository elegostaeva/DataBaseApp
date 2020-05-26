--Задание 2--

--Список читателей-должников во всей библиотеке--

SELECT DISTINCT t.id_ticket, r.*
FROM readers_violations
            JOIN tickets t on readers_violations.id_ticket = t.id_ticket
            JOIN delivery d on t.id_ticket = d.id_ticket
            JOIN readers r on t.id_reader = r.id_reader
WHERE readers_violations.id_violation = 2 AND d.real_return_date IS NULL;


--Число всех читателей-должников--

SELECT COUNT(DISTINCT t.id_ticket)
FROM readers_violations
            JOIN tickets t on readers_violations.id_ticket = t.id_ticket
            JOIN delivery d on t.id_ticket = d.id_ticket
            JOIN readers r on t.id_reader = r.id_reader
WHERE readers_violations.id_violation = 2 AND d.real_return_date IS NULL;


--Список должников сроком более 10 дней во свей библиотеке--

SELECT DISTINCT t.id_ticket, r.*, d.estimated_return_date, d.real_return_date
FROM readers_violations
            JOIN tickets t on readers_violations.id_ticket = t.id_ticket
            JOIN delivery d on t.id_ticket = d.id_ticket
            JOIN readers r on t.id_reader = r.id_reader
WHERE readers_violations.id_violation = 2 AND d.real_return_date IS NULL AND (julianday('now') -
                                                                              julianday(d.estimated_return_date)) > 10;


--Число всех читателей-должников сроком более 10 дней во всей библиотеке--

SELECT COUNT(DISTINCT t.id_ticket)
FROM readers_violations
            JOIN tickets t on readers_violations.id_ticket = t.id_ticket
            JOIN delivery d on t.id_ticket = d.id_ticket
            JOIN readers r on t.id_reader = r.id_reader
WHERE readers_violations.id_violation = 2 AND d.real_return_date IS NULL AND (julianday('now') -
                                                                              julianday(d.estimated_return_date)) > 10;



--Список читателей-должников в данном холле--

SELECT DISTINCT r.*, rih.id_hall
FROM readers_violations
            JOIN tickets t on readers_violations.id_ticket = t.id_ticket
            JOIN delivery d on t.id_ticket = d.id_ticket
            JOIN readers r on t.id_reader = r.id_reader
            JOIN readers_in_halls rih on r.id_reader = rih.id_reader
            JOIN readers_halls rh on rih.id_hall = rh.id_hall
WHERE rh.id_hall = :hall_id AND readers_violations.id_violation = 2 AND d.real_return_date IS NULL;


--Число всех читателей-должников в данном холле--

SELECT COUNT(DISTINCT t.id_ticket)
FROM readers_violations
            JOIN tickets t on readers_violations.id_ticket = t.id_ticket
            JOIN delivery d on t.id_ticket = d.id_ticket
            JOIN readers r on t.id_reader = r.id_reader
            JOIN readers_in_halls rih on r.id_reader = rih.id_reader
            JOIN readers_halls rh on rih.id_hall = rh.id_hall
WHERE rh.id_hall = :hall_id AND readers_violations.id_violation = 2 AND d.real_return_date IS NULL;


--Список должников сроком более 10 дней в данном холле--

SELECT DISTINCT t.id_ticket, r.*, d.estimated_return_date, d.real_return_date, rih.id_hall
FROM readers_violations
            JOIN tickets t on readers_violations.id_ticket = t.id_ticket
            JOIN delivery d on t.id_ticket = d.id_ticket
            JOIN readers r on t.id_reader = r.id_reader
            JOIN readers_in_halls rih on r.id_reader = rih.id_reader
            JOIN readers_halls rh on rih.id_hall = rh.id_hall
WHERE rh.id_hall = :hall_id AND readers_violations.id_violation = 2 AND d.real_return_date IS NULL AND (julianday('now')
       - julianday(d.estimated_return_date)) > 10;


--Число всех читателей-должников сроком более 10 дней в данном холле--

SELECT COUNT(DISTINCT t.id_ticket)
FROM readers_violations
            JOIN tickets t on readers_violations.id_ticket = t.id_ticket
            JOIN delivery d on t.id_ticket = d.id_ticket
            JOIN readers r on t.id_reader = r.id_reader
            JOIN readers_in_halls rih on r.id_reader = rih.id_reader
            JOIN readers_halls rh on rih.id_hall = rh.id_hall
WHERE rh.id_hall = :hall_id AND readers_violations.id_violation = 2 AND d.real_return_date IS NULL AND (julianday('now')
       - julianday(d.estimated_return_date)) > 10;


--Список читателей-должников во всей библиотеке по признаку принадлежности к кафедре--

SELECT DISTINCT t.id_ticket, r.*, p.*
FROM readers_violations
            JOIN tickets t on readers_violations.id_ticket = t.id_ticket
            JOIN delivery d on t.id_ticket = d.id_ticket
            JOIN readers r on t.id_reader = r.id_reader
            JOIN professors p on r.id_reader = p.id_reader
WHERE  p.id_cathedra = :cathedra_id AND readers_violations.id_violation = 2 AND d.real_return_date IS NULL;


--Число всех читателей-должников по признаку принадлежности к кафедре--

SELECT COUNT(DISTINCT t.id_ticket)
FROM readers_violations
            JOIN tickets t on readers_violations.id_ticket = t.id_ticket
            JOIN delivery d on t.id_ticket = d.id_ticket
            JOIN readers r on t.id_reader = r.id_reader
            JOIN professors p on r.id_reader = p.id_reader
WHERE p.id_cathedra = :cathedra_id AND readers_violations.id_violation = 2 AND d.real_return_date IS NULL;



--Список должников сроком более 10 дней в данном холле на данной кафедре--

SELECT DISTINCT t.id_ticket, r.*, d.estimated_return_date, d.real_return_date, rih.id_hall, p.*
FROM readers_violations
            JOIN tickets t on readers_violations.id_ticket = t.id_ticket
            JOIN delivery d on t.id_ticket = d.id_ticket
            JOIN readers r on t.id_reader = r.id_reader
            JOIN readers_in_halls rih on r.id_reader = rih.id_reader
            JOIN readers_halls rh on rih.id_hall = rh.id_hall
            JOIN professors p on r.id_reader = p.id_reader
WHERE p.id_cathedra = :cathedra_id AND rh.id_hall = :hall_id AND readers_violations.id_violation = 2 AND
       d.real_return_date IS NULL AND (julianday('now') - julianday(d.estimated_return_date)) > 10;


--Число всех читателей-должников сроком более 10 дней в данном холле на данной кафедре--

SELECT COUNT(DISTINCT t.id_ticket)
FROM readers_violations
            JOIN tickets t on readers_violations.id_ticket = t.id_ticket
            JOIN delivery d on t.id_ticket = d.id_ticket
            JOIN readers r on t.id_reader = r.id_reader
            JOIN readers_in_halls rih on r.id_reader = rih.id_reader
            JOIN readers_halls rh on rih.id_hall = rh.id_hall
            JOIN professors p on r.id_reader = p.id_reader
WHERE p.id_cathedra = :cathedra_id AND rh.id_hall = :hall_id AND readers_violations.id_violation = 2 AND
       d.real_return_date IS NULL AND (julianday('now') - julianday(d.estimated_return_date)) > 10;


--Список читателей-должников во всей библиотеке по признаку принадлежности к факультету--

SELECT DISTINCT t.id_ticket, r.*, s.*
FROM readers_violations
            JOIN tickets t on readers_violations.id_ticket = t.id_ticket
            JOIN delivery d on t.id_ticket = d.id_ticket
            JOIN readers r on t.id_reader = r.id_reader
            JOIN students s on r.id_reader = s.id_reader
WHERE  s.id_department = :department_id AND readers_violations.id_violation = 2 AND d.real_return_date IS NULL;


--Число всех читателей-должников по признаку принадлежности к факультету--

SELECT COUNT(DISTINCT t.id_ticket)
FROM readers_violations
            JOIN tickets t on readers_violations.id_ticket = t.id_ticket
            JOIN delivery d on t.id_ticket = d.id_ticket
            JOIN readers r on t.id_reader = r.id_reader
            JOIN students s on r.id_reader = s.id_reader
WHERE  s.id_department = :department_id AND readers_violations.id_violation = 2 AND d.real_return_date IS NULL;


--Список должников сроком более 10 дней в данном холле на данному факультету--

SELECT DISTINCT t.id_ticket, r.*, d.estimated_return_date, d.real_return_date, rih.id_hall, s.*
FROM readers_violations
            JOIN tickets t on readers_violations.id_ticket = t.id_ticket
            JOIN delivery d on t.id_ticket = d.id_ticket
            JOIN readers r on t.id_reader = r.id_reader
            JOIN readers_in_halls rih on r.id_reader = rih.id_reader
            JOIN readers_halls rh on rih.id_hall = rh.id_hall
            JOIN students s on r.id_reader = s.id_reader
WHERE s.id_department = :department_id AND rh.id_hall = :hall_id AND readers_violations.id_violation = 2 AND
       d.real_return_date IS NULL AND (julianday('now') - julianday(d.estimated_return_date)) > 10;


--Число всех читателей-должников сроком более 10 дней в данном холле на данному факультету--

SELECT COUNT(DISTINCT t.id_ticket)
FROM readers_violations
            JOIN tickets t on readers_violations.id_ticket = t.id_ticket
            JOIN delivery d on t.id_ticket = d.id_ticket
            JOIN readers r on t.id_reader = r.id_reader
            JOIN readers_in_halls rih on r.id_reader = rih.id_reader
            JOIN readers_halls rh on rih.id_hall = rh.id_hall
            JOIN students s on r.id_reader = s.id_reader
WHERE s.id_department = :department_id AND rh.id_hall = :hall_id AND readers_violations.id_violation = 2 AND
       d.real_return_date IS NULL AND (julianday('now') - julianday(d.estimated_return_date)) > 10;


--Список читателей-должников во всей библиотеке по признаку принадлежности к курсу--

SELECT DISTINCT t.id_ticket, r.*, s.*
FROM readers_violations
            JOIN tickets t on readers_violations.id_ticket = t.id_ticket
            JOIN delivery d on t.id_ticket = d.id_ticket
            JOIN readers r on t.id_reader = r.id_reader
            JOIN students s on r.id_reader = s.id_reader
WHERE  s.course = :course AND readers_violations.id_violation = 2 AND d.real_return_date IS NULL;


--Число всех читателей-должников по признаку принадлежности к курсу--

SELECT COUNT(DISTINCT t.id_ticket)
FROM readers_violations
            JOIN tickets t on readers_violations.id_ticket = t.id_ticket
            JOIN delivery d on t.id_ticket = d.id_ticket
            JOIN readers r on t.id_reader = r.id_reader
            JOIN students s on r.id_reader = s.id_reader
WHERE  s.course = :course AND readers_violations.id_violation = 2 AND d.real_return_date IS NULL;


--Список должников сроком более 10 дней в данном холле на данному курсу--

SELECT DISTINCT t.id_ticket, r.*, d.estimated_return_date, d.real_return_date, rih.id_hall, s.*
FROM readers_violations
            JOIN tickets t on readers_violations.id_ticket = t.id_ticket
            JOIN delivery d on t.id_ticket = d.id_ticket
            JOIN readers r on t.id_reader = r.id_reader
            JOIN readers_in_halls rih on r.id_reader = rih.id_reader
            JOIN readers_halls rh on rih.id_hall = rh.id_hall
            JOIN students s on r.id_reader = s.id_reader
WHERE s.course = :course AND rh.id_hall = :hall_id AND readers_violations.id_violation = 2 AND
       d.real_return_date IS NULL AND (julianday('now') - julianday(d.estimated_return_date)) > 10;


--Число всех читателей-должников сроком более 10 дней в данном холле на данному курсу--

SELECT COUNT(DISTINCT t.id_ticket)
FROM readers_violations
            JOIN tickets t on readers_violations.id_ticket = t.id_ticket
            JOIN delivery d on t.id_ticket = d.id_ticket
            JOIN readers r on t.id_reader = r.id_reader
            JOIN readers_in_halls rih on r.id_reader = rih.id_reader
            JOIN readers_halls rh on rih.id_hall = rh.id_hall
            JOIN students s on r.id_reader = s.id_reader
WHERE s.course = :course AND rh.id_hall = :hall_id AND readers_violations.id_violation = 2 AND d.real_return_date
       IS NULL AND (julianday('now') - julianday(d.estimated_return_date)) > 10;


--Список читателей-должников во всей библиотеке по признаку принадлежности к группе--

SELECT DISTINCT t.id_ticket, r.*, s.*
FROM readers_violations
            JOIN tickets t on readers_violations.id_ticket = t.id_ticket
            JOIN delivery d on t.id_ticket = d.id_ticket
            JOIN readers r on t.id_reader = r.id_reader
            JOIN students s on r.id_reader = s.id_reader
WHERE  s.group_number = :group_numder AND readers_violations.id_violation = 2 AND d.real_return_date IS NULL;


--Число всех читателей-должников по признаку принадлежности к группе--

SELECT COUNT(DISTINCT t.id_ticket)
FROM readers_violations
            JOIN tickets t on readers_violations.id_ticket = t.id_ticket
            JOIN delivery d on t.id_ticket = d.id_ticket
            JOIN readers r on t.id_reader = r.id_reader
            JOIN students s on r.id_reader = s.id_reader
WHERE  s.group_number = :group_numder AND readers_violations.id_violation = 2 AND d.real_return_date IS NULL;


--Список должников сроком более 10 дней в данном холле на данной группе--

SELECT DISTINCT t.id_ticket, r.*, d.estimated_return_date, d.real_return_date, rih.id_hall, s.*
FROM readers_violations
            JOIN tickets t on readers_violations.id_ticket = t.id_ticket
            JOIN delivery d on t.id_ticket = d.id_ticket
            JOIN readers r on t.id_reader = r.id_reader
            JOIN readers_in_halls rih on r.id_reader = rih.id_reader
            JOIN readers_halls rh on rih.id_hall = rh.id_hall
            JOIN students s on r.id_reader = s.id_reader
WHERE s.group_number = :group_numder AND rh.id_hall = :hall_id AND readers_violations.id_violation = 2 AND
       d.real_return_date IS NULL AND (julianday('now') - julianday(d.estimated_return_date)) > 10;


--Число всех читателей-должников сроком более 10 дней в данном холле на данной группе--

SELECT COUNT(DISTINCT t.id_ticket)
FROM readers_violations
            JOIN tickets t on readers_violations.id_ticket = t.id_ticket
            JOIN delivery d on t.id_ticket = d.id_ticket
            JOIN readers r on t.id_reader = r.id_reader
            JOIN readers_in_halls rih on r.id_reader = rih.id_reader
            JOIN readers_halls rh on rih.id_hall = rh.id_hall
            JOIN students s on r.id_reader = s.id_reader
WHERE s.group_number = :group_numder AND rh.id_hall = :hall_id AND readers_violations.id_violation = 2 AND
       d.real_return_date IS NULL AND (julianday('now') - julianday(d.estimated_return_date)) > 10;


--Список профессоров-должников во всей библиотеке--

SELECT DISTINCT t.id_ticket, r.*, p.*
FROM readers_violations
            JOIN tickets t on readers_violations.id_ticket = t.id_ticket
            JOIN delivery d on t.id_ticket = d.id_ticket
            JOIN readers r on t.id_reader = r.id_reader
            JOIN professors p on r.id_reader = p.id_reader
WHERE  readers_violations.id_violation = 2 AND d.real_return_date IS NULL;


--Число всех профессоров-должников по всей библиотеке--

SELECT COUNT(DISTINCT t.id_ticket)
FROM readers_violations
            JOIN tickets t on readers_violations.id_ticket = t.id_ticket
            JOIN delivery d on t.id_ticket = d.id_ticket
            JOIN readers r on t.id_reader = r.id_reader
            JOIN professors p on r.id_reader = p.id_reader
WHERE  readers_violations.id_violation = 2 AND d.real_return_date IS NULL;


--Список профессоров-должников сроком более 10 дней в данном холле--

SELECT DISTINCT t.id_ticket, r.*, d.estimated_return_date, d.real_return_date, rih.id_hall, p.*
FROM readers_violations
            JOIN tickets t on readers_violations.id_ticket = t.id_ticket
            JOIN delivery d on t.id_ticket = d.id_ticket
            JOIN readers r on t.id_reader = r.id_reader
            JOIN readers_in_halls rih on r.id_reader = rih.id_reader
            JOIN readers_halls rh on rih.id_hall = rh.id_hall
            JOIN professors p on r.id_reader = p.id_reader
WHERE rh.id_hall = :hall_id AND readers_violations.id_violation = 2 AND
       d.real_return_date IS NULL AND (julianday('now') - julianday(d.estimated_return_date)) > 10;


--Число профессоров-должников сроком более 10 дней в данном холле--

SELECT COUNT(DISTINCT t.id_ticket)
FROM readers_violations
            JOIN tickets t on readers_violations.id_ticket = t.id_ticket
            JOIN delivery d on t.id_ticket = d.id_ticket
            JOIN readers r on t.id_reader = r.id_reader
            JOIN readers_in_halls rih on r.id_reader = rih.id_reader
            JOIN readers_halls rh on rih.id_hall = rh.id_hall
            JOIN professors p on r.id_reader = p.id_reader
WHERE rh.id_hall = :hall_id AND readers_violations.id_violation = 2 AND
       d.real_return_date IS NULL AND (julianday('now') - julianday(d.estimated_return_date)) > 10;


--Список студентов-должников во всей библиотеке--

SELECT DISTINCT t.id_ticket, r.*, s.*
FROM readers_violations
            JOIN tickets t on readers_violations.id_ticket = t.id_ticket
            JOIN delivery d on t.id_ticket = d.id_ticket
            JOIN readers r on t.id_reader = r.id_reader
            JOIN students s on r.id_reader = s.id_reader
WHERE  readers_violations.id_violation = 2 AND d.real_return_date IS NULL;


--Число всех студентов-должников по всей библиотеке--

SELECT COUNT(DISTINCT t.id_ticket)
FROM readers_violations
            JOIN tickets t on readers_violations.id_ticket = t.id_ticket
            JOIN delivery d on t.id_ticket = d.id_ticket
            JOIN readers r on t.id_reader = r.id_reader
            JOIN students s on r.id_reader = s.id_reader
WHERE  readers_violations.id_violation = 2 AND d.real_return_date IS NULL;


--Список студентов-должников сроком более 10 дней в данном холле--

SELECT DISTINCT t.id_ticket, r.*, d.estimated_return_date, d.real_return_date, rih.id_hall, s.*
FROM readers_violations
            JOIN tickets t on readers_violations.id_ticket = t.id_ticket
            JOIN delivery d on t.id_ticket = d.id_ticket
            JOIN readers r on t.id_reader = r.id_reader
            JOIN readers_in_halls rih on r.id_reader = rih.id_reader
            JOIN readers_halls rh on rih.id_hall = rh.id_hall
            JOIN students s on r.id_reader = s.id_reader
WHERE rh.id_hall = :hall_id AND readers_violations.id_violation = 2 AND
       d.real_return_date IS NULL AND (julianday('now') - julianday(d.estimated_return_date)) > 10;


--Число студентов-должников сроком более 10 дней в данном холле--

SELECT COUNT(DISTINCT t.id_ticket)
FROM readers_violations
            JOIN tickets t on readers_violations.id_ticket = t.id_ticket
            JOIN delivery d on t.id_ticket = d.id_ticket
            JOIN readers r on t.id_reader = r.id_reader
            JOIN readers_in_halls rih on r.id_reader = rih.id_reader
            JOIN readers_halls rh on rih.id_hall = rh.id_hall
            JOIN students s on r.id_reader = s.id_reader
WHERE rh.id_hall = :hall_id AND readers_violations.id_violation = 2 AND
       d.real_return_date IS NULL AND (julianday('now') - julianday(d.estimated_return_date)) > 10;