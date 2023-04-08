package model;

import java.io.Serializable;

public class Theatre implements Serializable{
    
    private String theatreID;
    private String theatreDesc;
    private int totalSeatCount;
    private TheatreClasses theatreClasses;
    
    //Construcotr
    public Theatre() {
        
    }

    public Theatre(String theatreID) {
        this.theatreID = theatreID;
    }
    
    public Theatre(String theatreID, String theatreDesc, int totalSeatCount, TheatreClasses theatreClasses) {
        this.theatreID = theatreID;
        this.theatreDesc = theatreDesc;
        this.totalSeatCount = totalSeatCount;
        this.theatreClasses = theatreClasses;
        
    }
    
    //Getter
    public String getTheatreID() {
        return theatreID;
    }

    public String getTheatreDesc() {
        return theatreDesc;
    }

    public int getTotalSeatCount() {
        return totalSeatCount;
    }

    public TheatreClasses getTheatreClasses() {
        return theatreClasses;
    }
    
    //Setter
    public void setTheatreID(String theatreID) {
        this.theatreID = theatreID;
    }

    public void setTheatreDesc(String theatreDesc) {
        this.theatreDesc = theatreDesc;
    }

    public void setTotalSeatCount(int totalSeatCount) {
        this.totalSeatCount = totalSeatCount;
    }

    public void setTheatreClasses(TheatreClasses theatreClasses) {
        this.theatreClasses = theatreClasses;
    }

    @Override
    public String toString() {
        return "Theatre{" + "theatreID=" + theatreID + ", theatreDesc=" + theatreDesc + ", totalSeatCount=" + totalSeatCount + '}';
    }
}
