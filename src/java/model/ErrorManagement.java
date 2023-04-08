package model;

import java.sql.SQLException;
import java.util.*;
import javax.swing.JOptionPane;
import model.*;
    
public class ErrorManagement {
    
    public ErrorManagement(){
        
    }
    
    public boolean primaryKeyValidation(Object o, String id){
        
        try{
            if(o instanceof Theatre){
                TheatreDA theatreDA = new TheatreDA();
                Theatre theatre = theatreDA.retrieveRecord(id);
                
                return checking(theatre, id);
                 
            }else if(o instanceof Booking){
                BookingDA bookDA = new BookingDA();
                Booking book = bookDA.retrieveRecord(id);
                
                return checking(book, id);
            }

        }catch(SQLException ex){
            
        }
        return true;
    }
    
    public boolean checking(Object o, String id){
        if(o != null){ //student already exists in the database
            return false;
        }else{
            return true;
        }
    }
}
