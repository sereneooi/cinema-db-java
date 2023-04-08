package model;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;

public class Question {
    
    private String questionID;
    private String question;
    private boolean active;
    private String dateCreated;
    private String dateModified;

    public Question() {
    }
    
    public Question(String questionID) {
        this.questionID = questionID;
    }

    public Question(String questionID, String question, boolean active) {
        this.questionID = questionID;
        this.question = question;
        this.active = active;
    }

    public Question(String questionID, String question, boolean active, String dateCreated, String dateModified) {
        this.questionID = questionID;
        this.question = question;
        this.active = active;
        this.dateCreated = dateCreated;
        this.dateModified = dateModified;
    }

    public String getQuestionID() {
        return questionID;
    }
    
    public void setQuestionID(String questionID) {
        this.questionID = questionID;
    }

    public String getQuestion() {
        return question;
    }
    
    public void setQuestion(String question) {
        this.question = question;
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

    public static String generateQuestionID() throws Exception{
        QuestionDA questionDA = new QuestionDA();
        ArrayList<Question> questionList = questionDA.getRecord();
        String questionID;
        
        if(questionList.size() > 0) {
            String lastQuestionID = questionList.get(questionList.size() - 1).getQuestionID(); 
            int questionIDInt = Integer.parseInt(lastQuestionID.substring(1)) + 1;
            questionID = "Q" + String.format("%04d", questionIDInt);
        } else {
            questionID = "Q0001";
        }
        
        return questionID;
    }
}
