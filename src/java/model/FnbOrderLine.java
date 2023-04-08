package model;

import java.util.ArrayList;

public class FnbOrderLine {
    
    private String fnbOrderLineID;
    private int quantity = 1;
    private Fnb fnb;
    private FnbOrder fnbOrder;

    public FnbOrderLine() {
    }

    public FnbOrderLine(String fnbOrderLineID, Fnb fnb) {
        this.fnbOrderLineID = fnbOrderLineID;
        this.fnb = fnb;
    }
    
    public FnbOrderLine(String fnbOrderLineID, int quantity, Fnb fnb) {
        this.fnbOrderLineID = fnbOrderLineID;
        this.quantity = quantity;
        this.fnb = fnb;
    }
    
    public String getFnbOrderLineID() {
        return fnbOrderLineID;
    }
    
    public void setFnbOrderLineID(String fnbOrderLineID) {
        this.fnbOrderLineID = fnbOrderLineID;
    }

    public int getQuantity() {
        return quantity;
    }
    
    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public Fnb getFnb() {
        return fnb;
    }
    
    public void setFnb(Fnb fnb) {
        this.fnb = fnb;
    }

    public FnbOrder getFnbOrder() {
        return fnbOrder;
    }
    
    public void setFnbOrder(FnbOrder fnbOrder) {
        this.fnbOrder = fnbOrder;
    }
    
    public double calculateFnbSubTotal() {
        return this.fnb.getFnbPrice() * this.quantity;
    }
    
    public static String generateFnbOrderLineID() throws Exception{
        FnbOrderLineDA fnbOrderLineDA = new FnbOrderLineDA();
        ArrayList<FnbOrderLine> fnbOrderLineList = fnbOrderLineDA.getRecord();
        String fnbOrderLineID;
        
        if(fnbOrderLineList.size() > 0) {
            String lastFnbOrderLineID = fnbOrderLineList.get(fnbOrderLineList.size() - 1).getFnbOrderLineID(); 
            int fnbOrderLineIDInt = Integer.parseInt(lastFnbOrderLineID.substring(3)) + 1;
            fnbOrderLineID = "FOL" + String.format("%04d", fnbOrderLineIDInt);
        } else {
            fnbOrderLineID = "FOL0001";
        }
        
        return fnbOrderLineID;
    }

}
