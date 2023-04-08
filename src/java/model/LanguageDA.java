package model;

import java.sql.*;
import java.text.ParseException;
import javax.swing.*;
import java.text.SimpleDateFormat;  
import java.util.ArrayList;
import java.util.Date;
import model.*;

public class LanguageDA {
    private String host = "jdbc:derby://localhost:1527/cinemadb";
    private String user = "nbuser";
    private String password = "nbuser";
    private String tableName = "Language";
    private Connection conn;
    private PreparedStatement stmt;

    
    public LanguageDA(){
        createConnection();
    }

    //catch exception at caller
   public ArrayList<Language> getLanguageRecord() throws SQLException{
       
       String queryStr = "SELECT * FROM " + tableName;
       
       ArrayList<Language> languageList = new ArrayList<Language>();
        
        stmt = conn.prepareStatement(queryStr);
       
        ResultSet rs = stmt.executeQuery();

        while(rs.next()){
            languageList.add(new Language(rs.getString("languageID"), rs.getString("languageDesc")));
        } 
        return languageList;
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
        new LanguageDA();
    }
}
