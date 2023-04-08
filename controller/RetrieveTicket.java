package controller;

import model.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "RetrieveTicket", urlPatterns = {"/RetrieveTicket"})
public class RetrieveTicket extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        
         try{
             
             HttpSession session = request.getSession();
             String bookingResult=request.getParameter("bookingId");
            
            if(bookingResult != null || !bookingResult.isEmpty()){
                
                BookingDA bookDA = new BookingDA();
                Booking booking = bookDA.retrieveRecord(bookingResult);

                session.setAttribute("booking", booking); 
                
                response.sendRedirect("UpdateForm.jsp");
        }

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
            BookingDA bookDa = new BookingDA();
            List<Booking> booking = bookDa.retrieveAllRecord();
            
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
        }finally{
            out.close();
        }
    }
}
