package model;

import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;

public class FnbOrder {
    
    private String fnbOrderID;
    private String fnbOrderDateTime;
    private String deliveryAddress;
    private String deliveryDateTime;
    private String deliveryStatus;
    private Booking booking;
    private static double deliveryFee = 10;

    public FnbOrder() {
    }

    public FnbOrder(String fnbOrderID) {
        this.fnbOrderID = fnbOrderID;
    }

    public FnbOrder(String deliveryAddress, String deliveryDateTime) throws Exception {
        SimpleDateFormat fromUser = new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat myFormat = new SimpleDateFormat("dd-MM-yyyy");
        this.deliveryDateTime = myFormat.format(fromUser.parse(deliveryDateTime.substring(0, 10))) + " " + deliveryDateTime.substring(11);
        this.deliveryAddress = deliveryAddress;
    }

    public FnbOrder(String fnbOrderID, String deliveryAddress, String deliveryDateTime, String deliveryStatus) {
        this.fnbOrderID = fnbOrderID;
        this.deliveryAddress = deliveryAddress;
        this.deliveryDateTime = deliveryDateTime;
        this.deliveryStatus = deliveryStatus;
    }

    public FnbOrder(String fnbOrderID, String deliveryAddress, String deliveryDateTime, String deliveryStatus, Booking booking) {
        this.fnbOrderID = fnbOrderID;
        this.deliveryAddress = deliveryAddress;
        this.deliveryDateTime = deliveryDateTime;
        this.deliveryStatus = deliveryStatus;
        this.booking = booking;
    }

    public FnbOrder(String fnbOrderID, String fnbOrderDateTime, String deliveryAddress, String deliveryDateTime, String deliveryStatus, Booking booking) {
        this.fnbOrderID = fnbOrderID;
        this.fnbOrderDateTime = fnbOrderDateTime;
        this.deliveryAddress = deliveryAddress;
        this.deliveryDateTime = deliveryDateTime;
        this.deliveryStatus = deliveryStatus;
        this.booking = booking;
    }

    public String getFnbOrderID() {
        return fnbOrderID;
    }
    
    public void setFnbOrderID(String fnbOrderID) {
        this.fnbOrderID = fnbOrderID;
    }

    public String getFnbOrderDateTime() {
        return fnbOrderDateTime;
    }
    
    public void setFnbOrderDateTime() {
        LocalDateTime fnbOrderDateTime = LocalDateTime.now();  
        DateTimeFormatter format = DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm:ss");  
        this.fnbOrderDateTime = fnbOrderDateTime.format(format); 
    }
    
    public String getDeliveryAddress() {
        return deliveryAddress;
    }

    public void setDeliveryAddress(String deliveryAddress) {
        this.deliveryAddress = deliveryAddress;
    }

    public String getDeliveryDateTime() {
        return deliveryDateTime;
    }
    
    public void setDeliveryDateTime(String deliveryDateTime) {
        this.deliveryDateTime = deliveryDateTime;
    }

    public String getDeliveryStatus() {
        return deliveryStatus;
    }
    
    public void setDeliveryStatus(String deliveryStatus) {
        this.deliveryStatus = deliveryStatus;
    }

    public Booking getBooking() {
        return booking;
    }

    public void setBooking(Booking booking) {
        this.booking = booking;
    }

    public static double getDeliveryFee() {
        return deliveryFee;
    }

    public static void setDeliveryFee(double deliveryFee) {
        FnbOrder.deliveryFee = deliveryFee;
    }
    
    public static String generateFnbOrderID() throws Exception{
        FnbOrderDA fnbOrderDA = new FnbOrderDA();
        ArrayList<FnbOrder> fnbOrderList = fnbOrderDA.getRecord();
        String fnbOrderID;
        
        if(fnbOrderList.size() > 0) {
            String lastFnbOrderID = fnbOrderList.get(fnbOrderList.size() - 1).getFnbOrderID(); 
            int fnbOrderIDInt = Integer.parseInt(lastFnbOrderID.substring(2)) + 1;
            fnbOrderID = "FO" + String.format("%04d", fnbOrderIDInt);
        } else {
            fnbOrderID = "FO0001";
        }
        
        return fnbOrderID;
    }
}
