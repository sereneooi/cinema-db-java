package model;

import java.sql.*;
import java.text.ParseException;
import javax.swing.*;
import java.text.SimpleDateFormat;  
import java.util.ArrayList;
import java.util.Date;
import model.*;

public class MovieDA {
    private String host = "jdbc:derby://localhost:1527/cinemadb";
    private String user = "nbuser";
    private String password = "nbuser";
    private String tableName = "Movie";
    private Connection conn;
    private PreparedStatement stmt;

    
    public MovieDA(){
        createConnection();
    }

   public Movie getMovieRecord(String movieID) throws SQLException{
       
       String queryStr = "SELECT * FROM " + tableName + " JOIN MovieStatus ON Movie.movieStatusID = MovieStatus.movieStatusID " +
               "JOIN MovieType ON Movie.movieTypeID = MovieType.movieTypeID " + "JOIN MovieRestriction ON Movie.movieRestrictID = MovieRestriction.movieRestrictID " + "JOIN Language ON Movie.languageID = Language.languageID " + 
               "WHERE Movie.movieID = ?";
       
       Movie movieInfo = null;
        
        stmt = conn.prepareStatement(queryStr);
        stmt.setString(1, movieID);
       
        ResultSet rs = stmt.executeQuery();

        while(rs.next()){
            movieInfo = new Movie(rs.getString("movieID"), rs.getString("movieName"), rs.getString("movieTrailer"), rs.getString("moviePoster"), rs.getString("movieAdsPoster"),
                         rs.getString("synopsis"), rs.getString("duration"), rs.getDate("availableDate"), 
                         new MovieStatus(rs.getString("movieStatusID"), rs.getString("movieStatusDesc")),
                         new MovieType(rs.getString("movieTypeID"), rs.getString("movieTypeDesc")),
                         new MovieRestriction(rs.getString("movieRestrictID"), rs.getString("restrictionDesc"), rs.getString("restrictionImage")),
                         new Language(rs.getString("languageID"), rs.getString("languageDesc")));

        } 
        return movieInfo;
    }
   
   public Movie getMovieListingRecord(String movieID) throws SQLException{
       
       String queryStr = "SELECT * FROM " + tableName + " JOIN MovieStatus ON Movie.movieStatusID = MovieStatus.movieStatusID " +
               "JOIN MovieType ON Movie.movieTypeID = MovieType.movieTypeID " + "JOIN MovieRestriction ON Movie.movieRestrictID = MovieRestriction.movieRestrictID " + "JOIN Language ON Movie.languageID = Language.languageID " + 
               "WHERE Movie.movieID = ?";
       
       Movie movie = new Movie();
        
        stmt = conn.prepareStatement(queryStr);
        stmt.setString(1, movieID);
       
        ResultSet rs = stmt.executeQuery();

        while(rs.next()){
            movie = new Movie(rs.getString("movieID"), rs.getString("movieName"), rs.getString("movieTrailer"), rs.getString("moviePoster"), rs.getString("movieAdsPoster"),
                         rs.getString("synopsis"), rs.getString("duration"), rs.getDate("availableDate"), 
                         new MovieStatus(rs.getString("movieStatusID"), rs.getString("movieStatusDesc")),
                         new MovieType(rs.getString("movieTypeID"), rs.getString("movieTypeDesc")),
                         new MovieRestriction(rs.getString("movieRestrictID"), rs.getString("restrictionDesc"), rs.getString("restrictionImage")),
                         new Language(rs.getString("languageID"), rs.getString("languageDesc")));

        } 
        return movie;
    }
   
   public ArrayList<Movie> getMovieRecord() throws SQLException{
       
       String queryStr = "SELECT * FROM " + tableName;
       
       ArrayList<Movie> movieList = new ArrayList<Movie>();
        
        stmt = conn.prepareStatement(queryStr);
        ResultSet rs = stmt.executeQuery();

        while(rs.next()){
            movieList.add(new Movie(rs.getString("movieID"), rs.getString("movieName"), rs.getString("movieTrailer"), rs.getString("moviePoster"), rs.getString("movieAdsPoster"),
                         rs.getString("synopsis"), rs.getString("duration"), rs.getDate("availableDate"), 
                         new MovieStatus(rs.getString("movieStatusID"), rs.getString("movieStatusDesc")),
                         new MovieType(rs.getString("movieTypeID"), rs.getString("movieTypeDesc")),
                         new MovieRestriction(rs.getString("movieRestrictID"), rs.getString("restrictionDesc"), rs.getString("restrictionImage")),
                         new Language(rs.getString("languageID"), rs.getString("languageDesc"))));
        } 
        return movieList;
    }
   
