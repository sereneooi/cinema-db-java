package model;

import model.*;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import javax.swing.JOptionPane;

public class SeatTypeDA{
    private String host = "jdbc:derby://localhost:1527/cinemadb";
    private String user = "nbuser";
    private String password = "nbuser";
    private String tableName = "SEATTYPE";
    private Connection conn;
    private PreparedStatement stmt;
    private SeatType seatType;
    
    public SeatTypeDA(){
        createConnection();
        //seatTypeDa = new SeatTypeDA();
    }
    
    public SeatType retrieveRecord(String seatTypeId) throws SQLException{
        String queryStr = "SELECT * FROM " + tableName +  " WHERE seatTypeId = ?";
        SeatType seatType = null;
        String id = null;
        
        stmt = conn.prepareStatement(queryStr);
        stmt.setString(1, seatTypeId);

        ResultSet rs = stmt.executeQuery();

        if(rs.next()){    

            seatType = new SeatType(seatTypeId, rs.getString("seatDescription"), rs.getDouble("seatTypePrice"));

        }

        return seatType;
    }
    
     public List<SeatType> retrieveAllRecord() throws SQLException{
        String queryStr = "SELECT * FROM " + tableName;

        List<SeatType> seatType= new ArrayList<SeatType>();
        
        stmt = conn.prepareStatement(queryStr);
        ResultSet rs = stmt.executeQuery();

        while(rs.next()){
            seatType.add(new SeatType(rs.getString("seatTypeId"), rs.getString("seatDescription"), rs.getDouble("seatTypePrice")));
            rs.getRow();
        }

        return seatType;
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

    }    
}


