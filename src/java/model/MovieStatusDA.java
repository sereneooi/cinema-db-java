package model;

import java.sql.*;
import java.text.ParseException;
import javax.swing.*;
import java.text.SimpleDateFormat;  
import java.util.ArrayList;
import java.util.Date;
import model.*;

public class MovieStatusDA {
    private String host = "jdbc:derby://localhost:1527/cinemadb";
    private String user = "nbuser";
    private String password = "nbuser";
    private String tableName = "MovieStatus";
    private Connection conn;
    private PreparedStatement stmt;

    
    public MovieStatusDA(){
        createConnection();
    }

    //catch exception at caller
   public ArrayList<MovieStatus> getMovieStatusRecord() throws SQLException{
       
       String queryStr = "SELECT * FROM " + tableName;
       
       ArrayList<MovieStatus> movieStatusList = new ArrayList<MovieStatus>();
        
        stmt = conn.prepareStatement(queryStr);
        ResultSet rs = stmt.executeQuery();

        while(rs.next()){
            movieStatusList.add(new MovieStatus(rs.getString("movieStatusID"), rs.getString("movieStatusDesc")));
        } 
        return movieStatusList;
    }

    private void createConnection() {
        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            conn = DriverManager.getConnection(host, user, password);
        } catch (Exception ex) {
            JOptionPane.showMessageDialog(null, ex.getMessage(), "ERROR", JOptionPane.ERROR_MESSAGE);
        }
    }

    private void shutDown() {
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException ex) {
                JOptionPane.showMessageDialog(null, ex.getMessage(), "ERROR", JOptionPane.ERROR_MESSAGE);
            }
        }
    }

    public static void main(String[] args) {
        new MovieStatusDA();
    }
}

