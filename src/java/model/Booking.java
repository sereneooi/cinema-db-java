package model;

import java.io.Serializable;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.Locale;

public class Booking implements Serializable{
        
    private String bookingId;
    private String bookDateTime;
    private Account emailAddress;
    private Payment paymentId;

    public Booking() {
    }
    
    public Booking(String bookingId) {
        this.bookingId = bookingId;
    }
    
    public Booking(Account emailAddress, Payment paymentId) {
        this.emailAddress = emailAddress;
        this.paymentId = paymentId;
    }
    
    public Booking(String bookDateTime, Account emailAddress, Payment paymentId) {
        this.bookDateTime = bookDateTime;
        this.emailAddress = emailAddress;
        this.paymentId = paymentId;
    }    

    public Booking(String bookingId,String dateTime, Account emailAddress, Payment paymentId) {
        this.bookingId = bookingId;
        this.emailAddress = emailAddress;
        this.paymentId = paymentId;
        bookDateTime = dateTime;
    }

    public String getBookingId() {
        return bookingId;
    }

    public String getBookDateTime() {
        return bookDateTime;
    }

    public Account getEmailAddress() {
        return emailAddress;
    }

    public Payment getPaymentId() {
        return paymentId;
    }

    public void setBookingId(String bookingId) {
        this.bookingId = bookingId;
    }

    public void setBookDateTime(String bookDateTime) {
        this.bookDateTime = bookDateTime;
    }

    public void setEmailAddress(Account emailAddress) {
        this.emailAddress = emailAddress;
    }

    public void setPaymentId(Payment paymentId) {
        this.paymentId = paymentId;
    }
}
