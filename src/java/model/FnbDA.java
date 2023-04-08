package model;

import java.sql.*;
import java.util.ArrayList;

public class FnbDA {
    private String host = "jdbc:derby://localhost:1527/cinemadb";
    private String user = "nbuser";
    private String password = "nbuser";
    private String tableName = "Fnb";
    private Connection conn;
    private PreparedStatement stmt;
    private String innerJoinSqlStr = "SELECT fnbID, fnbImage, fnbDescription, fnbPrice, fnbStockLeft, active, Fnb.dateCreated, Fnb.dateModified, FnbCategory.fnbCategory " + 
                                                     "FROM " + tableName + 
                                                     " INNER JOIN FnbCategory " + 
                                                     "ON Fnb.FnbCategoryID = FnbCategory.FNBCATEGORYID ";
    
    public FnbDA() throws Exception{
        createConnection();
    }
    
    public ArrayList<Fnb> getRecord() throws SQLException {
        String sqlStr = innerJoinSqlStr + " ORDER BY fnbID";
        ArrayList<Fnb> fnbList = new ArrayList<Fnb>();
  
        stmt = conn.prepareStatement(sqlStr);
        ResultSet rs = stmt.executeQuery();
        
        while(rs.next()) {
            FnbCategory fnbCategory = new FnbCategory();
            fnbCategory.setFnbCategory(rs.getString("fnbCategory"));
            fnbList.add(new Fnb(rs.getString("fnbID"), rs.getString("fnbImage"), rs.getString("fnbDescription"), rs.getDouble("fnbPrice"), rs.getInt("fnbStockLeft"), rs.getBoolean("active"), rs.getString("dateCreated"), rs.getString("dateModified"), fnbCategory));
        }
        
        return fnbList;
    }
    
    public void insertRecord(Fnb fnb) throws SQLException {
        String sqlStr = "INSERT INTO " + tableName + " VALUES(?,?,?,?,?,?,?,?,?)";
        
        stmt = conn.prepareStatement(sqlStr);
        stmt.setString(1, fnb.getFnbID());
        stmt.setString(2, fnb.getFnbImage());
        stmt.setString(3, fnb.getFnbDescription());
        stmt.setDouble(4, fnb.getFnbPrice());
        stmt.setInt(5, fnb.getFnbStockLeft());
        stmt.setBoolean(6, fnb.isActive());
        stmt.setString(7, fnb.getDateCreated());
        stmt.setString(8, "");
        stmt.setString(9, fnb.getFnbCategory().getFnbCategoryID());
        
        stmt.executeUpdate();
    }
    
    public void updateRecord(Fnb fnb) throws SQLException {
        String sqlStr = "UPDATE " + tableName + " SET fnbDescription = ?, fnbPrice = ?, fnbStockLeft = ?, active = ?, dateModified = ?, fnbCategoryID = ?, fnbImage = ? WHERE fnbID = ?";
        
        if(fnb.getFnbImage().equals("") || fnb.getFnbImage() == null) {
            sqlStr = sqlStr.replace(", fnbImage = ?", "");
        }
        
        stmt = conn.prepareStatement(sqlStr);
        stmt.setString(1, fnb.getFnbDescription());
        stmt.setDouble(2, fnb.getFnbPrice());
        stmt.setInt(3, fnb.getFnbStockLeft());
        stmt.setBoolean(4, fnb.isActive());
        stmt.setString(5, fnb.getDateModified());
        stmt.setString(6, fnb.getFnbCategory().getFnbCategoryID());
        
        if(fnb.getFnbImage().equals("") || fnb.getFnbImage() == null) {
            stmt.setString(7, fnb.getFnbID());
        } else {
            stmt.setString(7, fnb.getFnbImage());
            stmt.setString(8, fnb.getFnbID());
        }

        stmt.executeUpdate();
    }
    
     public void deleteRecord(Fnb fnb) throws SQLException {
        String sqlStr = "DELETE FROM " + tableName + " WHERE fnbID = ?";
        
        stmt = conn.prepareStatement(sqlStr);
        stmt.setString(1, fnb.getFnbID());
        
        stmt.executeUpdate();
    }
     
