package model;

import java.text.ParseException;
import java.text.SimpleDateFormat;  
import java.util.Date; 
import java.util.concurrent.TimeUnit;
import java.util.logging.Level;
import java.util.logging.Logger;

public class IC {
    private String ic;
    
    public IC(String ic, char gender, String birthdate) throws InvalidICException, ParseException{ 
        
        String msg = "";
        Date birthDt = new SimpleDateFormat("yyyy-MM-dd").parse(birthdate);
        Date icDt = new SimpleDateFormat("yyMMdd").parse(ic.substring(0, 7));
        Date currentDt = new Date();
        
        if(ic.charAt(6) != '-' || ic.charAt(9) != '-'){
            msg = "IC entered should follow this format: 000101-07-0123\n";
            
        }else{
            
            // the last digit of ic number for the female will always be the even number, while for the male will be odd number.
            if(gender == 'F' && ic.charAt(13) % 2 != 0){
                msg += "Invalid IC Number entered. The last number should be an even number. \n";
                
            }else if(gender == 'M' && ic.charAt(13) % 2 == 0){
                msg += "Invalid IC Number entered. The last number should be an odd number.\n";
            }
            
            if(!birthDt.equals(icDt)){
                msg += "The IC entered does not match with birth date selected.\n";
            }
            
            long diffInMillies = Math.abs(currentDt.getTime() - birthDt.getTime());
            long diff = TimeUnit.DAYS.convert(diffInMillies, TimeUnit.MILLISECONDS);
            
            if(diff < (18 * 365)){ // if the age does not over 18 are not allowed to create account
                msg += "You are not allowed to create an account if you are not over 18-year old. \n";
            }
        }
        
        if (msg != ""){
            throw new InvalidICException(msg);
        }
   
        this.ic = ic;
    }
}
