CREATE TABLE IF NOT EXISTS cathedra
(
  cathedra_id BIGSERIAL NOT NULL PRIMARY KEY,
  cathedra_name TEXT NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS departments
(
  department_id BIGSERIAL NOT NULL PRIMARY KEY,
  department_name TEXT NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS readers
(
  reader_id BIGSERIAL NOT NULL PRIMARY KEY,
  reader_name TEXT NOT NULL,
  reader_lastname TEXT NOT NULL,
  reader_patronymic TEXT,
  retired_data TEXT
);

CREATE TABLE IF NOT EXISTS entrants
(
  entrant_id BIGSERIAL NOT NULL PRIMARY KEY,
  reader_id INTEGER NOT NULL UNIQUE REFERENCES readers(reader_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS professors
(
  professor_id BIGSERIAL NOT NULL PRIMARY KEY,
  reader_id INTEGER NOT NULL UNIQUE REFERENCES readers(reader_id) ON DELETE CASCADE ,
  cathedra_id INTEGER NOT NULL UNIQUE REFERENCES cathedra(cathedra_id) ON DELETE CASCADE ,
  degree text NOT NULL,
  rank text NOT NULL
);

CREATE TABLE IF NOT EXISTS readers_halls
(
  hall_id BIGSERIAL NOT NULL PRIMARY KEY
);

CREATE TABLE IF NOT EXISTS book
(
  book_id BIGSERIAL NOT NULL PRIMARY KEY,
  author_name TEXT NOT NULL,
  author_surname TEXT NOT NULL,
  book_name TEXT NOT NULL,
  date_of_receipt TEXT NOT NULL,
  date_of_issue TEXT,
  cost INTEGER NOT NULL,
  hall_id INTEGER REFERENCES readers_halls(hall_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS readers_in_halls
(
  reader_id INTEGER NOT NULL REFERENCES readers(reader_id) ON DELETE CASCADE ,
  hall_id INTEGER NOT NULL REFERENCES readers_halls(hall_id) ON DELETE CASCADE,
  UNIQUE (reader_id, hall_id)
);

CREATE TABLE IF NOT EXISTS students
(
  student_id BIGSERIAL NOT NULL PRIMARY KEY,
  reader_id INTEGER NOT NULL UNIQUE REFERENCES readers(reader_id) ON DELETE CASCADE ,
  group_number INTEGER NOT NULL,
  course INTEGER NOT NULL,
  department_id INTEGER NOT NULL REFERENCES departments(department_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS tickets
(
  ticket_id BIGSERIAL NOT NULL PRIMARY KEY,
  reader_id INTEGER NOT NULL UNIQUE REFERENCES readers(reader_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS delivery
(
  delivery_id BIGSERIAL NOT NULL PRIMARY KEY,
  book_id INTEGER NOT NULL REFERENCES book(book_id) ON DELETE CASCADE,
  ticket_id INTEGER NOT NULL REFERENCES tickets(ticket_id) ON DELETE CASCADE ,
  date_of_receipt TEXT NOT NULL,
  estimated_return_date TEXT NOT NULL,
  reservation_date TEXT,
  real_return_date TEXT
);

CREATE TABLE IF NOT EXISTS lost_book
(
  book_id INTEGER NOT NULL PRIMARY KEY UNIQUE REFERENCES book(book_id) ON DELETE CASCADE ,
  ticket_id INTEGER NOT NULL REFERENCES tickets(ticket_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS violation
(
  violation_id BIGSERIAL NOT NULL PRIMARY KEY,
  months_of_punishment INTEGER NOT NULL ,
  description TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS readers_violations
(
  reader_violation_id BIGSERIAL NOT NULL PRIMARY KEY,
  violation_id INTEGER NOT NULL REFERENCES violation(violation_id) ON DELETE CASCADE,
  ticket_id INTEGER NOT NULL REFERENCES tickets(ticket_id) ON DELETE CASCADE ,
  violation_date TEXT NOT NULL,
  book_id INTEGER NOT NULL REFERENCES book(book_id) ON DELETE CASCADE
);