     public Fnb getSpecificRecord(String fnbID) throws SQLException {
         String sqlStr = "SELECT * FROM " + tableName + " WHERE fnbID = ?";
         ResultSet rs = null;
         Fnb fnb = new Fnb();
         
         stmt = conn.prepareStatement(sqlStr);
         stmt.setString(1, fnbID);
         
         rs = stmt.executeQuery();
         
         if(rs.next()) {
             fnb = new Fnb(rs.getString("fnbID"), rs.getString("fnbImage"), rs.getString("fnbDescription"), rs.getDouble("fnbPrice"), rs.getInt("fnbStockLeft"), rs.getBoolean("active"), new FnbCategory(rs.getString("fnbCategoryID")));
         }
         
         return fnb;
     }
     
     public ArrayList<Fnb> filterFnb(String keyword) throws SQLException {
        String sqlStr = innerJoinSqlStr + 
                                " WHERE UPPER(fnbID) LIKE ? OR UPPER(fnbDescription) LIKE ? " +
                                "OR CAST(CAST(CAST(fnbPrice AS DECIMAL(5, 2)) AS CHAR(24)) AS VARCHAR(255)) LIKE ? OR " + 
                                "CAST(CAST(fnbStockLeft AS CHAR(24)) AS VARCHAR(255)) LIKE ? "+ 
                                "OR UPPER(Fnb.dateCreated) LIKE ? OR UPPER(Fnb.dateModified) LIKE ? " + 
                                "OR UPPER(FnbCategory.fnbCategory) LIKE ?";
        keyword = "%" + keyword.toUpperCase() + "%";
        ResultSet rs = null;
        ArrayList<Fnb> fnbList = new ArrayList<Fnb>();

        stmt = conn.prepareStatement(sqlStr);
        for(int i = 1; i < 8; i++) {
            stmt.setString(i, keyword);
        }

        rs = stmt.executeQuery();

        while(rs.next()) {
            FnbCategory fnbCategory = new FnbCategory();
            fnbCategory.setFnbCategory(rs.getString("fnbCategory"));
            fnbList.add(new Fnb(rs.getString("fnbID"), rs.getString("fnbImage"), rs.getString("fnbDescription"), rs.getDouble("fnbPrice"), rs.getInt("fnbStockLeft"), rs.getBoolean("active"), rs.getString("dateCreated"), rs.getString("dateModified"), fnbCategory));
        }

        return fnbList;
    }
     
     
     public ArrayList<Fnb> sortFnb(String columnName, String order) throws SQLException { 
        String sqlStr = innerJoinSqlStr +  
                                " ORDER BY " + columnName + " " + order;
        ResultSet rs = null;
        ArrayList<Fnb> fnbList = new ArrayList<Fnb>();

        stmt = conn.prepareStatement(sqlStr);
        rs = stmt.executeQuery();

        while(rs.next()) {
            FnbCategory fnbCategory = new FnbCategory();
            fnbCategory.setFnbCategory(rs.getString("fnbCategory"));
            fnbList.add(new Fnb(rs.getString("fnbID"), rs.getString("fnbImage"), rs.getString("fnbDescription"), rs.getDouble("fnbPrice"), rs.getInt("fnbStockLeft"), rs.getBoolean("active"), rs.getString("dateCreated"), rs.getString("dateModified"), fnbCategory));
        }

        return fnbList;
    }
     
     public void updateStockLeft(String fnbID, int quantity) throws SQLException {
        String sqlStr = "UPDATE " + tableName + " SET fnbStockLeft = ? WHERE fnbID = ?";
        
        Fnb fnb = getSpecificRecord(fnbID);
        stmt = conn.prepareStatement(sqlStr);
        stmt.setInt(1, fnb.getFnbStockLeft() - quantity);
        stmt.setString(2, fnbID);
        
        stmt.executeUpdate();
     }
    
    private void createConnection() throws Exception{
        Class.forName("org.apache.derby.jdbc.ClientDriver");
        conn = DriverManager.getConnection(host, user, password);
    }
}
