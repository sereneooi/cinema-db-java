package model;

import model.*;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import javax.swing.JOptionPane;

public class TheatreDA{
    private String host = "jdbc:derby://localhost:1527/cinemadb";
    private String user = "nbuser";
    private String password = "nbuser";
    private String tableName = "Theatre";
    private Connection conn;
    private PreparedStatement stmt;
    private TheatreClassesDA tClassesDa;
    
    public TheatreDA(){
        createConnection();
        tClassesDa = new TheatreClassesDA();
    }
    
    public int RecordCount() throws SQLException{
        String queryStr = "SELECT COUNT(*) FROM " + tableName;
        
        int rowCount = 0;
        
        stmt = conn.prepareStatement(queryStr);
        ResultSet rs = stmt.executeQuery();

        if(rs.next()){
            rowCount = rs.getInt(1);
        }
        
        return rowCount;
    }
    
    public Theatre retrieveRecord(String theatreID) throws SQLException{
        String queryStr = "SELECT * FROM " + tableName +  " WHERE theatreId = ?";
        Theatre theatre = null;
        String id = null;
        
        stmt = conn.prepareStatement(queryStr);
        stmt.setString(1, theatreID);

        ResultSet rs = stmt.executeQuery();

        if(rs.next()){    
            TheatreClasses theatreClasses = tClassesDa.retrieveTheatreClassesRecord(rs.getString("theatreClassesID"));
            theatre = new Theatre(theatreID, rs.getString("theatreDesc"), rs.getInt("totalSeatCount"), theatreClasses);
        }
        return theatre;
    }
    
     public List<Theatre> retrieveAllRecord() throws SQLException{
        String queryStr = "SELECT * FROM " + tableName;

        List<Theatre> theatre = new ArrayList<Theatre>();

        stmt = conn.prepareStatement(queryStr);
        ResultSet rs = stmt.executeQuery();
        int i = 0;

        while(rs.next()){
            TheatreClasses theatreClasses = tClassesDa.retrieveTheatreClassesRecord(rs.getString("theatreClassesID"));
            theatre.add(new Theatre(rs.getString("theatreId"), rs.getString("theatreDesc"), rs.getInt("totalSeatCount"), theatreClasses));
            rs.getRow();
        }

        return theatre;
    }
     
     public List<Theatre> searchRecord(String searchVariable) throws SQLException{
         String queryStr = "SELECT * FROM " + tableName + " WHERE theatreId LIKE '%" + searchVariable + "%' "
                 + "OR theatreDesc LIKE '%" + searchVariable + "%' "
                 + "OR theatreClassesID LIKE '%" + searchVariable + "%' "
                 + "OR theatreClassesID IN "
                 + "(SELECT theatreClassesID FROM THEATRECLASSES WHERE TheatreClassesDesc LIKE '%" + searchVariable + "%')";
         
         List<Theatre> theatre = new ArrayList<Theatre>();
         stmt = conn.prepareStatement(queryStr);
         
         ResultSet rs = stmt.executeQuery();
         
         while(rs.next()){
            TheatreClasses theatreClasses = tClassesDa.retrieveTheatreClassesRecord(rs.getString("theatreClassesID"));
            theatre.add(new Theatre(rs.getString("theatreId"), rs.getString("theatreDesc"), rs.getInt("totalSeatCount"), theatreClasses));
            rs.getRow();
        }

        return theatre;
    }
     
     public List<Theatre> sortingRecord(String sortingVariable) throws SQLException{
         String queryStr = "SELECT * FROM " + tableName + " ORDER BY " + sortingVariable;
         List<Theatre> theatre = new ArrayList<Theatre>();
         stmt = conn.prepareStatement(queryStr);
         
         ResultSet rs = stmt.executeQuery();
         
         while(rs.next()){
            TheatreClasses theatreClasses = tClassesDa.retrieveTheatreClassesRecord(rs.getString("theatreClassesID"));
            theatre.add(new Theatre(rs.getString("theatreId"), rs.getString("theatreDesc"), rs.getInt("totalSeatCount"), theatreClasses));
            rs.getRow();
        }
         
         return theatre;
     }
     
      public List<Theatre> sortingForeignKeyRecord(String sortingVariable) throws SQLException{
         String queryStr = "SELECT * FROM " + tableName + " AS t LEFT JOIN THEATRECLASSES AS tc ON tc.theatreClassesId = t.theatreClassesId"
                 + " ORDER BY tc." + sortingVariable;
         List<Theatre> theatre = new ArrayList<Theatre>();
         stmt = conn.prepareStatement(queryStr);
         
         ResultSet rs = stmt.executeQuery();
         
         while(rs.next()){
            TheatreClasses theatreClasses = tClassesDa.retrieveTheatreClassesRecord(rs.getString("theatreClassesID"));
            theatre.add(new Theatre(rs.getString("theatreId"), rs.getString("theatreDesc"), rs.getInt("totalSeatCount"), theatreClasses));
            rs.getRow();
        }
         
         return theatre;
     }
   
   
    public void addTheatre(Theatre theatre) throws SQLException{
        
        String sqlStr = "INSERT INTO THEATRE VALUES(?, ?, ?, ?)";
            
        stmt = conn.prepareStatement(sqlStr);
        stmt.setString(1, theatre.getTheatreID());
        stmt.setString(2, theatre.getTheatreDesc());
        stmt.setString(3, String.valueOf(theatre.getTotalSeatCount()));
        stmt.setString(4, theatre.getTheatreClasses().getTheatreClassesID());
        stmt.executeUpdate();
    }
    
    public void updateTheatre(Theatre theatre, String theatreIdResult)  throws SQLException{

        String sqlStr = "UPDATE THEATRE set theatreDesc = ?, totalSeatCount = ?, theatreClassesId = ? WHERE theatreId = ?";
            
        stmt = conn.prepareStatement(sqlStr);

        stmt.setString(1, theatre.getTheatreDesc());
        stmt.setString(2, String.valueOf(theatre.getTotalSeatCount()));
        stmt.setString(3, theatre.getTheatreClasses().getTheatreClassesID());
        stmt.setString(4, theatreIdResult);

        stmt.executeUpdate();
    }
    
    public List<Theatre> checkForeignKeyConstraint() throws SQLException{
        String queryStr = 
                "SELECT t.* "
                + "FROM " + tableName + " AS t "
                + "LEFT JOIN MOVIESCHEDULE AS s "
                + "ON s.theatreId = t.theatreId "
                + "WHERE s.theatreId IS NULL";
        
        List<Theatre> theatre = new ArrayList<Theatre>();

        stmt = conn.prepareStatement(queryStr);
        ResultSet rs = stmt.executeQuery();

        while(rs.next()){
            TheatreClasses theatreClasses = tClassesDa.retrieveTheatreClassesRecord(rs.getString("theatreClassesID"));
            theatre.add(new Theatre(rs.getString("theatreId"), rs.getString("theatreDesc"), rs.getInt("totalSeatCount"), theatreClasses));
            rs.getRow();
        }

        return theatre;
    }
    
    public void deleteTheatre(String theatreId) throws SQLException{

        String sqlStr = "DELETE FROM THEATRE WHERE theatreID = ?";
        
        stmt = conn.prepareStatement(sqlStr);
        stmt.setString(1, theatreId);

        stmt.executeUpdate();
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

    }    
}
