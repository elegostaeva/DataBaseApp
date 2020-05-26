--Задание 1--

--Получить список всех читателей холла--

SELECT r.*, rih.id_hall
FROM readers_halls
       JOIN readers_in_halls rih ON readers_halls.id_hall = rih.id_hall
       JOIN readers r ON rih.id_reader = r.id_reader
WHERE readers_halls.id_hall = :hall_id;


--Получить количество читателей в холле--

SELECT COUNT(*)
FROM readers_halls
       JOIN readers_in_halls rih ON readers_halls.id_hall = rih.id_hall
       JOIN readers r ON rih.id_reader = r.id_reader
WHERE readers_halls.id_hall = :hall_id;


--Получить список всех читателей холла c факультета--

SELECT s.*, r.reader_name, r.reader_lastname, rih.id_hall
FROM readers_halls
       JOIN readers_in_halls rih ON readers_halls.id_hall = rih.id_hall
       JOIN readers r ON rih.id_reader = r.id_reader
       JOIN students s ON r.id_reader = s.id_reader
WHERE s.id_department = :depatrment_id AND readers_halls.id_hall = :hall_id;


--Получить список всех читателей холла c кафедры--

SELECT p.*, r.reader_name, r.reader_lastname, rih.id_hall
FROM readers_halls
       JOIN readers_in_halls rih ON readers_halls.id_hall = rih.id_hall
       JOIN readers r ON rih.id_reader = r.id_reader
       JOIN professors p ON r.id_reader = p.id_reader
WHERE p.id_cathedra = :cathedra_id AND readers_halls.id_hall = :hall_id;


--Получить список всех читателей холла по курсу--

SELECT s.*, r.reader_name, r.reader_lastname, rih.id_hall
FROM readers_halls
       JOIN readers_in_halls rih ON readers_halls.id_hall = rih.id_hall
       JOIN readers r ON rih.id_reader = r.id_reader
       JOIN students s ON r.id_reader = s.id_reader
WHERE s.course = :course AND readers_halls.id_hall = :hall_id;


--Получить список всех читателей холла по группе--

SELECT s.*, r.reader_name, r.reader_lastname, rih.id_hall
FROM readers_halls
       JOIN readers_in_halls rih ON readers_halls.id_hall = rih.id_hall
       JOIN readers r ON rih.id_reader = r.id_reader
       JOIN students s ON r.id_reader = s.id_reader
WHERE s.group_number = :group_number AND readers_halls.id_hall = :hall_id;


--Получить список всех читателей--

SELECT r.*
FROM readers r;

--Получить общее число читателей--

SELECT COUNT(*)
FROM readers;


--Получить список всех читателей c факультета--

SELECT s.*, r.reader_name, r.reader_lastname
FROM readers r
       JOIN students s ON r.id_reader = s.id_reader
WHERE s.id_department = :depatrment_id;


--Получить список всех читателей c кафедры--

SELECT p.*, r.reader_name, r.reader_lastname
FROM readers r
       JOIN professors p ON r.id_reader = p.id_reader
WHERE p.id_cathedra = :cathedra_id;


--Получить список всех читателей по курсу--

SELECT s.*, r.reader_name, r.reader_lastname
FROM readers r
       JOIN students s ON r.id_reader = s.id_reader
WHERE s.course = :course;


--Получить список всех читателей по группе--

SELECT s.*, r.reader_name, r.reader_lastname
FROM readers r
       JOIN students s ON r.id_reader = s.id_reader
WHERE s.group_number = :group_number;
