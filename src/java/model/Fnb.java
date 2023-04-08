package model;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;

public class Fnb {
    
    private String fnbID;
    private String fnbImage;
    private String fnbDescription;
    private double fnbPrice;
    private int fnbStockLeft;
    private boolean active;
    private String dateCreated;
    private String dateModified;
    private FnbCategory fnbCategory;

    public Fnb() {
    }

    public Fnb(String fnbID) {
        this.fnbID = fnbID;
    }

    public Fnb(String fnbID, String fnbImage, String fnbDescription, double fnbPrice, int fnbStockLeft, boolean active, FnbCategory fnbCategory) {
        this.fnbID = fnbID;
        this.fnbImage = fnbImage;
        this.fnbDescription = fnbDescription;
        this.fnbPrice = fnbPrice;
        this.fnbStockLeft = fnbStockLeft;
        this.active = active;
        this.fnbCategory = fnbCategory;
    }

    public Fnb(String fnbID, String fnbImage, String fnbDescription, double fnbPrice, int fnbStockLeft, boolean active, String dateCreated, String dateModified, FnbCategory fnbCategory) {
        this.fnbID = fnbID;
        this.fnbImage = fnbImage;
        this.fnbDescription = fnbDescription;
        this.fnbPrice = fnbPrice;
        this.fnbStockLeft = fnbStockLeft;
        this.active = active;
        this.dateCreated = dateCreated;
        this.dateModified = dateModified;
        this.fnbCategory = fnbCategory;
    }

    public String getFnbID() {
        return fnbID;
    }
    
    public void setFnbID(String fnbID) {
        this.fnbID = fnbID;
    }

    public String getFnbImage() {
        return fnbImage;
    }
    
    public void setFnbImage(String fnbImage) {
        this.fnbImage = fnbImage;
    }

    public String getFnbDescription() {
        return fnbDescription;
    }
    
    public void setFnbDescription(String fnbDescription) {
        this.fnbDescription = fnbDescription;
    }

    public double getFnbPrice() {
        return fnbPrice;
    }
    
    public void setFnbPrice(double fnbPrice) {
        this.fnbPrice = fnbPrice;
    }

    public int getFnbStockLeft() {
        return fnbStockLeft;
    }

    public void setFnbStockLeft(int fnbStockLeft) {
        if(fnbStockLeft < 0) {
            fnbStockLeft = 0;
        }
        this.fnbStockLeft = fnbStockLeft;
    }

    public boolean isActive() {
        return active;
    }

    public void setActive(boolean active) {
        this.active = active;
    }

    public String getDateCreated() {
        return dateCreated;
    }
    
    public void setDateCreated() {   
        LocalDateTime dateCreated = LocalDateTime.now();  
        DateTimeFormatter format = DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm:ss");  
        this.dateCreated = dateCreated.format(format);  
    }

    public String getDateModified() {
        return dateModified;
    }
    
    public void setDateModified() {
        LocalDateTime dateModified = LocalDateTime.now();  
        DateTimeFormatter format = DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm:ss");  
        this.dateModified = dateModified.format(format);  
    }

    public FnbCategory getFnbCategory() {
        return fnbCategory;
    }

    public void setFnbCategory(FnbCategory fnbCategory) {
        this.fnbCategory = fnbCategory;
    }

    public static String generateFnbID() throws Exception{
        FnbDA fnbDA = new FnbDA();
        ArrayList<Fnb> fnbList = fnbDA.getRecord();
        String fnbID;
        
        if(fnbList.size() > 0) {
            String lastFnbID = fnbList.get(fnbList.size() - 1).getFnbID(); 
            int fnbIDInt = Integer.parseInt(lastFnbID.substring(1)) + 1;
            fnbID = "F" + String.format("%04d", fnbIDInt);
        } else {
            fnbID = "F0001";
        }
        
        return fnbID;
    }
}
