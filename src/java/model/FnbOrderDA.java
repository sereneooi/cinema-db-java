package model;

import java.sql.*;
import java.util.*;

public class FnbOrderDA {
    private String host = "jdbc:derby://localhost:1527/cinemadb";
    private String user = "nbuser";
    private String password = "nbuser";
    private String tableName = "FnbOrder";
    private Connection conn;
    private PreparedStatement stmt;
    private String innerJoinSqlStr = "SELECT * FROM " + tableName + 
                                                    " INNER JOIN Booking ON " + tableName + ".BOOKINGID = Booking.BOOKINGID " + 
                                                    "INNER JOIN Account ON Booking.EMAILADDRESS = Account.EMAILADDRESS " + 
                                                    "INNER JOIN Payment ON Payment.PAYMENTID = Booking.PAYMENTID " + 
                                                    "WHERE Account.EMAILADDRESS = ?";
    
    public FnbOrderDA() throws Exception{
        createConnection();
    }
    
    public ArrayList<FnbOrder> getRecord() throws SQLException {
        String sqlStr = "SELECT * FROM " + tableName;
        ArrayList<FnbOrder> fnbOrderList = new ArrayList<FnbOrder>();
        
        stmt = conn.prepareStatement(sqlStr);
        ResultSet rs = stmt.executeQuery();
        
        while(rs.next()) {
            fnbOrderList.add(new FnbOrder(rs.getString("fnbOrderID"), rs.getString("fnbOrderDateTime"), rs.getString("deliveryAddress"), rs.getString("deliveryDateTime"), rs.getString("deliveryStatus"), new Booking("bookingID")));
        }
        
        return fnbOrderList;
    }
    
    public ArrayList<FnbOrder> getDeliveryRecord(String deliveryDateTime) throws SQLException {        
        deliveryDateTime = deliveryDateTime + "%";
        String sqlStr = "SELECT * FROM " + tableName + " WHERE deliveryDateTime LIKE ? AND deliveryAddress IS NOT NULL ORDER BY deliveryDateTime DESC";
        ArrayList<FnbOrder> fnbOrderList = new ArrayList<FnbOrder>();
        
        stmt = conn.prepareStatement(sqlStr);
        stmt.setString(1, deliveryDateTime);
        ResultSet rs = stmt.executeQuery();
        
        while(rs.next()) {
            fnbOrderList.add(new FnbOrder(rs.getString("fnbOrderID"), rs.getString("fnbOrderDateTime"), rs.getString("deliveryAddress"), rs.getString("deliveryDateTime"), rs.getString("deliveryStatus"), new Booking("bookingID")));
        }
        
        return fnbOrderList;
    }
    
    public ArrayList<FnbOrder> getRecordByAccount(String emailAddress) throws SQLException {
        String sqlStr = innerJoinSqlStr + " ORDER BY fnbOrderDateTime DESC";
        ArrayList<FnbOrder> fnbOrderList = new ArrayList<FnbOrder>();
        
        stmt = conn.prepareStatement(sqlStr);
        stmt.setString(1, emailAddress);
        ResultSet rs = stmt.executeQuery();
        
        while(rs.next()) {
            Payment payment = new Payment(rs.getString("paymentID"), rs.getString("paymentMethod"), rs.getDouble("totalAmount"));
            Booking booking = new Booking(rs.getString("bookingID"), rs.getString("bookingDateTime"), new Account(rs.getString("emailAddress")), payment);
            fnbOrderList.add(new FnbOrder(rs.getString("fnbOrderID"), rs.getString("fnbOrderDateTime"), rs.getString("deliveryAddress"), rs.getString("deliveryDateTime"), rs.getString("deliveryStatus"), booking));
        }
        
        return fnbOrderList;
    }
    
    public ArrayList<FnbOrder> getUpcomingRecord(String emailAddress) throws SQLException {
        String sqlStr = innerJoinSqlStr + "AND UPPER(deliveryStatus) != 'DELIVERED' ORDER BY fnbOrderDateTime DESC";
        ArrayList<FnbOrder> fnbOrderList = new ArrayList<FnbOrder>();
        
        stmt = conn.prepareStatement(sqlStr);
        stmt.setString(1, emailAddress);
        ResultSet rs = stmt.executeQuery();
        
        while(rs.next()) {
            Payment payment = new Payment(rs.getString("paymentID"), rs.getString("paymentMethod"), rs.getDouble("totalAmount"));
            Booking booking = new Booking(rs.getString("bookingID"), rs.getString("bookingDateTime"), new Account(rs.getString("emailAddress")), payment);
            fnbOrderList.add(new FnbOrder(rs.getString("fnbOrderID"), rs.getString("fnbOrderDateTime"), rs.getString("deliveryAddress"), rs.getString("deliveryDateTime"), rs.getString("deliveryStatus"), booking));
        }
        
        return fnbOrderList;
    }
    
