package controller;

import model.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.time.*;
import java.time.format.DateTimeFormatter;
import java.util.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "ViewBookingRecordDetails", urlPatterns = {"/ViewBookingRecordDetails"})
public class ViewBookingRecordDetails extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        
        String bookingResult=request.getParameter("bookingId");
        
         try{
            HttpSession session = request.getSession();
            
            TicketDA ticketDA = new TicketDA();
            BookingDA bookingDA = new BookingDA();
            
            Booking bookingDetails = bookingDA.retrieveRecord(bookingResult);
            
            // Get Ticket Order ID
            List<Ticket> ticketDetails = ticketDA.getBookingRecord(bookingResult);
            out.print(ticketDetails.get(0).getBookingDetails().getEmailAddress().getRole().getRole());
            //Get Fnb Order ID
            FnbOrder fnbOrder= bookingDA.getFnbOrderRecord(bookingResult);
            
            List <FnbOrderLine> fnbOrderList = new ArrayList<>();
            List<String> paymentIdList = new ArrayList<>();
            Double fnbSubTotal;
                    
            int index = 0;
                
            if(fnbOrder.getFnbOrderID() == null){
                
                fnbOrderList.add(new FnbOrderLine(" ", 0, new Fnb(" ", " ", " ", 0.00, 0, false, null)));
                //bookedFnbNo.add(bookedTicketNo.get(count));
                fnbSubTotal = 0.00;
                
             }else{
                List <FnbOrderLine> fnbOrderLine =  bookingDA.getFnbRecord(fnbOrder.getFnbOrderID());

                fnbSubTotal = bookingDA.fnbSubTotalCal(fnbOrder.getFnbOrderID());
                //bookedFnbNo.add(fnbOrderLine.size());

                for(int i = 0; i < fnbOrderLine.size(); i++){
                    fnbOrderList.add(fnbOrderLine.get(i));
                }

                //index = index + bookedTicketNo.get(count);
            }
            
            session.setAttribute("fnbSubTotal", fnbSubTotal);
            session.setAttribute("bookingDetails", bookingDetails);
            session.setAttribute("fnbOrder", fnbOrderList);
            session.setAttribute("ticket", ticketDetails);
            response.sendRedirect("ViewSalesRecord.jsp");

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

