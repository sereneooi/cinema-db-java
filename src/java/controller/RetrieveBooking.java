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

@WebServlet(name = "RetrieveBooking", urlPatterns = {"/RetrieveBooking"})
public class RetrieveBooking extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        
         try{
             
             HttpSession session = request.getSession();
             String bookingResult=request.getParameter("bookingId");
             
            BookingDA bookDA = new BookingDA();
            Booking booking = bookDA.retrieveRecord(bookingResult);
            
            session.setAttribute("booking", booking); 
            response.sendRedirect("UpdateBooking.jsp");

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
         
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        
         try{
            HttpSession session = request.getSession();
            
            //Intialize
            TicketDA ticketDA = new TicketDA();
            BookingDA bookDA = new BookingDA();
                    
            List<Booking> booking = bookDA.retrieveAllRecord();
            List <Ticket> ticketList = new ArrayList<Ticket>();
            List <Integer> noOfTicket = new ArrayList<>();
            List <FnbOrder> fnbOrderList = new ArrayList<>();
            
            for(int i = 0; i < booking.size(); i++){
                //Fnb
                FnbOrder fnbOrder = bookDA.getFnbOrderRecord(booking.get(i).getBookingId());
                
                if(fnbOrder == null){
                    fnbOrderList.add(new FnbOrder("null"));
                }else
                    fnbOrderList.add(fnbOrder);
                
                //Ticket
                List <Ticket> ticket = ticketDA.getBookingRecord(booking.get(i).getBookingId());
                noOfTicket.add(ticket.size());
                for(int j = 0; j < ticket.size(); j++){
                    ticketList.add(ticket.get(j));
                    
                }
            }
            
            session.setAttribute("fnbOrderList", fnbOrderList);
            session.setAttribute("ticketList", ticketList);
            session.setAttribute("noOfTicket", noOfTicket);   
            session.setAttribute("bookingList", booking);
            session.setAttribute("totalNoOfRecord", booking.size());        
            
            response.sendRedirect("mainBookingLayout.jsp");

        }catch(SQLException ex){
            StackTraceElement[] elements = ex.getStackTrace();
            
            out.println("ERROR: " + ex.toString() + "<br/><br/>");
            
            for(StackTraceElement e: elements){
                out.println("File Name: " + e.getFileName() + "<br/>");
                out.println("Clas Name: " + e.getClassName() + "<br/>");
                out.println("Method Name: " + e.getMethodName() + "<br/>");
                out.println("Line Name: " + e.getLineNumber() + "<br/>");
            }
        }catch(Exception ex){
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
