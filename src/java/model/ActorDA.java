package model;

import java.sql.*;
import java.text.ParseException;
import javax.swing.*;
import java.text.SimpleDateFormat;  
import java.util.ArrayList;
import java.util.Date;
import model.*;

public class ActorDA {
    private String host = "jdbc:derby://localhost:1527/cinemadb";
    private String user = "nbuser";
    private String password = "nbuser";
    private String tableName = "Actor";
    private Connection conn;
    private PreparedStatement stmt;

    
    public ActorDA(){
        createConnection();
    }

    //catch exception at caller
   public ArrayList<Actor> getActorRecord() throws SQLException{
       
       String queryStr = "SELECT * FROM " + tableName;
       
       ArrayList<Actor> actorList = new ArrayList<Actor>();
        
        stmt = conn.prepareStatement(queryStr);
        ResultSet rs = stmt.executeQuery();

        while(rs.next()){
            actorList.add(new Actor(rs.getString("actorID"), rs.getString("actorName")));
        } 
        return actorList;
    }
   
   public Actor selectSpecificActorID(String actorID) throws SQLException{
       String queryStr = "SELECT * FROM "+ tableName + " WHERE actorID = ?";
       
        stmt = conn.prepareStatement(queryStr);
        stmt.setString(1, actorID);
        ResultSet rs = stmt.executeQuery();
        
       Actor selectedActorID = null;
        
        while(rs.next()){
            selectedActorID = new Actor(rs.getString("actorID"), rs.getString("actorName"));
        }
        
        return selectedActorID;
   }
   
   public String selectLastActorID() throws SQLException{
       String queryStr = "SELECT MAX(actorID) FROM "+ tableName;
       
        stmt = conn.prepareStatement(queryStr);
        ResultSet rs = stmt.executeQuery();
        
        String nextActorID = null;
        
        if(rs.next()){
            nextActorID = rs.getString(1);
        }
        
        return nextActorID;
   }
   
   public void addActor(Actor actor) throws SQLException {
          String insertStr = "INSERT INTO " + tableName + " VALUES(?, ?)";
        
            stmt = conn.prepareStatement(insertStr);
            stmt.setString(1, actor.getActorID());
            stmt.setString(2, actor.getActorName());

            stmt.executeUpdate();
    }
   
   public void updateActor(Actor actor) throws SQLException{
     
            String updateStr = "UPDATE " + tableName + " SET actorName = ? " + 
                    "WHERE actorID = ?";

            stmt = conn.prepareStatement(updateStr);
            stmt.setString(1, actor.getActorName());
            stmt.setString(2, actor.getActorID());
  
            stmt.executeUpdate();
    }
   
   public void deleteMovieSchedule(String actorID) throws SQLException{
    
          String deleteStr = "DELETE FROM " + tableName + " WHERE actorID = ?";
          
          stmt = conn.prepareStatement(deleteStr);
          stmt.setString(1, actorID);
          stmt.executeUpdate();

    }

    private void createConnection() {
        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            conn = DriverManager.getConnection(host, user, password);
        } catch (Exception ex) {
            JOptionPane.showMessageDialog(null, ex.getMessage(), "ERROR", JOptionPane.ERROR_MESSAGE);
        }
    }

    private void shutDown() {
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException ex) {
                JOptionPane.showMessageDialog(null, ex.getMessage(), "ERROR", JOptionPane.ERROR_MESSAGE);
            }
        }
    }

    public static void main(String[] args) {
        new ActorDA();
    }
}

