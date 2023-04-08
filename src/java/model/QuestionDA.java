package model;

import java.sql.*;
import java.util.ArrayList;

public class QuestionDA {
    private String host = "jdbc:derby://localhost:1527/cinemadb";
    private String user = "nbuser";
    private String password = "nbuser";
    private String tableName = "Question";
    private Connection conn;
    private PreparedStatement stmt;
    
    public QuestionDA() throws Exception{
        createConnection();
    }
    
    public ArrayList getRecord() throws SQLException {
        String sqlStr = "SELECT * FROM " + tableName;
        ArrayList<Question> questionList = new ArrayList<Question>();
        
        stmt = conn.prepareStatement(sqlStr);
        ResultSet rs = stmt.executeQuery();
        
        while(rs.next()) {
            questionList.add(new Question(rs.getString("questionID"), rs.getString("question"), rs.getBoolean("active"), rs.getString("dateCreated"), rs.getString("dateModified")));
        }
        
        return questionList;
    }
    
    public void getAverageRating() throws SQLException {
        
    }
    
    public void insertRecord(Question question) throws SQLException {
        String sqlStr = "INSERT INTO " + tableName + " VALUES(?,?,?,?,?)";
        
        stmt = conn.prepareStatement(sqlStr);
        stmt.setString(1, question.getQuestionID());
        stmt.setString(2, question.getQuestion());
        stmt.setBoolean(3, question.isActive());
        stmt.setString(4, question.getDateCreated());
        stmt.setString(5, "");
        
        stmt.executeUpdate();
    }
    
    public void updateRecord(Question question) throws SQLException {
        String sqlStr = "UPDATE " + tableName + " SET question = ?, active = ?, dateModified = ? WHERE questionID = ?";
        
        stmt = conn.prepareStatement(sqlStr);
        stmt.setString(1, question.getQuestion());
        stmt.setBoolean(2, question.isActive());
        stmt.setString(3, question.getDateModified());
        stmt.setString(4, question.getQuestionID());
        
        stmt.executeUpdate();
    }
    
     public void deleteRecord(Question question) throws SQLException {
        String sqlStr = "DELETE FROM " + tableName + " WHERE questionID = ?";
        
        stmt = conn.prepareStatement(sqlStr);
        stmt.setString(1, question.getQuestionID());
        
        stmt.executeUpdate();
    }
     
     public Question getSpecificRecord(String questionID) throws SQLException {
         String sqlStr = "SELECT * FROM " + tableName + " WHERE questionID = ?";
         ResultSet rs = null;
         Question question = new Question();
         
         stmt = conn.prepareStatement(sqlStr);
         stmt.setString(1, questionID);
         
         rs = stmt.executeQuery();
         
         if(rs.next()) {
             question = new Question(rs.getString("questionID"), rs.getString("question"), rs.getBoolean("active"));
         }
         
         return question;
     }
     
     public ArrayList<Question> filterQuestion(String keyword) throws SQLException {
        String sqlStr = "SELECT * FROM " + tableName + " WHERE UPPER(questionID) LIKE ? OR UPPER(question) LIKE ? OR UPPER(dateCreated) LIKE ? OR UPPER(dateModified) LIKE ?";
        keyword = "%" + keyword.toUpperCase() + "%";
        ResultSet rs = null;
        ArrayList<Question> questionList = new ArrayList<Question>();

        stmt = conn.prepareStatement(sqlStr);
        for(int i = 1; i < 5; i++) {
            stmt.setString(i, keyword);
        }

        rs = stmt.executeQuery();

        while(rs.next()) {
            questionList.add(new Question(rs.getString("questionID"), rs.getString("question"), rs.getBoolean("active"), rs.getString("dateCreated"), rs.getString("dateModified")));
        }

        return questionList;
    }
     
     public ArrayList<Question> sortQuestion(String columnName, String order) throws SQLException { 
        String sqlStr = "SELECT * FROM " + tableName + " ORDER BY UPPER(" + columnName + ") " + order;
        ResultSet rs = null;
        ArrayList<Question> questionList = new ArrayList<Question>();

        stmt = conn.prepareStatement(sqlStr);
        rs = stmt.executeQuery();

        while(rs.next()) {
            questionList.add(new Question(rs.getString("questionID"), rs.getString("question"), rs.getBoolean("active"), rs.getString("dateCreated"), rs.getString("dateModified")));
        }

        return questionList;
    }
    
    private void createConnection() throws Exception{
        Class.forName("org.apache.derby.jdbc.ClientDriver");
        conn = DriverManager.getConnection(host, user, password);
    }
}
