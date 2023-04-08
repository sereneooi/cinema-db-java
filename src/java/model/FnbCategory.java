package model;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;

public class FnbCategory {
    
    private String fnbCategoryID;
    private String fnbCategory;
    private String dateCreated;
    private String dateModified;

    public FnbCategory() {
    }

    public FnbCategory(String fnbCategoryID) {
        this.fnbCategoryID = fnbCategoryID;
    }

    public FnbCategory(String fnbCategoryID, String fnbCategory) {
        this.fnbCategoryID = fnbCategoryID;
        this.fnbCategory = fnbCategory;
    }

    public FnbCategory(String fnbCategoryID, String fnbCategory, String dateCreated, String dateModified) {
        this.fnbCategoryID = fnbCategoryID;
        this.fnbCategory = fnbCategory;
        this.dateCreated = dateCreated;
        this.dateModified = dateModified;
    }
    
    public String getFnbCategoryID() {
        return fnbCategoryID;
    }
    
    public void setFnbCategoryID(String fnbCategoryID) {
        this.fnbCategoryID = fnbCategoryID;
    }

    public String getFnbCategory() {
        return fnbCategory;
    }
    
    public void setFnbCategory(String fnbCategory) {
        this.fnbCategory = fnbCategory;
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
    
    public static String generateFnbCategoryID() throws Exception{
        FnbCategoryDA fnbCategoryDA = new FnbCategoryDA();
        ArrayList<FnbCategory> fnbCategoryList = fnbCategoryDA.getRecord();
        String fnbCategoryID;
        
        if(fnbCategoryList.size() > 0) {
            String lastFnbCategoryID = fnbCategoryList.get(fnbCategoryList.size() - 1).getFnbCategoryID(); 
            int fnbCategoryIDInt = Integer.parseInt(lastFnbCategoryID.substring(2)) + 1;
            fnbCategoryID = "FC" + String.format("%04d", fnbCategoryIDInt);
        } else {
            fnbCategoryID = "FC0001";
        }
        
        return fnbCategoryID;
    }
}
