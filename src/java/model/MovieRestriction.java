package model;

import java.io.Serializable;
import java.util.Objects;

public class MovieRestriction implements Serializable{
     //data members
     private String movieRestrictID;
     private String restrictionDesc;
     private String restrictionImage;
        
     //constructor
     public MovieRestriction() {
     }

    public MovieRestriction(String movieRestrictID) {
        this.movieRestrictID = movieRestrictID;
    }

    public MovieRestriction(String movieRestrictID, String restrictionDesc, String restrictionImage) {
        this.movieRestrictID = movieRestrictID;
        this.restrictionDesc = restrictionDesc;
        this.restrictionImage = restrictionImage;
    }
     
     //getter
    public String getMovieRestrictID() {
        return movieRestrictID;
    }

    public String getRestrictionDesc() {
        return restrictionDesc;
    }

    public String getRestrictionImage() {
        return restrictionImage;
    }
    
    //setter
    public void setMovieRestrictID(String movieRestrictID) {
        this.movieRestrictID = movieRestrictID;
    }

    public void setRestrictionDesc(String restrictionDesc) {
        this.restrictionDesc = restrictionDesc;
    }

    public void setRestrictionImage(String restrictionImage) {
        this.restrictionImage = restrictionImage;
    }
    
    public String toString() {
        return String.format("%s %s", movieRestrictID, restrictionDesc);
    }
}

