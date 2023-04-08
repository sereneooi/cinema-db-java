package model;

import java.sql.*;
import java.text.ParseException;
import javax.swing.*;
import java.text.SimpleDateFormat;  
import java.util.ArrayList;
import java.util.Date;
import model.*;

public class MovieTypeDA {
    private String host = "jdbc:derby://localhost:1527/cinemadb";
    private String user = "nbuser";
    private String password = "nbuser";
    private String tableName = "MovieType";
    private Connection conn;
    private PreparedStatement stmt;

    
    public MovieTypeDA(){
        createConnection();
    }

   public ArrayList<MovieType> getMovieTypeRecord() throws SQLException{
       
       String queryStr = "SELECT * FROM " + tableName;
       
       ArrayList<MovieType> movieTypeList = new ArrayList<MovieType>();
        
        stmt = conn.prepareStatement(queryStr);
        ResultSet rs = stmt.executeQuery();

        while(rs.next()){
            movieTypeList.add(new MovieType(rs.getString("movieTypeID"), rs.getString("movieTypeDesc")));
        } 
        return movieTypeList;
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
        new MovieTypeDA();
    }
}
