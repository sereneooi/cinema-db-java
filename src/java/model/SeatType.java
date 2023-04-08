package model;

public class SeatType {
    
    private String seatTypeId;
    private String seatTypeDesc;
    private double seatTypePrice;

    public SeatType(String seatTypeId) {
        this.seatTypeId = seatTypeId;
    }

    public SeatType(String seatTypeId, String seatTypeDesc, double seatTypePrice) {
        this.seatTypeId = seatTypeId;
        this.seatTypeDesc = seatTypeDesc;
        this.seatTypePrice = seatTypePrice;
    }

    public String getSeatTypeId() {
        return seatTypeId;
    }

    public void setSeatTypeId(String seatTypeId) {
        this.seatTypeId = seatTypeId;
    }

    public String getSeatTypeDesc() {
        return seatTypeDesc;
    }

    public void setSeatTypeDesc(String seatTypeDesc) {
        this.seatTypeDesc = seatTypeDesc;
    }

    public double getSeatTypePrice() {
        return seatTypePrice;
    }

    public void setSeatTypePrice(double seatTypePrice) {
        this.seatTypePrice = seatTypePrice;
    }
    
}
