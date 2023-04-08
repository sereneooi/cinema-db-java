package model;

import model.*;
import java.sql.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import javax.swing.JOptionPane;

public class TicketDA{
    private String host = "jdbc:derby://localhost:1527/cinemadb";
    private String user = "nbuser";
    private String password = "nbuser";
    private String tableName = "TICKET";
    private Connection conn;
    private PreparedStatement stmt;
    private SeatType seatType;
    
    public TicketDA(){
        createConnection();
    }
    
    //Serene Ooi Yin Ting
    public List<Ticket> getAllRecord(String email) throws SQLException{
        String queryStr = "SELECT * FROM " + tableName 
                + " INNER JOIN SEAT ON SEAT.SEATID = TICKET.SEATID"
                + " INNER JOIN SEATTYPE ON SEATTYPE.SEATTYPEID = SEAT.SEATTYPEID"
                + " INNER JOIN TICKETTYPE ON TICKETTYPE.TICKETTYPEID = TICKET.TICKETTYPEID"
                + " INNER JOIN BOOKING ON BOOKING.BOOKINGID = TICKET.BOOKINGID"
                + " INNER JOIN PAYMENT ON BOOKING.PAYMENTID = PAYMENT.PAYMENTID"
                + " INNER JOIN MOVIESCHEDULE ON MOVIESCHEDULE.MOVIESCHEDULEID = SEAT.MOVIESCHEDULEID"
                + " INNER JOIN THEATRE ON THEATRE.THEATREID = MOVIESCHEDULE.THEATREID"
                + " INNER JOIN THEATRECLASSES ON THEATRECLASSES.THEATRECLASSESID = THEATRE.THEATRECLASSESID"
                + " INNER JOIN MOVIE ON MOVIE.MOVIEID = MOVIESCHEDULE.MOVIEID"
                + " LEFT JOIN PROMOTION ON PROMOTION.PROMOCODE = PAYMENT.PROMOCODE"
                + " WHERE BOOKING.EMAILADDRESS = ?";
        List<Ticket> ticket = new ArrayList<>();
        Promotion promotion = null;
        
        stmt = conn.prepareStatement(queryStr);
        stmt.setString(1, email);
        ResultSet rs = stmt.executeQuery();

        while(rs.next()){    
            if(rs.getString("promoCode") != null){
                promotion = new Promotion(rs.getString("promoCode"), rs.getString("promoType"), Double.parseDouble(rs.getString("promoAmount")), rs.getString("promoStatus"));
            }
            
            ticket.add(new Ticket(rs.getString("ticketId"), 
                new Seat(rs.getString("seatId"), rs.getString("seatNo"), 
                new MovieSchedule(rs.getString("movieScheduleID"), rs.getString("showDate"), rs.getString("showTime"),
                new Movie(rs.getString("movieID"), rs.getString("movieName"), rs.getString("movieTrailer"), rs.getString("moviePoster"), rs.getString("movieAdsPoster"), rs.getString("synopsis"), rs.getString("duration"), null, null, null, null, null), 
                new Theatre(rs.getString("theatreID"), rs.getString("theatreDesc"), 0, null)), 
                new SeatType(rs.getString("seatTypeId"), rs.getString("seatDescription"), Double.parseDouble(rs.getString("seatTypePrice")))), 
                new TicketType(rs.getString("ticketTypeId"), rs.getString("ticketTypeDesc"), Double.parseDouble(rs.getString("ticketDiscountRate"))), 
                new Booking(rs.getString("bookingId"), rs.getString("bookingDateTime"), new Account("emailAddress"), 
                new Payment(rs.getString("paymentID"), null, rs.getString("paymentMethod"), Double.parseDouble(rs.getString("totalAmount")), promotion))));
            
        }
        return ticket;
    }
    
