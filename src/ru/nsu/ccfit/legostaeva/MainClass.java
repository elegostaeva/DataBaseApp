package ru.nsu.ccfit.legostaeva;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;
import java.util.concurrent.ThreadLocalRandom;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class MainClass {
    private static final int HALLS_NUMBER = 10;
    private static final int BOOKS_COUNT = 722;
    int bookIndex = 1;

    public static Connection connect() {
        Connection conn = null;
        try {
            // db parameters
            String url = "jdbc:postgresql://localhost:5433/postgres";
            // create a connection to the database
            conn = DriverManager.getConnection(url, "postgres", "tolyalalka");

            System.out.println("Connection to SQLite has been established.");

        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }

        return conn;
    }

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) throws SQLException, IOException {
        Connection connection = connect();
        if (connection == null) {
            return;
        }
        PreparedStatement statementInsertBook = connection.prepareStatement("INSERT " +
                "INTO book(author_name, author_surname, book_name, date_of_receipt, date_of_issue, cost, hall_id) " +
                "VALUES (?,?,?,?,?,?,?)");
        writeBooks(connection, statementInsertBook);
        List<String> manNames = readFile("man_names.txt");
        List<String> womanNames = readFile("woman_names.txt");
        List<String> manLastNames = readFile("man_last_name.txt");
        List<String> womanLastNames = readFile("woman_last_name.txt");
        List<String> manPatronomycs = readFile("man_patronomycs.txt");
        List<String> womanPatronomycs = readFile("woman_patronomycs.txt");

        PreparedStatement statementInsertReader = connection.prepareStatement("INSERT INTO readers(reader_name, reader_lastname, reader_patronymic, retired_data) VALUES (?, ?, ?, ?) RETURNING reader_id");
        PreparedStatement statementInsertStudent = connection.prepareStatement("INSERT INTO students(reader_id, group_number, course, department_id) VALUES (?, ?, ?, ?)");
        PreparedStatement statementInsertProfessors = connection.prepareStatement("INSERT INTO professors(reader_id, cathedra_id, degree, rank) VALUES (?, ?, ?, ?)");
        PreparedStatement statementInsertEntrants = connection.prepareStatement("INSERT INTO entrants(reader_id) VALUES (?)");
        PreparedStatement statementInsertReadersInHalls = connection.prepareStatement("INSERT INTO readers_reader_halls(reader_id, hall_id) VALUES (?, ?)");
        PreparedStatement statementInsertTickets = connection.prepareStatement("INSERT INTO tickets(reader_id) VALUES (?) RETURNING ticket_id");
        PreparedStatement statementInsertLostBooks = connection.prepareStatement("INSERT INTO lost_book(book_id, ticket_id) VALUES (?, ?)");
        PreparedStatement statementInsertDelivery = connection.prepareStatement("INSERT INTO delivery(book_id, ticket_id, date_of_receipt, estimated_return_date, reservation_date, real_return_date) VALUES (?, ?, ?, ?, ?, ?)");
        PreparedStatement statementInsertReadersViolations = connection.prepareStatement("INSERT INTO readers_violations(violation_id, ticket_id, violation_date, book_id) VALUES (?, ?, ?, ?)");

        PreparedStatement statementUpdateBook = connection.prepareStatement("UPDATE book SET hall_id = null WHERE book_id = ?");
        int bookIndex = 1;
        Random random = new Random(System.currentTimeMillis());
        for (int i = 0; i < BOOKS_COUNT/2; i++) {
            boolean isWomen = random.nextBoolean();
            Date retiredDate = randomDate(
                    LocalDate.of(2017, 1, 1),
                    LocalDate.of(2019, 9, 1));
            boolean hasRetiredDate = false;
            if (isWomen) {
                hasRetiredDate = prepareStatement(womanNames, womanLastNames, womanPatronomycs, random, statementInsertReader, retiredDate);
            } else {
                hasRetiredDate = prepareStatement(manNames, manLastNames, manPatronomycs, random, statementInsertReader, retiredDate);
            }

            ResultSet resultSet = statementInsertReader.executeQuery();
            resultSet.next();
            long readerId = resultSet.getLong(1);
            boolean readerBelongsToHall = false;
            for (int j = 1; j <= HALLS_NUMBER; j++) {
                boolean readerBelongsToCurrentHall = random.nextBoolean();
                if (readerBelongsToCurrentHall) {
                    statementInsertReadersInHalls.setLong(1, readerId);
                    statementInsertReadersInHalls.setInt(2, j);
                    statementInsertReadersInHalls.executeUpdate();
                    readerBelongsToHall = true;
                }
            }
            if (!readerBelongsToHall) {
                statementInsertReadersInHalls.setLong(1, readerId);
                statementInsertReadersInHalls.setInt(2, randBetween(1, HALLS_NUMBER));
                statementInsertReadersInHalls.executeUpdate();
            }
            int randomInt = random.nextInt(10);
            int ticketId = 0;
            if (randomInt == 0) {
                statementInsertEntrants.setLong(1, readerId);
                statementInsertEntrants.executeUpdate();
            } else if (randomInt < 3) {
                statementInsertProfessors.setLong(1, readerId);
                statementInsertProfessors.setInt(2, randBetween(1, 7));
                boolean isDoctor = random.nextBoolean();
                if (isDoctor) {
                    statementInsertProfessors.setString(3, "Доктор наук");
                } else {
                    statementInsertProfessors.setString(3, "Кандидат наук");

                }
                boolean isProfessor = random.nextBoolean();
                if (isProfessor) {
                    statementInsertProfessors.setString(4, "Профессор");
                } else {
                    statementInsertProfessors.setString(4, "Доцент");
                }
                statementInsertProfessors.executeUpdate();
                statementInsertTickets.setLong(1, readerId);
                ResultSet rs = statementInsertTickets.executeQuery();
                rs.next();
                ticketId = rs.getInt(1);
            } else {
                statementInsertStudent.setLong(1, readerId);
                statementInsertStudent.setInt(2, randBetween(100, 1000));
                statementInsertStudent.setInt(3, randBetween(1, 4));
                statementInsertStudent.setInt(4, randBetween(1, 9));
                statementInsertStudent.executeUpdate();
                statementInsertTickets.setLong(1, readerId);
                ResultSet rs = statementInsertTickets.executeQuery();
                rs.next();
                ticketId = rs.getInt(1);
            }

            boolean currentTicketHasABook = false;
            boolean isBookInReservation = false;
            boolean isNotOnTimeReturn = false;
            if (randomInt != 0) {
                for (int j = 0; j < 2; j++) {
                    currentTicketHasABook = random.nextBoolean();
                    if (currentTicketHasABook) {
                        Date localDate;
                        if (hasRetiredDate) {
                            localDate = randomDate(
                                    LocalDate.of(2016, 1, 1),
                                    retiredDate.toLocalDate().minusMonths(7L));
                        } else {
                            localDate = randomDate(
                                    LocalDate.of(2016, 1, 1),
                                    LocalDate.of(2019, 9, 1));
                        }
                        statementInsertDelivery.setInt(1, bookIndex);
                        statementInsertDelivery.setInt(2, ticketId);
                        isBookInReservation = random.nextBoolean();
                        if (!isBookInReservation) {
                            statementInsertDelivery.setDate(3, localDate);
                            statementInsertDelivery.setDate(5, null);
                        } else {
                            statementInsertDelivery.setDate(3, localDate);
                            statementInsertDelivery.setDate(5, Date.valueOf(localDate.toLocalDate().minusDays(5L)));
                        }
                        LocalDate localReturnDate = localDate.toLocalDate().plusMonths(6L);
                        statementInsertDelivery.setDate(4,  Date.valueOf(localReturnDate));

                        if (randomInt < 3) { //book is lost
                            statementInsertLostBooks.setInt(1, bookIndex);
                            statementInsertLostBooks.setInt(2, ticketId);
                            statementInsertLostBooks.executeUpdate();
                            statementInsertReadersViolations.setInt(1, 1);
                            statementInsertReadersViolations.setLong(2, ticketId);
                            statementInsertReadersViolations.setDate(3, Date.valueOf(localReturnDate));
                            statementInsertReadersViolations.setInt(4, bookIndex);
                            statementInsertReadersViolations.executeUpdate();
                            statementInsertDelivery.setDate(6, null);
                            statementUpdateBook.setInt(1, bookIndex);
                            statementUpdateBook.executeUpdate();
                        } else {
                            isNotOnTimeReturn = random.nextBoolean();
                            if (isNotOnTimeReturn) {
                                statementInsertReadersViolations.setInt(1, 2);
                                statementInsertReadersViolations.setLong(2, ticketId);
                                statementInsertReadersViolations.setDate(3, Date.valueOf(localReturnDate));
                                statementInsertReadersViolations.setInt(4, bookIndex);
                                statementInsertReadersViolations.executeUpdate();
                                LocalDate localRealReturnDate = localDate.toLocalDate().plusMonths(6L).plusDays(30L);
                                //statementInsertDelivery.setString(4, localReturnDate.toString());
                                int isDebtor = random.nextInt(5); //должник
                                if(isDebtor == 0){
                                    if(!hasRetiredDate && (localDate.toLocalDate().getYear() > 2017)){
                                        statementInsertDelivery.setDate(6, null);
                                        statementUpdateBook.setInt(1, bookIndex);
                                        statementUpdateBook.executeUpdate();
                                    } else {
                                        statementInsertDelivery.setDate(6, randomDate(localReturnDate, localRealReturnDate));
                                    }
                                } else {
                                    statementInsertDelivery.setDate(6, randomDate(localReturnDate, localRealReturnDate));
                                }
                            } else {
                                statementInsertDelivery.setDate(6, randomDate(localDate.toLocalDate(), localReturnDate));
                            }
                        }
                        statementInsertDelivery.executeUpdate();
                    }
                    bookIndex++;
                }
            }
        }
    }

    private static boolean prepareStatement(List<String> names, List<String> lastNames, List<String> patronomycs, Random random, PreparedStatement statement, Date retiredDate) throws SQLException {
        statement.setString(1, names.get(random.nextInt(names.size())));
        statement.setString(2, lastNames.get(random.nextInt(lastNames.size())));
        statement.setString(3, patronomycs.get(random.nextInt(patronomycs.size())));
        if (random.nextInt(10) != 0) {
            statement.setDate(4, null);
            return false;
        } else {
            statement.setDate(4, retiredDate);
            return true;
        }
    }

    private static int randBetween(int a, int b) {
        return a + (int) Math.round(Math.random() * (b - a));
    }

    private static List<String> readFile(String fileName) throws IOException {
        List<String> manNames = new ArrayList<>();
        String manName;
        BufferedReader bufferedReader = new BufferedReader(new FileReader("resources/" + fileName));
        while ((manName = bufferedReader.readLine()) != null) {
            manNames.add(manName);
        }
        return manNames;
    }

    private static void writeBooks(Connection connection, PreparedStatement preparedStatement) throws SQLException, IOException {
        PreparedStatement statementInsertBook = preparedStatement;
        Pattern compile = Pattern.compile("«(.*)» — ([А-Яа-я. ]+) ([А-Яа-я]+)");
        String book;
        BufferedReader bufferedReader = new BufferedReader(new FileReader("resources/books.txt"));
        while ((book = bufferedReader.readLine()) != null) {
            Matcher matcher = compile.matcher(book);
            while (matcher.find()) {
                statementInsertBook.setString(1, matcher.group(2));
                statementInsertBook.setString(2, matcher.group(3));
                statementInsertBook.setString(3, matcher.group(1));
                statementInsertBook.setDate(4, randomDate(
                        LocalDate.of(1990, 1, 1),
                        LocalDate.of(2019, 9, 1)
                ));
                statementInsertBook.setDate(5, randomDate(
                        LocalDate.of(2019, 3, 1),
                        LocalDate.of(2019, 9, 1)
                ));
                statementInsertBook.setInt(6, randBetween(0, 1000));
                statementInsertBook.setInt(7, randBetween(1, HALLS_NUMBER));
            }
            statementInsertBook.executeUpdate();
        }
    }

    private static Date randomDate(LocalDate from, LocalDate to) {
        long minDay = from.toEpochDay();
        long maxDay = to.toEpochDay();
        long randomDay = ThreadLocalRandom.current().nextLong(minDay, maxDay);
        LocalDate randomDate = LocalDate.ofEpochDay(randomDay);
        return Date.valueOf(randomDate);
    }

}
