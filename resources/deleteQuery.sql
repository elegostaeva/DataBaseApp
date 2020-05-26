delete from delivery;

delete from entrants;

delete from lost_book;

delete from professors;

delete from readers_reader_halls;

delete from readers_violations;

delete from book;

delete from students;

delete from tickets;

delete from readers;

ALTER SEQUENCE book_book_id_seq RESTART;
ALTER SEQUENCE   delivery_delivery_id_seq RESTART;
ALTER SEQUENCE  entrants_entrant_id_seq RESTART;
ALTER SEQUENCE   professors_professor_id_seq RESTART;
ALTER SEQUENCE  readers_reader_id_seq RESTART;
ALTER SEQUENCE  readers_violations_reader_violation_id_seq RESTART;
ALTER SEQUENCE  students_student_id_seq RESTART;
ALTER SEQUENCE   tickets_ticket_id_seq RESTART;

delete from readers_halls;
alter sequence readers_halls_hall_id_seq restart;