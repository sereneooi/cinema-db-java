
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.time.LocalDateTime;
import java.util.*;
import model.*;



@WebServlet(name = "CustPayment", urlPatterns = {"/CustPayment"})
public class CustPayment extends HttpServlet {
    
    private PromotionDA promoDA = new PromotionDA();
    private final PaymentDA paymentDA;

    public CustPayment() throws Exception {
        this.paymentDA = new PaymentDA();
    }



    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        
        String action = request.getParameter("action");
        String promoCode = request.getParameter("promoCode");
        
        try{
            FnbDA fnbDA = new FnbDA();
            FnbOrderDA fnbOrderDA = new FnbOrderDA();
            FnbOrderLineDA fnbOrderLineDA = new FnbOrderLineDA();
            PromotionDA promotionDA = new PromotionDA();
            PaymentDA paymentDA = new PaymentDA();
            BookingDA bookDA = new BookingDA();
            TicketDA ticketDA = new TicketDA();
            
            HttpSession session = request.getSession();
            Promotion promotion = new Promotion();
            boolean isValid = false;
            if(promoCode != null) {
                ArrayList<Promotion> promotionList = promotionDA.getAllRecord();
                for(int i = 0; i < promotionList.size(); i++) {
                    if(promoCode.equals(promotionList.get(i).getPromoCode())) {
                        if(session.getAttribute("ticketList") != null) {
                            if(promotionList.get(i).getPromoType().equalsIgnoreCase("movie")) {
                                isValid = true;
                                break;
                            }
                        } 
                        if (session.getAttribute("fnbOrderLineList") != null) {
                            if(promotionList.get(i).getPromoType().equalsIgnoreCase("food")) {
                                isValid = true;
                                break;
                            }
                        }
                    }
                }
                if(!isValid) {
                    request.setAttribute("errMsg", "Invalid promo code");   
                    request.getRequestDispatcher("CustPaymentAdd.jsp").include(request, response);
                }
            } 
            
            if(promoCode == null || isValid) {
                promotion = new Promotion(promoCode);
                String pMethod = request.getParameter("pMethod");
                double total = (double) session.getAttribute("totalAmount");

                if(isValid) {
                    total -= promotion.getPromoAmount();
                }

                LocalDateTime now = LocalDateTime.now();
                String paymentID = generatePaymentId();
                Payment payment = new Payment(paymentID, now, pMethod, total, promotion);
                paymentDA.addRecord(payment);

                List<Booking>bookList = bookDA.retrieveAllRecord();
                String bookId = ""; 
                if(bookList == null || bookList.isEmpty()){
                    bookId="B0001";
                }else{
                    String id = bookList.get(bookList.size()-1).getBookingId();
                    int intBookId = Integer.parseInt(id.substring(1, 5)) + 1;
                    bookId = 'B' + String.format("%04d" , intBookId);
                }

                Account account = (Account) session.getAttribute("currentUser");
                Booking booking = new Booking(bookId, now.toString(), account, new Payment(paymentID));
                bookDA.addRecord(booking);
                session.setAttribute("booking", booking);

                if(session.getAttribute("ticketList") != null) {
                    List<Ticket> ticket = (List<Ticket>)session.getAttribute("ticketList");
                    List<Ticket> ticketList = new ArrayList<>();
                    for(int z = 0; z< ticket.size();z++){
                        ticketList.add(new Ticket(new Seat(ticket.get(z).getSeatId().getSeatId()), new TicketType(ticket.get(z).getTicketType().getTicketTypeId()), new Booking(bookId)));
                        ticketDA.addItem(ticketList.get(z));
                    }    
                }

                FnbOrder fnbOrder = new FnbOrder(FnbOrder.generateFnbOrderID(), null, null, null, new Booking(bookId));
                if(session.getAttribute("fnbOrder") != null) {
                    FnbOrder sessionFnbOrder = (FnbOrder) session.getAttribute("fnbOrder");
                    fnbOrder.setFnbOrderID(FnbOrder.generateFnbOrderID());
                    fnbOrder.setDeliveryAddress(sessionFnbOrder.getDeliveryAddress());
                    fnbOrder.setDeliveryDateTime(sessionFnbOrder.getDeliveryDateTime());
                    fnbOrder.setDeliveryStatus("Order Placed");
                }
                fnbOrder.setFnbOrderDateTime();

                fnbOrderDA.insertRecord(fnbOrder);

                ArrayList<FnbOrderLine> fnbOrderLineList = (ArrayList<FnbOrderLine>)session.getAttribute("fnbOrderLineList");

                for(FnbOrderLine fnbOrderLine : fnbOrderLineList) {
                    fnbOrderLine.setFnbOrder(new FnbOrder(fnbOrder.getFnbOrderID()));
                    fnbOrderLine.setFnbOrderLineID(FnbOrderLine.generateFnbOrderLineID());
                    fnbOrderLineDA.insertRecord(fnbOrderLine);
                    fnbDA.updateStockLeft(fnbOrderLine.getFnb().getFnbID(), fnbOrderLine.getQuantity());
                }

                session.removeAttribute("ticketList");
                session.removeAttribute("totalAmount");
                session.removeAttribute("fnbOrderLineList");
                response.sendRedirect("CustTransactionSuccess.jsp");
            }
        }
        catch(Exception ex){
               StackTraceElement[] element = ex.getStackTrace();

            out.println("ERROR: " + ex.toString() + "<br/><br/>");

            for(StackTraceElement e: element) {
                out.println("File Name: " + e.getFileName() + "<br/>");
                out.println("Class Name: " + e.getClassName() + "<br/>");
                out.println("Method Name: " + e.getMethodName() + "<br/>");
                out.println("Line Number: " + e.getLineNumber() + "<br/>");
            }
        }
    }
    
    public String generatePaymentId() throws Exception{
        PaymentDA p = new PaymentDA();
        
        int recordCount = p.countTotalRecord();
        
        return String.format("P%04d", recordCount+1);
    }

}
