package model;

import java.util.ArrayList;

public class FeedbackResponse {
    
    private String feedbackResponseID;
    private Question question;
    private FeedbackForm feedbackForm;
    private int rating;

    public FeedbackResponse() {
    }

    public FeedbackResponse(String feedbackResponseID, Question question, FeedbackForm feedbackForm, int rating) {
        this.feedbackResponseID = feedbackResponseID;
        this.question = question;
        this.feedbackForm = feedbackForm;
        this.rating = rating;
    }

    public String getFeedbackResponseID() {
        return feedbackResponseID;
    }
    
    public void setFeedbackResponseID(String feedbackResponseID) {
        this.feedbackResponseID = feedbackResponseID;
    }

    public Question getQuestion() {
        return question;
    }
    
    public void setQuestionID(Question question) {
        this.question = question;
    }

    public FeedbackForm getFeedbackForm() {
        return feedbackForm;
    }
    
    public void setFeedbackForm(FeedbackForm feedbackForm) {
        this.feedbackForm = feedbackForm;
    }

    public int getRating() {
        return rating;
    }

    public void setRating(int rating) {
        this.rating = rating;
    }

    public static String generateFeedbackResponseID() throws Exception{
        FeedbackResponseDA feedbackResponseDA = new FeedbackResponseDA();
        ArrayList<FeedbackResponse> feedbackResponseList = feedbackResponseDA.getRecord();
        String feedbackResponseID;
        
        if(feedbackResponseList.size() > 0) {
            String lastFeedbackResponseID = feedbackResponseList.get(feedbackResponseList.size() - 1).getFeedbackResponseID(); 
            int feedbackResponseIDInt = Integer.parseInt(lastFeedbackResponseID.substring(2)) + 1;
            feedbackResponseID = "FR" + String.format("%04d", feedbackResponseIDInt);
        } else {
            feedbackResponseID = "FR0001";
        }
        
        return feedbackResponseID;
    }
    
    public static int[] countRating(String questionID) throws Exception {
        int[] count = new int[5];
        FeedbackResponseDA feedbackResponseDA = new FeedbackResponseDA();
        ArrayList<FeedbackResponse> feedbackResponseList = feedbackResponseDA.getRecord();
        
        for(FeedbackResponse feedbackResponse : feedbackResponseList) {                  
            if(feedbackResponse.getQuestion().getQuestionID().equals(questionID)) {                                   
                for(int i = 0; i < 5; i++) {
                    if(feedbackResponse.getRating() == i+1) {
                        count[i] ++;
                    }
                }
            }
        }
        
        return count;
    }
    
    public static double[] percentageRating(int[] count) {
        double[] percentage = new double[5];
        int totalCount = totalRespondent(count);
        
        for(int i = 0; i < percentage.length; i++) {
            percentage[i] = ((double)count[i] / totalCount) * 100;
        }
        
        return percentage;
    }
    
    public static double averageRating(int[] count) {
        double average = 0;
        int totalCount = totalRespondent(count), totalResponse = 0;
        
        for(int i = 0; i < count.length; i++) {
            totalResponse += count[i] * (i+1);
        }
        
        if(totalCount != 0) {
            average = (double) totalResponse / totalCount;
        }
        
        return average;
    }
    
    public static int totalRespondent(int[] count) {
        int totalCount = 0;
                
        for(int i = 0; i < count.length; i++) {
            totalCount += count[i];
        }
        
        return totalCount;
    }
    
}
