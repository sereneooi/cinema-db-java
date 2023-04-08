package model;

import java.io.Serializable;
import java.util.Objects;

public class Language implements Serializable{
     //data members
     private String languageID;
     private String languageDesc;
        
     //constructor
     public Language() {
     }

    public Language(String languageID) {
        this.languageID = languageID;
    }

    public Language(String languageID, String languageDesc) {
        this.languageID = languageID;
        this.languageDesc = languageDesc;
    }

    //getter
    public String getLanguageID() {
        return languageID;
    }

    public String getLanguageDesc() {
        return languageDesc;
    }
   
    //setter
    public void setLanguageID(String languageID) {
        this.languageID = languageID;
    }

    public void setLanguageDesc(String languageDesc) {
        this.languageDesc = languageDesc;
    }
    
    public String toString() {
        return String.format("%s", languageDesc);
    }
}
