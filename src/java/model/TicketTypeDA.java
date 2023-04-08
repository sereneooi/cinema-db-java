package model;

import model.*;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import javax.swing.JOptionPane;

public class TicketTypeDA{
    private String host = "jdbc:derby://localhost:1527/cinemadb";
    private String user = "nbuser";
    private String password = "nbuser";
    private String tableName = "TICKETTYPE";
    private Connection conn;
    private PreparedStatement stmt;
    private SeatType seatType;
    
    public TicketTypeDA(){
        createConnection();
    }
    
    public int recordCount() throws SQLException{
        String queryStr = "SELECT COUNT(*) FROM " + tableName;
        
        stmt = conn.prepareStatement(queryStr);
        ResultSet rs = stmt.executeQuery();
        rs.next();
        int rowCount = rs.getInt(1);
        return rowCount;
    }
    
    public List <TicketType> retrieveAllRecordIf() throws SQLException{
        String queryStr = "SELECT * FROM " + tableName;
        List <TicketType> ticketType = new ArrayList <TicketType>();
        
        stmt = conn.prepareStatement(queryStr);
        ResultSet rs = stmt.executeQuery();

        while(rs.next()){    
            ticketType.add(new TicketType(rs.getString("ticketTypeId"), rs.getString("ticketTypeDesc"), rs.getDouble("ticketDiscountRate")));
        }

        return ticketType;
    }    
    
    
    public TicketType retrieveRecord(String ticketTypeDesc) throws SQLException{
        String queryStr = "SELECT * FROM " + tableName +  " WHERE ticketTypeDesc = ?";
        TicketType ticketType = null;
        
        stmt = conn.prepareStatement(queryStr);
        stmt.setString(1, ticketTypeDesc);
        ResultSet rs = stmt.executeQuery();

        if(rs.next()){    
            ticketType = new TicketType(rs.getString("ticketTypeId"), ticketTypeDesc, rs.getDouble("ticketDiscountRate"));
        }

        return ticketType;
    }
    
    public List <TicketType> retrieveAllRecord() throws SQLException{
        String queryStr = "SELECT * FROM " + tableName;
        List <TicketType> ticketType = new ArrayList <TicketType>();
        
        stmt = conn.prepareStatement(queryStr);
        ResultSet rs = stmt.executeQuery();

        while(rs.next()){    
            ticketType.add(new TicketType(rs.getString("ticketTypeId"), rs.getString("ticketTypeDesc"), rs.getDouble("ticketDiscountRate")));
        }

        return ticketType;
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
        new TicketTypeDA();
    }    
}