package model;

import model.TheatreClasses;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import javax.swing.JOptionPane;

public class TheatreClassesDA{
    private String host = "jdbc:derby://localhost:1527/cinemadb";
    private String user = "nbuser";
    private String password = "nbuser";
    private String tableName = "TheatreClasses";
    private Connection conn;
    private PreparedStatement stmt;
    
    public TheatreClassesDA(){
        createConnection();
    }
    
    /*
    public int getSizeOfColumn(int columnNo) throws SQLException{
        String queryStr = "SELECT * FROM " + tableName;
        
        //Creating a Statement object
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery(queryStr);

        //Retrieving the ResultSetMetaData object
        ResultSetMetaData rsmd = rs.getMetaData();

        //getting the column type
        int column_size = rsmd.getPrecision(columnNo);
        
        return column_size;
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
    }*/
    
     public List<TheatreClasses> retrieveAllRecord() throws SQLException{
        String queryStr = "SELECT * FROM " + tableName;

        List<TheatreClasses> theatreClasses= new ArrayList<TheatreClasses>();
        
            stmt = conn.prepareStatement(queryStr);
            ResultSet rs = stmt.executeQuery();
            int i = 0;
            
            while(rs.next()){    
                
                theatreClasses.add(new TheatreClasses(rs.getString("theatreClassesId"), rs.getString("theatreClassesDesc")));
                
                rs.getRow();
                
            }
            
            return theatreClasses;
    }
    
    public TheatreClasses retrieveTheatreClassesRecord(String theatreClassesID){
        String queryStr = "SELECT * FROM " + tableName +  " WHERE TheatreClassesId = ?";
        TheatreClasses theatreClasses = null;
        
        try{
            stmt = conn.prepareStatement(queryStr);
            stmt.setString(1, theatreClassesID);
            
            ResultSet rs = stmt.executeQuery();
            
            if(rs.next()){
                
                theatreClasses = new TheatreClasses(theatreClassesID, rs.getString("theatreClassesDesc"));
            
            }
        }catch (SQLException ex){
            System.out.println("ERROR: " + ex.toString() + "<br/>");
            
            StackTraceElement[] element = ex.getStackTrace();
            
            for(StackTraceElement e:element){
                System.out.println("File Name: " + e.getFileName() + "<br/>");
                System.out.println("Class Name: " + e.getClassName() + "<br/>");
                System.out.println("Method Name: " + e.getMethodName() + "<br/>");
                System.out.println("Line Number: " + e.getLineNumber() + "<br/>");
            }
        }
        
        return theatreClasses;
        
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
        new TheatreClassesDA();
    }    
}

