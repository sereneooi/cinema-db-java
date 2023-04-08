package model;

import model.*;
import java.sql.*;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;
import javax.swing.JOptionPane;

public class BookingDA{
    private String host = "jdbc:derby://localhost:1527/cinemadb";
    private String user = "nbuser";
    private String password = "nbuser";
    private String tableName = "Booking";
    private Connection conn;
    private PreparedStatement stmt;
    private TheatreClassesDA tClassesDa;
    
    public BookingDA(){
        createConnection();
    }
    
    public List<Booking> searchRecord(String searchVariable) throws SQLException{
         String queryStr = "SELECT * FROM " + tableName 
                 + " INNER JOIN ACCOUNT ON ACCOUNT.EMAILADDRESS = BOOKING.EMAILADDRESS"
                 + " INNER JOIN PAYMENT ON PAYMENT.PAYMENTID = BOOKING.PAYMENTID"
                 + " WHERE BOOKING.bookingId LIKE '%" + searchVariable + "%' "
                 + "OR BOOKING.emailAddress LIKE '%" + searchVariable + "%' "
                 + "OR BOOKING.paymentId LIKE '%" + searchVariable + "%' "
                 + " OR BOOKING.paymentId IN "
                 + "(SELECT paymentId FROM PAYMENT WHERE paymentMethod LIKE '%" + searchVariable + "%')";
         
         List<Booking> booking = new ArrayList<Booking>();
         stmt = conn.prepareStatement(queryStr);
         
         ResultSet rs = stmt.executeQuery();
         
         while(rs.next()){
            booking.add(new Booking(rs.getString("bookingId"), rs.getString("bookingDateTime"), (new Account(rs.getString("emailAddress"))), 
                            (new Payment(rs.getString("paymentId"), null, rs.getString("paymentMethod"), '\0', null))));
        }

        return booking;
    }
    
        public List<Booking> searchRecordByDate(String userSelectDate) throws SQLException{
         String queryStr = "SELECT * FROM " + tableName 
                 + " INNER JOIN ACCOUNT ON ACCOUNT.EMAILADDRESS = BOOKING.EMAILADDRESS"
                 + " INNER JOIN PAYMENT ON PAYMENT.PAYMENTID = BOOKING.PAYMENTID"
                 + " WHERE DATE(PAYMENT.PAYMENTDATETIME) = '" + userSelectDate + "'";
         
         List<Booking> booking = new ArrayList<Booking>();
         stmt = conn.prepareStatement(queryStr);
         
         ResultSet rs = stmt.executeQuery();
         
         while(rs.next()){
            booking.add(new Booking(rs.getString("bookingId"), rs.getString("bookingDateTime"), (new Account(rs.getString("emailAddress"))), 
                            (new Payment(rs.getString("paymentId"), null, rs.getString("paymentMethod"), '\0', null))));
        }

        return booking;
    }
     
     public  List<Booking> sortingRecord(String sortingVariable) throws SQLException{
         String queryStr = "SELECT * FROM " + tableName 
                                    + " INNER JOIN ACCOUNT ON ACCOUNT.EMAILADDRESS = BOOKING.EMAILADDRESS"
                                    + " INNER JOIN PAYMENT ON PAYMENT.PAYMENTID = BOOKING.PAYMENTID"
                                    + " ORDER BY BOOKING." + sortingVariable;
         
         List<Booking> booking = new ArrayList<Booking>();
         stmt = conn.prepareStatement(queryStr);
         
         ResultSet rs = stmt.executeQuery();
         
         while(rs.next()){
             booking.add(new Booking(rs.getString("bookingId"), rs.getString("bookingDateTime"), 
                            (new Account(rs.getString("emailAddress"))), 
                            (new Payment(rs.getString("paymentId"), null, rs.getString("paymentMethod"), '\0', null))));
        }
         
         return booking;
     }
     
