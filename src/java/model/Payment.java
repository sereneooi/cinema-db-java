package model;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Objects;

public class Payment {
    private String paymentID;
    private LocalDateTime paymentDateTime;
    private String paymentMethod;
    private double totalAmount;
    private Promotion promotion;
    
    public Payment(){
    }
    
    public Payment(String paymentID) {
        this.paymentID = paymentID;
    }
    
    public Payment(String paymentID, String paymentMethod){
        this.paymentID = paymentID;
        this.paymentMethod = paymentMethod;
    }
    
    public Payment(String paymentID, String paymentMethod, double totalAmount){
        this.paymentID = paymentID;
        this.paymentMethod = paymentMethod;
        this.totalAmount = totalAmount;
    }
    
    public Payment(String paymentID, String paymentDateTime, String paymentMethod, double totalAmount){
        this.paymentID = paymentID;
        this.paymentDateTime = LocalDateTime.parse(paymentDateTime, DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss.s"));
        this.paymentMethod = paymentMethod;
        this.totalAmount = totalAmount;
    }
    
    public Payment(String paymentID, LocalDateTime paymentDateTime, String paymentMethod, double totalAmount, Promotion promotion){
        this.paymentID = paymentID;
        this.paymentDateTime = paymentDateTime;
        this.paymentMethod = paymentMethod;
        this.totalAmount = totalAmount;
        this.promotion = promotion;
    }

    public String getPaymentID() {
        return paymentID;
    }

    public void setPaymentID(String paymentID) {
        this.paymentID = paymentID;
    }

    public LocalDateTime getPaymentDateTime() {
        return paymentDateTime;
    }

    public void setPaymentDateTime(LocalDateTime paymentDateTime) {
        this.paymentDateTime = paymentDateTime;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public double getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(double totalAmount) {
        this.totalAmount = totalAmount;
    }

    public Promotion getPromotion() {
        return promotion;
    }

    public void setPromotion(Promotion promotion) {
        this.promotion = promotion;
    }

    

}
