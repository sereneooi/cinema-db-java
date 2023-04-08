package model;

import java.sql.*;
import java.text.ParseException;
import javax.swing.*;
import java.text.SimpleDateFormat;  
import java.util.ArrayList;
import java.util.Date;
import model.*;

public class MovieRestrictionDA {
    private String host = "jdbc:derby://localhost:1527/cinemadb";
    private String user = "nbuser";
    private String password = "nbuser";
    private String tableName = "MovieRestriction";
    private Connection conn;
    private PreparedStatement stmt;

    
    public MovieRestrictionDA(){
        createConnection();
    }

    //catch exception at caller
   public ArrayList<MovieRestriction> getMovieRestrictionRecord() throws SQLException{
       
       String queryStr = "SELECT * FROM " + tableName;
       
       ArrayList<MovieRestriction> movieRestrictionList = new ArrayList<MovieRestriction>();
        
        stmt = conn.prepareStatement(queryStr);
        ResultSet rs = stmt.executeQuery();

        while(rs.next()){
            movieRestrictionList.add(new MovieRestriction(rs.getString("movieRestrictID"), rs.getString("restrictionDesc"), rs.getString("restrictionImage")));
        } 
        return movieRestrictionList;
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
        new MovieRestrictionDA();
    }
}


