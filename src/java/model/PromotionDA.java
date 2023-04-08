package model;

import java.sql.*;
import java.util.ArrayList;
import javax.swing.*;

public class PromotionDA {
    private String host = "jdbc:derby://localhost:1527/cinemadb";
    private String user = "nbuser";
    private String password = "nbuser";
    private String tableName = "Promotion";
    private Connection conn;
    private PreparedStatement stmt;

    public PromotionDA() {
        createConnection();
    }
    
    public void addRecord(Promotion promotion) {
        String insertStr = "INSERT INTO " + tableName + " VALUES(?, ?, ?,?)";
        try {
            stmt = conn.prepareStatement(insertStr);
            stmt.setString(1, promotion.getPromoCode());
            stmt.setString(2, promotion.getPromoType());
            stmt.setDouble(3, promotion.getPromoAmount());
            stmt.setString(4, promotion.getPromoStatus());
            stmt.executeUpdate();
        } catch (SQLException ex) {
            JOptionPane.showMessageDialog(null, ex.getMessage(), "ERROR", JOptionPane.ERROR_MESSAGE);
        }
    }
    
    public Promotion getRecord(String promoCode) {
        String queryStr = "SELECT * FROM " + tableName + " WHERE PromoCode = ?";
        Promotion promotion = null;
        try {
            stmt = conn.prepareStatement(queryStr);
            stmt.setString(1, promoCode);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                promotion = new Promotion(promoCode, rs.getString("PromoType"), rs.getDouble("PromoAmount"), rs.getString("PromoStatus"));
                
            }
        } catch (SQLException ex) {
            JOptionPane.showMessageDialog(null, ex.getMessage(), "ERROR", JOptionPane.ERROR_MESSAGE);
        }
        return promotion;
    }
    
    public ArrayList<Promotion> getAllRecord() {
        String queryStr = "SELECT * FROM " + tableName;
        ArrayList<Promotion> promotionList = new ArrayList<Promotion>();
        
        try {
            stmt = conn.prepareStatement(queryStr);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                promotionList.add(new Promotion(rs.getString("PromoCode"), rs.getString("PromoType"), rs.getDouble("PromoAmount"), rs.getString("PromoStatus")));
                
            }
        } catch (SQLException ex) {
            JOptionPane.showMessageDialog(null, ex.getMessage(), "ERROR", JOptionPane.ERROR_MESSAGE);
        }
        return promotionList;
    }
    
    public String updateRecord(Promotion promotion) {
        String msg = "";
        try {
            String updateStr = "UPDATE " + tableName + " SET PromoType = ?, PromoAmount = ?, PromoStatus = ? " + " WHERE PromoCode = ?";
            stmt = conn.prepareStatement(updateStr);
            stmt.setString(1, promotion.getPromoType());
            stmt.setDouble(2, promotion.getPromoAmount());
            stmt.setString(3, promotion.getPromoStatus());
            stmt.setString(4, promotion.getPromoCode());
            stmt.executeUpdate();
        } catch (SQLException ex) {
            msg = ex.getMessage();
        }
        return msg;
    }
    
    public void updateStatusRecord(String promoCode) {
        try {
            String updateStr = "UPDATE " + tableName + " SET promoStatus = 'Unavailable' WHERE promoCode = ?"; 
            stmt = conn.prepareStatement(updateStr);
            stmt.setString(1, promoCode);
            stmt.executeUpdate();

        } catch (SQLException ex) {
            JOptionPane.showMessageDialog(null, ex.getMessage(), "ERROR", JOptionPane.ERROR_MESSAGE);
        }
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
        PromotionDA da = new PromotionDA();
        Promotion p = new Promotion("CC123", "Food", 4.0, "Available");
        da.updateRecord(p);
    }
    
}