    public FnbOrder getSpecificRecord(String fnbOrderID) throws SQLException {
        String sqlStr = "SELECT * FROM " + tableName + " WHERE fnbOrderID = ?";
        FnbOrder fnbOrder = new FnbOrder();
        
        stmt = conn.prepareStatement(sqlStr);
        stmt.setString(1, fnbOrderID);
        ResultSet rs = stmt.executeQuery();
        
        if(rs.next()) {
            fnbOrder = new FnbOrder(rs.getString("fnbOrderID"), rs.getString("fnbOrderDateTime"), rs.getString("deliveryAddress"), rs.getString("deliveryDateTime"), rs.getString("deliveryStatus"), new Booking("bookingID"));
        }
        
        return fnbOrder;
    }
    
    public int countDeliveryStatus(String deliveryStatus, String deliveryDateTime) throws SQLException {
        deliveryDateTime = deliveryDateTime + "%";
        String sqlStr = "SELECT COUNT(DeliveryStatus) AS Count FROM " + tableName + " WHERE UPPER(DeliveryStatus) = ? AND deliveryDateTime LIKE ?";
        int count = 0;
        
        stmt = conn.prepareStatement(sqlStr);
        stmt.setString(1, deliveryStatus.toUpperCase());
        stmt.setString(2, deliveryDateTime);
        ResultSet rs = stmt.executeQuery();
        
        if(rs.next()) {
            count = rs.getInt("Count");
        }
        
        return count++;
    }
    
    public void insertRecord(FnbOrder fnbOrder) throws SQLException {
        String sqlStr = "INSERT INTO " + tableName + " VALUES(?,?,?,?,?,?)";
        
        stmt = conn.prepareStatement(sqlStr);
        stmt.setString(1, fnbOrder.getFnbOrderID());
        stmt.setString(2, fnbOrder.getFnbOrderDateTime());
        stmt.setString(3, fnbOrder.getDeliveryAddress());
        stmt.setString(4, fnbOrder.getDeliveryDateTime());
        stmt.setString(5, fnbOrder.getDeliveryStatus());
        stmt.setString(6, fnbOrder.getBooking().getBookingId());
        
        stmt.executeUpdate();
    }
    
    public void updateRecord(FnbOrder fnbOrder) throws SQLException {
        String sqlStr = "UPDATE " + tableName + " SET deliveryAddress = ?, deliveryDateTime = ?, deliveryStatus = ? WHERE fnbOrderID = ?";
        
        stmt = conn.prepareStatement(sqlStr);
        stmt.setString(1, fnbOrder.getDeliveryAddress());
        stmt.setString(2, fnbOrder.getDeliveryDateTime());
        stmt.setString(3, fnbOrder.getDeliveryStatus());
        stmt.setString(4, fnbOrder.getFnbOrderID());
        
        stmt.executeUpdate();
    }
    
    public ArrayList<FnbOrder> sortFnbOrder(String columnName, String order, String deliveryDateTime) throws SQLException { 
        deliveryDateTime += "%";
        String sqlStr = "SELECT * FROM " + tableName + " WHERE deliveryDateTime LIKE ? AND deliveryAddress IS NOT NULL ORDER BY UPPER(" + columnName + ") " + order;
        ResultSet rs = null;
        ArrayList<FnbOrder> fnbOrderList = new ArrayList<FnbOrder>();

        stmt = conn.prepareStatement(sqlStr);
        stmt.setString(1, deliveryDateTime);
        rs = stmt.executeQuery();

        while(rs.next()) {
            fnbOrderList.add(new FnbOrder(rs.getString("fnbOrderID"), rs.getString("fnbOrderDateTime"), rs.getString("deliveryAddress"), rs.getString("deliveryDateTime"), rs.getString("deliveryStatus"), new Booking("bookingID")));
        }

        return fnbOrderList;
    }
    
    /*public void deleteRecord(FnbOrder fnbOrder) throws SQLException {
        String sqlStr = "DELETE FROM " + tableName + " WHERE fnbOrderID = ?";
        
        stmt = conn.prepareStatement(sqlStr);
        stmt.setString(1, fnbCategory.getFnbCategoryID());
        
        stmt.executeUpdate();
    }
    
    /*public FnbCategory getSpecificRecord(String fnbCategoryID) throws SQLException {
        String sqlStr = "SELECT * FROM " + tableName + " WHERE fnbCategoryID = ?";
        ResultSet rs = null;
        FnbCategory fnbCategory = new FnbCategory();

        stmt = conn.prepareStatement(sqlStr);
        stmt.setString(1, fnbCategoryID);

        rs = stmt.executeQuery();

        if(rs.next()) {
            fnbCategory = new FnbCategory(rs.getString("fnbCategoryID"), rs.getString("fnbCategory"));
        }

        return fnbCategory;
    }*/

    private void createConnection() throws Exception {
        Class.forName("org.apache.derby.jdbc.ClientDriver");
        conn = DriverManager.getConnection(host, user, password);
    }
}