      public List<Booking> sortingForeignKeyRecord(String sortingVariable) throws SQLException{
         String queryStr = "SELECT PAYMENT.*, BOOKING.* FROM " + tableName + " LEFT JOIN PAYMENT AS PAYMENT ON PAYMENT.PAYMENTID = BOOKING.PAYMENTID"
                 + " ORDER BY PAYMENT." + sortingVariable;
         
          List<Booking> booking = new ArrayList<Booking>();
         stmt = conn.prepareStatement(queryStr);
         
         ResultSet rs = stmt.executeQuery();
         
         while(rs.next()){
             booking.add(new Booking(rs.getString("bookingId"), rs.getString("bookingDateTime"), 
                            (new Account(rs.getString("emailAddress"))), 
                            new Payment(rs.getString("paymentId"), rs.getString("paymentMethod"))));
        }
         
         return booking;
     }
   
    public Booking addRecord(Booking book) throws SQLException, ParseException{
        
        String sqlStr = "INSERT INTO BOOKING VALUES(?, ?, ?, ?, ?)";

        //auto booking id increament
        BookingDA bookDA = new BookingDA();
        List<Booking>bookList = bookDA.retrieveAllRecord();
        String bookId = ""; 
        if(bookList == null || bookList.isEmpty()){
            bookId="B0001";
        }else{
            String id = bookList.get(bookList.size()-1).getBookingId();
            int intBookId = Integer.parseInt(id.substring(1, 5)) + 1;
            bookId = 'B' + String.format("%04d" , intBookId);
        }
        
        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        LocalDateTime now = LocalDateTime.now();  
        String bookingDateTime = dtf.format(now);  
        
        Booking booking = new Booking(bookId, bookingDateTime, new Account(book.getEmailAddress().getEmailAddress()), 
                                     new Payment(book.getPaymentId().getPaymentID()));
        
        // Add Booking Item
        stmt = conn.prepareStatement(sqlStr);
        stmt.setString(1, bookId);
        stmt.setString(2, bookingDateTime);
        stmt.setString(3, book.getEmailAddress().getEmailAddress());
        stmt.setString(4, book.getPaymentId().getPaymentID());
        stmt.setString(5, null);
        stmt.executeUpdate();
        
        return booking;
    }
    
    public Booking updateBooking(Booking booking, String bookingId)  throws SQLException{

        String sqlStr = "UPDATE Booking set emailAddress = ?, paymentId = ?, MODIFIEDDATETIME = ? WHERE bookingId = ?";
        
        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        LocalDateTime now = LocalDateTime.now();  
        String bookingDateTime = dtf.format(now);  
        
        booking = new Booking(bookingId, " ", new Account(booking.getEmailAddress().getEmailAddress()), 
                                     new Payment(booking.getPaymentId().getPaymentID()));        
        
        stmt = conn.prepareStatement(sqlStr);

        stmt.setString(1, booking.getEmailAddress().getEmailAddress());
        stmt.setString(2, booking.getPaymentId().getPaymentID());
        stmt.setString(3, bookingDateTime);
        stmt.setString(4, booking.getBookingId());

        stmt.executeUpdate();
        
        return booking;
    }
    
    //Report FnB
    public List<FnbOrderLine> getFnbRecord(String fnbOrderId) throws SQLException{
        String queryStr = "SELECT * FROM FNBORDERLINE"
                        + " INNER JOIN FNB ON FNB.FNBID = FNBORDERLINE.FNBID"
                        + " INNER JOIN FNBORDER ON FNBORDER.FNBORDERID = FNBORDERLINE.FNBORDERID"
                        + " WHERE FNBORDERLINE.FNBORDERID = ?";
        
        List <FnbOrderLine> fnbOrderLine = new ArrayList<>();
        
        stmt = conn.prepareStatement(queryStr);
        stmt.setString(1, fnbOrderId);
        ResultSet rs = stmt.executeQuery();
        
        while(rs.next()){
            fnbOrderLine.add(new FnbOrderLine(rs.getString("fnbOrderLineId"), rs.getInt("quantity"), 
                                   new Fnb(rs.getString("fnbId"), rs.getString("fnbImage"), rs.getString("fnbDescription"), rs.getDouble("fnbPrice"), 0, false, null)));
        }
        return fnbOrderLine;
    }
    