    public List<Ticket> getBookingRecord(String bookingId) throws SQLException{
        String queryStr = "SELECT * FROM " + tableName 
                + " INNER JOIN SEAT ON SEAT.SEATID = TICKET.SEATID"
                + " INNER JOIN SEATTYPE ON SEATTYPE.SEATTYPEID = SEAT.SEATTYPEID"
                + " INNER JOIN TICKETTYPE ON TICKETTYPE.TICKETTYPEID = TICKET.TICKETTYPEID"
                + " INNER JOIN BOOKING ON BOOKING.BOOKINGID = TICKET.BOOKINGID"
                + " INNER JOIN ACCOUNT ON ACCOUNT.EMAILADDRESS = BOOKING.EMAILADDRESS"
                + " INNER JOIN ROLE ON ROLE.ROLEID = ACCOUNT.ROLEID"
                + " INNER JOIN PAYMENT ON BOOKING.PAYMENTID = PAYMENT.PAYMENTID"
                + " INNER JOIN MOVIESCHEDULE ON MOVIESCHEDULE.MOVIESCHEDULEID = SEAT.MOVIESCHEDULEID"
                + " INNER JOIN THEATRE ON THEATRE.THEATREID = MOVIESCHEDULE.THEATREID"
                + " INNER JOIN THEATRECLASSES ON THEATRECLASSES.THEATRECLASSESID = THEATRE.THEATRECLASSESID"
                + " INNER JOIN MOVIE ON MOVIE.MOVIEID = MOVIESCHEDULE.MOVIEID"
                + " LEFT JOIN PROMOTION ON PROMOTION.PROMOCODE = PAYMENT.PROMOCODE"
                + " WHERE TICKET.BOOKINGID = ?";
        List<Ticket> ticket = new ArrayList<>();
        Promotion promotion = null;
        
        stmt = conn.prepareStatement(queryStr);
        stmt.setString(1, bookingId);
        ResultSet rs = stmt.executeQuery();

        while(rs.next()){  
            if(rs.getString("promoCode") != null){
                promotion = new Promotion(rs.getString("promoCode"), rs.getString("promoType"), Double.parseDouble(rs.getString("promoAmount")), rs.getString("promoStatus"));
            }
            
            ticket.add(new Ticket(rs.getString("ticketId"), 
                new Seat(rs.getString("seatId"), rs.getString("seatNo"), 
                new MovieSchedule(rs.getString("movieScheduleID"), rs.getString("showDate"), rs.getString("showTime"),
                new Movie(rs.getString("movieID"), rs.getString("movieName"), rs.getString("movieTrailer"), rs.getString("moviePoster"), rs.getString("movieAdsPoster"), rs.getString("synopsis"), rs.getString("duration"), null, null, null, null, null), 
                new Theatre(rs.getString("theatreID"), rs.getString("theatreDesc"), 0, null)), 
                new SeatType(rs.getString("seatTypeId"), rs.getString("seatDescription"), Double.parseDouble(rs.getString("seatTypePrice")))), 
                new TicketType(rs.getString("ticketTypeId"), rs.getString("ticketTypeDesc"), Double.parseDouble(rs.getString("ticketDiscountRate"))), 
                new Booking(rs.getString("bookingId"), rs.getString("bookingDateTime"), 
                new Account(rs.getString("emailAddress"), rs.getString("Name"), rs.getString("Password"), rs.getString("Ic"), rs.getString("Gender").charAt(0), rs.getString("BirthDate"), rs.getString("Address"), rs.getString("ContactNo"), 
                new Role(rs.getString("RoleId"), rs.getString("Role")), rs.getDate("dateCreated"), rs.getDate("dateModified")),
                new Payment(rs.getString("paymentID"), null, rs.getString("paymentMethod"), Double.parseDouble(rs.getString("totalAmount")), promotion))));
        }
        return ticket;
    }
    
