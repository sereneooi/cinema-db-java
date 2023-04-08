package model;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;

public class FeedbackForm {
    
    private String feedbackFormID;
    private String feedbackDateTime;
    private Booking booking;

    public FeedbackForm() {
    }

    public FeedbackForm(String feedbackFormID) {
        this.feedbackFormID = feedbackFormID;
    }

    public FeedbackForm(String feedbackFormID, Booking booking) {
        this.feedbackFormID = feedbackFormID;
        this.booking = booking;
    }

    public FeedbackForm(String feedbackFormID, String feedbackDateTime, Booking booking) {
        this.feedbackFormID = feedbackFormID;
        this.feedbackDateTime = feedbackDateTime;
        this.booking = booking;
    }

    public String getFeedbackFormID() {
        return feedbackFormID;
    }
    
    public void setFeedbackFormID(String feedbackFormID) {
        this.feedbackFormID = feedbackFormID;
    }

    public String getFeedbackDateTime() {
        return feedbackDateTime;
    }
    
    public void setFeedbackDateTime() {   
        LocalDateTime feedbackDateTime = LocalDateTime.now();  
        DateTimeFormatter format = DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm:ss");  
        this.feedbackDateTime = feedbackDateTime.format(format);  
    }

    public Booking getBooking() {
        return booking;
    }
    
    public void setBooking(Booking booking) {
        this.booking = booking;
    }

    public static String generateFeedbackFormID() throws Exception{
        FeedbackFormDA feedbackFormDA = new FeedbackFormDA();
        ArrayList<FeedbackForm> feedbackFormList = feedbackFormDA.getRecord();
        String feedbackFormID;
        
        if(feedbackFormList.size() > 0) {
            String lastFeedbackFormID = feedbackFormList.get(feedbackFormList.size() - 1).getFeedbackFormID(); 
            int feedbackFormIDInt = Integer.parseInt(lastFeedbackFormID.substring(2)) + 1;
            feedbackFormID = "FF" + String.format("%04d", feedbackFormIDInt);
        } else {
            feedbackFormID = "FF0001";
        }
        
        return feedbackFormID;
    }
}
