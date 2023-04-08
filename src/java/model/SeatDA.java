package model;

import model.*;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import javax.swing.JOptionPane;

public class SeatDA{
    private String host = "jdbc:derby://localhost:1527/cinemadb";
    private String user = "nbuser";
    private String password = "nbuser";
    private String tableName = "Seat";
    private Connection conn;
    private PreparedStatement stmt;
    private SeatTypeDA seatTypeDA = new SeatTypeDA();
    
    public SeatDA(){
        createConnection();
    }
    
    public List<String> searchRecord(String movieScheduleId) throws SQLException{
        String queryStr = "SELECT SeatNo FROM " + tableName + " AS s LEFT JOIN MOVIESCHEDULE AS m ON m.movieScheduleId = s.movieScheduleId WHERE s.movieScheduleId = ?";
        
        stmt = conn.prepareStatement(queryStr);
        stmt.setString(1, movieScheduleId);
        
        ResultSet rs = stmt.executeQuery();
        List <String> seatName = new ArrayList<String>();
        while(rs.next()){
            seatName.add(rs.getString("seatNo"));
        }

        return seatName;
    }
    
    public MovieSchedule retrieveMovieScheduleForSeat(String scheduleId) throws SQLException{
        String queryStr = "SELECT * FROM MOVIESCHEDULE" 
                                + " INNER JOIN MOVIE ON MOVIE.MOVIEID = MOVIESCHEDULE.MOVIEID"
                                + " INNER JOIN THEATRE ON THEATRE.THEATREID = MOVIESCHEDULE.THEATREID"
                                + " INNER JOIN THEATRECLASSES ON THEATRECLASSES.THEATRECLASSESID = THEATRE.THEATRECLASSESID"
                                + " WHERE MOVIESCHEDULE.MOVIESCHEDULEID = ?";
        
         MovieSchedule movieSchedule = null;
         
         stmt = conn.prepareStatement(queryStr);
         stmt.setString(1, scheduleId);
         ResultSet rs = stmt.executeQuery();
            
        if(rs.next()){
            
            movieSchedule = new MovieSchedule(rs.getString("movieScheduleID"), rs.getString("showDate"), rs.getString("showTime"),
                                    new Movie(rs.getString("movieID"), rs.getString("movieName"), rs.getString("movieTrailer"), rs.getString("moviePoster"), rs.getString("movieAdsPoster"), rs.getString("synopsis"), rs.getString("duration"), null, null, null, null, null),
                                    new Theatre(rs.getString("theatreID"), rs.getString("theatreDesc"), rs.getInt("totalSeatCount"),
                                    new TheatreClasses(rs.getString("theatreClassesID"), rs.getString("theatreClassesDesc")))); 
        
        }
        
        return movieSchedule;
        
    }
    
    public List <Seat> retrieveAllRecord() throws SQLException{
        String queryStr = "SELECT * FROM " + tableName;
        List <Seat> seat = new ArrayList <Seat>();
        
        stmt = conn.prepareStatement(queryStr);
        ResultSet rs = stmt.executeQuery();

        while(rs.next()){    

            seat.add(new Seat(rs.getString("seatId"), rs.getString("seatNo"), new MovieSchedule(rs.getString("movieScheduleId")), new SeatType(rs.getString("seatTypeId"))));

        }

        return seat;
    }
    
    public Seat retrieveRecord(String seatId) throws SQLException{
        String queryStr = "SELECT * FROM " + tableName +  " WHERE seatId = ?";
        Seat seat = null;
        
        stmt = conn.prepareStatement(queryStr);
        stmt.setString(1, seatId);

        ResultSet rs = stmt.executeQuery();

        if(rs.next()){    

            SeatType seatType = seatTypeDA.retrieveRecord(rs.getString("seatTypeId"));
            MovieSchedule movieSchedule = null;
            seat = new Seat(seatId, rs.getString("seatNo"), movieSchedule, seatType);

        }

        return seat;
    }
    
     public void addItem(Seat seat) throws SQLException{
         String queryStr = "INSERT INTO SEAT VALUES(?, ?, ?, ?)";
         
        stmt = conn.prepareStatement(queryStr); 
                 
        // Add Booking Item
        stmt = conn.prepareStatement(queryStr);
        stmt.setString(1, seat.getSeatId());
        stmt.setString(2, seat.getSeatNo());
        stmt.setString(3, seat.getMovieScheduleInfor().getMovieScheduleID());
        stmt.setString(4, seat.getSeatType().getSeatTypeId());

        stmt.executeUpdate();
     }
    
    private void createConnection() {
        try {
            
            conn = DriverManager.getConnection(host, user, password);
            System.out.println("***TRACE: Connection established.");
            
        } catch (SQLException ex) {
            StackTraceElement[] traceElements = ex.getStackTrace();
            for (int i = 0; i < traceElements.length; i++) {
              System.out.print("method " + traceElements[i].getMethodName());
              System.out.print("(" + traceElements[i].getClassName() + ":");
              System.out.println(traceElements[i].getLineNumber() + ")");
            }                
        }
    }

    private void shutDown() {
        if (conn != null)
            
            try {
            conn.close();
            
        } catch (SQLException ex) {
            
            JOptionPane.showMessageDialog(null, ex.getMessage(), "ERROR", JOptionPane.ERROR_MESSAGE);
            StackTraceElement[] traceElements = ex.getStackTrace();
            for (int i = 0; i < traceElements.length; i++) {
              System.out.print("method " + traceElements[i].getMethodName());
              System.out.print("(" + traceElements[i].getClassName() + ":");
              System.out.println(traceElements[i].getLineNumber() + ")");
            }                            
        }
    }    
    
    public static void main(String[] args) {
        new SeatDA();
    }    
}