   public ArrayList<Movie> searchMovieRecord() throws SQLException{
       
       
       String queryStr = "SELECT Movie.movieID, Movie.movieName, Movie.movieStatusID FROM " + tableName + " JOIN MovieStatus ON Movie.movieStatusID = MovieStatus.movieStatusID";
       
       ArrayList<Movie> movieList = new ArrayList<Movie>();
        
        stmt = conn.prepareStatement(queryStr);
        ResultSet rs = stmt.executeQuery();

        while(rs.next()){
            movieList.add(new Movie(rs.getString("movieID"), rs.getString("movieName"), new MovieStatus(rs.getString("movieStatusID"))));
        } 
        return movieList;
    }
   
   public ArrayList<Movie> displayMovieRecord() throws SQLException{
       
       String queryStr = "SELECT * FROM " + tableName + " JOIN MovieStatus ON Movie.movieStatusID = MovieStatus.movieStatusID " +
               "JOIN MovieType ON Movie.movieTypeID = MovieType.movieTypeID " + "JOIN MovieRestriction ON Movie.movieRestrictID = MovieRestriction.movieRestrictID " + "JOIN Language ON Movie.languageID = Language.languageID " +
               "ORDER BY movieID";
       
       ArrayList<Movie> movieList = new ArrayList<Movie>();
        
        stmt = conn.prepareStatement(queryStr);
       
        ResultSet rs = stmt.executeQuery();

        while(rs.next()){
            movieList.add(new Movie(rs.getString("movieID"), rs.getString("movieName"), rs.getString("movieTrailer"), rs.getString("moviePoster"), rs.getString("movieAdsPoster"),
                         rs.getString("synopsis"), rs.getString("duration"), rs.getDate("availableDate"), 
                         new MovieStatus(rs.getString("movieStatusID"), rs.getString("movieStatusDesc")),
                         new MovieType(rs.getString("movieTypeID"), rs.getString("movieTypeDesc")),
                         new MovieRestriction(rs.getString("movieRestrictID"), rs.getString("restrictionDesc"), rs.getString("restrictionImage")),
                         new Language(rs.getString("languageID"), rs.getString("languageDesc"))));

        } 
        return movieList;
    }

   public ArrayList<Movie> getStatusRecord(String movieStatusID) throws SQLException{
       
       String queryStr = "SELECT * FROM " + tableName + " JOIN MovieStatus ON Movie.movieStatusID = MovieStatus.movieStatusID " +
               "JOIN MovieType ON Movie.movieTypeID = MovieType.movieTypeID " + "JOIN MovieRestriction ON Movie.movieRestrictID = MovieRestriction.movieRestrictID " + "JOIN Language ON Movie.languageID = Language.languageID " + 
               "WHERE Movie.movieStatusID = ?";
       
       ArrayList<Movie> movieList = new ArrayList<Movie>();
        
        stmt = conn.prepareStatement(queryStr);
        stmt.setString(1, movieStatusID);
       
        ResultSet rs = stmt.executeQuery();

        while(rs.next()){
            movieList.add(new Movie(rs.getString("movieID"), rs.getString("movieName"), rs.getString("movieTrailer"), rs.getString("moviePoster"), rs.getString("movieAdsPoster"),
                         rs.getString("synopsis"), rs.getString("duration"), rs.getDate("availableDate"), 
                         new MovieStatus(rs.getString("movieStatusID"), rs.getString("movieStatusDesc")),
                         new MovieType(rs.getString("movieTypeID"), rs.getString("movieTypeDesc")),
                         new MovieRestriction(rs.getString("movieRestrictID"), rs.getString("restrictionDesc"), rs.getString("restrictionImage")),
                         new Language(rs.getString("languageID"), rs.getString("languageDesc"))));

        }  
        return movieList;
    }
   
   public ArrayList<Movie> displayStatusRecord(String movieStatusID) throws SQLException{
       
       String queryStr = "SELECT * FROM " + tableName + " JOIN MovieStatus ON Movie.movieStatusID = MovieStatus.movieStatusID " +
               "JOIN MovieType ON Movie.movieTypeID = MovieType.movieTypeID " + "JOIN MovieRestriction ON Movie.movieRestrictID = MovieRestriction.movieRestrictID " + "JOIN Language ON Movie.languageID = Language.languageID " + 
               "JOIN MovieSchedule ON Movie.movieID = MovieSchedule.movieID " + "WHERE Movie.movieStatusID = ?";
       
       ArrayList<Movie> movieList = new ArrayList<Movie>();
        
        stmt = conn.prepareStatement(queryStr);
        stmt.setString(1, movieStatusID);
       
        ResultSet rs = stmt.executeQuery();

        while(rs.next()){
            movieList.add(new Movie(rs.getString("movieID"), rs.getString("movieName"), rs.getString("movieTrailer"), rs.getString("moviePoster"), rs.getString("movieAdsPoster"),
                         rs.getString("synopsis"), rs.getString("duration"), rs.getDate("availableDate"), 
                         new MovieStatus(rs.getString("movieStatusID"), rs.getString("movieStatusDesc")),
                         new MovieType(rs.getString("movieTypeID"), rs.getString("movieTypeDesc")),
                         new MovieRestriction(rs.getString("movieRestrictID"), rs.getString("restrictionDesc"), rs.getString("restrictionImage")),
                         new Language(rs.getString("languageID"), rs.getString("languageDesc"))));

        }  
        return movieList;
    }
   
