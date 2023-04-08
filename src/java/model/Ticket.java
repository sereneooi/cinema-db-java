package model;

public class Ticket {
    
    private String ticketId;
    private Seat seatId;
    private TicketType ticketType;
    private Booking bookingDetails;

    public Ticket() {
        this(" ", null, null, null);
    }
    
    public Ticket(String ticketId) {
        this(ticketId, null, null, null);
    }
    
    public Ticket(Seat seatId, TicketType ticketType) {
        this(seatId, ticketType, null);
    }
    
     public Ticket(String ticketId, Seat seatId, TicketType ticketType) {
        this(ticketId, seatId, ticketType, null);
    }       
    
    public Ticket(Seat seatId, TicketType ticketType, Booking bookingDetails) {
        this("", seatId, ticketType, bookingDetails);
    }
    
    public Ticket(String ticketId, Seat seatId, TicketType ticketType, Booking bookingDetails) {
        this.ticketId = ticketId;
        this.seatId = seatId;
        this.ticketType = ticketType;
        this.bookingDetails = bookingDetails;
    }

    public String getTicketId() {
        return ticketId;
    }

    public void setTicketId(String ticketId) {
        this.ticketId = ticketId;
    }

    public Seat getSeatId() {
        return seatId;
    }

    public void setSeatId(Seat seatId) {
        this.seatId = seatId;
    }

    public TicketType getTicketType() {
        return ticketType;
    }

    public void setTicketType(TicketType ticketType) {
        this.ticketType = ticketType;
    }

    public Booking getBookingDetails() {
        return bookingDetails;
    }

    public void setBookingDetails(Booking bookingDetails) {
        this.bookingDetails = bookingDetails;
    }
    
    
}
