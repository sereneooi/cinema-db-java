package model;

import java.sql.*;
import java.util.*;

public class FnbOrderLineDA {
    private String host = "jdbc:derby://localhost:1527/cinemadb";
    private String user = "nbuser";
    private String password = "nbuser";
    private String tableName = "FnbOrderLine";
    private Connection conn;
    private PreparedStatement stmt;
    
    public FnbOrderLineDA() throws Exception{
        createConnection();
    }
    
    public ArrayList getRecord() throws SQLException {
        String sqlStr = "SELECT * FROM " + tableName;
        ArrayList<FnbOrderLine> fnbOrderLineList = new ArrayList<FnbOrderLine>();
        
        stmt = conn.prepareStatement(sqlStr);
        ResultSet rs = stmt.executeQuery();
        
        while(rs.next()) {
            fnbOrderLineList.add(new FnbOrderLine(rs.getString("fnbOrderLineID"), rs.getInt("quantity"), new Fnb(rs.getString("fnbID"))));
        }
        
        return fnbOrderLineList;
    }
    
    public Object[] getRecordByFnbOrderID(String fnbOrderID) throws SQLException {
        String sqlStr = "SELECT * FROM " + tableName + " INNER JOIN Fnb ON " + tableName + ".FNBID = Fnb.FNBID WHERE fnbOrderID = ?";
        ArrayList<FnbOrderLine> fnbOrderLineList = new ArrayList<FnbOrderLine>();
        ArrayList<Fnb> fnbList = new ArrayList<Fnb>();
        
        stmt = conn.prepareStatement(sqlStr);
        stmt.setString(1, fnbOrderID);
        ResultSet rs = stmt.executeQuery();
        
        while(rs.next()) {
            Fnb fnb = new Fnb(rs.getString("fnbID"), rs.getString("fnbImage"), rs.getString("fnbDescription"), rs.getDouble("fnbPrice"), rs.getInt("fnbStockLeft"), rs.getBoolean("active"), new FnbCategory(rs.getString("fnbCategoryID")));
            fnbList.add(fnb);
            fnbOrderLineList.add(new FnbOrderLine(rs.getString("fnbOrderLineID"), rs.getInt("quantity"), fnb));   
        }

        return new Object[] {fnbOrderLineList, fnbList};
    }
    
    public Object[] getFullDetailsRecord(String fnbOrderID) throws SQLException {
        String sqlStr = "SELECT * FROM " + tableName + 
                               " INNER JOIN Fnb ON " + tableName + ".FNBID = Fnb.FNBID " +
                               "INNER JOIN FnbOrder ON " + tableName + ".fnbOrderID = FnbOrder.FNBORDERID " + 
                               "INNER JOIN Booking ON FnbOrder.BOOKINGID = Booking.BOOKINGID " +
                               "INNER JOIN Account ON Booking.EMAILADDRESS = Account.EMAILADDRESS " + 
                               "WHERE FnbOrderLine.fnbOrderID = ?";
        ArrayList<FnbOrderLine> fnbOrderLineList = new ArrayList<FnbOrderLine>();
        ArrayList<Fnb> fnbList = new ArrayList<Fnb>();
        Account account = new Account();
        
        stmt = conn.prepareStatement(sqlStr);
        stmt.setString(1, fnbOrderID);
        ResultSet rs = stmt.executeQuery();
        
        while(rs.next()) {
            Fnb fnb = new Fnb(rs.getString("fnbID"), rs.getString("fnbImage"), rs.getString("fnbDescription"), rs.getDouble("fnbPrice"), rs.getInt("fnbStockLeft"), rs.getBoolean("active"), new FnbCategory(rs.getString("fnbCategoryID")));
            fnbList.add(fnb);
            account = new Account(rs.getString("emailAddress"), rs.getString("name"), rs.getString("contactNo"));
            fnbOrderLineList.add(new FnbOrderLine(rs.getString("fnbOrderLineID"), rs.getInt("quantity"), fnb));   
        }
        
        return new Object[] {fnbOrderLineList, fnbList, account};
        
    }
    
    public void insertRecord(FnbOrderLine fnbOrderLine) throws SQLException {
        String sqlStr = "INSERT INTO " + tableName + " VALUES(?,?,?,?)";
        
        stmt = conn.prepareStatement(sqlStr);
        stmt.setString(1, fnbOrderLine.getFnbOrderLineID());
        stmt.setInt(2, fnbOrderLine.getQuantity());
        stmt.setString(3, fnbOrderLine.getFnb().getFnbID());
        stmt.setString(4, fnbOrderLine.getFnbOrder().getFnbOrderID());
        
        stmt.executeUpdate();
    }
    
    /*public void updateRecord(Fnb fnb) throws SQLException {
        String sqlStr = "UPDATE " + tableName + " SET fnbDescription = ?, fnbPrice = ?, fnbStockLeft = ?, dateModified = ?, fnbCategoryID = ?, fnbImage = ? WHERE fnbID = ?";
        
        if(fnb.getFnbImage().equals("") || fnb.getFnbImage() == null) {
            sqlStr = sqlStr.replace(", fnbImage = ?", "");
        }
        
        stmt = conn.prepareStatement(sqlStr);
        stmt.setString(1, fnb.getFnbDescription());
        stmt.setDouble(2, fnb.getFnbPrice());
        stmt.setInt(3, fnb.getFnbStockLeft());
        stmt.setString(4, fnb.getDateModified());
        stmt.setString(5, fnb.getFnbCategory().getFnbCategoryID());
        
        if(fnb.getFnbImage().equals("") || fnb.getFnbImage() == null) {
            stmt.setString(6, fnb.getFnbID());
        } else {
            stmt.setString(6, fnb.getFnbImage());
            stmt.setString(7, fnb.getFnbID());
        }

        stmt.executeUpdate();
    }*/
    
     /*public void deleteRecord(String fnbOrderID) throws SQLException {
        String sqlStr = "DELETE FROM " + tableName + " WHERE fnbOrderID = ?";
        
        stmt = conn.prepareStatement(sqlStr);
        stmt.setString(1, fnbOrderID);
        
        stmt.executeUpdate();
    }*/
     
     /*public Fnb getSpecificRecord(String fnbID) throws SQLException {
         String sqlStr = "SELECT * FROM " + tableName + " WHERE fnbID = ?";
         ResultSet rs = null;
         Fnb fnb = new Fnb();
         
         stmt = conn.prepareStatement(sqlStr);
         stmt.setString(1, fnbID);
         
         rs = stmt.executeQuery();
         
         if(rs.next()) {
             fnb = new Fnb(rs.getString("fnbID"), rs.getString("fnbImage"), rs.getString("fnbDescription"), rs.getDouble("fnbPrice"), rs.getInt("fnbStockLeft"), new FnbCategory(rs.getString("fnbCategoryID")));
         }
         
         return fnb;
     }*/
    
    private void createConnection() throws Exception{
        Class.forName("org.apache.derby.jdbc.ClientDriver");
        conn = DriverManager.getConnection(host, user, password);
    }
}