   public ArrayList<Movie> displayNxtMonthComingSoonList (int nextMonth) throws SQLException{
       
       String queryStr = "SELECT movieID FROM " + tableName + " WHERE movieStatusID = ? AND MONTH(availableDate) = ? " + 
               "ORDER BY movieID FETCH FIRST 5 ROWS ONLY";
       
       ArrayList<Movie> comingSoonList = new ArrayList<Movie>();
        
        stmt = conn.prepareStatement(queryStr);
        //MS002 will always be ID for coming soon movies
        stmt.setString(1, "MS002");
        stmt.setInt(2, nextMonth);
        ResultSet rs = stmt.executeQuery();

        while(rs.next()){
            comingSoonList.add(new Movie(rs.getString("movieID")));

        }  
        return comingSoonList;
    }
   
   
   public String selectLastMovieID() throws SQLException{
       String queryStr = "SELECT MAX(movieID) FROM "+ tableName;
       
        stmt = conn.prepareStatement(queryStr);
        ResultSet rs = stmt.executeQuery();
        
        String nextMovieID = null;
        
        if(rs.next()){
            nextMovieID = rs.getString(1);
        }
        
        return nextMovieID;
   }
   
 
   public void addMovieRecord(Movie movie) throws SQLException {
          String insertStr = "INSERT INTO " + tableName + " VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        //to convert java.uti.Date to java.sql.Date
        java.sql.Date sqlDate = convert(movie.getAvailableDate());

            stmt = conn.prepareStatement(insertStr);
            stmt.setString(1, movie.getMovieID());
            stmt.setString(2, movie.getMovieName());
            stmt.setString(3, movie.getMovieTrailer());
            stmt.setString(4, movie.getMoviePoster());
            stmt.setString(5, movie.getMovieAdsPoster());
            stmt.setString(6, movie.getSynopsis());
            stmt.setString(7, movie.getDurationWeb());
            stmt.setDate(8, sqlDate);
            stmt.setString(9, movie.getMovieStatus().getMovieStatusID());
            stmt.setString(10, movie.getMovieType().getMovieTypeID());
            stmt.setString(11, movie.getMovieRestrict().getMovieRestrictID());
            stmt.setString(12, movie.getLanguage().getLanguageID());
            stmt.executeUpdate();
    }
   
   public void updateMovieRecord(Movie movie) throws SQLException{
     
            String updateStr = "UPDATE " + tableName + " SET movieName = ?, movieTrailer = ?, moviePoster = ?, movieAdsPoster = ?, synopsis = ?, duration = ?, availableDate = ?, " + 
                    "movieStatusID = ?, movieTypeID = ?, movieRestrictID = ?, languageID = ? " + "WHERE movieID = ?";
 
            //to convert java.uti.Date to java.sql.Date
            java.sql.Date sqlDate = convert(movie.getAvailableDate());
            
            stmt = conn.prepareStatement(updateStr);
            stmt.setString(1, movie.getMovieName());
            stmt.setString(2, movie.getMovieTrailer());
            stmt.setString(3, movie.getMoviePoster());
            stmt.setString(4, movie.getMovieAdsPoster());
            stmt.setString(5, movie.getSynopsis());
            stmt.setString(6, movie.getDurationWeb());
            stmt.setDate(7, sqlDate);
            stmt.setString(8, movie.getMovieStatus().getMovieStatusID());
            stmt.setString(9, movie.getMovieType().getMovieTypeID());
            stmt.setString(10, movie.getMovieRestrict().getMovieRestrictID());
            stmt.setString(11, movie.getLanguage().getLanguageID());
            stmt.setString(12, movie.getMovieID());
            stmt.executeUpdate();
    }

   
   public void deleteMovieRecord(Movie movie) throws SQLException{
    
          String deleteStr = "DELETE FROM " + tableName + " WHERE movieID = ?";
          
          stmt = conn.prepareStatement(deleteStr);
          stmt.setString(1, movie.getMovieID());
          stmt.executeUpdate();

    }
   
      //function to convert java.uti.Date to java.sql.Date
    private static java.sql.Date convert(java.util.Date utilDate) {
        java.sql.Date sDate = new java.sql.Date(utilDate.getTime());
        return sDate;
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
        new MovieDA();
    }
}

