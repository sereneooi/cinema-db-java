package model;

import java.io.Serializable;
import java.sql.SQLException;
import java.sql.Time;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.Objects;
import java.util.logging.Level;
import java.util.logging.Logger;

public class MovieSchedule implements Serializable{
     //data members
     private String movieScheduleID;
     private String showDate;
     private String showTime;
     //private Time showTimeSql;
     private String strShowDateTime;
     private LocalDateTime showDateTime;
     private Movie movie;
     private Theatre theatre;
     
        
     //constructor
     public MovieSchedule() {
     }

    public MovieSchedule(String movieScheduleID) {
        this.movieScheduleID = movieScheduleID;
    }

    public MovieSchedule(String movieScheduleID, String showTime) {
        this.movieScheduleID = movieScheduleID;
        this.showTime= showTime;
    }
    
     public MovieSchedule(String movieScheduleID, String showDate, String showTime){
        this.movieScheduleID = movieScheduleID;
         try {
                this.showDate = dateFormatter(showDate);
                this.showTime = timeFormatter(showTime);
         } catch (ParseException ex) {
                Logger.getLogger(MovieSchedule.class.getName()).log(Level.SEVERE, null, ex);
         }
       
        this.strShowDateTime = this.showDate + "  -  " + this.showTime;
    }
     
     public MovieSchedule(String movieScheduleID, String showDate, String showTime, String strShowDateTime, Movie movie) {
        this.movieScheduleID = movieScheduleID;
        this.showDate = showDate;
        this.showTime = showTime;
        this.strShowDateTime = strShowDateTime;
        this.movie = movie;
    }

    public MovieSchedule(String movieScheduleID, String showDate, String showTime, Movie movie, Theatre theatre) {
        this.movieScheduleID = movieScheduleID;
        this.showDate = showDate;
        this.showTime = showTime;
        this.strShowDateTime = showDate + " " + showTime;
        this.showDateTime = LocalDateTime.parse(strShowDateTime, DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
        this.movie = movie;
        this.theatre = theatre;
    }
    
    public MovieSchedule(String movieScheduleID, String strShowDateTime, Movie movie, Theatre theatre) {
        this.movieScheduleID = movieScheduleID;
        this.showDateTime = LocalDateTime.parse(strShowDateTime, DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss a"));
        this.movie = movie;
        this.theatre = theatre;
    }
    
    //getter
    public String getMovieScheduleID() {
        return movieScheduleID;
    }

    public String getShowDate() {
        return showDate;
    }

    public String getShowTime() {
        return showTime;
    }

    public String getStrShowDateTime() {
        return strShowDateTime;
    }

    public LocalDateTime getShowDateTime() {
        return showDateTime;
    }

    public Movie getMovie() {
        return movie;
    }

    public Theatre getTheatre() {    
        return theatre;
    }

    //setter
    public void setMovieScheduleID(String movieScheduleID) {
        this.movieScheduleID = movieScheduleID;
    }

    public void setShowDate(String showDate) {
        this.showDate = showDate;
    }

    public void setShowTime(String showTime) {
        this.showTime = showTime;
    }

    public void setStrShowDateTime(String strShowDateTime) {
        this.strShowDateTime = strShowDateTime;
    }

    public void setShowDateTime(LocalDateTime showDateTime) {
        this.showDateTime = showDateTime;
    }

    public void setMovie(Movie movie) {
        this.movie = movie;
    }

    public void setTheatre(Theatre theatre) {
        this.theatre = theatre;
    }
    
    //auto increment next movieScheduleID;
    public String nextMovieScheduleID() throws SQLException{

        MovieScheduleDA movieScheduleDA = new MovieScheduleDA();
        String movieScheduleID = movieScheduleDA.selectLastMovieScheduleID();

        //extract out the string and integer into diff variable
        String codeID = movieScheduleID.substring(0, 1);
        String numID = movieScheduleID.substring(1);
        
        int numOfIntID = Integer.parseInt(numID);
        int increasedIntID = numOfIntID + 1;
        String increasedStrID = String.valueOf(increasedIntID);
        
        String movieIntID = null;
        int count = 0;    
            
        //Counts each character except space    
        for(int i = 0; i < increasedStrID.length(); i++) {    
            if(increasedStrID.charAt(i) != ' '){
            	count++;
            	//add one "0" --> if ID in integer only have 2 digit
            	if(count <= 2){
                       movieIntID = "00" + increasedStrID;   
            	}else{
                    movieIntID = "0" + increasedStrID;
                }
            }         
        }
         return codeID + movieIntID;
    }
    
    //set format of date
    public String dateFormatter(String date) throws ParseException{
        Date dateOld=new SimpleDateFormat("yyyy-MM-dd").parse(date); 
        
        //set the format of date to dd MMMM yyyy
        SimpleDateFormat DateFor = new SimpleDateFormat("dd MMMM yyyy");
        String stringDate = DateFor.format(dateOld);
      
        return stringDate;
    }
    
    //displaying given time in 24 hour format with AM/PM
    public String timeFormatter(String showTime) throws ParseException{

        //old format
        SimpleDateFormat sdfOld = new SimpleDateFormat("HH:mm:00");
    
    	
         Date showtimeDateType = sdfOld.parse(showTime);
    	
         //new format
         SimpleDateFormat sdfNew = new SimpleDateFormat("hh:mm aa");
         //formatting the given time to new format with AM/PM
         String formattedShowtime = sdfNew.format(showtimeDateType);

        return formattedShowtime;
    }
}