    //Ong JingRou
    //CRUD
    public List <Ticket> retrieveNonBookingTicket() throws SQLException{
        
               String queryStr = "SELECT * FROM " + tableName 
                + " INNER JOIN SEAT ON SEAT.SEATID = TICKET.SEATID"
                + " INNER JOIN SEATTYPE ON SEATTYPE.SEATTYPEID = SEAT.SEATTYPEID"
                + " INNER JOIN TICKETTYPE ON TICKETTYPE.TICKETTYPEID = TICKET.TICKETTYPEID"
                + " INNER JOIN MOVIESCHEDULE ON MOVIESCHEDULE.MOVIESCHEDULEID = SEAT.MOVIESCHEDULEID"
                + " INNER JOIN THEATRE ON THEATRE.THEATREID = MOVIESCHEDULE.THEATREID"
                + " INNER JOIN THEATRECLASSES ON THEATRECLASSES.THEATRECLASSESID = THEATRE.THEATRECLASSESID"
                + " INNER JOIN MOVIE ON MOVIE.MOVIEID = MOVIESCHEDULE.MOVIEID"
                + " WHERE TICKET.BOOKINGID IS NULL"
                + " ORDER BY TICKET.TICKETID";      
               
        List<Ticket> ticket = new ArrayList<>();
        
        stmt = conn.prepareStatement(queryStr);
        ResultSet rs = stmt.executeQuery();

        while(rs.next()){  
            ticket.add(new Ticket(rs.getString("ticketId"), 
            new Seat(rs.getString("seatId"), rs.getString("seatNo"), 
            new MovieSchedule(rs.getString("movieScheduleID"), rs.getString("showDate"), rs.getString("showTime"), 
            new Movie(rs.getString("movieID"), rs.getString("movieName"), rs.getString("movieTrailer"), rs.getString("moviePoster"), rs.getString("movieAdsPoster"), rs.getString("synopsis"), rs.getString("duration"), null, null, null, null, null), 
            new Theatre(rs.getString("theatreID"), rs.getString("theatreDesc"), 0, null)), 
            new SeatType(rs.getString("seatTypeId"), rs.getString("seatDescription"), Double.parseDouble(rs.getString("seatTypePrice")))), 
            new TicketType(rs.getString("ticketTypeId"), rs.getString("ticketTypeDesc"), Double.parseDouble(rs.getString("ticketDiscountRate")))));
        }
        return ticket;
    }
    
    public List <Ticket> retreiveAllRecord()throws SQLException{
        String queryStr = "SELECT * FROM " + tableName;
        List <Ticket> ticket = new ArrayList <Ticket>();
        
        stmt = conn.prepareStatement(queryStr);
        ResultSet rs = stmt.executeQuery();

        while(rs.next()){    
            ticket.add(new Ticket(rs.getString("ticketId"), new Seat(rs.getString("seatId")), new TicketType(rs.getString("ticketTypeId")), new Booking(rs.getString("bookingId"))));
        }
        
        return ticket;
    }
        
    public void addItem(Ticket ticket) throws SQLException{
        
        String sqlStr = "INSERT INTO TICKET VALUES(?, ?, ?, ?)";
        
        List<Ticket> ticketList = retreiveAllRecord();
        String ticketId = ""; 

        if(ticketList == null || ticketList.isEmpty()){
            ticketId="T0001";
        }else{
            String id = ticketList.get(ticketList.size()-1).getTicketId();
            int intTicketId = Integer.parseInt(id.substring(1, 5)) + 1;
            ticketId = 'T' + String.format("%04d" , intTicketId);
        }
        
        stmt = conn.prepareStatement(sqlStr);
        stmt.setString(1, ticketId);
        stmt.setString(2, ticket.getSeatId().getSeatId());
        stmt.setString(3, ticket.getTicketType().getTicketTypeId());
        stmt.setString(4, ticket.getBookingDetails().getBookingId());
        stmt.executeUpdate();
    }
    
