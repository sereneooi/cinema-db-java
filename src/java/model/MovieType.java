package model;

import java.io.Serializable;
import java.util.Objects;

public class MovieType implements Serializable{
     //data members
     private String movieTypeID;
     private String movieTypeDesc;
        
     //constructor
     public MovieType() {
     }

    public MovieType(String movieTypeID) {
        this.movieTypeID = movieTypeID;
    }

    public MovieType(String movieTypeID, String movieTypeDesc) {
        this.movieTypeID = movieTypeID;
        this.movieTypeDesc = movieTypeDesc;
    }
    
    //getter
    public String getMovieTypeID() {
        return movieTypeID;
    }

    public String getMovieTypeDesc() {
        return movieTypeDesc;
    }

    //setter
    public void setMovieTypeID(String movieTypeID) {
        this.movieTypeID = movieTypeID;
    }
     
    public void setMovieTypeDesc(String movieTypeDesc) {    
        this.movieTypeDesc = movieTypeDesc;
    }

    public String toString() {
        return String.format("%s", movieTypeDesc);
    }
}
