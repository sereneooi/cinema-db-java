package controller;

import model.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "AddSeat", urlPatterns = {"/AddSeat"})
public class AddSeat extends HttpServlet {

   
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
       
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();        
        
        MovieSchedule movieSchedule = (MovieSchedule)request.getSession().getAttribute("movieScheduleDetails");
        int seatCount = movieSchedule.getTheatre().getTotalSeatCount();
        out.print(movieSchedule.getMovieScheduleID());
        out.print(seatCount);
        try{
            List<Seat> seat = new ArrayList <Seat>();
            SeatTypeDA seatTypeDA = new SeatTypeDA();      
            SeatDA seatDA = new SeatDA();      
            
            List<SeatType> seatType = seatTypeDA.retrieveAllRecord();
            List<String> selectedSeat = new ArrayList<String>();
            List<String> selectedSeatType = new ArrayList<String>();

            Integer[] typeCount = new Integer[seatType.size()];    // all elements are null
            Arrays.fill(typeCount, 0);
            int count = 0, totalSelectedSeatCount = 0; int intSeatId = 0;

             List<Seat> seatList = seatDA.retrieveAllRecord();
             String seatId = ""; 
             if(seatList == null || seatList.isEmpty()){
                 seatId="C0001";
             }else{
                 String id = seatList.get(seatList.size()-1).getSeatId();
                 intSeatId = Integer.parseInt(id.substring(1, 5));
                 
             }
                    
            for(int seatNumber = 0; seatNumber < seatCount; seatNumber++){
                if(request.getParameter("selectedSeat["+seatNumber+"]") != null){
                    String myString = request.getParameter("selectedSeat["+seatNumber+"]");
                    String[] splitSeat = myString.split("@");
                    selectedSeat.add(splitSeat[0]);
                    selectedSeatType.add(splitSeat[1]);
                    
                    for(int j = 0; j < seatType.size(); j++){
                        if(seatType.get(j).getSeatTypeId().equals(selectedSeatType.get(count))){
                            typeCount[j]++;
                            totalSelectedSeatCount++;
                        }
                    }
                      
                    intSeatId = intSeatId + 1;
                    seatId = 'C' + String.format("%04d" , intSeatId);
                    
                    SeatType seatTypeObj =  seatTypeDA.retrieveRecord(selectedSeatType.get(count));
                    seat.add(new Seat(seatId, selectedSeat.get(count), new MovieSchedule(movieSchedule.getMovieScheduleID()), new SeatType(selectedSeatType.get(count))));
                    count++;
                }
            }
            
            for(int i = 0; i< seat.size();i++){
                seatDA.addItem(seat.get(i));
            }
            
            HttpSession session = request.getSession();
            session.setAttribute("seatList", seat);
            session.setAttribute("totalSelectedSeatCount", totalSelectedSeatCount);
            session.setAttribute("typeCount", typeCount);
            
            out.print(totalSelectedSeatCount);
            
            response.sendRedirect(request.getContextPath() + "/movieTicket.jsp");
            
        }catch(SQLException ex){
                StackTraceElement[] elements = ex.getStackTrace();

                out.println("ERROR: " + ex.toString() + "<br/><br/>");

                for(StackTraceElement e: elements){
                    out.println("File Name: " + e.getFileName() + "<br/>");
                    out.println("Clas Name: " + e.getClassName() + "<br/>");
                    out.println("Method Name: " + e.getMethodName() + "<br/>");
                    out.println("Line Name: " + e.getLineNumber() + "<br/>");
                }
            }finally{
                out.close();
            }
        }
}
