package model;

import java.io.Serializable;

public class TheatreClasses implements Serializable{
    
    private String theatreClassesID;
    private String theatreClassesDesc;
    
    //Constructor
    public TheatreClasses() {
        
    }

    public TheatreClasses(String theatreClassesID) {
        this.theatreClassesID = theatreClassesID;
    }

    public TheatreClasses(String theatreClassesID, String theatreClassesDesc) {
        this.theatreClassesID = theatreClassesID;
        this.theatreClassesDesc = theatreClassesDesc;
    }
    
    //Getter and Stter
    public String getTheatreClassesID() {
        return theatreClassesID;
    }

    public void setTheatreClassesID(String theatreClassesID) {
        this.theatreClassesID = theatreClassesID;
    }

    public String getTheatreClassesDesc() {
        return theatreClassesDesc;
    }

    public void setTheatreClassesDesc(String theatreClassesDesc) {
        this.theatreClassesDesc = theatreClassesDesc;
    }

    @Override
    public String toString() {
        return "TheatreClasses{" + "theatreClassesID=" + theatreClassesID + ", theatreClassesDesc=" + theatreClassesDesc + '}';
    }
}
