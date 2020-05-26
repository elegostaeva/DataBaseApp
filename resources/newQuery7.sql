-- Выбрать преподавателей перечисленных кафедр. Вывести в обратном алфавитном порядке по ФИО --
SELECT r.*
FROM professors
       JOIN readers r on professors.id_reader = r.id_reader
       JOIN cathedra c on professors.id_cathedra = c.id_cathedra
WHERE c.id_cathedra IN ('1',
                       '2')
ORDER BY r.reader_name DESC, r.reader_patronymic DESC, r.reader_lastname DESC;