    public List <Ticket> retrieveAllBookingTicket() throws SQLException{
        
               String queryStr = "SELECT * FROM " + tableName 
                                    + " INNER JOIN SEAT ON SEAT.SEATID = TICKET.SEATID"
                                    + " INNER JOIN SEATTYPE ON SEATTYPE.SEATTYPEID = SEAT.SEATTYPEID"
                                    + " INNER JOIN TICKETTYPE ON TICKETTYPE.TICKETTYPEID = TICKET.TICKETTYPEID"
                                    + " INNER JOIN MOVIESCHEDULE ON MOVIESCHEDULE.MOVIESCHEDULEID = SEAT.MOVIESCHEDULEID"
                                    + " INNER JOIN THEATRE ON THEATRE.THEATREID = MOVIESCHEDULE.THEATREID"
                                    + " INNER JOIN THEATRECLASSES ON THEATRECLASSES.THEATRECLASSESID = THEATRE.THEATRECLASSESID"
                                    + " INNER JOIN MOVIE ON MOVIE.MOVIEID = MOVIESCHEDULE.MOVIEID"
                                    + " RIGHT JOIN BOOKING ON BOOKING.BOOKINGID = TICKET.BOOKINGID"
                                    + " INNER JOIN ACCOUNT ON ACCOUNT.EMAILADDRESS = BOOKING.EMAILADDRESS"
                                    + " INNER JOIN PAYMENT ON PAYMENT.PAYMENTID = BOOKING.PAYMENTID"
                                    + " ORDER BY BOOKING.BOOKINGID";
               
        List<Ticket> ticket = new ArrayList<>();
        
        stmt = conn.prepareStatement(queryStr);
        ResultSet rs = stmt.executeQuery();

        while(rs.next()){  
            ticket.add(new Ticket(rs.getString("ticketId"), 
            new Seat(rs.getString("seatId"), rs.getString("seatNo"), 
            new MovieSchedule(rs.getString("movieScheduleID"), rs.getString("showDate"), rs.getString("showTime"), 
            new Movie(rs.getString("movieID"), rs.getString("movieName"), rs.getString("movieTrailer"), rs.getString("moviePoster"), rs.getString("movieAdsPoster"), rs.getString("synopsis"), rs.getString("duration"), null, null, null, null, null), 
            new Theatre(rs.getString("theatreID"), rs.getString("theatreDesc"), 0, null)), 
            new SeatType(rs.getString("seatTypeId"), rs.getString("seatDescription"), Double.parseDouble(rs.getString("seatTypePrice")))), 
            new TicketType(rs.getString("ticketTypeId"), rs.getString("ticketTypeDesc"), Double.parseDouble(rs.getString("ticketDiscountRate"))),
            new Booking(rs.getString("bookingId"), rs.getString("bookingDateTime"),
            new Account(rs.getString("emailAddress")), 
            new Payment(rs.getString("paymentId"), null, rs.getString("paymentMethod"), rs.getDouble("totalAmount"), null))));
        }
        return ticket;
    }
    
