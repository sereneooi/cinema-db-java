package model;

import java.sql.*;
import java.text.ParseException;
import javax.swing.*;
import java.text.SimpleDateFormat;  
import java.util.ArrayList;
import java.util.Date;
import model.*;


public class MovieScheduleDA {
    private String host = "jdbc:derby://localhost:1527/cinemadb";
    private String user = "nbuser";
    private String password = "nbuser";
    private String tableName = "MovieSchedule";
    private Connection conn;
    private PreparedStatement stmt;

    
    public MovieScheduleDA(){
        createConnection();
    }

   public ArrayList<Movie> getShowtimeRecord(String showDate) throws SQLException{
       
       String queryStr = "SELECT DISTINCT Movie.movieID, Movie.movieName, Movie.moviePoster, Movie.duration FROM " + tableName + " JOIN Movie ON MovieSchedule.movieID = Movie.movieID " +
               "WHERE MovieSchedule.showDate = ?";
            
       ArrayList<Movie> movieShowList = new ArrayList<Movie>();
        
        stmt = conn.prepareStatement(queryStr);
        stmt.setString(1, showDate);
       
        ResultSet rs = stmt.executeQuery();
        
        while(rs.next()){
            
            movieShowList.add(new Movie(rs.getString("movieID"), rs.getString("movieName"), rs.getString("moviePoster"), rs.getString("duration")));
           
        } 
        return movieShowList;
    }
   
   public ArrayList<Movie> getScheduleBetweenTwoDate(String showDateStart, String showDateEnd) throws SQLException{
       
       String queryStr = "SELECT DISTINCT Movie.movieID, Movie.movieName, Movie.moviePoster, Movie.movieAdsPoster, Movie.duration, Movie.synopsis FROM " + tableName + " JOIN Movie ON MovieSchedule.movieID = Movie.movieID " +
               "WHERE MovieSchedule.showDate BETWEEN ? AND ?";
            
       ArrayList<Movie> movieShowList = new ArrayList<Movie>();
        
        stmt = conn.prepareStatement(queryStr);
        stmt.setString(1, showDateStart);
        stmt.setString(2, showDateEnd);
       
        ResultSet rs = stmt.executeQuery();
        
        while(rs.next()){
            movieShowList.add(new Movie(rs.getString("movieID"), rs.getString("movieName"), rs.getString("moviePoster"), rs.getString("movieAdsPoster"), rs.getString("duration"), rs.getString("synopsis")));
        } 
        return movieShowList;
    }
   
   public ArrayList<MovieSchedule> getShowtimeForSpecificDate(String movieID, String showDate) throws SQLException{
       
       String queryStr = "SELECT DISTINCT MovieSchedule.movieScheduleID, MovieSchedule.showTime, MovieSchedule.showDateTime FROM " + tableName + " JOIN Movie ON MovieSchedule.movieID = Movie.movieID " +
               "WHERE Movie.movieID = ? AND MovieSchedule.showDate = ? ORDER BY MovieSchedule.showDateTime";
       
       ArrayList<MovieSchedule> showTimeList = new ArrayList<MovieSchedule>();
        
        stmt = conn.prepareStatement(queryStr);
        stmt.setString(1, movieID);
        stmt.setString(2, showDate);
       
        ResultSet rs = stmt.executeQuery();
        
        while(rs.next()){
            showTimeList.add(new MovieSchedule(rs.getString("movieScheduleID"), (rs.getTime("showTime").toString()) ));
        } 
        return showTimeList;
    }
   
   public ArrayList<MovieSchedule> displayShowtimeRecord(String movieID) throws SQLException{
       
       String queryStr = "SELECT MovieSchedule.movieScheduleID, MovieSchedule.showDate, MovieSchedule.showTime FROM " + tableName + " JOIN Movie ON MovieSchedule.movieID = Movie.movieID " + 
                                   "WHERE Movie.movieID = ? ORDER BY MovieSchedule.showDateTime"; 
    
       ArrayList<MovieSchedule> scheduleList = new ArrayList<MovieSchedule>();
        
        stmt = conn.prepareStatement(queryStr);
        stmt.setString(1, movieID);
       
        ResultSet rs = stmt.executeQuery();
        
        while(rs.next()){
            scheduleList.add(new MovieSchedule(rs.getString("movieScheduleID"), (rs.getDate("showDate").toString()), (rs.getTime("showTime").toString())));
        } 
        return scheduleList;
    }
   