    public FnbOrder getFnbOrderRecord(String bookingId) throws SQLException{
        String queryStr = "SELECT * FROM FNBORDER"
                                    + " INNER JOIN BOOKING ON BOOKING.BOOKINGID = FNBORDER.BOOKINGID"
                                    + " WHERE BOOKING.BOOKINGID = ?";
        
        FnbOrder fnbOrder = new FnbOrder();
        
        stmt = conn.prepareStatement(queryStr);
        stmt.setString(1, bookingId);
        ResultSet rs = stmt.executeQuery();
        
        if(rs.next()){
            fnbOrder = new FnbOrder(rs.getString("fnbOrderID"), rs.getString("fnbOrderDateTime"), rs.getString("deliveryAddress"), rs.getString("deliveryDateTime"), rs.getString("deliveryStatus"), new Booking("bookingID"));
        }
        
        return fnbOrder;
    }
    
    //Sale Report Calculcation
        public Double fnbSubTotalCal(String fnbOrderId) throws SQLException{
        String queryStr = "SELECT SUM(FNBORDERLINE.QUANTITY * FNB.FNBPRICE) FROM FNBORDERLINE"
                        + " INNER JOIN FNB ON FNB.FNBID = FNBORDERLINE.FNBID"
                        + " INNER JOIN FNBORDER ON FNBORDER.FNBORDERID = FNBORDERLINE.FNBORDERID"
                        + " WHERE FNBORDERLINE.FNBORDERID = ?";
        
        List <FnbOrderLine> fnbOrderLine = new ArrayList<>();
        
        stmt = conn.prepareStatement(queryStr);
        stmt.setString(1, fnbOrderId);
        ResultSet rs = stmt.executeQuery();
        
        rs.next();
        double fnbSubTotal= rs.getDouble(1);
        
        return fnbSubTotal;
    }
    
    //Retrieve Data from database
    public Payment retrievePaymentRecord(String paymentID) throws SQLException {
        String queryStr = "SELECT * FROM PAYMENT WHERE PAYMENT.PAYMENTID = ?";
        Payment payment = null;

        stmt = conn.prepareStatement(queryStr);
        stmt.setString(1, paymentID);
        ResultSet rs = stmt.executeQuery();

        if(rs.next()){
            payment = new Payment(paymentID, rs.getString("PaymentMethod"), rs.getDouble("TotalAmount"));
        }
        return payment;
    }
    
    public Payment getPaymentRecord(String paymentId) throws SQLException {
        String queryStr = "SELECT * "
                                + "FROM PAYMENT  AS P "
                                + "INNER JOIN " + tableName + " AS B "
                                + "ON B.paymentId = P.paymentId "
                                + "WHERE B.paymentId = ?";
        Payment payment = null;

        stmt = conn.prepareStatement(queryStr);
        stmt.setString(1, paymentId);
        ResultSet rs = stmt.executeQuery();
        
        if(rs.next()){
            payment = new Payment(rs.getString("paymentId"), rs.getString("PaymentMethod"), rs.getDouble("TotalAmount"));
        }
        return payment;
    }
    
    public Booking retrieveRecord(String bookingId) throws SQLException{
        String queryStr = "SELECT * FROM " + tableName +  " AS b "
                + "INNER JOIN Account AS a ON b.emailAddress = a.emailAddress "
                + "INNER JOIN Payment AS p ON b.paymentId = p.paymentId "
                + "WHERE bookingId = ?";

        Booking booking = null;

        stmt = conn.prepareStatement(queryStr);
        stmt.setString(1, bookingId);
        
        ResultSet rs = stmt.executeQuery();
        
        if(rs.next()){
            booking = new Booking(rs.getString("bookingId"), rs.getString("bookingDateTime"), 
                                new Account(rs.getString("emailAddress")), 
                                new Payment(rs.getString("paymentId"), rs.getString("paymentMethod"), '\0'));
        }

        return booking;
    }

