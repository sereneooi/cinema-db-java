package model;

import java.io.Serializable;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Calendar;
import java.util.Date;
import java.util.Objects;
import java.text.DateFormat;


public class Movie implements Serializable{
     //data members
     private String movieID;
     private String movieName;
     private String movieTrailer;
     private String moviePoster;
     private String movieAdsPoster;
     private String synopsis;
     private int availableDay;
     private int availableMonth;
     private int availableYear;
     private int durationHour;
     private int durationMinutes;
     private String duration;
     private String durationWeb;
     private Date availableDate;
     private LocalDate availableDateWeb;
     private MovieStatus movieStatus;
     private MovieType movieType;
     private MovieRestriction movieRestrict;
     private Language language;
     private static int noOfMovie;
        
     //constructor
     public Movie() {
     }

    public Movie(String movieID) {
        this.movieID = movieID;
    }
    
    public Movie(String movieID, String movieName, MovieStatus movieStatus) {
        this.movieID = movieID;
        this.movieName = movieName;
        this.movieStatus = movieStatus;
    }

    public Movie(String movieID, String movieName, String moviePoster) {
        this.movieID = movieID;
        this.movieName = movieName;
        this.moviePoster = moviePoster;
    }
    

    public Movie(String movieID, String movieName, String moviePoster, String duration) {
        this.movieID = movieID;
        this.movieName = movieName;
        this.moviePoster = moviePoster;
        this.duration = duration;
    }

    public Movie(String movieID, String movieName, String moviePoster, String movieAdsPoster, String duration, String synopsis) {
        this.movieID = movieID;
        this.movieName = movieName;
        this.moviePoster = moviePoster;
        this.movieAdsPoster = movieAdsPoster;
        this.duration = duration;
        this.synopsis = synopsis;
    }
    
    public Movie(String movieID, String movieName, String movieTrailer, String moviePoster, String movieAdsPoster, String synopsis, String duration, Date availableDate, MovieStatus movieStatus, MovieType movieType, MovieRestriction movieRestrict, Language language) {
        this.movieID = movieID;
        this.movieName = movieName;
        this.movieTrailer = movieTrailer;
        this.moviePoster = moviePoster;
        this.movieAdsPoster = movieAdsPoster;
        this.synopsis = synopsis;
        this.duration = duration;
        this.availableDate = availableDate;
        this.movieStatus = movieStatus;
        this.movieType = movieType;
        this.movieRestrict = movieRestrict;
        this.language = language;
        
        noOfMovie++;
    }
 
    public Movie(String movieID, String movieName, String movieTrailer, String moviePoster, String movieAdsPoster, String synopsis, int durationHour, int durationMinutes, String availableDateStr, MovieStatus movieStatus, MovieType movieType, MovieRestriction movieRestrict, Language language) {
        this.movieID = movieID;
        this.movieName = movieName;
        this.movieTrailer = movieTrailer;
        this.moviePoster = moviePoster;
        this.movieAdsPoster = movieAdsPoster;
        this.synopsis = synopsis;
        this.durationWeb = String.valueOf(durationHour) +  " Hour " + String.valueOf(durationMinutes) + " Minutes";
        this.availableDate =  java.sql.Date.valueOf(availableDateStr);
        this.movieStatus = movieStatus;
        this.movieType = movieType;
        this.movieRestrict = movieRestrict;
        this.language = language;
        
        noOfMovie++;
    }

    //getter
    public String getMovieID() {
        return movieID;
    }

    public String getMovieName() {
        return movieName;
    }

    public String getMovieTrailer() {
        return movieTrailer;
    }

    public String getMoviePoster() {
        return moviePoster;
    }

    public String getMovieAdsPoster() {
        return movieAdsPoster;
    }

    public String getSynopsis() {
        return synopsis;
    }

    public int getAvailableDay() {
        return availableDay;
    }

    public int getAvailableMonth() {
        return availableMonth;
    }

    public int getAvailableYear() {
        return availableYear;
    }

    public String getDuration() {
        return duration;
    }

    public String getDurationWeb() {
        return durationWeb;
    }

    public Date getAvailableDate() {
        return availableDate;
    }

    public MovieStatus getMovieStatus() {
        return movieStatus;
    }