    public List <Ticket> retrieveAllForSales() throws SQLException{
        
               String queryStr = "SELECT * FROM " + tableName 
                                    + " INNER JOIN SEAT ON SEAT.SEATID = TICKET.SEATID"
                                    + " INNER JOIN SEATTYPE ON SEATTYPE.SEATTYPEID = SEAT.SEATTYPEID"
                                    + " INNER JOIN MOVIESCHEDULE ON MOVIESCHEDULE.MOVIESCHEDULEID = SEAT.MOVIESCHEDULEID"
                                    + " INNER JOIN MOVIE ON MOVIE.MOVIEID = MOVIESCHEDULE.MOVIEID"
                                    + " INNER JOIN TICKETTYPE ON TICKETTYPE.TICKETTYPEID = TICKET.TICKETTYPEID"
                                    + " INNER JOIN BOOKING ON BOOKING.BOOKINGID = TICKET.BOOKINGID"
                                    + " INNER JOIN ACCOUNT ON ACCOUNT.EMAILADDRESS = BOOKING.EMAILADDRESS"
                                    + " INNER JOIN PAYMENT ON PAYMENT.PAYMENTID = BOOKING.PAYMENTID"
                                    + " LEFT JOIN PROMOTION ON PROMOTION.PROMOCODE = PAYMENT.PROMOCODE"
                                    + " ORDER BY BOOKING.BOOKINGID";
               
        List<Ticket> ticket = new ArrayList<>();
        
        stmt = conn.prepareStatement(queryStr);
        ResultSet rs = stmt.executeQuery();

        while(rs.next()){  
            ticket.add(new Ticket(rs.getString("ticketId"), 
                            new Seat(rs.getString("seatId"), rs.getString("seatNo"),
                            new MovieSchedule(rs.getString("movieScheduleID"), rs.getString("showDate"), rs.getString("showTime"), 
                            new Movie(rs.getString("movieID"), rs.getString("movieName"), rs.getString("movieTrailer"), rs.getString("moviePoster"), rs.getString("movieAdsPoster"), rs.getString("synopsis"), rs.getString("duration"), null, null, null, null, null), null), 
                            new SeatType(rs.getString("seatTypeId"), rs.getString("seatDescription"), Double.parseDouble(rs.getString("seatTypePrice")))), 
                            new TicketType(rs.getString("ticketTypeId"), rs.getString("ticketTypeDesc"), Double.parseDouble(rs.getString("ticketDiscountRate"))),
                            new Booking(rs.getString("bookingId"), rs.getString("bookingDateTime"),
                            new Account(rs.getString("emailAddress")), 
                            new Payment(rs.getString("paymentId"), null, rs.getString("paymentMethod"), rs.getDouble("totalAmount"),
                            new Promotion(rs.getString("promoCode"), rs.getString("promoType"), rs.getDouble("promoAmount"), null)))));
        }
        return ticket;
    }
    
    public List<Integer> calAllTotalTicket() throws SQLException{

        String queryStr = "SELECT COUNT(TICKETID) FROM " + tableName  
                                    + " INNER JOIN SEAT ON SEAT.SEATID = TICKET.SEATID"
                                    + " INNER JOIN SEATTYPE ON SEATTYPE.SEATTYPEID = SEAT.SEATTYPEID"
                                    + " INNER JOIN MOVIESCHEDULE ON MOVIESCHEDULE.MOVIESCHEDULEID = SEAT.MOVIESCHEDULEID"
                                    + " INNER JOIN MOVIE ON MOVIE.MOVIEID = MOVIESCHEDULE.MOVIEID"
                                    + " INNER JOIN TICKETTYPE ON TICKETTYPE.TICKETTYPEID = TICKET.TICKETTYPEID"
                                    + " INNER JOIN BOOKING ON BOOKING.BOOKINGID = TICKET.BOOKINGID"
                                    + " INNER JOIN ACCOUNT ON ACCOUNT.EMAILADDRESS = BOOKING.EMAILADDRESS"
                                    + " INNER JOIN PAYMENT ON PAYMENT.PAYMENTID = BOOKING.PAYMENTID"
                                    + " AND TICKET.BOOKINGID IS NOT NULL"
                                    + " GROUP BY TICKET.BOOKINGID"
                                    + " ORDER BY TICKET.BOOKINGID";
        
        List <Integer> bookedTicketNo = new ArrayList<>(); 
        
        stmt = conn.prepareStatement(queryStr);
        ResultSet rs = stmt.executeQuery();

        while(rs.next()){  
            bookedTicketNo.add(rs.getInt(1));
        }
        return bookedTicketNo;
    }   

