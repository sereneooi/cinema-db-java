package model;

import java.io.Serializable;
import java.sql.SQLException;
import java.util.Objects;

public class Actor implements Serializable{
     //data members
     private String actorID;
     private String actorName;
        
     //constructor
     public Actor() {
     }

    public Actor(String actorID) {
        this.actorID = actorID;
    }

    public Actor(String actorID, String actorName) {
        this.actorID = actorID;
        this.actorName = actorName;
    }

    //getter
    public String getActorID() {
        return actorID;
    }

    public String getActorName() {
        return actorName;
    }
    
    //setter
    public void setActorID(String actorID) {
        this.actorID = actorID;
    }

    public void setActorName(String actorName) {
        this.actorName = actorName;
    }
    
    public String toString() {
        return String.format("%s", actorName);
    }
    
    //auto increment next movieScheduleID;
    public String nextActorID() throws SQLException{

        ActorDA actorDA = new ActorDA();
        String actorID = actorDA.selectLastActorID();

        //extract out the string and integer into diff variable
        String codeID = actorID.substring(0, 1);
        String numID = actorID.substring(1);
        
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
}

