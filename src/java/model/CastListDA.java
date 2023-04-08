package model;

import java.sql.*;
import java.text.ParseException;
import javax.swing.*;
import java.text.SimpleDateFormat;  
import java.util.ArrayList;
import java.util.Date;
import model.*;

public class CastListDA {
    private String host = "jdbc:derby://localhost:1527/cinemadb";
    private String user = "nbuser";
    private String password = "nbuser";
    private String tableName = "CastList";
    private Connection conn;
    private PreparedStatement stmt;

    
    public CastListDA(){
        createConnection();
    }

    //catch exception at caller
   public ArrayList<CastList> getCastListRecord(String movieID) throws SQLException{
       
       String queryStr = "SELECT * FROM " + tableName + " JOIN Movie ON CastList.movieID = Movie.movieID " + 
               "JOIN Actor ON CastList.actorID = Actor.actorID " + "JOIN MovieStatus ON Movie.movieStatusID = MovieStatus.movieStatusID " +
               "JOIN MovieType ON Movie.movieTypeID = MovieType.movieTypeID " + "JOIN MovieRestriction ON Movie.movieRestrictID = MovieRestriction.movieRestrictID " + "JOIN Language ON Movie.languageID = Language.languageID " +
               "WHERE Movie.movieID = ?";
       
       ArrayList<CastList> actorNameList = new ArrayList<CastList>();
        
        stmt = conn.prepareStatement(queryStr);
        stmt.setString(1, movieID);
       
        ResultSet rs = stmt.executeQuery();

        while(rs.next()){
            actorNameList.add(new CastList(rs.getString("castListID"), 
                         new Actor(rs.getString("actorID"), rs.getString("actorName")),
                         new Movie(rs.getString("movieID"), rs.getString("movieName"), rs.getString("movieTrailer"), rs.getString("moviePoster"), rs.getString("movieAdsPoster"), rs.getString("synopsis"), rs.getString("duration"), rs.getDate("availableDate"), 
                         new MovieStatus(rs.getString("movieStatusID"), rs.getString("movieStatusDesc")),
                         new MovieType(rs.getString("movieTypeID"), rs.getString("movieTypeDesc")),
                         new MovieRestriction(rs.getString("movieRestrictID"), rs.getString("restrictionDesc"), rs.getString("restrictionImage")),
                         new Language(rs.getString("languageID"), rs.getString("languageDesc")))));
        } 
        return actorNameList;
    }
   
   public String selectLastCastListID () throws SQLException{
       String queryStr = "SELECT MAX(castListID) FROM "+ tableName;
       
        stmt = conn.prepareStatement(queryStr);
        ResultSet rs = stmt.executeQuery();
        
        String nextCastListID = null;
        
        if(rs.next()){
            nextCastListID = rs.getString(1);
        }
        
        return nextCastListID;
   }
   
   
   public void addCastListRecord(String castListID, Actor actor, String movieID) throws SQLException {
          String insertStr = "INSERT INTO " + tableName + " VALUES(?, ?, ?)";
        

            stmt = conn.prepareStatement(insertStr);
            stmt.setString(1, castListID);
            stmt.setString(2, actor.getActorID());
            stmt.setString(3, movieID);
            
            stmt.executeUpdate();
    }
   
   public void updateCastListRecord(String castListID, Actor actor) throws SQLException{

            String updateStr = "UPDATE " + tableName + " SET actorID = ? WHERE castListID = ?";
            
            stmt = conn.prepareStatement(updateStr);

            stmt.setString(1, actor.getActorID());
            stmt.setString(2, castListID);
            stmt.executeUpdate();
    }
   
   public void deleteCastListRecord(String movieID) throws SQLException{
    
          String deleteStr = "DELETE FROM " + tableName + " WHERE movieID = ?";
          stmt = conn.prepareStatement(deleteStr);
          stmt.setString(1, movieID);
          stmt.executeUpdate();

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
        new CastListDA();
    }
}


