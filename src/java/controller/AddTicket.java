package controller;

import model.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.*;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "AddTicket", urlPatterns = {"/AddTicket"})
public class AddTicket extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        
        List <Seat> seat = (ArrayList <Seat>)request.getSession().getAttribute("seatList");
        String total = request.getParameter("total");
        
        try{
            HttpSession session = request.getSession();
            
            TicketTypeDA ticketTypeDA = new TicketTypeDA();
            List <TicketType> ticketType = ticketTypeDA.retrieveAllRecord();
            int count = ticketTypeDA.recordCount();
            List <Ticket> ticket = new ArrayList<Ticket>();
            TicketDA ticketDA = new TicketDA();
            int ticektTypeCount  = 0, seatCount = 0;
            
            
            for(int i = 0; i < count; i++){
     
                if((request.getParameter("ticketTypeCount["+i+"]") != null)){
                    ticektTypeCount = Integer.parseInt(request.getParameter("ticketTypeCount["+i+"]"));
                    for(int j = 0; j < ticektTypeCount; j++){
                        
                        //auto booking id increament
                        BookingDA bookDA = new BookingDA();
                        List<Booking>bookList = bookDA.retrieveAllRecord();
                        String bookId = ""; 
                        if(bookList == null || bookList.isEmpty()){
                            bookId="B0001";
                        }else{
                            String id = bookList.get(bookList.size()-1).getBookingId();
                            int intBookId = Integer.parseInt(id.substring(1, 5)) - 1;
                            bookId = 'B' + String.format("%04d" , intBookId);
                        }

                        ticket.add(new Ticket(new Seat(seat.get(seatCount).getSeatId()), new TicketType(ticketType.get(i).getTicketTypeId()), new Booking(null)));
                        seatCount++;
                    }
                    
                }

                if((request.getParameter("TwinSeatCount["+i+"]") != null)){
                    ticektTypeCount = Integer.parseInt(request.getParameter("TwinSeatCount["+i+"]"));
                    
                    for(int j = 0; j < ticektTypeCount; j++){
                        
                        //auto booking id increament
                        BookingDA bookDA = new BookingDA();
                        List<Booking>bookList = bookDA.retrieveAllRecord();
                        String bookId = ""; 
                        if(bookList == null || bookList.isEmpty()){
                            bookId="B0001";
                        }else{
                            String id = bookList.get(bookList.size()-1).getBookingId();
                            int intBookId = Integer.parseInt(id.substring(1, 5)) - 1;
                            bookId = 'B' + String.format("%04d" , intBookId);
                        }

                        ticket.add(new Ticket(new Seat(seat.get(seatCount).getSeatId()), new TicketType(ticketType.get(i).getTicketTypeId()), new Booking(null)));
                        seatCount++;
                    }                    
                }
            }

            session.setAttribute("movieTotalPrice", total);
            session.setAttribute("ticketList", ticket);
            response.sendRedirect("food.jsp");
            
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
