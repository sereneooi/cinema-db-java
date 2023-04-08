package model;

import java.sql.*;
import java.util.ArrayList;

public class FnbCategoryDA {
    private String host = "jdbc:derby://localhost:1527/cinemadb";
    private String user = "nbuser";
    private String password = "nbuser";
    private String tableName = "FnbCategory";
    private Connection conn;
    private PreparedStatement stmt;
    
    public FnbCategoryDA() throws Exception{
        createConnection();
    }
    
    public ArrayList<FnbCategory> getRecord() throws SQLException {
        String sqlStr = "SELECT * FROM " + tableName;
        ArrayList<FnbCategory> fnbCategoryList = new ArrayList<FnbCategory>();
        
        stmt = conn.prepareStatement(sqlStr);
        ResultSet rs = stmt.executeQuery();
        
        while(rs.next()) {
            fnbCategoryList.add(new FnbCategory(rs.getString("fnbCategoryID"), rs.getString("fnbCategory"), rs.getString("dateCreated"), rs.getString("dateModified")));
        }
        
        return fnbCategoryList;
    }
    
    public void insertRecord(FnbCategory fnbCategory) throws SQLException {
        String sqlStr = "INSERT INTO " + tableName + " VALUES(?,?,?,?)";
        
        stmt = conn.prepareStatement(sqlStr);
        stmt.setString(1, fnbCategory.getFnbCategoryID());
        stmt.setString(2, fnbCategory.getFnbCategory());
        stmt.setString(3, fnbCategory.getDateCreated());
        stmt.setString(4, "");
        
        stmt.executeUpdate();
    }
    
    public void updateRecord(FnbCategory fnbCategory) throws SQLException {
        String sqlStr = "UPDATE " + tableName + " SET fnbCategory = ?, dateModified = ? WHERE fnbCategoryID = ?";
        
        stmt = conn.prepareStatement(sqlStr);
        stmt.setString(1, fnbCategory.getFnbCategory());
        stmt.setString(2, fnbCategory.getDateModified());
        stmt.setString(3, fnbCategory.getFnbCategoryID());
        
        stmt.executeUpdate();
    }
    
    public void deleteRecord(FnbCategory fnbCategory) throws SQLException {
        String sqlStr = "DELETE FROM " + tableName + " WHERE fnbCategoryID = ?";
        
        stmt = conn.prepareStatement(sqlStr);
        stmt.setString(1, fnbCategory.getFnbCategoryID());
        
        stmt.executeUpdate();
    }
    
    public FnbCategory getSpecificRecord(String fnbCategoryID) throws SQLException {
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
    }
    
    public ArrayList<FnbCategory> filterFnbCategory(String keyword) throws SQLException {
        String sqlStr = "SELECT * FROM " + tableName + " WHERE UPPER(fnbCategoryID) LIKE ? OR UPPER(fnbCategory) LIKE ? OR UPPER(dateCreated) LIKE ? OR UPPER(dateModified) LIKE ?";
        keyword = "%" + keyword.toUpperCase() + "%";
        ResultSet rs = null;
        ArrayList<FnbCategory> fnbCategoryList = new ArrayList<FnbCategory>();

        stmt = conn.prepareStatement(sqlStr);
        for(int i = 1; i < 5; i++) {
            stmt.setString(i, keyword);
        }

        rs = stmt.executeQuery();

        while(rs.next()) {
            fnbCategoryList.add(new FnbCategory(rs.getString("fnbCategoryID"), rs.getString("fnbCategory"), rs.getString("dateCreated"), rs.getString("dateModified")));
        }

        return fnbCategoryList;
    }
     
    public ArrayList<FnbCategory> sortFnbCategory(String columnName, String order) throws SQLException { 
        String sqlStr = "SELECT * FROM " + tableName + " ORDER BY UPPER(" + columnName + ") " + order;
        ResultSet rs = null;
        ArrayList<FnbCategory> fnbCategoryList = new ArrayList<FnbCategory>();

        stmt = conn.prepareStatement(sqlStr);
        rs = stmt.executeQuery();

        while(rs.next()) {
            fnbCategoryList.add(new FnbCategory(rs.getString("fnbCategoryID"), rs.getString("fnbCategory"), rs.getString("dateCreated"), rs.getString("dateModified")));
        }

        return fnbCategoryList;
    }
    
    private void createConnection() throws Exception {
        Class.forName("org.apache.derby.jdbc.ClientDriver");
        conn = DriverManager.getConnection(host, user, password);
    }
}
