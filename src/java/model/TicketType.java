package model;

public class TicketType {
    
    private String ticketTypeId;
    private String ticketTypeDesc;
    private double ticketDiscountRate;

    public TicketType(String ticketTypeId) {
        this.ticketTypeId = ticketTypeId;
    }
    
    public TicketType(String ticketTypeId, String ticketTypeDesc) {
        this(ticketTypeId, ticketTypeDesc, '\0');
    }    

    public TicketType(String ticketTypeId, String ticketTypeDesc, double ticketDiscountRate) {
        this.ticketTypeId = ticketTypeId;
        this.ticketTypeDesc = ticketTypeDesc;
        this.ticketDiscountRate = ticketDiscountRate;
    }

    public String getTicketTypeId() {
        return ticketTypeId;
    }

    public void setTicketTypeId(String ticketTypeId) {
        this.ticketTypeId = ticketTypeId;
    }

    public String getTicketTypeDesc() {
        return ticketTypeDesc;
    }

    public void setTicketTypeDesc(String ticketTypeDesc) {
        this.ticketTypeDesc = ticketTypeDesc;
    }

    public double getTicketDiscountRate() {
        return ticketDiscountRate;
    }

    public void setTicketDiscountRate(double ticketDiscountRate) {
        this.ticketDiscountRate = ticketDiscountRate;
    }
}
