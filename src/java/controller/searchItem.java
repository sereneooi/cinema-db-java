package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.*;
import jakarta.servlet.RequestDispatcher;

@WebServlet(name = "searchItem", urlPatterns = {"/searchItem"})
public class searchItem extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        
        //Theatre
        String theatreSearch = request.getParameter("theatreSearch");
        String bookingSearch = request.getParameter("bookingSearch");
        String salesDateSearch = request.getParameter("userSelectDate");
        
        try{
                        
            HttpSession session = request.getSession();

            //Theatre
            if((theatreSearch != null && !theatreSearch.isEmpty())){

                TheatreDA theatreDA = new TheatreDA();
                List<Theatre> theatre = theatreDA.searchRecord(theatreSearch);
                    
                session.setAttribute("theatreList", theatre);
                session.setAttribute("totalNoOfRecord", theatre.size());
                
                response.sendRedirect("TheatreAdminLayout.jsp");
                
            }else if((bookingSearch != null && !bookingSearch.isEmpty()) || (salesDateSearch != null && !salesDateSearch.isEmpty())){
                
                BookingDA bookingDA = new BookingDA();
                 List<Booking> booking = new ArrayList<>();
                if(bookingSearch != null && !bookingSearch.isEmpty()){
                    booking = bookingDA.searchRecord(bookingSearch);
                }else if(salesDateSearch != null && !salesDateSearch.isEmpty()){
                    booking = bookingDA.searchRecordByDate(salesDateSearch);
                }
                
                //Intialize
                TicketDA ticketDA = new TicketDA();

                List <Ticket> ticketList = new ArrayList<Ticket>();
                List <Integer> noOfTicket = new ArrayList<>();
                List <FnbOrder> fnbOrderList = new ArrayList<>();

                for(int i = 0; i < booking.size(); i++){

                    //Fnb
                    FnbOrder fnbOrder = bookingDA.getFnbOrderRecord(booking.get(i).getBookingId());

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
