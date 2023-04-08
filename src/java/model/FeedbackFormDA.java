package model;

import java.sql.*;
import java.util.ArrayList;

public class FeedbackFormDA {
    private String host = "jdbc:derby://localhost:1527/cinemadb";
    private String user = "nbuser";
    private String password = "nbuser";
    private String tableName = "FeedbackForm";
    private Connection conn;
    private PreparedStatement stmt;
    
    public FeedbackFormDA() throws Exception{
        createConnection();
    }
    
    public ArrayList<FeedbackForm> getRecord() throws SQLException {
        String sqlStr = "SELECT * FROM " + tableName;
        ArrayList<FeedbackForm> feedbackFormList = new ArrayList<FeedbackForm>();
        
        stmt = conn.prepareStatement(sqlStr);
        ResultSet rs = stmt.executeQuery();
        
        while(rs.next()) {
            feedbackFormList.add(new FeedbackForm(rs.getString("feedbackFormID"), rs.getString("feedbackDateTime"), new Booking(rs.getString("bookingID"))));
        }
        
        return feedbackFormList;
    }
    
    public void insertRecord(FeedbackForm feedbackForm) throws SQLException {
        String sqlStr = "INSERT INTO " + tableName + " VALUES(?,?,?)";
        
        stmt = conn.prepareStatement(sqlStr);
        stmt.setString(1, feedbackForm.getFeedbackFormID());
        stmt.setString(2, feedbackForm.getFeedbackDateTime());
        stmt.setString(3, feedbackForm.getBooking().getBookingId());
        
        stmt.executeUpdate();
    }

    private void createConnection() throws Exception {
        Class.forName("org.apache.derby.jdbc.ClientDriver");
        conn = DriverManager.getConnection(host, user, password);
    }
}
