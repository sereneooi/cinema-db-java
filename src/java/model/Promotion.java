
package model;

import java.util.Objects;

public class Promotion { 
    private String promoCode;
    private String promoType;
    private double promoAmount;
    private String promoStatus;
    
    public Promotion(){
    }
    
    public Promotion(String promoCode){
        this.promoCode = promoCode;
    }
    
    public Promotion(String promoCode, String promoType, double promoAmount, String promoStatus){
        this.promoCode = promoCode;
        this.promoType = promoType;
        this.promoAmount = promoAmount;
        this.promoStatus = promoStatus;
    }

    public String getPromoCode() {
        return promoCode;
    }

    public void setPromoCode(String promoCode) {
        this.promoCode = promoCode;
    }

    public String getPromoType() {
        return promoType;
    }

    public void setPromoType(String promoType) {
        this.promoType = promoType;
    }
    
    public double getPromoAmount() {
        return promoAmount;
    }

    public void setPromoAmount(double promoAmount) {
        this.promoAmount = promoAmount;
    }

    public String getPromoStatus() {
        return promoStatus;
    }

    public void setPromoStatus(String promoStatus) {
        this.promoStatus = promoStatus;
    }

}

