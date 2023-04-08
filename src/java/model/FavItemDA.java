package model;

import java.sql.*;
import java.util.ArrayList;

public class FavItemDA {
    private String host = "jdbc:derby://localhost:1527/cinemadb";
    private String user = "nbuser";
    private String password = "nbuser";
    private String tableName = "FavItem";
    private Connection conn;
    private PreparedStatement stmt;
    
    public FavItemDA() throws Exception{
        createConnection();
    }
    
    public ArrayList<FavItem> getRecord() throws SQLException {
        String sqlStr = "SELECT * FROM " + tableName;
        ArrayList<FavItem> favItemList = new ArrayList<FavItem>();
        
        stmt = conn.prepareStatement(sqlStr);
        ResultSet rs = stmt.executeQuery();
        
        while(rs.next()) {
            favItemList.add(new FavItem(rs.getString("favItemID"), new Fnb(rs.getString("fnbID")), new Account(rs.getString("emailAddress"))));
        }
        
        return favItemList;
    }
    
    public void insertRecord(FavItem favItem) throws SQLException {
        String sqlStr = "INSERT INTO " + tableName + " VALUES(?,?,?)";
        
        stmt = conn.prepareStatement(sqlStr);
        stmt.setString(1, favItem.getFavItemID());
        stmt.setString(2, favItem.getFnb().getFnbID());
        stmt.setString(3, favItem.getAccount().getEmailAddress());
        
        stmt.executeUpdate();
    }
    
    public void deleteRecord(FavItem favItem) throws SQLException {
        String sqlStr = "DELETE FROM " + tableName + " WHERE favItemID = ?";
        
        stmt = conn.prepareStatement(sqlStr);
        stmt.setString(1, favItem.getFavItemID());
        
        stmt.executeUpdate();
    }
    
    public void deleteFnbID(String fnbID) throws SQLException {
        String sqlStr = "DELETE FROM " + tableName + " WHERE fnbID = ?";
        
        stmt = conn.prepareStatement(sqlStr);
        stmt.setString(1, fnbID);
        
        stmt.executeUpdate();
    }
    
    public FavItem getSpecificRecord(String favItemID) throws SQLException {
        String sqlStr = "SELECT * FROM " + tableName + " WHERE favItemID = ?";
        ResultSet rs = null;
        FavItem favItem = new FavItem();

        stmt = conn.prepareStatement(sqlStr);
        stmt.setString(1, favItemID);

        rs = stmt.executeQuery();

        if(rs.next()) {
            favItem = new FavItem(rs.getString("favItemID"), new Fnb(rs.getString("fnbID")), new Account(rs.getString("emailAddress")));
        }

        return favItem;
    }
      
    public ArrayList<FavItem> getRecordByAccount(String emailAddress) throws SQLException {
        String sqlStr = "SELECT * FROM " + tableName + " WHERE emailAddress = ?";
        ArrayList<FavItem> favItemList = new ArrayList<FavItem>();
        
        stmt = conn.prepareStatement(sqlStr);
        stmt.setString(1, emailAddress);
        ResultSet rs = stmt.executeQuery();
        
        while(rs.next()) {
            favItemList.add(new FavItem(rs.getString("favItemID"), new Fnb(rs.getString("fnbID")), new Account(rs.getString("emailAddress"))));
        }
        
        return favItemList;
    }
    
    public ArrayList<String> getFnbID() throws SQLException {
        String sqlStr = "SELECT DISTINCT(fnbID) FROM " + tableName;
        ArrayList<String> fnbIDList = new ArrayList<String>();

        stmt = conn.prepareStatement(sqlStr);
        ResultSet rs = stmt.executeQuery();
        
        while(rs.next()) {
            fnbIDList.add(rs.getString("fnbID"));
        }
        
        return fnbIDList;
    }
    
    public Object[] getFavouriteCount() throws SQLException {
        String sqlStr = "SELECT FavItem.FnbId, fnbImage, fnbDescription, fnbPrice, fnbStockLeft, active, COUNT(FavItemID) AS countFavItem " + 
                                "FROM " + tableName +
                                " INNER JOIN Fnb ON " + tableName + ".fnbID = Fnb.fnbID " + 
                                "GROUP BY " + tableName + ".FnbID, fnbImage, fnbDescription, fnbPrice, fnbStockLeft, active " + 
                                "ORDER BY countFavItem DESC";
        ArrayList<Fnb> fnbList = new ArrayList<Fnb>();
        ArrayList<Integer> count = new ArrayList<Integer>();
        
        stmt = conn.prepareStatement(sqlStr);
        ResultSet rs = stmt.executeQuery();
        
        while(rs.next()) {
            Fnb fnb = new Fnb(rs.getString("fnbID"), rs.getString("fnbImage"), rs.getString("fnbDescription"), rs.getDouble("fnbPrice"), rs.getInt("fnbStockLeft"), rs.getBoolean("active"), new FnbCategory());
            fnbList.add(fnb);
            count.add(rs.getInt("countFavItem"));
        }
        
        return new Object[] {fnbList, count};
    }
    
    private void createConnection() throws Exception {
        Class.forName("org.apache.derby.jdbc.ClientDriver");
        conn = DriverManager.getConnection(host, user, password);
    }
}
