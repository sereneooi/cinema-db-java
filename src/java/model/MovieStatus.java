package model;

import java.io.Serializable;
import java.util.Objects;

public class MovieStatus implements Serializable{
     //data members
     private String movieStatusID;
     private String movieStatusDesc;
        
     //constructor
     public MovieStatus() {
     }

    public MovieStatus(String movieStatusID) {
        this.movieStatusID = movieStatusID;
    }

    public MovieStatus(String movieStatusID, String movieStatusDesc) {
        this.movieStatusID = movieStatusID;
        this.movieStatusDesc = movieStatusDesc;
    }

    //getter
    public String getMovieStatusID() {
        return movieStatusID;
    }
   
    public String getMovieStatusDesc() {    
        return movieStatusDesc;
    }

    //setter
    public void setMovieStatusID(String movieStatusID) {
        this.movieStatusID = movieStatusID;
    }

    public void setMovieStatusDesc(String movieStatusDesc) {
        this.movieStatusDesc = movieStatusDesc;
    }

    public String toString() {
        return String.format("%s", movieStatusDesc);
    }
}

