package model;

import java.sql.*;
import java.util.*;

public class FeedbackResponseDA {
    private String host = "jdbc:derby://localhost:1527/cinemadb";
    private String user = "nbuser";
    private String password = "nbuser";
    private String tableName = "FeedbackResponse";
    private Connection conn;
    private PreparedStatement stmt;
    
    public FeedbackResponseDA() throws Exception{
        createConnection();
    }
    
    public ArrayList<FeedbackResponse> getRecord() throws SQLException {
        String sqlStr = "SELECT * FROM " + tableName;
        ArrayList<FeedbackResponse> feedbackResponseList = new ArrayList<FeedbackResponse>();
        
        stmt = conn.prepareStatement(sqlStr);
        ResultSet rs = stmt.executeQuery();
        
        while(rs.next()) {
            feedbackResponseList.add(new FeedbackResponse(rs.getString("feedbackResponseID"), new Question(rs.getString("questionID")), new FeedbackForm(rs.getString("feedbackFormID")), rs.getInt("rating")));
        }
        
        return feedbackResponseList;
    }
    
    public void insertRecord(FeedbackResponse feedbackResponse) throws SQLException {
        String sqlStr = "INSERT INTO " + tableName + " VALUES(?,?,?,?)";
        
        stmt = conn.prepareStatement(sqlStr);
        stmt.setString(1, feedbackResponse.getFeedbackResponseID());
        stmt.setString(2, feedbackResponse.getQuestion().getQuestionID());
        stmt.setString(3, feedbackResponse.getFeedbackForm().getFeedbackFormID());
        stmt.setInt(4, feedbackResponse.getRating());
        
        stmt.executeUpdate();
    }

    private void createConnection() throws Exception {
        Class.forName("org.apache.derby.jdbc.ClientDriver");
        conn = DriverManager.getConnection(host, user, password);
    }
}
