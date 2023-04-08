package model;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Objects;

public class CastList implements Serializable{
     //data members
     private String castListID;
     private Actor actor;
     private Movie movie;
        
     //constructor
     public CastList() {
     }
     
     public CastList(String castListID) {
         this.castListID = castListID;
     }

    public CastList(String castListID, Actor actor, Movie movie) {
        this.castListID = castListID;
        this.actor = actor;
        this.movie = movie;
    }
     
    //getter
    public String getCastListID() {
        return castListID;
    }

    public Actor getActor() {
        return actor;
    }

    public Movie getMovie() {
        return movie;
    }
    
    //setter
    public void setCastListID(String castListID) {
        this.castListID = castListID;
    }

    public void setActor(Actor actor) {
        this.actor = actor;
    }

    public void setMovie(Movie movie) {
        this.movie = movie;
    }
    
    public String toString() {
        return String.format("%s, %s, %s", castListID, actor, movie);
    }
}


