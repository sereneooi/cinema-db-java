package model;

public class Seat {
    
    private String seatId;
    private String seatNo;
    private MovieSchedule movieScheduleInfor;
    private SeatType seatType;

    public Seat(String seatId) {
        this.seatId = seatId;
    }
    
    public Seat(String seatId, String seatNo) {
        this(seatId, seatNo, null, null);
    }    

    public Seat(String seatId, String seatNo, MovieSchedule movieScheduleInfor, SeatType seatType) {
        this.seatId = seatId;
        this.seatNo = seatNo;
        this.movieScheduleInfor = movieScheduleInfor;
        this.seatType = seatType;
    }

    public String getSeatId() {
        return seatId;
    }

    public void setSeatId(String seatId) {
        this.seatId = seatId;
    }
    
    public String getSeatNo() {
        return seatNo;
    }

    public void setSeatNo(String seatNo) {
        this.seatNo = seatNo;
    }

    public MovieSchedule getMovieScheduleInfor() {
        return movieScheduleInfor;
    }

    public void setMovieScheduleInfor(MovieSchedule movieScheduleInfor) {
        this.movieScheduleInfor = movieScheduleInfor;
    }

    public SeatType getSeatType() {
        return seatType;
    }

    public void setSeatType(SeatType seatType) {
        this.seatType = seatType;
    }
    
    
}