    //Sales Report
    public List<Ticket> retrieveTicketDetails(String userSelectDate) throws SQLException{
        
        //Add FNB after that
        String queryStr = "SELECT * FROM " + tableName  
                                    + " INNER JOIN SEAT ON SEAT.SEATID = TICKET.SEATID"
                                    + " INNER JOIN SEATTYPE ON SEATTYPE.SEATTYPEID = SEAT.SEATTYPEID"
                                    + " INNER JOIN MOVIESCHEDULE ON MOVIESCHEDULE.MOVIESCHEDULEID = SEAT.MOVIESCHEDULEID"
                                    + " INNER JOIN MOVIE ON MOVIE.MOVIEID = MOVIESCHEDULE.MOVIEID"
                                    + " INNER JOIN TICKETTYPE ON TICKETTYPE.TICKETTYPEID = TICKET.TICKETTYPEID"
                                    + " INNER JOIN BOOKING ON BOOKING.BOOKINGID = TICKET.BOOKINGID"
                                    + " INNER JOIN ACCOUNT ON ACCOUNT.EMAILADDRESS = BOOKING.EMAILADDRESS"
                                    + " INNER JOIN PAYMENT ON PAYMENT.PAYMENTID = BOOKING.PAYMENTID"
                                    + " LEFT JOIN PROMOTION ON PROMOTION.PROMOCODE = PAYMENT.PROMOCODE"
                                    + " WHERE DATE(PAYMENT.PAYMENTDATETIME) = '" + userSelectDate + "'"
                                    + " ORDER BY BOOKING.BOOKINGID";
        
        List<Ticket> ticket = new ArrayList<>();
        
        stmt = conn.prepareStatement(queryStr);
        ResultSet rs = stmt.executeQuery();

        while(rs.next()){  
            ticket.add(new Ticket(rs.getString("ticketId"), 
                            new Seat(rs.getString("seatId"), rs.getString("seatNo"),
                            new MovieSchedule(rs.getString("movieScheduleID"), rs.getString("showDate"), rs.getString("showTime"), 
                            new Movie(rs.getString("movieID"), rs.getString("movieName"), rs.getString("movieTrailer"), rs.getString("moviePoster"), rs.getString("movieAdsPoster"), rs.getString("synopsis"), rs.getString("duration"), null, null, null, null, null), null), 
                            new SeatType(rs.getString("seatTypeId"), rs.getString("seatDescription"), Double.parseDouble(rs.getString("seatTypePrice")))), 
                            new TicketType(rs.getString("ticketTypeId"), rs.getString("ticketTypeDesc"), Double.parseDouble(rs.getString("ticketDiscountRate"))),
                            new Booking(rs.getString("bookingId"), rs.getString("bookingDateTime"),
                            new Account(rs.getString("emailAddress")), 
                            new Payment(rs.getString("paymentId"), null, rs.getString("paymentMethod"), rs.getDouble("totalAmount"),
                            new Promotion(rs.getString("promoCode"), rs.getString("promoType"), rs.getDouble("promoAmount"), null)))));
        }
        return ticket;
    }
    
    public List<Integer> calTotalTicket(String userSelectDate) throws SQLException{

        String queryStr = "SELECT COUNT(TICKETID) FROM " + tableName  
                                    + " INNER JOIN SEAT ON SEAT.SEATID = TICKET.SEATID"
                                    + " INNER JOIN SEATTYPE ON SEATTYPE.SEATTYPEID = SEAT.SEATTYPEID"
                                    + " INNER JOIN MOVIESCHEDULE ON MOVIESCHEDULE.MOVIESCHEDULEID = SEAT.MOVIESCHEDULEID"
                                    + " INNER JOIN MOVIE ON MOVIE.MOVIEID = MOVIESCHEDULE.MOVIEID"
                                    + " INNER JOIN TICKETTYPE ON TICKETTYPE.TICKETTYPEID = TICKET.TICKETTYPEID"
                                    + " INNER JOIN BOOKING ON BOOKING.BOOKINGID = TICKET.BOOKINGID"
                                    + " INNER JOIN ACCOUNT ON ACCOUNT.EMAILADDRESS = BOOKING.EMAILADDRESS"
                                    + " INNER JOIN PAYMENT ON PAYMENT.PAYMENTID = BOOKING.PAYMENTID"
                                    + " WHERE DATE(PAYMENT.PAYMENTDATETIME) = '" + userSelectDate + "'"
                                    + " AND TICKET.BOOKINGID IS NOT NULL"
                                    + " GROUP BY TICKET.BOOKINGID"
                                    + " ORDER BY TICKET.BOOKINGID";
        
        List <Integer> bookedTicketNo = new ArrayList<>(); 
        
        stmt = conn.prepareStatement(queryStr);
        ResultSet rs = stmt.executeQuery();

        while(rs.next()){  
            bookedTicketNo.add(rs.getInt(1));
        }
        return bookedTicketNo;
    }   
    
