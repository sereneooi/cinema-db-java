package model;

import model.Promotion;
import model.Payment;
import java.sql.*;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import javax.swing.*;

public class PaymentDA {
    
    private String host = "jdbc:derby://localhost:1527/cinemadb";
    private String user = "nbuser";
    private String password = "nbuser";
    private String tableName = "Payment";
    private Connection conn;
    private PreparedStatement stmt;
    private PromotionDA promoDA;
    private FnbOrderDA fnbOrderDA;
    private DateTimeFormatter formatter;

    public PaymentDA() throws Exception{
        createConnection();
        promoDA = new PromotionDA();
        fnbOrderDA = new FnbOrderDA();
        formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
    }
    
    public void addRecord(Payment payment) throws SQLException{
        String insertStr = "INSERT INTO " + tableName + " VALUES(?, ?, ?, ?, ?)";
        
            stmt = conn.prepareStatement(insertStr);
            stmt.setString(1, payment.getPaymentID());
            stmt.setTimestamp(2, Timestamp.valueOf(payment.getPaymentDateTime()));
            stmt.setDouble(3, payment.getTotalAmount());
            stmt.setString(4, payment.getPaymentMethod());
            stmt.setString(5, payment.getPromotion().getPromoCode());

            stmt.executeUpdate();
        
    }
    
     public Payment getPayment(String paymentID) throws SQLException {
        String queryStr = "SELECT * FROM " + tableName + " WHERE PaymentID = ?";
        Payment payment = null;
        
        stmt = conn.prepareStatement(queryStr);
        stmt.setString(1, paymentID);
        ResultSet rs = stmt.executeQuery();
            
        if (rs.next()) {
            payment = new Payment(rs.getString("paymentId"), rs.getTimestamp("PaymentDateTime").toLocalDateTime(), 
                    rs.getString("PaymentMethod"), rs.getDouble("TotalAmount"),
                    promoDA.getRecord(rs.getString("PromoCode")));
        }
        return payment;
    }
    
    public ArrayList<Payment> getAllPayment() throws SQLException{

        String queryStr = "SELECT * FROM " + tableName; 
        ArrayList<Payment> paymentList = new ArrayList<>();
        
        stmt = conn.prepareStatement(queryStr);
        ResultSet rs = stmt.executeQuery();
            
        while(rs.next()){
            paymentList.add(new Payment(rs.getString("paymentId"), rs.getTimestamp("PaymentDateTime").toLocalDateTime(), 
                rs.getString("PaymentMethod"), rs.getDouble("TotalAmount"), promoDA.getRecord(rs.getString("PromoCode"))));
                
        }
        return paymentList;
    }
    
    public int countTotalRecord() throws SQLException {
        String queryStr = "SELECT COUNT(PaymentID) FROM " + tableName;
        int count = 0;
        
        stmt = conn.prepareStatement(queryStr);
        ResultSet rs = stmt.executeQuery();
        
        if(rs.next()) {
            count = rs.getInt(1);
        }
        
        return count;
    }
    
    public Payment getRecord(String paymentID) {
        String queryStr = "SELECT * FROM " + tableName + " WHERE PaymentID = ?";
        Payment payment = null;
        try {
            stmt = conn.prepareStatement(queryStr);
            stmt.setString(1, paymentID);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                Promotion promotion = promoDA.getRecord(rs.getString("PromoCode"));
                payment = new Payment(paymentID, rs.getTimestamp("PaymentDateTime").toLocalDateTime(), rs.getString("PaymentMethod"), 
                        rs.getDouble("TotalAmount"), promotion);
            }
        } catch (SQLException ex) {
            JOptionPane.showMessageDialog(null, ex.getMessage(), "ERROR", JOptionPane.ERROR_MESSAGE);
        }
        return payment;
    }

    public void updateRecord(Payment payment) {
        try {
            String updateStr = "UPDATE " + tableName + 
                    " SET PaymentDateTime = ?, PaymentMethod = ?, TotalAmount = ?, PromoCode = ? WHERE PaymentID = ?";
            stmt = conn.prepareStatement(updateStr);
            stmt.setTimestamp(1, Timestamp.valueOf(payment.getPaymentDateTime()));
            stmt.setString(2, payment.getPaymentMethod());
            stmt.setDouble(3, payment.getTotalAmount());
            stmt.setString(4, payment.getPromotion().getPromoCode());
            stmt.setString(5, payment.getPaymentID());
            stmt.executeUpdate();
        } catch (SQLException ex) {
            JOptionPane.showMessageDialog(null, ex.getMessage(), "ERROR", JOptionPane.ERROR_MESSAGE);
        }
    }
    
    public void deleteRecord(String paymentID) {
        try {
            String deleteStr = "DELETE FROM " + tableName + " WHERE PaymentID = ?";
            stmt = conn.prepareStatement(deleteStr);
            stmt.setString(1, paymentID);
            stmt.executeUpdate();

        } catch (SQLException ex) {
            JOptionPane.showMessageDialog(null, ex.getMessage(), "ERROR", JOptionPane.ERROR_MESSAGE);
        }
    }
    
    public double getDailyRevenue(String paymentDateTime) throws SQLException {
        String sqlStr = "SELECT SUM(totalAmount) FROM " + tableName + " WHERE CAST(paymentDateTime AS VARCHAR(255)) LIKE ?";
        paymentDateTime = paymentDateTime + "%";
        double total = 0;
        
        stmt = conn.prepareStatement(sqlStr);
        stmt.setString(1, paymentDateTime);
        ResultSet rs = stmt.executeQuery();
        
        if(rs.next()) {
           total = rs.getDouble(1);
        }
        
        return total;
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

    public static void main(String[] args) throws Exception {
        PaymentDA da = new PaymentDA();

    }
}