     public List<Booking> retrieveAllRecord() throws SQLException{
        String queryStr = "SELECT * FROM " + tableName 
                                    + " LEFT JOIN PAYMENT ON PAYMENT.PAYMENTID = BOOKING.PAYMENTID"
                                    + " LEFT JOIN ACCOUNT ON ACCOUNT.EMAILADDRESS = BOOKING.EMAILADDRESS"
                                    + " ORDER BY BOOKING.BOOKINGID";

        List<Booking> booking = new ArrayList<Booking>();

        stmt = conn.prepareStatement(queryStr);
        ResultSet rs = stmt.executeQuery();
        int i = 0;

        while(rs.next()){
            booking.add(new Booking(rs.getString("bookingId"), rs.getString("bookingDateTime"), 
                                new Account(rs.getString("emailAddress")), 
                                new Payment(rs.getString("paymentId"), null, rs.getString("paymentMethod"), '\0', null)));
        }

        return booking;
    }
     
     public int getTotalDailyBooking(String bookingDateTime) throws SQLException {
        String queryStr = "SELECT COUNT(bookingID) FROM " + tableName + " WHERE CAST(bookingDateTime AS VARCHAR(255)) LIKE ?";
        bookingDateTime = bookingDateTime + "%";
        int total = 0;
        
        stmt = conn.prepareStatement(queryStr);
        stmt.setString(1, bookingDateTime);
        ResultSet rs = stmt.executeQuery();
        
        if(rs.next()){
            total = rs.getInt(1);
        }
        
        return total;
     }
     
     public Object[] getRecentTransaction(String bookingDateTime) throws SQLException {
        String queryStr = "SELECT * FROM " + tableName + " INNER JOIN Payment ON " + tableName + ".PAYMENTID = Payment.PAYMENTID LEFT OUTER JOIN FnbOrder ON " + tableName + ".BOOKINGID = FnbOrder.BOOKINGID WHERE CAST(bookingDateTime AS VARCHAR(255)) LIKE ? ORDER BY bookingDateTime DESC FETCH FIRST 10 ROWS ONLY";
        bookingDateTime += "%";
        ArrayList<Booking> bookingList = new ArrayList<Booking>();
        ArrayList<String> fnbOrderList = new ArrayList<String>();
        
        stmt = conn.prepareStatement(queryStr);
        stmt.setString(1, bookingDateTime);
        ResultSet rs = stmt.executeQuery();
        
        while(rs.next()){
            bookingList.add(new Booking(rs.getString("BookingID"), rs.getString("BookingDateTime"), new Account(rs.getString("emailAddress")), new Payment("", null, "", rs.getDouble("TotalAmount"), new Promotion())));
            fnbOrderList.add(rs.getString("deliveryAddress"));
        }
        
        return new Object[] {bookingList, fnbOrderList};
     }
     
     
    private void createConnection() {
        try {
            
            conn = DriverManager.getConnection(host, user, password);
            System.out.println("***TRACE: Connection established.");
            
        } catch (SQLException ex) {
            
            JOptionPane.showMessageDialog(null, ex.getMessage(), "ERROR", JOptionPane.ERROR_MESSAGE);
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
            
            JOptionPane.showMessageDialog(null, ex.getMessage(), "ERROR", JOptionPane.ERROR_MESSAGE);
            StackTraceElement[] traceElements = ex.getStackTrace();
            for (int i = 0; i < traceElements.length; i++) {
              System.out.print("method " + traceElements[i].getMethodName());
              System.out.print("(" + traceElements[i].getClassName() + ":");
              System.out.println(traceElements[i].getLineNumber() + ")");
            }                            
        }
    }    
    
    public static void main(String[] args) {
        new BookingDA();
    }    
}