    //Sales Report Calcualtion
    public Double calGrandTotal(List <String> paymentIdList) throws SQLException{
        String query = "SELECT SUM(PAYMENT.TOTALAMOUNT) FROM PAYMENT WHERE PAYMENTID in (";
        String temp = "";

        for(int i = 0; i < paymentIdList.size(); i++) {
          temp += ",?";
        }

        temp = temp.replaceFirst(",", "");
        temp += ")";
        query = query + temp;

        stmt = conn.prepareStatement(query);
        
        for( int i=0; i < paymentIdList.size(); i++ ) {
            stmt.setString( i+1, paymentIdList.get(i));
        }
        
        ResultSet rs = stmt.executeQuery();
        
        rs.next();
        double grandTotal= rs.getDouble(1);
        
        return grandTotal;
    }
    
    //Top 10 List of highest Grossing Film Report
    public List <Double> topHighestFilms() throws SQLException{
        String queryStr = "SELECT SUM((SEATTYPE.SEATTYPEPRICE * (1 - TICKETTYPE.TICKETDISCOUNTRATE))) AS GROSS FROM " + tableName
                                    + " INNER JOIN SEAT ON SEAT.SEATID = TICKET.SEATID"
                                    + " INNER JOIN SEATTYPE ON SEATTYPE.SEATTYPEID = SEAT.SEATTYPEID"
                                    + " INNER JOIN MOVIESCHEDULE ON MOVIESCHEDULE.MOVIESCHEDULEID = SEAT.MOVIESCHEDULEID"
                                    + " INNER JOIN MOVIE ON MOVIE.MOVIEID = MOVIESCHEDULE.MOVIEID"
                                    + " INNER JOIN TICKETTYPE ON TICKETTYPE.TICKETTYPEID = TICKET.TICKETTYPEID"
                                    + " INNER JOIN BOOKING ON BOOKING.BOOKINGID = TICKET.BOOKINGID"
                                    + " INNER JOIN ACCOUNT ON ACCOUNT.EMAILADDRESS = BOOKING.EMAILADDRESS"
                                    + " INNER JOIN PAYMENT ON PAYMENT.PAYMENTID = BOOKING.PAYMENTID"
                                    + " WHERE YEAR(MOVIE.AVAILABLEDATE) = 2022"
                                    + " GROUP BY MOVIE.MOVIENAME"
                                    + " ORDER BY GROSS DESC"
                                    + " FETCH FIRST 5 ROWS ONLY";
        
        List <Double> grossing  = new ArrayList<>();
        
        stmt = conn.prepareStatement(queryStr);
        ResultSet rs = stmt.executeQuery();
        
         while(rs.next()){  
            grossing.add(rs.getDouble(1));
         }
        
        return grossing;
        
    }
    
