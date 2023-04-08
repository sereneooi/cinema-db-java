package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Account;
import model.AccountDA;
import model.Booking;
import model.BookingDA;
import model.Payment;
import model.PaymentDA;
import model.Ticket;
import model.TicketDA;

@WebServlet(name = "UpdateBooking", urlPatterns = {"/UpdateBooking"})
public class UpdateBooking extends HttpServlet {

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        
        //Booking
        String emailAddress = request.getParameter("emailAddress");
        String paymentID = request.getParameter("paymenID");
        String bookingId = request.getParameter("bookingId");
        String confirmation = request.getParameter("confirmation");
        
        try{
            HttpSession session = request.getSession();
            Account currentUser = (Account)session.getAttribute("currentUser");
            
            if(currentUser.getRole().getRoleId().equals("R0001")){
                //Initialize
                BookingDA bookDA = new BookingDA();
                String validationMsg = "";  
                boolean validation = true;

                //Booking
                if((emailAddress != null && !emailAddress.isEmpty()) || 
                        (paymentID != null && !paymentID.isEmpty())){

                        //Account
                        AccountDA accDA = new AccountDA();
                        Account acc = accDA.getRecord(emailAddress, null);

                        //Payment
                        Payment payment = bookDA.retrievePaymentRecord(paymentID);
                        Payment pay = bookDA.getPaymentRecord(paymentID);

                        //Booking
                        Booking getSessionBook = (Booking)session.getAttribute("booking");

                        session.setAttribute("bookingId", bookingId); 
                        session.setAttribute("emailAddress", emailAddress); 
                        session.setAttribute("paymentID", paymentID); 

                        if(acc == null){

                            String accErrorMsg = "Sorry Email Address Not Found!!";
                            request.setAttribute("paymentConfirmMsg", null);
                            request.setAttribute("accConfirmMsg", accErrorMsg);
                            RequestDispatcher rd=request.getRequestDispatcher("UpdateBooking.jsp");  
                            rd.include(request, response);  

                        }else if(payment == null){

                            String paymentErrorMsg = "Sorry Payment ID Not Found!!";
                            request.setAttribute("accConfirmMsg", null);
                            request.setAttribute("paymentConfirmMsg", paymentErrorMsg);
                            RequestDispatcher rd=request.getRequestDispatcher("UpdateBooking.jsp");  
                            rd.include(request, response); 

                        }else if(pay != null && !paymentID.equals(getSessionBook.getPaymentId().getPaymentID())){

                            String paymentErrorMsg = "Sorry This Payment Is Not Available!!";
                            request.setAttribute("accConfirmMsg", null);
                            request.setAttribute("paymentConfirmMsg", paymentErrorMsg);
                            RequestDispatcher rd=request.getRequestDispatcher("UpdateBooking.jsp");  
                            rd.include(request, response); 

                        }
                        else{

                            request.setAttribute("accResult", acc);
                            request.setAttribute("paymentResult", payment);
                            RequestDispatcher rd=request.getRequestDispatcher("UpdateBooking.jsp");  
                            rd.include(request, response);

                        }


                }else if(confirmation.equals("CONFIRM")){
                    validation = true;
                    bookingId = (String)session.getAttribute("bookingId");
                    emailAddress = (String)session.getAttribute("emailAddress");
                    paymentID = (String)session.getAttribute("paymentID");

                    session.setAttribute("bookingResult", null);
                    session.setAttribute("paymentResult", null);

                    Booking book = new Booking();
                    book = new Booking(new Account(emailAddress), new Payment(paymentID));
                    Booking booking = bookDA.updateBooking(book, bookingId);

                    validationMsg = "Item " + booking.getBookingId() + " Updated!";
                    request.setAttribute("emailAddress", null);
                    request.setAttribute("paymentId", null); 
                    session.setAttribute("Booking", booking);
                    session.setAttribute("Object", booking);
                    session.setAttribute("ValidationMessage", validationMsg);                
                    session.setAttribute("verificationSucceed", validation);
                    response.sendRedirect("AddValidation.jsp");

                }
            }else{
                out.println("<script type=\"text/javascript\">");
                out.println("alert('You are not allow to access this page.');");
                out.println("location='mainBookingLayout.jsp';");
                out.println("</script>");
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