    public MovieType getMovieType() {
        return movieType;
    }

    public MovieRestriction getMovieRestrict() {
        return movieRestrict;
    }

    public Language getLanguage() {
        return language;
    }

    public static int getNoOfMovie() {
        return noOfMovie;
    }
    
    //setter
    public void setMovieID(String movieID) {
        this.movieID = movieID;
    }

    public void setMovieName(String movieName) {
        this.movieName = movieName;
    }

    public void setMovieTrailer(String movieTrailer) {
        this.movieTrailer = movieTrailer;
    }

    public void setMoviePoster(String moviePoster) {
        this.moviePoster = moviePoster;
    }

    public void setMovieAdsPoster(String movieAdsPoster) {
        this.movieAdsPoster = movieAdsPoster;
    }

    public void setSynopsis(String synopsis) {
        this.synopsis = synopsis;
    }

    public void setDuration(String duration) {
        this.duration = duration;
    }

    public void setDurationWeb(int durationHour, int durationMinutes) {
        this.durationWeb = String.valueOf(durationHour) +  " Hour " + String.valueOf(durationMinutes) + " Minutes";
    }
   
    public void setAvailableDate(Date availableDate) {
        this.availableDate = availableDate;
    }

    public void setAvailableDateWeb(int availableDay, int availableMonth, int availableYear) {
        this.availableDateWeb = LocalDate.of(availableYear, availableMonth, availableDay);
    }

    public void setMovieStatus(MovieStatus movieStatus) {
        this.movieStatus = movieStatus;
    }

    public void setMovieType(MovieType movieType) {
        this.movieType = movieType;
    }

    public void setMovieRestrict(MovieRestriction movieRestrict) {
        this.movieRestrict = movieRestrict;
    }

    public void setLanguage(Language language) {
        this.language = language;
    }
    
    //set format of date
    public String dateFormatter(Date date){
        //set the format of date to dd MMMM yyyy
        SimpleDateFormat DateFor = new SimpleDateFormat("dd MMMM yyyy");
        String stringDate = DateFor.format(date);
      
        return stringDate;
    }
    
    //set format of date
    public String dateFormatter(String date) throws ParseException{
        Date dateOld=new SimpleDateFormat("yyyy-MM-dd").parse(date); 
        
        //set the format of date to dd MMMM yyyy
        SimpleDateFormat DateFor = new SimpleDateFormat("dd MMMM yyyy");
        String stringDate = DateFor.format(dateOld);
      
        return stringDate;
    }
    
    //get day of a week
    public String getDayOfWeek(String date) throws ParseException{
        Date dateRetrieved=new SimpleDateFormat("yyyy-MM-dd").parse(date);
        
        // the day of the week abbreviated
        SimpleDateFormat simpleDateformat = new SimpleDateFormat("E"); 
        String dayOfWeek = simpleDateformat.format(dateRetrieved);
        
        return dayOfWeek;
    }
    
     //date auto increment by 1
    public String dateIncrement(String dateToBeIncreased){

            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Calendar c = Calendar.getInstance();
            
            try{
                 c.setTime(sdf.parse(dateToBeIncreased));
            }catch(ParseException e){
                 e.printStackTrace();
             }
            
            //Incrementing the date by 1 day
            c.add(Calendar.DAY_OF_MONTH, 1);  
            String nextDate = sdf.format(c.getTime());  
            
            return nextDate;
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
    
    //set movie Trailer to autoplay & autoMute
    public String autoPlayVideo(String movieTrailer){
       String movieAutoPlayTrailer = movieTrailer + "?autoplay=1&mute=1";
      
        return movieAutoPlayTrailer ;
    } 
    
    //auto increment next movieID;
    public String nextMovieID() throws SQLException{

        MovieDA movieDA = new MovieDA();
        String movieID = movieDA.selectLastMovieID();

        //extract out the string and integer into diff variable
        String codeID = movieID.substring(0, 2);
        String numID = movieID.substring(2);
        
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
            	if(count == 2){
                       movieIntID = "0" + increasedStrID;   
            	}
            }         
        }
         return codeID + movieIntID;
    }
    
    public String toString() {
        return String.format("%s, %s, %s, %s, %s", movieName, synopsis, movieStatus, movieType, language);
    }
    
}

