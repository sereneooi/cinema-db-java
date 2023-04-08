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

@WebServlet(name = "RetrieveSalesReport", urlPatterns = {"/RetrieveSalesReport"})
public class RetrieveSalesReport extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        
        String date = request.getParameter("userSelectDate");
        
         try{
            
             List <FnbOrderLine> fnbOrderList = new ArrayList<>();
            List<Integer> bookedTicketNo = new ArrayList<>();
            List<Integer> bookedFnbNo = new ArrayList<>();
            List<String> paymentIdList = new ArrayList<>();
            List <Double> fnbSubTotal = new ArrayList<>();
            
            HttpSession session = request.getSession();
            TicketDA ticketDA = new TicketDA();
            BookingDA bookingDA = new BookingDA();
             List<Ticket> bookingDetail = new ArrayList<>();

            if(date == null){
               bookingDetail = ticketDA.retrieveAllForSales();
               bookedTicketNo = ticketDA.calAllTotalTicket();
            }else{
                bookingDetail = ticketDA.retrieveTicketDetails(date);
                bookedTicketNo = ticketDA.calTotalTicket(date);
            }
            
            if(bookingDetail.isEmpty()){
                
                out.println("<script type=\"text/javascript\">");
                out.println("alert('Not Record Found! .');");
                out.println("location='SalesReport.jsp';");
                out.println("</script>");
            }else{
            

                    
            
            int index = 0;

            for(int count = 0; count < bookedTicketNo.size(); count++){
                FnbOrder fnbOrder= bookingDA.getFnbOrderRecord(bookingDetail.get(index).getBookingDetails().getBookingId());
                
                if(fnbOrder.getFnbOrderID() == null){
                    for(int j = 0; j < bookedTicketNo.get(count); j++){
                        fnbOrderList.add(new FnbOrderLine(" ", 0, new Fnb(" ", " ", " ", 0.00, 0, false, null)));
                    }
                    bookedFnbNo.add(bookedTicketNo.get(count));
                    fnbSubTotal.add(0.00);
                 }else{
                    List <FnbOrderLine> fnbOrderLine =  bookingDA.getFnbRecord(fnbOrder.getFnbOrderID());

                    fnbSubTotal.add(bookingDA.fnbSubTotalCal(fnbOrder.getFnbOrderID()));
                    bookedFnbNo.add(fnbOrderLine.size());
                    
                    for(int i = 0; i < fnbOrderLine.size(); i++){
                        fnbOrderList.add(fnbOrderLine.get(i));
                    } 
                }
                
                paymentIdList.add(bookingDetail.get(index).getBookingDetails().getPaymentId().getPaymentID());
                index = index + bookedTicketNo.get(count);
            }
            
            session.setAttribute("fnbSubTotal", fnbSubTotal);
            session.setAttribute("bookedFnbNo", bookedFnbNo);
            session.setAttribute("fnbOrderList", fnbOrderList);
            session.setAttribute("bookedTicketNo", bookedTicketNo);
            session.setAttribute("bookingDetailList", bookingDetail);
            response.sendRedirect("SalesReport.jsp");
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
}