    public List<String> topHighestFilmsDetails() throws SQLException{
        String queryStr = "SELECT SUM((SEATTYPE.SEATTYPEPRICE * (1 - TICKETTYPE.TICKETDISCOUNTRATE))) AS GROSS, MOVIE.MOVIENAME FROM " + tableName
                                    + " INNER JOIN SEAT ON SEAT.SEATID = TICKET.SEATID"
                                    + " INNER JOIN SEATTYPE ON SEATTYPE.SEATTYPEID = SEAT.SEATTYPEID"
                                    + " INNER JOIN MOVIESCHEDULE ON MOVIESCHEDULE.MOVIESCHEDULEID = SEAT.MOVIESCHEDULEID"
                                    + " INNER JOIN MOVIE ON MOVIE.MOVIEID = MOVIESCHEDULE.MOVIEID"
                                    + " INNER JOIN TICKETTYPE ON TICKETTYPE.TICKETTYPEID = TICKET.TICKETTYPEID"
                                    + " INNER JOIN BOOKING ON BOOKING.BOOKINGID = TICKET.BOOKINGID"
                                    + " WHERE YEAR(MOVIE.AVAILABLEDATE) = 2022"
                                    + " GROUP BY MOVIE.MOVIENAME"
                                    + " ORDER BY GROSS DESC"
                                    + " FETCH FIRST 5 ROWS ONLY";
        
        List<String> ticket = new ArrayList<>();
        stmt = conn.prepareStatement(queryStr);
        ResultSet rs = stmt.executeQuery();
        
        while(rs.next()){  
            ticket.add(rs.getString("movieName"));
        }
        
        return ticket;
    }

    public List<Integer> topHighestFilmsSold() throws SQLException{
        String queryStr = "SELECT COUNT(MOVIE.MOVIENAME) FROM " + tableName
                                    + " INNER JOIN SEAT ON SEAT.SEATID = TICKET.SEATID"
                                    + " INNER JOIN SEATTYPE ON SEATTYPE.SEATTYPEID = SEAT.SEATTYPEID"
                                    + " INNER JOIN MOVIESCHEDULE ON MOVIESCHEDULE.MOVIESCHEDULEID = SEAT.MOVIESCHEDULEID"
                                    + " INNER JOIN MOVIE ON MOVIE.MOVIEID = MOVIESCHEDULE.MOVIEID"
                                    + " INNER JOIN TICKETTYPE ON TICKETTYPE.TICKETTYPEID = TICKET.TICKETTYPEID"
                                    + " INNER JOIN BOOKING ON BOOKING.BOOKINGID = TICKET.BOOKINGID"
                                    + " WHERE YEAR(MOVIE.AVAILABLEDATE) = 2022"
                                    + " GROUP BY MOVIE.MOVIENAME"
                                    + " ORDER BY SUM((SEATTYPE.SEATTYPEPRICE * (1 - TICKETTYPE.TICKETDISCOUNTRATE))) DESC"
                                    + " FETCH FIRST 5 ROWS ONLY";
        
        List<Integer> soldCount = new ArrayList<>();
        stmt = conn.prepareStatement(queryStr);
        ResultSet rs = stmt.executeQuery();
        
        while(rs.next()){  
            soldCount.add(rs.getInt(1));
        }
        
        return soldCount;
    }
    

    private void createConnection() {
        try {
            
            conn = DriverManager.getConnection(host, user, password);
            System.out.println("***TRACE: Connection established.");
            
        } catch (SQLException ex) {
            StackTraceElement[] traceElements = ex.getStackTrace();
            for (int i = 0; i < traceElements.length; i++) {
              System.out.print("method " + traceElements[i].getMethodName());
              System.out.print("(" + traceElements[i].getClassName() + ":");
              System.out.println(traceElements[i].getLineNumber() + ")");
            }                
        }
    }

    private void shutDown() {
        if (conn != null)
            
            try {
            conn.close();
            
        } catch (SQLException ex) {
            StackTraceElement[] traceElements = ex.getStackTrace();
            for (int i = 0; i < traceElements.length; i++) {
              System.out.print("method " + traceElements[i].getMethodName());
              System.out.print("(" + traceElements[i].getClassName() + ":");
              System.out.println(traceElements[i].getLineNumber() + ")");
            }                            
        }
    }    
    
    public static void main(String[] args) {
        new TicketDA();
    }    
}