   public String selectLastMovieScheduleID() throws SQLException{
       String queryStr = "SELECT MAX(movieScheduleID) FROM "+ tableName;
       
        stmt = conn.prepareStatement(queryStr);
        ResultSet rs = stmt.executeQuery();
        
        String nextMovieScheduleID = null;
        
        if(rs.next()){
            nextMovieScheduleID = rs.getString(1);
        }
        
        return nextMovieScheduleID;
   }
   
   public ArrayList<Movie> displayMostPopularMovie(int currentMonth) throws SQLException{
       String queryStr = "SELECT movieID FROM "+ tableName + " WHERE MONTH(showDate) = ? GROUP BY movieID ORDER BY COUNT(movieID) DESC FETCH FIRST 6 ROWS ONLY";
       
       ArrayList<Movie> popularMovie = new ArrayList<Movie>();
       
        stmt = conn.prepareStatement(queryStr);
        stmt.setInt(1, currentMonth);
        
        ResultSet rs = stmt.executeQuery();

        while(rs.next()){
            popularMovie.add(new Movie(rs.getString("movieID")));
        }
        
        return popularMovie;
   }
   
   public String displayTrendingTrailer(String dateTdy, String dateNxtWeek) throws SQLException{
       String queryStr = "SELECT movieID FROM "+ tableName + " WHERE showDate BETWEEN ? AND ? GROUP BY movieID ORDER BY COUNT(movieID) DESC FETCH FIRST 1 ROWS ONLY";
       
        stmt = conn.prepareStatement(queryStr);
        stmt.setString(1, dateTdy);
        stmt.setString(2, dateNxtWeek);
        ResultSet rs = stmt.executeQuery();
        
        String trendingMovieID = null;
        
        if(rs.next()){
            trendingMovieID = rs.getString(1);
        }
        
        return trendingMovieID;
   }
   
   public void addMovieSchedule(MovieSchedule movieSchedule) throws SQLException {
          String insertStr = "INSERT INTO " + tableName + " VALUES(?, ?, ?, ?, ?, ?)";
        
            stmt = conn.prepareStatement(insertStr);
            stmt.setString(1, movieSchedule.getMovieScheduleID());
            stmt.setString(2, movieSchedule.getShowDate());
            stmt.setString(3, movieSchedule.getShowTime());
            stmt.setString(4, movieSchedule.getStrShowDateTime());
            stmt.setString(5, movieSchedule.getMovie().getMovieID());
            stmt.setString(6, movieSchedule.getTheatre().getTheatreID());
            stmt.executeUpdate();
    }
   
   public void updateMovieSchedule(MovieSchedule movieSchedule) throws SQLException{
     
            String updateStr = "UPDATE " + tableName + " SET MovieSchedule.showDate = ?, MovieSchedule.showTime = ?, MovieSchedule.showDateTime = ? " + 
                    "WHERE movieScheduleID = ?";

            stmt = conn.prepareStatement(updateStr);
            stmt.setString(1, movieSchedule.getShowDate());
            stmt.setString(2, movieSchedule.getShowTime());
            stmt.setString(3, movieSchedule.getStrShowDateTime());
            stmt.setString(4, movieSchedule.getMovieScheduleID());
  
            stmt.executeUpdate();
    }
   
   public void deleteMovieSchedule(MovieSchedule movieSchedule) throws SQLException{
    
          String deleteStr = "DELETE FROM " + tableName + " WHERE MovieSchedule.movieScheduleID = ?";
          
          stmt = conn.prepareStatement(deleteStr);
          stmt.setString(1, movieSchedule.getMovieScheduleID());
          stmt.executeUpdate();

    }
   
   public void deleteMovieSchedule(String movieID) throws SQLException{
    
          String deleteStr = "DELETE FROM " + tableName + " WHERE MovieSchedule.movieID = ?";
       
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
        new MovieScheduleDA();
    }
}



